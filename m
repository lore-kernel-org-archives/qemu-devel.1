Received: from eggs.gnu.org ([2001:4830:134:3::10]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBl-0001n6-SV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBj-0001NU-0A
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRXBi-0001GJ-Oi
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:38 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Nov 2018 07:49:31 +0100
Message-Id: <20181127064932.7299-6-kraxel@redhat.com>
In-Reply-To: <20181127064932.7299-1-kraxel@redhat.com>
References: <20181127064932.7299-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] usb-host: set ifs.detached as true if
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, linzhecheng <linzhecheng@huawei.com>

From: linzhecheng <linzhecheng@huawei.com>

If no kernel driver is active, we can already claim and perform I/O on
it without detaching it.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Message-id: 20181120083419.17716-1-linzhecheng@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 3 +++
 1 file changed, 3 insertions(+)

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
2.9.3
