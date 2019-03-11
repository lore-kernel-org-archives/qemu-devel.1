Received: from eggs.gnu.org ([209.51.188.92]:60199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL7-0005Ps-KV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL6-0003Yg-Rl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:57 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Mar 2019 20:11:28 +0100
Message-Id: <20190311191128.30562-6-laurent@vivier.eu>
In-Reply-To: <20190311191128.30562-1-laurent@vivier.eu>
References: <20190311191128.30562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/5] hw/nvram/fw_cfg: Use the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The load/store API eases code review.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190309181920.30553-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/nvram/fw_cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 13aab122889d..5c3a46ce6f2a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -85,7 +85,7 @@ static char *read_splashfile(char *filename, gsize *file_sizep,
     }
 
     /* check magic ID */
-    filehead = ((content[0] & 0xff) + (content[1] << 8)) & 0xffff;
+    filehead = lduw_le_p(content);
     if (filehead == 0xd8ff) {
         file_type = JPG_FILE;
     } else if (filehead == 0x4d42) {
@@ -96,7 +96,7 @@ static char *read_splashfile(char *filename, gsize *file_sizep,
 
     /* check BMP bpp */
     if (file_type == BMP_FILE) {
-        bmp_bpp = (content[28] + (content[29] << 8)) & 0xffff;
+        bmp_bpp = lduw_le_p(&content[28]);
         if (bmp_bpp != 24) {
             goto error;
         }
-- 
2.20.1
