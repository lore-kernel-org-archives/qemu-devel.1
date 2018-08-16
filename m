Received: from eggs.gnu.org ([2001:4830:134:3::10]:38254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fqEpi-0005h5-Du
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fqEpd-0000OJ-SG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:44:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2562 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fqEpd-0000JE-5T
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:44:41 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 16 Aug 2018 17:43:56 +0800
Message-ID: <20180816094356.16396-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] usb-host: insert usb device into hostdevs to
 be scaned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, wangxinxin.wang@huawei.com, linzhecheng <linzhecheng@huawei.com>

According to the comment of usb_host_post_load_bh, after removing the
usb device passed through, we will kick host to scan it again, but the emulated
usb device is not added to global list hostdevs, so it can never be discovered then.
So just do it before usb_host_auto_check. What's more, it's futile to walk devs in
usb_host_auto_check periodically if hostdevs is empty, so let's delete the usb_auto_timer.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index f31e9cbbb8..632abaa390 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1534,6 +1534,10 @@ static void usb_host_post_load_bh(void *opaque)
         usb_device_detach(udev);
     }
     dev->bh_postld_pending = false;
+    if (!dev->needs_autoscan) {
+        dev->needs_autoscan = true;
+        QTAILQ_INSERT_TAIL(&hostdevs, dev, next);
+    }
     usb_host_auto_check(NULL);
 }
 
@@ -1631,6 +1635,14 @@ static void usb_host_auto_check(void *unused)
     int unconnected = 0;
     int i, n;
 
+    if (QTAILQ_EMPTY(&hostdevs)) {
+        if (usb_auto_timer) {
+            timer_del(usb_auto_timer);
+            usb_auto_timer = NULL;
+        }
+        return;
+    }
+
     if (usb_host_init() != 0) {
         return;
     }
@@ -1682,6 +1694,8 @@ static void usb_host_auto_check(void *unused)
                     s->errcount++;
                     continue;
                 }
+                s->needs_autoscan = false;
+                QTAILQ_REMOVE(&hostdevs, s, next);
                 break;
             }
         }
-- 
2.12.2.windows.2
