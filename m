Received: from eggs.gnu.org ([2001:4830:134:3::10]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eZ-0007ed-9l
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eW-00083j-9e
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg9eW-000835-1t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39CED61B91
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 12:34:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1LCYgrK011832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:34:43 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 13:34:37 +0100
Message-Id: <1487680479-15132-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1487680479-15132-1-git-send-email-armbru@redhat.com>
References: <1487680479-15132-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] hw/scsi: Concentrate -drive if=scsi
 auto-create in one place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The logic to create frontends for -drive if=scsi is in SCSI HBAs.  For
all other interface types, it's in machine initialization code.

A few machine types create the SCSI HBAs necessary for that.  That's
also not done for other interface types.

I'm going to deprecate these SCSI eccentricities.  In preparation for
that, create the frontends in main() instead of the SCSI HBAs, by
calling new function scsi_legacy_handle_cmdline() there.

Note that not all SCSI HBAs create frontends.  Take care not to change
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1487161136-9018-2-git-send-email-armbru@redhat.com>
Acked-By: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp-pci.c      |  3 ---
 hw/scsi/esp.c          |  6 ------
 hw/scsi/lsi53c895a.c   |  3 ---
 hw/scsi/megasas.c      |  4 ----
 hw/scsi/mptsas.c       |  4 ----
 hw/scsi/scsi-bus.c     | 45 ++++++++++++++++++++++++++++++++++++++-------
 hw/scsi/spapr_vscsi.c  |  3 ---
 hw/scsi/virtio-scsi.c  |  8 --------
 include/hw/scsi/scsi.h |  3 ++-
 vl.c                   |  4 ++++
 10 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 595f88b..e295d88 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -367,9 +367,6 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
     s->irq = pci_allocate_irq(dev);
 
     scsi_bus_new(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info, NULL);
-    if (!d->hotplugged) {
-        scsi_bus_legacy_handle_cmdline(&s->bus, errp);
-    }
 }
 
 static void esp_pci_scsi_uninit(PCIDevice *d)
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5a5a4e9..eee831e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -690,7 +690,6 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     SysBusESPState *sysbus = ESP(dev);
     ESPState *s = &sysbus->esp;
-    Error *err = NULL;
 
     sysbus_init_irq(sbd, &s->irq);
     assert(sysbus->it_shift != -1);
@@ -703,11 +702,6 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
 
     scsi_bus_new(&s->bus, sizeof(s->bus), dev, &esp_scsi_info, NULL);
-    scsi_bus_legacy_handle_cmdline(&s->bus, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
-        return;
-    }
 }
 
 static void sysbus_esp_hard_reset(DeviceState *dev)
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index feb1191..292fa87 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2216,9 +2216,6 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     QTAILQ_INIT(&s->queue);
 
     scsi_bus_new(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, NULL);
-    if (!d->hotplugged) {
-        scsi_bus_legacy_handle_cmdline(&s->bus, errp);
-    }
 }
 
 static void lsi_scsi_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 1a8b04c..e3d59b7 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2325,7 +2325,6 @@ static const struct SCSIBusInfo megasas_scsi_info = {
 
 static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 {
-    DeviceState *d = DEVICE(dev);
     MegasasState *s = MEGASAS(dev);
     MegasasBaseClass *b = MEGASAS_DEVICE_GET_CLASS(s);
     uint8_t *pci_conf;
@@ -2426,9 +2425,6 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
                  &megasas_scsi_info, NULL);
-    if (!d->hotplugged) {
-        scsi_bus_legacy_handle_cmdline(&s->bus, errp);
-    }
 }
 
 static Property megasas_properties_gen1[] = {
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index ad87e78..2e091c0 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1271,7 +1271,6 @@ static const struct SCSIBusInfo mptsas_scsi_info = {
 
 static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
 {
-    DeviceState *d = DEVICE(dev);
     MPTSASState *s = MPT_SAS(dev);
     Error *err = NULL;
     int ret;
@@ -1326,9 +1325,6 @@ static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
     QTAILQ_INIT(&s->pending);
 
     scsi_bus_new(&s->bus, sizeof(s->bus), &dev->qdev, &mptsas_scsi_info, NULL);
-    if (!d->hotplugged) {
-        scsi_bus_legacy_handle_cmdline(&s->bus, errp);
-    }
 }
 
 static void mptsas_scsi_uninit(PCIDevice *dev)
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 5940cb1..b9111ee 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -261,12 +261,11 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     return SCSI_DEVICE(dev);
 }
 
-void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, Error **errp)
+void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
 {
     Location loc;
     DriveInfo *dinfo;
     int unit;
-    Error *err = NULL;
 
     loc_push_none(&loc);
     for (unit = 0; unit <= bus->info->max_target; unit++) {
@@ -276,15 +275,47 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, Error **errp)
         }
         qemu_opts_loc_restore(dinfo->opts);
         scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
