Received: from eggs.gnu.org ([2001:4830:134:3::10]:58736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gP1UX-0003zZ-Uv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gP1UU-0008Kw-Gc
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:34:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39927 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gP1UU-0008Jb-4o
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:34:38 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 20 Nov 2018 16:34:19 +0800
Message-ID: <20181120083419.17716-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] usb-host: set ifs.detached as true if
 kernel driver is not active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, jianjay.zhou@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, linzhecheng <linzhecheng@huawei.com>

If no kernel driver is active, we can already claim and perform I/O on
it without detaching it.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index f31e9cbbb8..b6602ded4e 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1120,6 +1120,9 @@ static void usb_host_detach_kernel(USBHostDevice *s)
         rc = libusb_kernel_driver_active(s->dh, i);
         usb_host_libusb_error("libusb_kernel_driver_active", rc);
         if (rc != 1) {
+            if (rc == 0) {
+                s->ifs[i].detached = true;
+            }
             continue;
         }
         trace_usb_host_detach_kernel(s->bus_num, s->addr, i);
-- 
2.12.2.windows.2
