Received: from eggs.gnu.org ([209.51.188.92]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT88-0005Mu-1v
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT82-00020q-9v
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:20:12 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:24 +0100
Message-Id: <20190118121925.24468-11-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/11] s390x/pci: Ignore the unplug call if we
 already have a release_timer
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
Message-Id: <20190114103110.10909-5-david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e5a4cf03b2..9d23c1b300 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -976,6 +976,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
