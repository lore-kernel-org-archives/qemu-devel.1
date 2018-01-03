Received: from eggs.gnu.org ([2001:4830:134:3::10]:52983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYS-0003S5-H9
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYR-0000bu-Fc
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:32 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYR-0000b9-BS
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:31 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so3805637qtj.6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:35 -0300
Message-Id: <20180103212436.15762-25-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 24/25] sdcard: introduce Spec v3.01 SD
 commands
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d626445282..6fbc640d2e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -305,7 +305,7 @@ typedef struct {
 static const sd_cmd_supported_t cmd_supported[SDCARD_CMD_MAX] = {
      /*           SD                  SPI          */
      [0] = {{200, BIT(0)},      {200, BIT(0)},      },
-     [1] = {{},                 {200, BIT(0)},      },
+     [1] = {{301, BIT(0)},      {200, BIT(0)},      },
      [2] = {{200, BIT(0)},      {},                 },
      [3] = {{200, BIT(0)},      {},                 },
      [4] = {{200, BIT(0)},      {},                 },
@@ -322,6 +322,7 @@ static const sd_cmd_supported_t cmd_supported[SDCARD_CMD_MAX] = {
     [16] = {{200, BIT_2_4_7},   {200, BIT_2_4_7},   },
     [17] = {{200, BIT(2)},      {200, BIT(2)},      },
     [18] = {{200, BIT(2)},      {200, BIT(2)},      },
+    [23] = {{301, BIT_2_4},     {},                 },
     [24] = {{200, BIT(4)},      {200, BIT(4)},      },
     [25] = {{200, BIT(4)},      {200, BIT(4)},      },
     [26] = {{200, BIT_MANUF},   {/*?*/},            },
@@ -344,8 +345,8 @@ static const sd_cmd_supported_t cmd_supported[SDCARD_CMD_MAX] = {
     [55] = {{200, BIT(8)},      {200, BIT(8)},      },
     [56] = {{200, BIT(8)},      {200, BIT(8)},      },
     [57] = {{200, BIT(10)},     {200, BIT(10)},     },
-    [58] = {{},                 {200, BIT(0)},      },
-    [59] = {{},                 {200, BIT(0)},      },
+    [58] = {{301, BIT(0)},      {200, BIT(0)},      },
+    [59] = {{301, BIT(0)},      {200, BIT(0)},      },
     [60] = {{200, BIT_MANUF},   {/*?*/},            },
     [61] = {{200, BIT_MANUF},   {/*?*/},            },
     [62] = {{200, BIT_MANUF},   {/*?*/},            },
@@ -372,6 +373,18 @@ static const sd_cmd_supported_t cmd_supported[SDCARD_CMD_MAX] = {
     [51] = {{200, BIT(8)},      {200, BIT(8)},      },
 };
 
+static const char *spec_version_name(uint16_t spec_version)
+{
+    switch (spec_version) {
+    case SD_PHY_SPEC_VER_2_00:
+        return "v2.00";
+    case SD_PHY_SPEC_VER_3_01:
+        return "v3.01";
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static bool cmd_version_supported(SDState *sd, uint8_t cmd, bool is_acmd)
 {
     const sd_cmd_supported_t *cmdset = is_acmd ? acmd_supported : cmd_supported;
@@ -387,11 +400,12 @@ static bool cmd_version_supported(SDState *sd, uint8_t cmd, bool is_acmd)
     default:
         g_assert_not_reached();
     }
-    if (cmd_version) {
+    if (cmd_version >= sd->spec_version) {
         return true;
     }
-    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported %s%02u\n",
-                  sd->proto_name, is_acmd ? "ACMD" : "CMD", cmd);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported %s%02u (%s)\n",
+                  sd->proto_name, is_acmd ? "ACMD" : "CMD", cmd,
+                  spec_version_name(cmd_version));
 
     return false;
 }
@@ -416,8 +430,9 @@ static bool cmd_class_supported(SDState *sd, uint8_t cmd, uint8_t class,
     if (cmd_ccc_mask & BIT(class)) {
         return true;
     }
-    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported %s%02u (class %d)\n",
-                  sd->proto_name, is_acmd ? "ACMD" : "CMD", cmd, class);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported %s%02u (class %d, %s)\n",
+                  sd->proto_name, is_acmd ? "ACMD" : "CMD", cmd, class,
+                  spec_version_name(sd->spec_version));
 
     return false;
 }
-- 
2.15.1
