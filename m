Received: from eggs.gnu.org ([2001:4830:134:3::10]:60538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=oBba=ZH=redhat.com=mst@kernel.org>)
	id 1cWVUz-00058g-DF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=oBba=ZH=redhat.com=mst@kernel.org>)
	id 1cWVUw-0001Zk-Bx
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:53:01 -0500
Received: from mail.kernel.org ([198.145.29.136]:44220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=oBba=ZH=redhat.com=mst@kernel.org>)
	id 1cWVUw-0001Xp-5I
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:52:58 -0500
Date: Wed, 25 Jan 2017 23:52:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485381149-19044-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] qxl: switch to constants within BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

We are switching BUILD_BUG_ON to verify that it's parameter is a
compile-time constant, and it turns out that some gcc versions
(specifically gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609) are
not smart enough to figure it out for expressions involving local
variables. This is harmless but means that the check is ineffective for
these platforms.  To fix, replace variables with macros.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/qxl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 62d0c80..af4c0ca 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -306,12 +306,11 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
 
 static ram_addr_t qxl_rom_size(void)
 {
-    uint32_t required_rom_size = sizeof(QXLRom) + sizeof(QXLModes) +
-                                 sizeof(qxl_modes);
-    uint32_t rom_size = 8192; /* two pages */
+#define QXL_REQUIRED_SZ (sizeof(QXLRom) + sizeof(QXLModes) + sizeof(qxl_modes))
+#define QXL_ROM_SZ 8192
 
-    QEMU_BUILD_BUG_ON(required_rom_size > rom_size);
-    return rom_size;
+    QEMU_BUILD_BUG_ON(QXL_REQUIRED_SZ > QXL_ROM_SZ);
+    return QXL_ROM_SZ;
 }
 
 static void init_qxl_rom(PCIQXLDevice *d)
-- 
MST
