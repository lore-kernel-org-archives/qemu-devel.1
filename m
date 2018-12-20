Received: from eggs.gnu.org ([2001:4830:134:3::10]:60341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Eu-0005PT-E6
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Eo-0001LY-FX
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3Eo-0001Je-5h
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:02 -0500
Date: Thu, 20 Dec 2018 13:40:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-35-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 34/44] pci/pcihp: perform check for bus
 capability in pre_plug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: David Hildenbrand <david@redhat.com>

Perform the check in the pre_plug handler. In addition, we need the
capability only if the device is actually hotplugged (and not created
during machine initialization). This is a preparation for coldplugging
pci devices via that hotplug handler.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/pcihp.h |  2 ++
 hw/acpi/pcihp.c         | 21 +++++++++++++++------
 hw/acpi/piix4.c         | 16 ++++++++++++++--
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 8a65f99fc8..ce31625850 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -56,6 +56,8 @@ typedef struct AcpiPciHpState {
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
                      MemoryRegion *address_space_io, bool bridges_enabled);
 
+void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp);
 void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp);
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 80d42e12ff..5e7cef173c 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -217,17 +217,24 @@ void acpi_pcihp_reset(AcpiPciHpState *s)
     acpi_pcihp_update(s);
 }
 
+void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    /* Only hotplugged devices need the hotplug capability. */
+    if (dev->hotplugged &&
+        acpi_pcihp_get_bsel(pci_get_bus(PCI_DEVICE(dev))) < 0) {
+        error_setg(errp, "Unsupported bus. Bus doesn't have property '"
+                   ACPI_PCIHP_PROP_BSEL "' set");
+        return;
+    }
+}
+
 void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
-    int bsel = acpi_pcihp_get_bsel(pci_get_bus(pdev));
-    if (bsel < 0) {
-        error_setg(errp, "Unsupported bus. Bus doesn't have property '"
-                   ACPI_PCIHP_PROP_BSEL "' set");
-        return;
-    }
+    int bsel;
 
     /* Don't send event when device is enabled during qemu machine creation:
      * it is present on boot, no hotplug event is necessary. We do send an
@@ -236,6 +243,8 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
         return;
     }
 
+    bsel = acpi_pcihp_get_bsel(pci_get_bus(pdev));
+    g_assert(bsel >= 0);
     s->acpi_pcihp_pci_status[bsel].up |= (1U << slot);
     acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 2f4dd03b83..f68e62d36c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -371,6 +371,18 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
     acpi_pm1_evt_power_down(&s->ar);
 }
 
+static void piix4_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
+    } else if (!object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
+               !object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        error_setg(errp, "acpi: device pre plug request for not supported"
+                   " device type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
 static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
                                  DeviceState *dev, Error **errp)
 {
@@ -393,8 +405,7 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
             acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
         }
     } else {
-        error_setg(errp, "acpi: device plug request for not supported device"
-                   " type: %s", object_get_typename(OBJECT(dev)));
+        g_assert_not_reached();
     }
 }
 
@@ -703,6 +714,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
      */
     dc->user_creatable = false;
     dc->hotpluggable = false;
+    hc->pre_plug = piix4_device_pre_plug_cb;
     hc->plug = piix4_device_plug_cb;
     hc->unplug_request = piix4_device_unplug_request_cb;
     hc->unplug = piix4_device_unplug_cb;
-- 
MST
