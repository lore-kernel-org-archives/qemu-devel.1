Received: from eggs.gnu.org ([2001:4830:134:3::10]:37333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWV-0002So-PP
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWU-00048n-E7
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWU-00045M-6C
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:58 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWM-0001Pt-V4
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:35 +0000
Message-Id: <1483962824-29185-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/21] hw/arm/virt: eliminate struct
 VirtGuestInfoState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Instead of allocating a new struct just for VirtGuestInfo and the
machine_done Notifier, place them inside VirtMachineState. This
is the mach-virt equivalent of "pc: Eliminate struct
PcGuestInfoState"

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-8-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt-acpi-build.h |  6 ------
 hw/arm/virt.c                    | 20 +++++++++++---------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt-acpi-build.h b/include/hw/arm/virt-acpi-build.h
index 2bcd222..925c434 100644
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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8ba50ad..9b55ef0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -76,6 +76,8 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
+    VirtGuestInfo acpi_guest_info;
+    Notifier machine_done;
     bool secure;
     bool highmem;
     int32_t gic_version;
@@ -1197,12 +1199,13 @@ static void virt_build_smbios(VirtGuestInfo *guest_info)
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
@@ -1215,8 +1218,7 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
-    VirtGuestInfoState *guest_info_state = g_malloc0(sizeof *guest_info_state);
-    VirtGuestInfo *guest_info = &guest_info_state->info;
+    VirtGuestInfo *guest_info = &vms->acpi_guest_info;
     char **cpustr;
     ObjectClass *oc;
     const char *typename;
@@ -1415,8 +1417,8 @@ static void machvirt_init(MachineState *machine)
     guest_info->use_highmem = vms->highmem;
     guest_info->gic_version = vms->gic_version;
     guest_info->no_its = vmc->no_its;
-    guest_info_state->machine_done.notify = virt_guest_info_machine_done;
-    qemu_add_machine_init_done_notifier(&guest_info_state->machine_done);
+    vms->machine_done.notify = virt_machine_done;
+    qemu_add_machine_init_done_notifier(&vms->machine_done);
 
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.kernel_filename = machine->kernel_filename;
-- 
2.7.4
