Received: from eggs.gnu.org ([209.51.188.92]:57742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gzUd8-0002nL-11
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gzUd6-0001om-VJ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:58:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47234
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gzUd6-0001oM-Q4
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:58:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1SMsN1C087556
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 17:58:16 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qxpbeevxc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 17:58:15 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Thu, 28 Feb 2019 22:58:15 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Thu, 28 Feb 2019 19:57:56 -0300
In-Reply-To: <20190228225759.21328-1-farosas@linux.ibm.com>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190228225759.21328-3-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v4 2/5] kvm-all: Introduce
 kvm_set_singlestep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexey Kardashevskiy <aik@ozlabs.ru>

For single stepping (via KVM) of a guest vcpu to work, KVM needs not
only to support the SET_GUEST_DEBUG ioctl but to also recognize the
KVM_GUESTDBG_SINGLESTEP bit in the control field of the
kvm_guest_debug struct.

This patch adds support for querying the single step capability so
that QEMU can decide what to do for the platforms that do not have
such support.

This will allow architecture-specific implementations of a fallback
mechanism for single stepping in cases where KVM does not support it.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 accel/kvm/kvm-all.c             | 16 ++++++++++++++++
 accel/stubs/kvm-stub.c          |  4 ++++
 exec.c                          |  2 +-
 include/sysemu/kvm.h            |  3 +++
 stubs/Makefile.objs             |  1 +
 stubs/kvm-arch-set-singlestep.c |  8 ++++++++
 6 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 stubs/kvm-arch-set-singlestep.c

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fd92b6f375..d3ac5a9e5c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2267,6 +2267,13 @@ bool kvm_arm_supports_user_irq(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
 }
 
+/* Whether the KVM_SET_GUEST_DEBUG ioctl supports single stepping */
+int kvm_has_guestdbg_singlestep(void)
+{
+    /* return kvm_check_extension(kvm_state, KVM_CAP_GUEST_DEBUG_SSTEP); */
+    return 0;
+}
+
 #ifdef KVM_CAP_SET_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
                                                  target_ulong pc)
@@ -2316,6 +2323,15 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return data.err;
 }
 
+void kvm_set_singlestep(CPUState *cs, int enabled)
+{
+    if (kvm_has_guestdbg_singlestep()) {
+        kvm_update_guest_debug(cs, 0);
+    } else {
+        kvm_arch_set_singlestep(cs, enabled);
+    }
+}
+
 int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type)
 {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 02d5170031..69bd07f50e 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -79,6 +79,10 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return -ENOSYS;
 }
 
+void kvm_set_singlestep(CPUState *cs, int enabled)
+{
+}
+
 int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type)
 {
diff --git a/exec.c b/exec.c
index 518064530b..8817513e26 100644
--- a/exec.c
+++ b/exec.c
@@ -1236,7 +1236,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
     if (cpu->singlestep_enabled != enabled) {
         cpu->singlestep_enabled = enabled;
         if (kvm_enabled()) {
-            kvm_update_guest_debug(cpu, 0);
+            kvm_set_singlestep(cpu, enabled);
         } else {
             /* must flush all the translated code to avoid inconsistencies */
             /* XXX: only flush what is necessary */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190f..e1ef2f5b99 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -214,6 +214,7 @@ int kvm_has_pit_state2(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 int kvm_has_intx_set_mask(void);
+int kvm_has_guestdbg_singlestep(void);
 
 int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
@@ -246,6 +247,7 @@ bool kvm_memcrypt_enabled(void);
  */
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
 
+void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
 
 #ifdef NEED_CPU_H
 #include "cpu.h"
@@ -258,6 +260,7 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type);
 void kvm_remove_all_breakpoints(CPUState *cpu);
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
+void kvm_set_singlestep(CPUState *cs, int enabled);
 
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa5832..884f9b2268 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -12,6 +12,7 @@ stub-obj-y += get-vm-name.o
 stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
+stub-obj-y += kvm-arch-set-singlestep.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
diff --git a/stubs/kvm-arch-set-singlestep.c b/stubs/kvm-arch-set-singlestep.c
new file mode 100644
index 0000000000..ba6e0323d6
--- /dev/null
+++ b/stubs/kvm-arch-set-singlestep.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+
+void kvm_arch_set_singlestep(CPUState *cpu, int enabled)
+{
+    warn_report("KVM does not support single stepping");
+}
-- 
2.20.1
