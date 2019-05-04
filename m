Received: from eggs.gnu.org ([209.51.188.92]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ9-000792-2H
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ6-0001C6-Tj
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:36 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:19 -0600
Message-Id: <20190504120528.6389-2-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/9] qemugdb: allow adding support for other
 coroutine backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org

Split the jmpbuf access to a separate module and dispatch based
on which CoroutineXYZ type is defined.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qemugdb/coroutine.py          | 106 ++++++++------------------
 scripts/qemugdb/coroutine_ucontext.py |  69 +++++++++++++++++
 2 files changed, 100 insertions(+), 75 deletions(-)
 create mode 100644 scripts/qemugdb/coroutine_ucontext.py

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 41e079d0e2..db2753d949 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 
-# GDB debugging support
+# GDB debugging support, coroutine dispatch
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
 #
@@ -10,82 +10,25 @@
 # This work is licensed under the terms of the GNU GPL, version 2
 # or later.  See the COPYING file in the top-level directory.
 
+from . import coroutine_ucontext
 import gdb
 
 VOID_PTR = gdb.lookup_type('void').pointer()
+UINTPTR_T = gdb.lookup_type('uintptr_t')
 
-def get_fs_base():
-    '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
-       pthread_self().'''
-    # %rsp - 120 is scratch space according to the SystemV ABI
-    old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
-    fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
-    return fs_base
-
-def pthread_self():
-    '''Fetch pthread_self() from the glibc start_thread function.'''
-    f = gdb.newest_frame()
-    while f.name() != 'start_thread':
-        f = f.older()
-        if f is None:
-            return get_fs_base()
-
-    try:
-        return f.read_var("arg")
-    except ValueError:
-        return get_fs_base()
-
-def get_glibc_pointer_guard():
-    '''Fetch glibc pointer guard value'''
-    fs_base = pthread_self()
-    return gdb.parse_and_eval('*(uint64_t*)((uint64_t)%s + 0x30)' % fs_base)
-
-def glibc_ptr_demangle(val, pointer_guard):
-    '''Undo effect of glibc's PTR_MANGLE()'''
-    return gdb.parse_and_eval('(((uint64_t)%s >> 0x11) | ((uint64_t)%s << (64 - 0x11))) ^ (uint64_t)%s' % (val, val, pointer_guard))
-
-def get_jmpbuf_regs(jmpbuf):
-    JB_RBX  = 0
-    JB_RBP  = 1
-    JB_R12  = 2
-    JB_R13  = 3
-    JB_R14  = 4
-    JB_R15  = 5
-    JB_RSP  = 6
-    JB_PC   = 7
-
-    pointer_guard = get_glibc_pointer_guard()
-    return {'rbx': jmpbuf[JB_RBX],
-        'rbp': glibc_ptr_demangle(jmpbuf[JB_RBP], pointer_guard),
-        'rsp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
-        'r12': jmpbuf[JB_R12],
-        'r13': jmpbuf[JB_R13],
-        'r14': jmpbuf[JB_R14],
-        'r15': jmpbuf[JB_R15],
-        'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
-
-def bt_jmpbuf(jmpbuf):
-    '''Backtrace a jmpbuf'''
-    regs = get_jmpbuf_regs(jmpbuf)
-    old = dict()
-
-    for i in regs:
-        old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
-
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, regs[i]))
-
-    gdb.execute('bt')
-
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, old[i]))
-
-def coroutine_to_jmpbuf(co):
-    coroutine_pointer = co.cast(gdb.lookup_type('CoroutineUContext').pointer())
-    return coroutine_pointer['env']['__jmpbuf']
+backends = {
+    'CoroutineUContext': coroutine_ucontext
+}
 
+def coroutine_backend():
+    for k, v in backends.items():
+        try:
+            gdb.lookup_type(k)
+        except:
+            continue
+        return v
+
+    raise Exception('could not find coroutine backend')
 
 class CoroutineCommand(gdb.Command):
     '''Display coroutine backtrace'''
