Received: from eggs.gnu.org ([2001:4830:134:3::10]:34521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks3-0008TZ-A2
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks0-00056b-Jj
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gXks0-00055l-DE
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:00 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 14 Dec 2018 11:38:51 +0100
Message-Id: <20181214103854.13820-3-kraxel@redhat.com>
In-Reply-To: <20181214103854.13820-1-kraxel@redhat.com>
References: <20181214103854.13820-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] usb-host: reset and close
 libusb_device_handle before qemu exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, linzhecheng <linzhecheng@huawei.com>

From: linzhecheng <linzhecheng@huawei.com>

we should perform these things as same as usb_host_close.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Message-id: 20181130064700.5984-1-linzhecheng@huawei.com

[ kraxel: whitespace fixup ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b6602ded4e..833250a886 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -988,7 +988,9 @@ static void usb_host_exit_notifier(struct Notifier *n, void *data)
 
     if (s->dh) {
         usb_host_release_interfaces(s);
+        libusb_reset_device(s->dh);
         usb_host_attach_kernel(s);
+        libusb_close(s->dh);
     }
 }
 
-- 
2.9.3
