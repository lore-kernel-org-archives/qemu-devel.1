Received: from eggs.gnu.org ([209.51.188.92]:46846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFL-00075b-F3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFJ-0008Vo-LW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:51 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Jan 2019 16:57:31 +0100
Message-Id: <20190130155733.32742-5-david@redhat.com>
In-Reply-To: <20190130155733.32742-1-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] s390x/pci: Introduce unplug requests
 and split unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>

PCI on s390x is really weird and how it was modeled in QEMU might not have
been the right choice. Anyhow, right now it is the case that:
- Hotplugging a PCI device will silently create a zPCI device
  (if none is provided)
- Hotunplugging a zPCI device will unplug the PCI device (if any)
- Hotunplugging a PCI device will unplug also the zPCI device
As far as I can see, we can no longer change this behavior. But we
should fix it.

Both device types are handled via a single hotplug handler call. This
is problematic for various reasons:
1. Unplugging via the zPCI device allows to unplug devices that are not
   hot removable. (check performed in qdev_unplug()) - bad.
2. Hotplug handler chains are not possible for the unplug case. In the
   future, the machine might want to override hotplug handlers, to
   process device specific stuff and to then branch off to the actual
   hotplug handler. We need separate hotplug handler calls for both the
   PCI and zPCI device to make this work reliably. All other PCI
   implementations are already prepared to handle this correctly, only
   s390x is missing.

Therefore, introduce the unplug_request handler and properly perform
unplug checks by redirecting to the separate unplug_request handlers.
When finally unplugging, perform two separate hotplug_handler_unplug()
calls, first for the PCI device, followed by the zPCI device. This now
nicely splits unplugging paths for both devices.

The redirect part is a little hairy, as the user is allowed to trigger
unplug either via the PCI or the zPCI device. So redirect always to the
PCI unplug request handler first and remember if that check has been
performed in the zPCI device. Redirect then to the zPCI device unplug
request handler to perform the magic. Remembering that we already
checked the PCI device breaks the redirect loop.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 166 +++++++++++++++++++++++++++-------------
 hw/s390x/s390-pci-bus.h |   1 +
 2 files changed, 113 insertions(+), 54 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2efd9186c2..e84e00d20c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -148,6 +148,22 @@ out:
     psccb->header.response_code = cpu_to_be16(rc);
 }
 
+static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
+{
+    HotplugHandler *hotplug_ctrl;
+
+    /* Unplug the PCI device */
+    if (pbdev->pdev) {
+        hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(pbdev->pdev));
+        hotplug_handler_unplug(hotplug_ctrl, DEVICE(pbdev->pdev),
+                               &error_abort);
+    }
+
+    /* Unplug the zPCI device */
+    hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(pbdev));
+    hotplug_handler_unplug(hotplug_ctrl, DEVICE(pbdev), &error_abort);
+}
+
 void s390_pci_sclp_deconfigure(SCCB *sccb)
 {
     IoaCfgSccb *psccb = (IoaCfgSccb *)sccb;
@@ -179,7 +195,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
         rc = SCLP_RC_NORMAL_COMPLETION;
 
         if (pbdev->release_timer) {
-            qdev_unplug(DEVICE(pbdev->pdev), NULL);
+            s390_pci_perform_unplug(pbdev);
         }
     }
 out:
@@ -217,6 +233,24 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
     return NULL;
 }
 
+static S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
+                                                  PCIDevice *pci_dev)
+{
+    S390PCIBusDevice *pbdev;
+
+    if (!pci_dev) {
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
+        if (pbdev->pdev == pci_dev) {
+            return pbdev;
+        }
+    }
+
+    return NULL;
+}
+
 S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx)
 {
     return g_hash_table_lookup(s->zpci_table, &idx);
@@ -955,77 +989,100 @@ static void s390_pcihost_timer_cb(void *opaque)
     pbdev->state = ZPCI_FS_STANDBY;
     s390_pci_generate_plug_event(HP_EVENT_CONFIGURED_TO_STBRES,
                                  pbdev->fh, pbdev->fid);
-    qdev_unplug(DEVICE(pbdev), NULL);
+    s390_pci_perform_unplug(pbdev);
 }
 
 static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
