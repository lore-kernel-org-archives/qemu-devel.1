Received: from eggs.gnu.org ([2001:4830:134:3::10]:55382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7Ho-0002CA-CU
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7Hm-0001dq-RL
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:48 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sat, 11 Nov 2017 03:19:51 +0800
Message-ID: <1510341591-22817-13-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 12/12] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
translate the host VA which is delivered by host to guest PA, then fill
this PA to CPER and fill the CPER to guest APEI GHES memory, finally
notify guest according the SIGBUS type. There are two kinds of SIGBUS
that QEMU need to handle, which are BUS_MCEERR_AO and BUS_MCEERR_AR.

Guest access device type poisoned memory, generate SError interrupt,
so it reports it to host firmware. Host kernel gets an APEI notification
and memory_failure() causes the affected page to be unmapped from the
guest's stage2, and SIGBUS_MCEERR_AO is sent to user-space. Here Qemu
will create a new CPER and add it to guest APEI GHES memory, and notify the
guest with a GPIO-Signal notification.

When guest hit a PG_hwpoison page, it will trap to KVM as stage2 fault,
here a SIGBUS_MCEERR_AR synchronous signal is delivered to user-space,
Qemu record this error into guest APEI GHES memory and notify guest using
Synchronous-External-Abort(SEA).

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Quanming Wu <wuquanming@huawei.com>

---
QEMU handing the SIGBUS is discussed here:
https://lkml.org/lkml/2017/2/27/246

Using which error notification to notify guest is discussed here:
https://lkml.org/lkml/2017/9/14/241
https://lkml.org/lkml/2017/9/22/499
---
 include/sysemu/kvm.h |  2 +-
 target/arm/kvm.c     |  2 ++
 target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3a458f5..90c1605 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -361,7 +361,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef TARGET_I386
+#if defined(TARGET_I386) || defined(TARGET_AARCH64)
 #define KVM_HAVE_MCE_INJECTION 1
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d85e36a..8523158 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -26,6 +26,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "qemu/log.h"
+#include "exec/ram_addr.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -182,6 +183,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    qemu_register_reset(kvm_unpoison_all, NULL);
     type_register_static(&host_arm_cpu_type_info);
 
     return 0;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 7f662e9..3b532e1 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -27,6 +27,9 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "hw/arm/arm.h"
+#include "exec/ram_addr.h"
+#include "hw/acpi/acpi-defs.h"
+#include "hw/acpi/hest_ghes.h"
 
 static bool have_guest_debug;
 
@@ -943,6 +946,37 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+{
+    ram_addr_t ram_addr;
+    hwaddr paddr;
+
+    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
+    if (addr) {
+        ram_addr = qemu_ram_addr_from_host(addr);
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            kvm_cpu_synchronize_state(c);
+            kvm_hwpoison_page_add(ram_addr);
+            if (code == BUS_MCEERR_AR) {
+                ghes_update_guest(ACPI_HEST_NOTIFY_SEA, paddr);
+                kvm_inject_arm_sea(c);
+            } else if (code == BUS_MCEERR_AO) {
+                ghes_update_guest(ACPI_HEST_NOTIFY_GPIO, paddr);
+                qemu_hardware_error_notify();
+            }
+            return;
+        }
+        fprintf(stderr, "Hardware memory error for memory used by "
+                "QEMU itself instead of guest system!\n");
+    }
+
+    if (code == BUS_MCEERR_AR) {
+        fprintf(stderr, "Hardware memory error!\n");
+        exit(1);
+    }
+}
+
 /* C6.6.29 BRK instruction */
 static const uint32_t brk_insn = 0xd4200000;
 
-- 
1.8.3.1
