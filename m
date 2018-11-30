Received: from eggs.gnu.org ([2001:4830:134:3::10]:44336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gScaE-0001rL-Do
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gScaB-0003Fo-7B
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:47:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40694 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gScaA-0003CT-QL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:47:23 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Fri, 30 Nov 2018 14:47:00 +0800
Message-ID: <20181130064700.5984-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] usb-host: reset and close libusb_device_handle
 before qemu exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, jianjay.zhou@huawei.com, wangxinxin.wang@huawei.com, linzhecheng <linzhecheng@huawei.com>

we should perform these things as same as usb_host_close.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b6602ded4e..2016375e6b 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -988,7 +988,9 @@ static void usb_host_exit_notifier(struct Notifier *n, void *data)
 
     if (s->dh) {
         usb_host_release_interfaces(s);
+	libusb_reset_device(s->dh);
         usb_host_attach_kernel(s);
+	libusb_close(s->dh);
     }
 }
 
-- 
2.12.2.windows.2
