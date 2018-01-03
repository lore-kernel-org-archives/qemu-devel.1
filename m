Received: from eggs.gnu.org ([2001:4830:134:3::10]:51722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXQ-0002Pm-Mw
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXO-0007xx-IP
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:28 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXO-0007xD-6A
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:26 -0500
Received: by mail-qt0-x242.google.com with SMTP id k19so3802433qtj.6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:20 -0300
Message-Id: <20180103212436.15762-10-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/25] sdcard: use G_BYTE from cutils
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

code is now easier to read.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1f209b8199..d4aa7b4a92 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -38,6 +38,7 @@
 #include "hw/sd/sdcard_legacy.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
+#include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -369,7 +370,7 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
     uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
 
-    if (size <= 0x40000000) {	/* Standard Capacity SD */
+    if (size <= 1 * G_BYTE /* FIXME 2GB? */) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-- 
2.15.1
