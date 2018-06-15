Received: from eggs.gnu.org ([2001:4830:134:3::10]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTpiq-0004mX-Lb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTpip-0001OL-Nr
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:29:04 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 15 Jun 2018 16:28:29 +0200
Message-Id: <1529072910-16156-11-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/11] hw/arm/virt: Use 256MB ECAM region by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org, christoffer.dall@arm.com, marc.zyngier@arm.com

With this patch, virt-3.0 machine uses a new 256MB ECAM region
by default instead of the legacy 16MB one, if highmem is set
(LPAE supported by the guest) and (!firmware_loaded || aarch64).

Indeed aarch32 mode FW may not support this high ECAM region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c         | 10 ++++++++++
 include/hw/arm/virt.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 75a1a14..5a16e6c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1317,6 +1317,7 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
+    bool aarch64 = true;
 
     /* We can probe only here because during property set
      * KVM is not available yet
@@ -1432,6 +1433,8 @@ static void machvirt_init(MachineState *machine)
         numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
                           &error_fatal);
 
+        aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
+
         if (!vms->secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
@@ -1490,6 +1493,8 @@ static void machvirt_init(MachineState *machine)
         create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
 
+    vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
+
     create_rtc(vms, pic);
 
     create_pcie(vms, pic);
@@ -1786,6 +1791,8 @@ static void virt_3_0_instance_init(Object *obj)
                                     "Set GIC version. "
                                     "Valid values are 2, 3 and host", NULL);
 
+    vms->highmem_ecam = !vmc->no_highmem_ecam;
+
     if (vmc->no_its) {
         vms->its = false;
     } else {
@@ -1823,8 +1830,11 @@ static void virt_2_12_instance_init(Object *obj)
 
 static void virt_machine_2_12_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_3_0_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
+    vmc->no_highmem_ecam = true;
 }
 DEFINE_VIRT_MACHINE(2, 12)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 085fdcc..9a870cc 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -98,6 +98,7 @@ typedef struct {
     bool no_pmu;
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
+    bool no_highmem_ecam;
 } VirtMachineClass;
 
 typedef struct {
-- 
2.5.5
