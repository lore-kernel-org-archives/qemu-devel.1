Received: from eggs.gnu.org ([209.51.188.92]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUou-0007Ec-Ql
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUor-0002kq-0Q
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gkUoq-0002gW-Fh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0IDwk5R102942
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:22 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q3e4t5gan-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:21 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 18 Jan 2019 14:08:19 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 18 Jan 2019 12:07:55 -0200
In-Reply-To: <20190118140758.829-1-farosas@linux.ibm.com>
References: <20190118140758.829-1-farosas@linux.ibm.com>
Message-Id: <20190118140758.829-5-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v3 4/7] kvm-all: Introduce
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com, aik@ozlabs.ru

This will allow architecture-specifc implementations of a fallback
mechanism for single stepping in cases where KVM does not support it
via the KVM_SET_GUEST_DEBUG ioctl.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 accel/kvm/kvm-all.c             | 9 +++++++++
 accel/stubs/kvm-stub.c          | 4 ++++
 exec.c                          | 2 +-
 include/sysemu/kvm.h            | 2 ++
 stubs/Makefile.objs             | 1 +
 stubs/kvm-arch-set-singlestep.c | 8 ++++++++
 6 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 stubs/kvm-arch-set-singlestep.c

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0dc7a32883..8dc5d32f08 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2320,6 +2320,15 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
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
index 895449f926..6612f90b3a 100644
--- a/exec.c
+++ b/exec.c
@@ -1234,7 +1234,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
     if (cpu->singlestep_enabled != enabled) {
         cpu->singlestep_enabled = enabled;
         if (kvm_enabled()) {
-            kvm_update_guest_debug(cpu, 0);
+            kvm_set_singlestep(cpu, enabled);
         } else {
             /* must flush all the translated code to avoid inconsistencies */
             /* XXX: only flush what is necessary */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ca2bbff053..e1ef2f5b99 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -247,6 +247,7 @@ bool kvm_memcrypt_enabled(void);
  */
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
 
+void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
 
 #ifdef NEED_CPU_H
 #include "cpu.h"
@@ -259,6 +260,7 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type);
 void kvm_remove_all_breakpoints(CPUState *cpu);
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
+void kvm_set_singlestep(CPUState *cs, int enabled);
 
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5dd0aeeec6..145ca9620b 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -16,6 +16,7 @@ stub-obj-y += get-vm-name.o
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
2.17.1
