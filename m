Received: from eggs.gnu.org ([209.51.188.92]:51207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gizWv-0004ba-Ia
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gizWu-0001Kf-I2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:31:41 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 Jan 2019 11:31:08 +0100
Message-Id: <20190114103110.10909-5-david@redhat.com>
In-Reply-To: <20190114103110.10909-1-david@redhat.com>
References: <20190114103110.10909-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] s390x/pci: Ignore the unplug call if we
 already have a release_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

... otherwise two successive calls to qdev_unplug() (e.g. by an impatient
user) will effectively overwrite pbdev->release_timer, resulting in a
memory leak. We are already processing the unplug.

If there is already a release_timer, the unplug will be performed after
the timeout.

Can be easily triggered by
(hmp) device_add virtio-mouse-pci,id=test
(hmp) stop
(hmp) device_del test
(hmp) device_del test

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 59325cae3b..34a9cb2a80 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -972,6 +972,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     case ZPCI_FS_STANDBY:
         break;
     default:
+        if (pbdev->release_timer) {
+            return;
+        }
         s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
                                      pbdev->fh, pbdev->fid);
         pbdev->release_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-- 
2.17.2
