Received: from eggs.gnu.org ([209.51.188.92]:50354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ8-000790-Kn
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ6-0001CE-V4
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:36 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:20 -0600
Message-Id: <20190504120528.6389-3-pbonzini@redhat.com>
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/9] qemugdb: allow adding support for other
 architectures
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

$sp and $pc are standard register names that are available
on most machines, use them instead of $rsp and $rip so that
other architectures can use qemu_coroutine_sp and
qemu_coroutine_pc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qemugdb/coroutine.py          | 4 ++--
 scripts/qemugdb/coroutine_ucontext.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index db2753d949..076f6808ab 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -62,11 +62,11 @@ class CoroutineSPFunction(gdb.Function):
         gdb.Function.__init__(self, 'qemu_coroutine_sp')
 
     def invoke(self, addr):
-        return coroutine_backend().get_coroutine_regs(addr)['rsp'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['sp'].cast(VOID_PTR)
 
 class CoroutinePCFunction(gdb.Function):
     def __init__(self):
         gdb.Function.__init__(self, 'qemu_coroutine_pc')
 
     def invoke(self, addr):
-        return coroutine_backend().get_coroutine_regs(addr)['rip'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['pc'].cast(VOID_PTR)
diff --git a/scripts/qemugdb/coroutine_ucontext.py b/scripts/qemugdb/coroutine_ucontext.py
index a2f8c1dbbf..eed095be22 100644
--- a/scripts/qemugdb/coroutine_ucontext.py
+++ b/scripts/qemugdb/coroutine_ucontext.py
@@ -57,12 +57,12 @@ def get_jmpbuf_regs(jmpbuf):
     pointer_guard = get_glibc_pointer_guard()
     return {'rbx': jmpbuf[JB_RBX],
         'rbp': glibc_ptr_demangle(jmpbuf[JB_RBP], pointer_guard),
-        'rsp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
+        'sp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
         'r12': jmpbuf[JB_R12],
         'r13': jmpbuf[JB_R13],
         'r14': jmpbuf[JB_R14],
         'r15': jmpbuf[JB_R15],
-        'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
+        'pc': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
 
 def get_coroutine_regs(addr):
     co = addr.cast(gdb.lookup_type('CoroutineUContext').pointer())
-- 
2.21.0
