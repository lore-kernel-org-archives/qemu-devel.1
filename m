Received: from eggs.gnu.org ([2001:4830:134:3::10]:33249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oC-0001kW-OY
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oB-0003tS-Np
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:16 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:44 +0100
Message-Id: <20170102200153.28864-8-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/16] hw/arm/virt: eliminate struct
 VirtGuestInfoState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

Instead of allocating a new struct just for VirtGuestInfo and the
machine_done Notifier, place them inside VirtMachineState. This
is the mach-virt equivalent of "pc: Eliminate struct
PcGuestInfoState"

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c                    | 20 +++++++++++---------
 include/hw/arm/virt-acpi-build.h |  6 ------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 67c0abb30b5b..d242980869bc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -76,6 +76,8 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
+    VirtGuestInfo acpi_guest_info;
+    Notifier machine_done;
     bool secure;
     bool highmem;
     bool virt;
@@ -1222,12 +1224,13 @@ static void virt_build_smbios(VirtGuestInfo *guest_info)
 }
 
 static
-void virt_guest_info_machine_done(Notifier *notifier, void *data)
+void virt_machine_done(Notifier *notifier, void *data)
 {
-    VirtGuestInfoState *guest_info_state = container_of(notifier,
-                                              VirtGuestInfoState, machine_done);
-    virt_acpi_setup(&guest_info_state->info);
-    virt_build_smbios(&guest_info_state->info);
+    VirtMachineState *vms = container_of(notifier, VirtMachineState,
+                                         machine_done);
+
+    virt_acpi_setup(&vms->acpi_guest_info);
+    virt_build_smbios(&vms->acpi_guest_info);
 }
 
 static void machvirt_init(MachineState *machine)
@@ -1240,8 +1243,7 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
-    VirtGuestInfoState *guest_info_state = g_malloc0(sizeof *guest_info_state);
-    VirtGuestInfo *guest_info = &guest_info_state->info;
+    VirtGuestInfo *guest_info = &vms->acpi_guest_info;
     char **cpustr;
     ObjectClass *oc;
     const char *typename;
@@ -1459,8 +1461,8 @@ static void machvirt_init(MachineState *machine)
     guest_info->use_highmem = vms->highmem;
     guest_info->gic_version = vms->gic_version;
     guest_info->no_its = vmc->no_its;
-    guest_info_state->machine_done.notify = virt_guest_info_machine_done;
-    qemu_add_machine_init_done_notifier(&guest_info_state->machine_done);
+    vms->machine_done.notify = virt_machine_done;
+    qemu_add_machine_init_done_notifier(&vms->machine_done);
 
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.kernel_filename = machine->kernel_filename;
diff --git a/include/hw/arm/virt-acpi-build.h b/include/hw/arm/virt-acpi-build.h
index 2bcd22265cfa..925c4347381c 100644
--- a/include/hw/arm/virt-acpi-build.h
+++ b/include/hw/arm/virt-acpi-build.h
@@ -34,12 +34,6 @@ typedef struct VirtGuestInfo {
     bool no_its;
 } VirtGuestInfo;
 
-
-typedef struct VirtGuestInfoState {
-    VirtGuestInfo info;
-    Notifier machine_done;
-} VirtGuestInfoState;
-
 void virt_acpi_setup(VirtGuestInfo *guest_info);
 
 #endif
-- 
2.9.3
