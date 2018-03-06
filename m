Received: from eggs.gnu.org ([2001:4830:134:3::10]:47998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVN-0004m2-F3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVH-0006Ab-00
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:45 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:53448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVG-0006A1-LN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:38 -0500
Received: by mail-wm0-x232.google.com with SMTP id e194so3743398wmd.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:18:59 +0100
Message-Id: <1520342370-123606-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/34] scsi: Remove automatic creation of SCSI
 controllers with -drive if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Automatic creation of SCSI controllers for "-drive if=scsi" for x86
machines was quite a bad idea (see description of commit f778a82f0c179
for details). This is marked as deprecated since QEMU v2.9.0, and as
far as I know, nobody complained that this is still urgently required
anymore. Time to remove this now.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1519123357-13225-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c           | 17 -----------------
 hw/i386/pc_piix.c      |  4 ----
 hw/i386/pc_q35.c       |  3 ---
 hw/scsi/lsi53c895a.c   |  2 +-
 hw/scsi/scsi-bus.c     | 49 +------------------------------------------------
 hw/scsi/spapr_vscsi.c  |  3 +--
 include/hw/scsi/scsi.h |  2 +-
 qemu-doc.texi          |  5 -----
 tests/qemu-iotests/051 |  4 ----
 vl.c                   |  9 ---------
 10 files changed, 4 insertions(+), 94 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 94cfd40..35fcb6e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1636,23 +1636,6 @@ void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
     rom_reset_order_override();
 }
 
-void pc_pci_device_init(PCIBus *pci_bus)
-{
-    int max_bus;
-    int bus;
-
-    /* Note: if=scsi is deprecated with PC machine types */
-    max_bus = drive_get_max_bus(IF_SCSI);
-    for (bus = 0; bus <= max_bus; bus++) {
-        pci_create_simple(pci_bus, -1, "lsi53c895a");
-        /*
-         * By not creating frontends here, we make
-         * scsi_legacy_handle_cmdline() create them, and warn that
-         * this usage is deprecated.
-         */
-    }
-}
-
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
 {
     DeviceState *dev;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 456dc9e..8658bcb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -295,10 +295,6 @@ static void pc_init1(MachineState *machine,
                                  PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
     }
 
-    if (pcmc->pci_enabled) {
-        pc_pci_device_init(pci_bus);
-    }
-
     if (pcms->acpi_nvdimm_state.is_enabled) {
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index aba7541..0c0bc48 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -273,9 +273,6 @@ static void pc_q35_init(MachineState *machine)
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, host_bus);
     pc_nic_init(isa_bus, host_bus);
-    if (pcmc->pci_enabled) {
-        pc_pci_device_init(host_bus);
-    }
 
     if (pcms->acpi_nvdimm_state.is_enabled) {
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 191505d..f3d4c4d 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2277,5 +2277,5 @@ void lsi53c895a_create(PCIBus *bus)
 {
     LSIState *s = LSI53C895A(pci_create_simple(bus, -1, "lsi53c895a"));
 
-    scsi_bus_legacy_handle_cmdline(&s->bus, false);
+    scsi_bus_legacy_handle_cmdline(&s->bus);
 }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index b7bafbe..1eaeffc 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -271,7 +271,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     return SCSI_DEVICE(dev);
 }
 
-void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated)
+void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
 {
     Location loc;
     DriveInfo *dinfo;
@@ -284,59 +284,12 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated)
             continue;
         }
         qemu_opts_loc_restore(dinfo->opts);
-        if (deprecated) {
-            /* Handling -drive not claimed by machine initialization */
-            if (blk_get_attached_dev(blk_by_legacy_dinfo(dinfo))) {
-                continue;       /* claimed */
-            }
-            if (!dinfo->is_default) {
-                warn_report("bus=%d,unit=%d is deprecated with this"
-                            " machine type",
-                            bus->busnr, unit);
-            }
-        }
         scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
                                   unit, false, -1, false, NULL, &error_fatal);
     }
     loc_pop(&loc);
 }
 
