Received: from eggs.gnu.org ([2001:4830:134:3::10]:56672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FJ-0001ju-Pq
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FI-00059O-FC
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6FI-000590-7R
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:18 +0200
Message-Id: <20170830165252.13421-11-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/44] watchdog/wdt_diag288: Mark diag288
 watchdog as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

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
Message-Id: <1502892528-22618-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/watchdog/wdt_diag288.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index a7b64e2c40..47f289216a 100644
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
2.13.5
