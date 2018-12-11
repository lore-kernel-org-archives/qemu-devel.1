Received: from eggs.gnu.org ([2001:4830:134:3::10]:35919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gWWW8-0002Gd-Ky
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gWWW4-00050V-NP
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:07:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59935 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gWWW4-0004y9-Ae
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:07:16 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 11 Dec 2018 09:06:56 +0800
Message-ID: <20181211010656.704-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] usb-host: reset and close
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
Cc: kraxel@redhat.com, jianjay.zhou@huawei.com, linzhecheng <linzhecheng@huawei.com>

we should perform these actions as same as usb_host_close.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

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
2.12.2.windows.2