-static bool is_scsi_hba_with_legacy_magic(Object *obj)
-{
-    static const char *magic[] = {
-        "am53c974", "dc390", "esp", "lsi53c810", "lsi53c895a",
-        "megasas", "megasas-gen2", "mptsas1068", "spapr-vscsi",
-        "virtio-scsi-device",
-        NULL
-    };
-    const char *typename = object_get_typename(obj);
-    int i;
-
-    for (i = 0; magic[i]; i++)
-        if (!strcmp(typename, magic[i])) {
-            return true;
-    }
-
-    return false;
-}
-
-static int scsi_legacy_handle_cmdline_cb(Object *obj, void *opaque)
-{
-    SCSIBus *bus = (SCSIBus *)object_dynamic_cast(obj, TYPE_SCSI_BUS);
-
-    if (bus && is_scsi_hba_with_legacy_magic(OBJECT(bus->qbus.parent))) {
-        scsi_bus_legacy_handle_cmdline(bus, true);
-    }
-
-    return 0;
-}
-
-void scsi_legacy_handle_cmdline(void)
-{
-    object_child_foreach_recursive(object_get_root(),
-                                   scsi_legacy_handle_cmdline_cb, NULL);
-}
-
 static int32_t scsi_invalid_field(SCSIRequest *req, uint8_t *buf)
 {
     scsi_req_build_sense(req, SENSE_CODE(INVALID_FIELD));
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 360db53..a9e49c7 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1215,8 +1215,7 @@ void spapr_vscsi_create(VIOsPAPRBus *bus)
     dev = qdev_create(&bus->bus, "spapr-vscsi");
 
     qdev_init_nofail(dev);
-    scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus,
-                                   false);
+    scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus);
 }
 
 static int spapr_vscsi_devnode(VIOsPAPRDevice *dev, void *fdt, int node_off)
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 802a647..7ecadda 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -153,7 +153,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
                                       bool share_rw,
                                       const char *serial, Error **errp);
-void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated);
+void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
 void scsi_legacy_handle_cmdline(void);
 
 SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 76ca83f..fb6fac5 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2680,11 +2680,6 @@ The ``-net vlan=NN'' argument is partially replaced with the
 new ``-netdev'' argument. The remaining use cases will no
 longer be directly supported in QEMU.
 
-@subsection -drive if=scsi (since 2.9.0)
-
-The ``-drive if=scsi'' argument is replaced by the the
-``-device BUS-TYPE'' argument combined with ``-drive if=none''.
-
 @subsection -drive cyls=...,heads=...,secs=...,trans=... (since 2.10.0)
 
 The drive geometry arguments are replaced by the the geometry arguments
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 0c3be16..f617e25 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -157,9 +157,7 @@ case "$QEMU_DEFAULT_MACHINE" in
     pc)
         run_qemu -drive if=floppy
         run_qemu -drive if=ide,media=cdrom
-        run_qemu -drive if=scsi,media=cdrom
         run_qemu -drive if=ide
-        run_qemu -drive if=scsi
         ;;
      *)
         ;;
@@ -188,9 +186,7 @@ case "$QEMU_DEFAULT_MACHINE" in
     pc)
         run_qemu -drive file="$TEST_IMG",if=floppy,readonly=on
         run_qemu -drive file="$TEST_IMG",if=ide,media=cdrom,readonly=on
-        run_qemu -drive file="$TEST_IMG",if=scsi,media=cdrom,readonly=on
         run_qemu -drive file="$TEST_IMG",if=ide,readonly=on
-        run_qemu -drive file="$TEST_IMG",if=scsi,readonly=on
         ;;
      *)
         ;;
diff --git a/vl.c b/vl.c
index a92f60c..6e4f1a2 100644
--- a/vl.c
+++ b/vl.c
@@ -4621,15 +4621,6 @@ int main(int argc, char **argv, char **envp)
 
     rom_reset_order_override();
 
-    /*
-     * Create frontends for -drive if=scsi leftovers.
-     * Normally, frontends for -drive get created by machine
-     * initialization for onboard SCSI HBAs.  However, we create a few
-     * more ever since SCSI qdevification, but this is pretty much an
-     * implementation accident, and deprecated.
-     */
-    scsi_legacy_handle_cmdline();
-
     /* Did we create any drives that we failed to create a device for? */
     drive_check_orphaned();
 
-- 
1.8.3.1