-                                  unit, false, -1, NULL, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            break;
-        }
+                                  unit, false, -1, NULL, &error_fatal);
     }
     loc_pop(&loc);
 }
 
+static bool is_scsi_hba_with_legacy_magic(Object *obj)
+{
+    static const char *magic[] = {
+        "am53c974", "dc390", "esp", "lsi53c810", "lsi53c895a",
+        "megasas", "megasas-gen2", "mptsas1068", "spapr-vscsi",
+        "virtio-scsi-device",
+        NULL
+    };
+    const char *typename = object_get_typename(obj);
+    int i;
+
+    for (i = 0; magic[i]; i++)
+        if (!strcmp(typename, magic[i])) {
+            return true;
+    }
+
+    return false;
+}
+
+static int scsi_legacy_handle_cmdline_cb(Object *obj, void *opaque)
+{
+    SCSIBus *bus = (SCSIBus *)object_dynamic_cast(obj, TYPE_SCSI_BUS);
+
+    if (bus && is_scsi_hba_with_legacy_magic(OBJECT(bus->qbus.parent))) {
+        scsi_bus_legacy_handle_cmdline(bus);
+    }
+
+    return 0;
+}
+
+void scsi_legacy_handle_cmdline(void)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   scsi_legacy_handle_cmdline_cb, NULL);
+}
+
 static int32_t scsi_invalid_field(SCSIRequest *req, uint8_t *buf)
 {
     scsi_req_build_sense(req, SENSE_CODE(INVALID_FIELD));
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 6090a20..7d44771 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1206,9 +1206,6 @@ static void spapr_vscsi_realize(VIOsPAPRDevice *dev, Error **errp)
 
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
                  &vscsi_scsi_info, NULL);
-    if (!dev->qdev.hotplugged) {
-        scsi_bus_legacy_handle_cmdline(&s->bus, errp);
-    }
 }
 
 void spapr_vscsi_create(VIOsPAPRBus *bus)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index b01030b..4fb9259 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -897,14 +897,6 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     /* override default SCSI bus hotplug-handler, with virtio-scsi's one */
     qbus_set_hotplug_handler(BUS(&s->bus), dev, &error_abort);
 
-    if (!dev->hotplugged) {
-        scsi_bus_legacy_handle_cmdline(&s->bus, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            return;
-        }
-    }
-
     virtio_scsi_dataplane_setup(s, errp);
 }
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 9bad49e..eeef949 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -177,7 +177,8 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
                                       const char *serial, Error **errp);
-void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, Error **errp);
+void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
+void scsi_legacy_handle_cmdline(void);
 
 /*
  * Predefined sense codes
diff --git a/vl.c b/vl.c
index 27d9829..ab40889 100644
--- a/vl.c
+++ b/vl.c
@@ -62,6 +62,7 @@ int main(int argc, char **argv)
 #include "hw/usb.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
+#include "hw/scsi/scsi.h"
 #include "hw/bt.h"
 #include "sysemu/watchdog.h"
 #include "hw/smbios/smbios.h"
@@ -4509,6 +4510,9 @@ int main(int argc, char **argv, char **envp)
 
     rom_reset_order_override();
 
+    /* Create frontends for -drive if=scsi */
+    scsi_legacy_handle_cmdline();
+
     /* Did we create any drives that we failed to create a device for? */
     drive_check_orphaned();
 
-- 
2.7.4
