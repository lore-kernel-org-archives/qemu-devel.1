Received: from eggs.gnu.org ([208.118.235.92]:51394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf36y-0005Wz-IU
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf36t-0000Hr-Io
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:32:36 -0500
Received: from m12-16.163.com ([220.181.12.16]:46269)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf36t-0000HZ-0E
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:32:31 -0500
From: Li Qiang <liq3ea@163.com>
Date: Thu,  3 Jan 2019 05:31:13 -0800
Message-Id: <20190103133113.49599-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] usb: dev-mtp: close fd in
 usb_mtp_object_readdir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Li Qiang <liq3ea@163.com>

Spotted by Coverity: CID 1397070

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/usb/dev-mtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index b19b576278..666bafd9e8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -666,6 +666,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
     }
     dir = fdopendir(fd);
     if (!dir) {
+        close(fd);
         return;
     }
 #ifdef CONFIG_INOTIFY1
@@ -682,6 +683,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
         usb_mtp_add_child(s, o, entry->d_name);
     }
     closedir(dir);
+    close(fd);
 }
 
 /* ----------------------------------------------------------------------- */
-- 
2.17.1
