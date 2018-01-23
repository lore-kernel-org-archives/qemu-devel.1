Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9n-0003Xh-LX
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9m-0000Z9-NZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:55 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9m-0000Yg-J7
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:54 -0500
Received: by mail-qt0-x242.google.com with SMTP id g14so17245529qti.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:21:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:21:27 -0300
Message-Id: <20180123032135.28863-5-f4bug@amsat.org>
In-Reply-To: <20180123032135.28863-1-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/12] sdcard: replace fprintf() by
 qemu_hexdump()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3590099ce8..03263e08ae 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -44,13 +44,6 @@
 
 //#define DEBUG_SD 1
 
-#ifdef DEBUG_SD
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
-
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
@@ -1630,13 +1623,7 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    if (rsplen) {
-        int i;
-        DPRINTF("Response:");
-        for (i = 0; i < rsplen; i++)
-            fprintf(stderr, " %02x", response[i]);
-        fputc('\n', stderr);
-    }
+    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
 #endif
 
     return rsplen;
-- 
2.15.1
