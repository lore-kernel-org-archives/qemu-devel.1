Received: from eggs.gnu.org ([209.51.188.92]:54728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nD-0001Qv-Lr
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nB-00083O-M2
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:51 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:41:03 +0100
Message-Id: <20190205164109.25413-5-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
References: <20190205164109.25413-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/10] s390x/pci: Drop release timer and replace
 it with a flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's handle it similar to x86 ACPI PCI code and don't use a timer.
Instead, remember if an unplug request is pending and keep it pending
for eternity. (a follow up patch will process the request on
reboot).

We expect that a guest that is up and running, will process the unplug
request and trigger the unplug. This is normal operation, no timer needed.

If the guest does not react, this usually means something in the guest
is going wrong. Simply removing the device after 30 seconds does not
really sound like a good idea. It might sometimes be wanted, but I
consider this rather an "opt-in" decision as it might harm a guest not
prepared for it.

If we ever actually want a "forced/surprise removal", we will have to
implement something on top of the existing "device_del" framework. E.g.
also x86 might want to do a forced/surprise removal of PCI devices under
some conditions. "device_del X, forced=true" could be an option and will
require changes to the hotplug handler infrastructure.

This will then move the responsibility on when to do a forced removal
to a higher level. Doing a forced removal right now over-complicates
things and doesn't really seem to be required.

Let's allow to send multiple requests.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190130155733.32742-6-david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 38 +++++++-------------------------------
 hw/s390x/s390-pci-bus.h |  3 +--
 2 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index bc17a8cf65..c96a7cba34 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -194,7 +194,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
         pbdev->state = ZPCI_FS_STANDBY;
         rc = SCLP_RC_NORMAL_COMPLETION;
 
-        if (pbdev->release_timer) {
+        if (pbdev->unplug_requested) {
             s390_pci_perform_unplug(pbdev);
         }
     }
@@ -959,23 +959,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-static void s390_pcihost_timer_cb(void *opaque)
-{
-    S390PCIBusDevice *pbdev = opaque;
-
-    if (pbdev->summary_ind) {
-        pci_dereg_irqs(pbdev);
-    }
-    if (pbdev->iommu->enabled) {
-        pci_dereg_ioat(pbdev->iommu);
-    }
-
-    pbdev->state = ZPCI_FS_STANDBY;
-    s390_pci_generate_plug_event(HP_EVENT_CONFIGURED_TO_STBRES,
-                                 pbdev->fh, pbdev->fid);
-    s390_pci_perform_unplug(pbdev);
-}
-
 static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
@@ -1002,12 +985,6 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->state = ZPCI_FS_RESERVED;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
-
-        if (pbdev->release_timer) {
-            timer_del(pbdev->release_timer);
-            timer_free(pbdev->release_timer);
-            pbdev->release_timer = NULL;
-        }
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
@@ -1054,15 +1031,14 @@ static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
             s390_pci_perform_unplug(pbdev);
             break;
         default:
-            if (pbdev->release_timer) {
-                return;
-            }
+            /*
+             * Allow to send multiple requests, e.g. if the guest crashed
+             * before releasing the device, we would not be able to send
+             * another request to the same VM (e.g. fresh OS).
+             */
+            pbdev->unplug_requested = true;
             s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
                                          pbdev->fh, pbdev->fid);
-            pbdev->release_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                                s390_pcihost_timer_cb, pbdev);
-            timer_mod(pbdev->release_timer,
-                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + HOT_UNPLUG_TIMEOUT);
         }
     } else {
         g_assert_not_reached();
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index b1a6bb8296..550f3cc5e9 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -35,7 +35,6 @@
 #define ZPCI_MAX_UID 0xffff
 #define UID_UNDEFINED 0
 #define UID_CHECKING_ENABLED 0x01
-#define HOT_UNPLUG_TIMEOUT (NANOSECONDS_PER_SECOND * 60 * 5)
 
 #define S390_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(S390pciState, (obj), TYPE_S390_PCI_HOST_BRIDGE)
@@ -335,8 +334,8 @@ struct S390PCIBusDevice {
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
-    QEMUTimer *release_timer;
     bool pci_unplug_request_processed;
+    bool unplug_requested;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
-- 
2.17.2
