Received: from eggs.gnu.org ([2001:4830:134:3::10]:34471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlxr-0006Vd-25
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlxm-00024r-17
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:27:55 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jan 2017 16:27:33 +0100
Message-Id: <1485444454-30749-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1485444454-30749-1-git-send-email-armbru@redhat.com>
References: <1485444454-30749-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] hw: Deprecate -drive if=scsi with
 non-onboard HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Block backends defined with "-drive if=T" with T other than "none" are
meant to be picked up by machine initialization code: a suitable
frontend gets created and wired up automatically.

Drives defined with if=scsi are also picked up by SCSI HBAs added with
-device, unlike other interface types.  Deprecate this usage, as follows.

Create the frontends for onboard HBAs in machine initialization code,
exactly like we do for if=ide and other interface types.  Change
scsi_legacy_handle_cmdline() to create a frontend only when it's still
missing, and warn that this usage is deprecated.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/realview.c      |  2 +-
 hw/arm/versatilepb.c   |  2 +-
 hw/i386/pc.c           |  2 +-
 hw/scsi/lsi53c895a.c   |  7 +++++++
 hw/scsi/scsi-bus.c     | 13 +++++++++++--
 hw/scsi/spapr_vscsi.c  |  2 ++
 include/hw/pci/pci.h   |  2 ++
 include/hw/scsi/scsi.h |  2 +-
 vl.c                   |  8 +++++++-
 9 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 8c11c7a..b7d4753 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -259,7 +259,7 @@ static void realview_init(MachineState *machine,
         }
         n = drive_get_max_bus(IF_SCSI);
         while (n >= 0) {
-            pci_create_simple(pci_bus, -1, "lsi53c895a");
+            lsi53c895a_create(pci_bus);
             n--;
         }
     }
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 7b5cb36..b0e9f5b 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -290,7 +290,7 @@ static void versatile_init(MachineState *machine, int board_id)
     }
     n = drive_get_max_bus(IF_SCSI);
     while (n >= 0) {
-        pci_create_simple(pci_bus, -1, "lsi53c895a");
+        lsi53c895a_create(pci_bus);
         n--;
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8d2a848..c345c04 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1652,7 +1652,7 @@ void pc_pci_device_init(PCIBus *pci_bus)
 
     max_bus = drive_get_max_bus(IF_SCSI);
     for (bus = 0; bus <= max_bus; bus++) {
-        pci_create_simple(pci_bus, -1, "lsi53c895a");
+        lsi53c895a_create(pci_bus);
     }
 }
 
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 292fa87..595c260 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2268,3 +2268,10 @@ static void lsi53c895a_register_types(void)
 }
 
 type_init(lsi53c895a_register_types)
+
+void lsi53c895a_create(PCIBus *bus)
+{
+    LSIState *s = LSI53C895A(pci_create_simple(bus, -1, "lsi53c895a"));
+
+    scsi_bus_legacy_handle_cmdline(&s->bus, false);
+}
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index b9111ee..4ca3fb2 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -261,7 +261,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     return SCSI_DEVICE(dev);
 }
 
-void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
+void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated)
 {
     Location loc;
     DriveInfo *dinfo;
@@ -274,6 +274,15 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
             continue;
         }
         qemu_opts_loc_restore(dinfo->opts);
+        if (deprecated) {
+            /* Handling -drive not claimed by machine initialization */
+            if (blk_get_attached_dev(blk_by_legacy_dinfo(dinfo))) {
+                continue;       /* claimed */
+            }
+            error_report("warning: bus=%d,unit=%d is deprecated with this"
+                         " machine type",
+                         bus->busnr, unit);
+        }
         scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
                                   unit, false, -1, NULL, &error_fatal);
     }
@@ -304,7 +313,7 @@ static int scsi_legacy_handle_cmdline_cb(Object *obj, void *opaque)
     SCSIBus *bus = (SCSIBus *)object_dynamic_cast(obj, TYPE_SCSI_BUS);
 
     if (bus && is_scsi_hba_with_legacy_magic(OBJECT(bus->qbus.parent))) {
-        scsi_bus_legacy_handle_cmdline(bus);
+        scsi_bus_legacy_handle_cmdline(bus, true);
     }
 
     return 0;
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7d44771..55ee48c 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1215,6 +1215,8 @@ void spapr_vscsi_create(VIOsPAPRBus *bus)
     dev = qdev_create(&bus->bus, "spapr-vscsi");
 
     qdev_init_nofail(dev);
+    scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus,
+                                   false);
 }
 
 static int spapr_vscsi_devnode(VIOsPAPRDevice *dev, void *fdt, int node_off)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 772692f..961ef39 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -686,6 +686,8 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
 PCIDevice *pci_create(PCIBus *bus, int devfn, const char *name);
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
 
+void lsi53c895a_create(PCIBus *bus);
+
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index eeef949..6b85786 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -177,7 +177,7 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
                                       const char *serial, Error **errp);
-void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
+void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated);
 void scsi_legacy_handle_cmdline(void);
 
 /*
diff --git a/vl.c b/vl.c
index e4657fb..99840a8 100644
--- a/vl.c
+++ b/vl.c
@@ -4557,7 +4557,13 @@ int main(int argc, char **argv, char **envp)
 
     rom_reset_order_override();
 
-    /* Create frontends for -drive if=scsi */
+    /*
+     * Create frontends for -drive if=scsi leftovers.
+     * Normally, frontends for -drive get created by machine
+     * initialization for onboard SCSI HBAs.  However, we create a few
+     * more ever since SCSI qdevification, but this is pretty much an
+     * implementation accident, and deprecated.
+     */
     scsi_legacy_handle_cmdline();
 
     /* Did we create any drives that we failed to create a device for? */
-- 
2.7.4
