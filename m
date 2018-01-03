Received: from eggs.gnu.org ([2001:4830:134:3::10]:52850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYH-0003GY-5h
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYE-0000JT-Nr
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:21 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYE-0000JK-Fh
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:18 -0500
Received: by mail-qk0-x242.google.com with SMTP id c5so3241412qkg.6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:32 -0300
Message-Id: <20180103212436.15762-22-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 21/25] sdcard: add cmd_version_supported(),
 improve cmd_class_supported()
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

Using the cmd_supported[] array we keep track of which Spec version introduced
a command, and which class it belongs to.

This array is initialized with SD Spec v2.00.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 16a8a7411d..0e4871869f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -278,13 +278,121 @@ static const sd_cmd_type_t sd_cmd_type[SDCARD_CMD_MAX] = {
     sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none,
 };
 
-static const int sd_cmd_class[SDCARD_CMD_MAX] = {
-    0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
-    2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
-    5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
-    7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
+#define BIT_2_4     (BIT(2) | BIT(4))
+#define BIT_2_4_7   (BIT(2) | BIT(4) | BIT(7))
+#define BIT_SECU    BIT(30) /* SD Specifications Part3 Security Specification */
+#define BIT_MANUF   BIT(31) /* reserved for manufacturer */
+
+typedef struct {
+    struct {
+        uint16_t version;
+        uint32_t ccc_mask;
+    } sd, spi;
+} sd_cmd_supported_t;
+
+static const sd_cmd_supported_t cmd_supported[SDCARD_CMD_MAX] = {
+     /*           SD                  SPI          */
+     [0] = {{200, BIT(0)},      {200, BIT(0)},      },
+     [1] = {{},                 {200, BIT(0)},      },
+     [2] = {{200, BIT(0)},      {},                 },
+     [3] = {{200, BIT(0)},      {},                 },
+     [4] = {{200, BIT(0)},      {},                 },
+     [5] = {{200, BIT(9)},      {200, BIT(9)},      },
+     [6] = {{200, BIT(10)},     {200, BIT(10)},     },
+     [7] = {{200, BIT(0)},      {},                 },
+     [8] = {{200, BIT(0)},      {200, BIT(0)},      },
+     [9] = {{200, BIT(0)},      {200, BIT(0)},      },
+    [10] = {{200, BIT(0)},      {200, BIT(0)},      },
+    [12] = {{200, BIT(0)},      {200, BIT(0)},      },
+    [13] = {{200, BIT(0)},      {200, BIT(0)},      },
+    [14] = {{200, BIT(0)},      {},                 },
+    [15] = {{200, BIT(0)},      {},                 },
+    [16] = {{200, BIT_2_4_7},   {200, BIT_2_4_7},   },
+    [17] = {{200, BIT(2)},      {200, BIT(2)},      },
+    [18] = {{200, BIT(2)},      {200, BIT(2)},      },
+    [24] = {{200, BIT(4)},      {200, BIT(4)},      },
+    [25] = {{200, BIT(4)},      {200, BIT(4)},      },
+    [26] = {{200, BIT_MANUF},   {/*?*/},            },
+    [27] = {{200, BIT(4)},      {200, BIT(4)},      },
+    [28] = {{200, BIT(6)},      {200, BIT(6)},      },
+    [29] = {{200, BIT(6)},      {200, BIT(6)},      },
+    [30] = {{200, BIT(6)},      {200, BIT(6)},      },
+    [32] = {{200, BIT(5)},      {200, BIT(5)},      },
+    [33] = {{200, BIT(5)},      {200, BIT(5)},      },
+    [34] = {{200, BIT(10)},     {200, BIT(10)},     },
+    [35] = {{200, BIT(10)},     {200, BIT(10)},     },
+    [36] = {{200, BIT(10)},     {200, BIT(10)},     },
+    [37] = {{200, BIT(10)},     {200, BIT(10)},     },
+    [38] = {{200, BIT(5)},      {200, BIT(5)},      },
+    [42] = {{200, BIT(7)},      {200, BIT(7)},      },
+    [50] = {{200, BIT(10)},     {200, BIT(10)},     },
+    [52] = {{200, BIT(9)},      {200, BIT(9)},      },
+    [53] = {{200, BIT(9)},      {200, BIT(9)},      },
+    [54] = {{/* 2.00 SDIO */},  {/* 2.00 SDIO */},  },
+    [55] = {{200, BIT(8)},      {200, BIT(8)},      },
+    [56] = {{200, BIT(8)},      {200, BIT(8)},      },
+    [57] = {{200, BIT(10)},     {200, BIT(10)},     },
+    [58] = {{},                 {200, BIT(0)},      },
+    [59] = {{},                 {200, BIT(0)},      },
+    [60] = {{200, BIT_MANUF},   {/*?*/},            },
+    [61] = {{200, BIT_MANUF},   {/*?*/},            },
+    [62] = {{200, BIT_MANUF},   {/*?*/},            },
+    [63] = {{200, BIT_MANUF},   {/*?*/},            },
+}, acmd_supported[SDCARD_CMD_MAX] = {
+     /*           SD                  SPI          */
+     [6] = {{200, BIT(8)},      {},                 },
+    [13] = {{200, BIT(8)},      {200, BIT(8)},      },
+    [18] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [22] = {{200, BIT(8)},      {200, BIT(8)},      },
+    [23] = {{200, BIT(8)},      {200, BIT(8)},      },
+    [25] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [26] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [38] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [41] = {{200, BIT(8)},      {200, BIT(8)},      },
+    [42] = {{200, BIT(8)},      {200, BIT(8)},      },
+    [43] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [44] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [45] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [46] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [47] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [48] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [49] = {{200, BIT_SECU},    {200, BIT_SECU},    },
+    [51] = {{200, BIT(8)},      {200, BIT(8)},      },
 };
 
+static bool cmd_version_supported(SDState *sd, uint8_t cmd, bool is_acmd)
+{
+    const sd_cmd_supported_t *cmdset = is_acmd ? acmd_supported : cmd_supported;
+    uint16_t cmd_version;
+
+    cmd_version = sd->spi ? cmdset[cmd].spi.version : cmdset[cmd].sd.version;
+    if (cmd_version) {
+        return true;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported %s%02u\n",
+                  sd->proto_name, is_acmd ? "ACMD" : "CMD", cmd);
+
+    return false;
+}
+
+static bool cmd_class_supported(SDState *sd, uint8_t cmd, uint8_t class,
+                                bool is_acmd)
+{
+    const sd_cmd_supported_t *cmdset = is_acmd ? acmd_supported : cmd_supported;
+    uint32_t cmd_ccc_mask;
+
+    cmd_ccc_mask = sd->spi ? cmdset[cmd].spi.ccc_mask : cmdset[cmd].sd.ccc_mask;
+
+    /* class 1, 3 and 9 are not supported in SPI mode */
+    if (cmd_ccc_mask & BIT(class)) {
+        return true;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported %s%02u (class %d)\n",
+                  sd->proto_name, is_acmd ? "ACMD" : "CMD", cmd, class);
+
+    return false;
+}
+
 static uint8_t sd_crc7(void *message, size_t width)
 {
     int i, bit;
@@ -1570,8 +1678,8 @@ static bool cmd_valid_while_locked(SDState *sd, SDRequest *req)
     if (req->cmd == 16 || req->cmd == 55) {
         return true;
     }
-    return sd_cmd_class[req->cmd] == 0
-            || sd_cmd_class[req->cmd] == 7;
+    return cmd_class_supported(sd, req->cmd, 0, false) ||
+            cmd_class_supported(sd, req->cmd, 7, false);
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -1596,6 +1704,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
         req->cmd &= 0x3f;
     }
 
+    if (!cmd_version_supported(sd, req->cmd, sd->expecting_acmd)) {
+        sd->card_status |= ILLEGAL_COMMAND;
+        rtype = sd_illegal;
+        goto send_response;
+    }
+
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req)) {
             sd->card_status |= ILLEGAL_COMMAND;
-- 
2.15.1
