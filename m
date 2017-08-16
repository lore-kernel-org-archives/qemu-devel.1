Received: from eggs.gnu.org ([2001:4830:134:3::10]:60295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhz0G-00063d-4P
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhz0A-0004L5-Am
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dhz0A-0004KU-4L
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 10:08:54 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 16 Aug 2017 16:08:48 +0200
Message-Id: <1502892528-22618-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/watchdog/wdt_diag288: Mark diag288 watchdog
 as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>

QEMU currently aborts when the user tries to hot-unplug a diag288
device:

$ qemu-system-s390x -nographic -nodefaults -S -monitor stdio
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) device_add diag288,id=x
(qemu) device_del x
**
ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
Aborted (core dumped)

The device is not designed as hot-pluggable (it should only be used
via the "-watchdog" parameter), so let's simply remove the possibility
to hotplug it to prevent that users can run into this ugly situation.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/watchdog/wdt_diag288.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index a7b64e2..47f2892 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -121,6 +121,7 @@ static void wdt_diag288_class_init(ObjectClass *klass, void *data)
     dc->realize = wdt_diag288_realize;
     dc->unrealize = wdt_diag288_unrealize;
     dc->reset = wdt_diag288_reset;
+    dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->vmsd = &vmstate_diag288;
     diag288->handle_timer = wdt_diag288_handle_timer;
-- 
1.8.3.1