@@ -99,18 +42,31 @@ class CoroutineCommand(gdb.Command):
             gdb.write('usage: qemu coroutine <coroutine-pointer>\n')
             return
 
-        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
+        addr = gdb.parse_and_eval(argv[0])
+        regs = coroutine_backend().get_coroutine_regs(addr)
+        old = dict()
+
+        for i in regs:
+            old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
+
+        for i in regs:
+            gdb.execute('set $%s = %s' % (i, regs[i].cast(UINTPTR_T)))
+
+        gdb.execute('bt')
+
+        for i in regs:
+            gdb.execute('set $%s = %s' % (i, old[i].cast(UINTPTR_T)))
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
         gdb.Function.__init__(self, 'qemu_coroutine_sp')
 
     def invoke(self, addr):
-        return get_jmpbuf_regs(coroutine_to_jmpbuf(addr))['rsp'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['rsp'].cast(VOID_PTR)
 
 class CoroutinePCFunction(gdb.Function):
     def __init__(self):
         gdb.Function.__init__(self, 'qemu_coroutine_pc')
 
     def invoke(self, addr):
-        return get_jmpbuf_regs(coroutine_to_jmpbuf(addr))['rip'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['rip'].cast(VOID_PTR)
diff --git a/scripts/qemugdb/coroutine_ucontext.py b/scripts/qemugdb/coroutine_ucontext.py
new file mode 100644
index 0000000000..a2f8c1dbbf
--- /dev/null
+++ b/scripts/qemugdb/coroutine_ucontext.py
@@ -0,0 +1,69 @@
+#!/usr/bin/python
+
+# GDB debugging support
+#
+# Copyright 2012 Red Hat, Inc. and/or its affiliates
+#
+# Authors:
+#  Avi Kivity <avi@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import gdb
+
+def get_fs_base():
+    '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
+       pthread_self().'''
+    # %rsp - 120 is scratch space according to the SystemV ABI
+    old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
+    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
+    fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
+    gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
+    return fs_base
+
+def pthread_self():
+    '''Fetch pthread_self() from the glibc start_thread function.'''
+    f = gdb.newest_frame()
+    while f.name() != 'start_thread':
+        f = f.older()
+        if f is None:
+            return get_fs_base()
+
+    try:
+        return f.read_var("arg")
+    except ValueError:
+        return get_fs_base()
+
+def get_glibc_pointer_guard():
+    '''Fetch glibc pointer guard value'''
+    fs_base = pthread_self()
+    return gdb.parse_and_eval('*(uint64_t*)((uint64_t)%s + 0x30)' % fs_base)
+
+def glibc_ptr_demangle(val, pointer_guard):
+    '''Undo effect of glibc's PTR_MANGLE()'''
+    return gdb.parse_and_eval('(((uint64_t)%s >> 0x11) | ((uint64_t)%s << (64 - 0x11))) ^ (uint64_t)%s' % (val, val, pointer_guard))
+
+def get_jmpbuf_regs(jmpbuf):
+    JB_RBX  = 0
+    JB_RBP  = 1
+    JB_R12  = 2
+    JB_R13  = 3
+    JB_R14  = 4
+    JB_R15  = 5
+    JB_RSP  = 6
+    JB_PC   = 7
+
+    pointer_guard = get_glibc_pointer_guard()
+    return {'rbx': jmpbuf[JB_RBX],
+        'rbp': glibc_ptr_demangle(jmpbuf[JB_RBP], pointer_guard),
+        'rsp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
+        'r12': jmpbuf[JB_R12],
+        'r13': jmpbuf[JB_R13],
+        'r14': jmpbuf[JB_R14],
+        'r15': jmpbuf[JB_R15],
+        'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
+
+def get_coroutine_regs(addr):
+    co = addr.cast(gdb.lookup_type('CoroutineUContext').pointer())
+    return get_jmpbuf_regs(co['env']['__jmpbuf'])
-- 
2.21.0
