Received: from eggs.gnu.org ([209.51.188.92]:40757)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gpwZ2-0005vV-Rc
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 09:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gpwZ1-0000h7-VG
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 09:46:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:43039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gpwZ1-0000Ym-MR
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 09:46:35 -0500
From: Kamil Rytarowski <n54@gmx.com>
Date: Sat,  2 Feb 2019 15:45:31 +0100
Message-Id: <20190202144531.5772-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>

This improves the commit:
"target-i386: Fix build by providing stub kvm_arch_get_supported_cpuid()"
r. 2140cfa51d59177815f5b82e94ac48fb24909aba

Clang/LLVM on NetBSD with enabled optimization cannot link
correct qemu program because of a missing symbol of
kvm_arch_get_supported_cpuid() in kvm-stubs.o used by executables.

There are more than a single one kvm-stub.c and several types
of possible programs such as bsd-user ones. the previous workaround
does not work reliably for all use-cases. Instead of reworking
the stubs and linking rules, move the workaround from a code that
depends on the __OPTIMIZE__ builtin compiler flag, build option (KVM),
compiler and arrangement of linking rules to a simple macro in a
shared header with all the users that defines fallback dummy
implementation, ignoring whether it is optimized out or not.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 include/sysemu/kvm.h   | 13 +++++++++++++
 target/i386/kvm-stub.c | 10 ----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190f..93d3c0f0b3 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -459,8 +459,21 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
         kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
     })
 
+#ifdef CONFIG_KVM
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
+#else
+/*
+ * This function is only called inside conditionals which we
+ * rely on the compiler to optimize out when CONFIG_KVM is not
+ * defined.
+ */
+#define kvm_arch_get_supported_cpuid(a, b, c, d)                     \
+    ({                                                               \
+        abort();                                                     \
+        0;                                                           \
+    })
+#endif
 uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
 
 
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index e7a673e5db..9ce8566700 100644
--- a/target/i386/kvm-stub.c
+++ b/target/i386/kvm-stub.c
@@ -29,16 +29,6 @@ bool kvm_enable_x2apic(void)
 {
     return false;
 }
-
-/* This function is only called inside conditionals which we
- * rely on the compiler to optimize out when CONFIG_KVM is not
- * defined.
- */
-uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
-                                      uint32_t index, int reg)
-{
-    abort();
-}
 #endif
 
 bool kvm_hv_vpindex_settable(void)
-- 
2.20.1
