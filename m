Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSj-0005Eq-ES
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSW-00050I-FN
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSW-0004yH-9t
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:32 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSV-0005dq-57
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:26:05 +0100
Message-Id: <1504527967-29248-35-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 34/36] hw/arm/digic: Mark device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
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
2.7.4
