Received: from eggs.gnu.org ([2001:4830:134:3::10]:42568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkACY-0005Zn-At
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkACX-0001tn-77
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:30:42 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Aug 2017 16:30:31 +0200
Message-Id: <1503412231-13961-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/arm/digic: Mark device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Antony Pavlov <antonynpavlov@gmail.com>

QEMU currently shows some unexpected behavior when the user trys to
do a "device_add digic" on an unrelated ARM machine like integratorcp
in "-nographic" mode (the device_add command does not immediately
return to the monitor prompt), and trying to "device_del" the device
later results in a "qemu/qdev-monitor.c:872:qdev_unplug: assertion
failed: (hotplug_ctrl)" error condition.
Looking at the realize function of the device, it uses serial_hds
directly and this means that the device can not be added a second
time, so let's simply mark it with "user_creatable = false" now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Updated the comment and the patch description

 hw/arm/digic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 94f3263..6184020 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -101,6 +101,8 @@ static void digic_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = digic_realize;
+    /* Reason: Uses serial_hds in the realize function --> not usable twice */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo digic_type_info = {
-- 
1.8.3.1
