Received: from eggs.gnu.org ([209.51.188.92]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3KE9-0006Uc-Ds
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3KE7-0001rQ-NF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:40:21 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 13:35:07 +0100
Message-Id: <20190311123507.24867-4-pbonzini@redhat.com>
In-Reply-To: <20190311123507.24867-1-pbonzini@redhat.com>
References: <20190311123507.24867-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] coroutine: add x86 specific coroutine
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This backend is faster (100ns vs 150ns per switch on my laptop), but
especially it will be possible to add CET support to it in 4.1.  In
the meanwhile, it is nice to have it as an experimental alternative.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                        |   8 ++
 scripts/qemugdb/coroutine.py     |   5 +-
 scripts/qemugdb/coroutine_x86.py |  21 +++
 util/coroutine-x86.c             | 213 +++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+), 2 deletions(-)
 create mode 100644 scripts/qemugdb/coroutine_x86.py
 create mode 100644 util/coroutine-x86.c

diff --git a/configure b/configure
index 62a2a490f2..af65edc30a 100755
--- a/configure
+++ b/configure
@@ -5123,6 +5123,14 @@ else
       error_exit "only the 'windows' coroutine backend is valid for Wind=
ows"
     fi
     ;;
+  x86)
+    if test "$mingw32" =3D "yes"; then
+      error_exit "only the 'windows' coroutine backend is valid for Wind=
ows"
+    fi
+    if test "$cpu" !=3D "x86_64"; then
+      error_exit "the 'x86' backend is only valid for x86_64 hosts"
+    fi
+    ;;
   *)
     error_exit "unknown coroutine backend $coroutine"
     ;;
diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index db2753d949..f716db22bb 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -10,14 +10,15 @@
 # This work is licensed under the terms of the GNU GPL, version 2
 # or later.  See the COPYING file in the top-level directory.
=20
-from . import coroutine_ucontext
+from . import coroutine_ucontext, coroutine_x86
 import gdb
=20
 VOID_PTR =3D gdb.lookup_type('void').pointer()
 UINTPTR_T =3D gdb.lookup_type('uintptr_t')
=20
 backends =3D {
-    'CoroutineUContext': coroutine_ucontext
+    'CoroutineUContext': coroutine_ucontext,
+    'CoroutineX86': coroutine_x86
 }
=20
 def coroutine_backend():
diff --git a/scripts/qemugdb/coroutine_x86.py b/scripts/qemugdb/coroutine=
_x86.py
new file mode 100644
index 0000000000..05f830cdb8
--- /dev/null
+++ b/scripts/qemugdb/coroutine_x86.py
@@ -0,0 +1,21 @@
+#!/usr/bin/python
+
+# GDB debugging support
+#
+# Copyright 2019 Red Hat, Inc.
+#
+# Authors:
+#  Paolo Bonzini <pbonzini@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import gdb
+
+U64_PTR =3D gdb.lookup_type('uint64_t').pointer()
+
+def get_coroutine_regs(addr):
+    addr =3D addr.cast(gdb.lookup_type('CoroutineX86').pointer())
+    rsp =3D addr['sp'].cast(U64_PTR)
+    return {'rsp': rsp,
+            'rip': rsp.dereference()}
diff --git a/util/coroutine-x86.c b/util/coroutine-x86.c
new file mode 100644
index 0000000000..7f5e7d7696
--- /dev/null
+++ b/util/coroutine-x86.c
@@ -0,0 +1,213 @@
+/*
+ * x86-specific coroutine initialization code
+ *
+ * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
+ * Copyright (C) 2011  Kevin Wolf <kwolf@redhat.com>
+ * Copyright (C) 2019  Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.0 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+
+/* XXX Is there a nicer way to disable glibc's stack check for longjmp? =
*/
+#ifdef _FORTIFY_SOURCE
+#undef _FORTIFY_SOURCE
+#endif
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/coroutine_int.h"
+
+#ifdef CONFIG_VALGRIND_H
+#include <valgrind/valgrind.h>
+#endif
+
+#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
+#ifdef CONFIG_ASAN_IFACE_FIBER
+#define CONFIG_ASAN 1
+#include <sanitizer/asan_interface.h>
+#endif
+#endif
+
+typedef struct {
+    Coroutine base;
+    void *stack;
+    size_t stack_size;
+    void *sp;
+
+#ifdef CONFIG_VALGRIND_H
+    unsigned int valgrind_stack_id;
+#endif
+} CoroutineX86;
+
+/**
+ * Per-thread coroutine bookkeeping
+ */
+static __thread CoroutineX86 leader;
+static __thread Coroutine *current;
+
+static void finish_switch_fiber(void *fake_stack_save)
+{
+#ifdef CONFIG_ASAN
+    const void *bottom_old;
+    size_t size_old;
+
+    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &size_=
old);
+
+    if (!leader.stack) {
+        leader.stack =3D (void *)bottom_old;
+        leader.stack_size =3D size_old;
+    }
+#endif
+}
+
+static void start_switch_fiber(void **fake_stack_save,
+                               const void *bottom, size_t size)
+{
+#ifdef CONFIG_ASAN
+    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
+#endif
+}
+
+/* On entry to a coroutine, rax is "value" and rsi is the coroutine itse=
lf.  */
+#define CO_SWITCH(from, to, action, jump) ({                            =
                \