-    PCIDevice *pci_dev = NULL;
-    PCIBus *bus;
-    int32_t devfn;
     S390PCIBusDevice *pbdev = NULL;
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        PCIDevice *pci_dev = PCI_DEVICE(dev);
+        PCIBus *bus;
+        int32_t devfn;
+
+        pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
+        g_assert(pbdev);
+
+        s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
+                                     pbdev->fh, pbdev->fid);
+        bus = pci_get_bus(pci_dev);
+        devfn = pci_dev->devfn;
+        object_unparent(OBJECT(pci_dev));
+
+        s390_pci_msix_free(pbdev);
+        s390_pci_iommu_free(s, bus, devfn);
+        pbdev->pdev = NULL;
+        pbdev->state = ZPCI_FS_RESERVED;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
+        pbdev = S390_PCI_DEVICE(dev);
+
+        if (pbdev->release_timer) {
+            timer_del(pbdev->release_timer);
+            timer_free(pbdev->release_timer);
+            pbdev->release_timer = NULL;
+        }
+        pbdev->fid = 0;
+        QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
+        g_hash_table_remove(s->zpci_table, &pbdev->idx);
+        object_unparent(OBJECT(pbdev));
+    }
+}
+
+static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev,
+                                        Error **errp)
+{
+    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
+    S390PCIBusDevice *pbdev;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
         error_setg(errp, "PCI bridge hot unplug currently not supported");
-        return;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        pci_dev = PCI_DEVICE(dev);
-
-        QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
-            if (pbdev->pdev == pci_dev) {
-                break;
-            }
-        }
-        assert(pbdev != NULL);
+        /*
+         * Redirect the unplug request to the zPCI device and remember that
+         * we've checked the PCI device already (to prevent endless recursion).
+         */
+        pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
+        g_assert(pbdev);
+        pbdev->pci_unplug_request_processed = true;
+        qdev_unplug(DEVICE(pbdev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
-        pci_dev = pbdev->pdev;
-    } else {
-        g_assert_not_reached();
-    }
 
-    switch (pbdev->state) {
-    case ZPCI_FS_RESERVED:
-        goto out;
-    case ZPCI_FS_STANDBY:
-        break;
-    default:
-        if (pbdev->release_timer) {
+        /*
+         * If unplug was initially requested for the zPCI device, we
+         * first have to redirect to the PCI device, which will in return
+         * redirect back to us after performing its checks (if the request
+         * is not blocked, e.g. because it's a PCI bridge).
+         */
+        if (pbdev->pdev && !pbdev->pci_unplug_request_processed) {
+            qdev_unplug(DEVICE(pbdev->pdev), errp);
             return;
         }
-        s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
-                                     pbdev->fh, pbdev->fid);
-        pbdev->release_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                            s390_pcihost_timer_cb,
-                                            pbdev);
-        timer_mod(pbdev->release_timer,
-                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + HOT_UNPLUG_TIMEOUT);
-        return;
-    }
+        pbdev->pci_unplug_request_processed = false;
 
-    if (pbdev->release_timer) {
-        timer_del(pbdev->release_timer);
-        timer_free(pbdev->release_timer);
-        pbdev->release_timer = NULL;
+        switch (pbdev->state) {
+        case ZPCI_FS_STANDBY:
+        case ZPCI_FS_RESERVED:
+            s390_pci_perform_unplug(pbdev);
+            break;
+        default:
+            if (pbdev->release_timer) {
+                return;
+            }
+            s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
+                                         pbdev->fh, pbdev->fid);
+            pbdev->release_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                                s390_pcihost_timer_cb, pbdev);
+            timer_mod(pbdev->release_timer,
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + HOT_UNPLUG_TIMEOUT);
+        }
+    } else {
+        g_assert_not_reached();
     }
-
-    s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
-                                 pbdev->fh, pbdev->fid);
-    bus = pci_get_bus(pci_dev);
-    devfn = pci_dev->devfn;
-    object_unparent(OBJECT(pci_dev));
-    fmb_timer_free(pbdev);
-    s390_pci_msix_free(pbdev);
-    s390_pci_iommu_free(s, bus, devfn);
-    pbdev->pdev = NULL;
-    pbdev->state = ZPCI_FS_RESERVED;
-out:
-    pbdev->fid = 0;
-    QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
-    g_hash_table_remove(s->zpci_table, &pbdev->idx);
-    object_unparent(OBJECT(pbdev));
 }
 
 static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
@@ -1077,6 +1134,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
     dc->realize = s390_pcihost_realize;
     hc->pre_plug = s390_pcihost_pre_plug;
     hc->plug = s390_pcihost_plug;
+    hc->unplug_request = s390_pcihost_unplug_request;
     hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
 }
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index dadad1f758..b1a6bb8296 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -336,6 +336,7 @@ struct S390PCIBusDevice {
     IndAddr *summary_ind;
     IndAddr *indicator;
     QEMUTimer *release_timer;
+    bool pci_unplug_request_processed;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
-- 
2.17.2