+    int ret =3D action;                                                 =
                  \
+    void *from_ =3D from;                                               =
                  \
+    void *to_ =3D to;                                                   =
                  \
+    asm volatile(                                                       =
                \
+        ".cfi_remember_state\n"                                         =
                \
+        "pushq %%rbp\n"                     /* save scratch register on =
source stack */ \
+        ".cfi_adjust_cfa_offset 8\n"                                    =
                \
+        ".cfi_rel_offset %%rbp, 0\n"                                    =
                \
+        "call 1f\n"                         /* switch continues at label=
 1 */           \
+        ".cfi_adjust_cfa_offset 8\n"                                    =
                \
+        "jmp 2f\n"                          /* switch back continues at =
label 2 */      \
+        "1: movq (%%rsp), %%rbp\n"          /* save source IP for debugg=
ing */          \
+        "movq %%rsp, %c[sp](%[FROM])\n"     /* save source SP */        =
                \
+        "movq %c[sp](%[TO]), %%rsp\n"       /* load destination SP */   =
                \
+        jump "\n"                           /* coroutine switch */      =
                \
+        "2:"                                                            =
                \
+        ".cfi_adjust_cfa_offset -8\n"                                   =
                \
+        "popq %%rbp\n"                                                  =
                \
+        ".cfi_adjust_cfa_offset -8\n"                                   =
                \
+        ".cfi_restore_state\n"                                          =
                \
+        : "+a" (ret), [FROM] "+b" (from_), [TO] "+D" (to_)              =
                \
+        : [sp] "i" (offsetof(CoroutineX86, sp))                         =
                \
+        : "rcx", "rdx", "rsi", "r8", "r9", "r10", "r11", "r12", "r13", "=
r14", "r15",    \
+          "memory");                                                    =
                \
+    ret; \
+})
+
+static void __attribute__((__used__)) coroutine_trampoline(void *arg)
+{
+    CoroutineX86 *self =3D arg;
+    Coroutine *co =3D &self->base;
+
+    finish_switch_fiber(NULL);
+
+    while (true) {
+        qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
+        co->entry(co->entry_arg);
+    }
+}
+
+Coroutine *qemu_coroutine_new(void)
+{
+    CoroutineX86 *co;
+    void *fake_stack_save =3D NULL;
+
+    co =3D g_malloc0(sizeof(*co));
+    co->stack_size =3D COROUTINE_STACK_SIZE;
+    co->stack =3D qemu_alloc_stack(&co->stack_size);
+    co->sp =3D co->stack + co->stack_size;
+
+#ifdef CONFIG_VALGRIND_H
+    co->valgrind_stack_id =3D
+        VALGRIND_STACK_REGISTER(co->stack, co->stack + co->stack_size);
+#endif
+
+    /* Immediately enter the coroutine once to pass it its address as th=
e argument */
+    co->base.caller =3D qemu_coroutine_self();
+    start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
+    CO_SWITCH(current, co, 0, "jmp coroutine_trampoline");
+    finish_switch_fiber(fake_stack_save);
+    co->base.caller =3D NULL;
+
+    return &co->base;
+}
+
+#ifdef CONFIG_VALGRIND_H
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
+/* Work around an unused variable in the valgrind.h macro... */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
+#endif
+static inline void valgrind_stack_deregister(CoroutineX86 *co)
+{
+    VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
+}
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+#endif
+
+void qemu_coroutine_delete(Coroutine *co_)
+{
+    CoroutineX86 *co =3D DO_UPCAST(CoroutineX86, base, co_);
+
+#ifdef CONFIG_VALGRIND_H
+    valgrind_stack_deregister(co);
+#endif
+
+    qemu_free_stack(co->stack, co->stack_size);
+    g_free(co);
+}
+
+/*
+ * This function is marked noinline to prevent GCC from inlining it
+ * into coroutine_trampoline(). If we allow it to do that then it
+ * hoists the code to get the address of the TLS variable "current"
+ * out of the while() loop. This is an invalid transformation because
+ * qemu_coroutine_switch() may be called when running thread A but
+ * return in thread B, and so we might be in a different thread
+ * context each time round the loop.
+ */
+CoroutineAction __attribute__((noinline))
+qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
+                      CoroutineAction action)
+{
+    CoroutineX86 *from =3D DO_UPCAST(CoroutineX86, base, from_);
+    CoroutineX86 *to =3D DO_UPCAST(CoroutineX86, base, to_);
+    void *fake_stack_save =3D NULL;
+
+    current =3D to_;
+
+    start_switch_fiber(action =3D=3D COROUTINE_TERMINATE ?
+                       NULL : &fake_stack_save, to->stack, to->stack_siz=
e);
+    action =3D CO_SWITCH(from, to, action, "ret");
+    finish_switch_fiber(fake_stack_save);
+
+    return action;
+}
+
+Coroutine *qemu_coroutine_self(void)
+{
+    if (!current) {
+        current =3D &leader.base;
+    }
+    return current;
+}
+
+bool qemu_in_coroutine(void)
+{
+    return current && current->caller;
+}
--=20
2.20.1
