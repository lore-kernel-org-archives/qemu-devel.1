Received: from eggs.gnu.org ([2001:4830:134:3::10]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYB-0003AV-N3
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqY6-00007r-7u
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:15 -0500
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqY6-00006w-0e
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:10 -0500
Received: by mail-qt0-x231.google.com with SMTP id 33so3816570qtv.1
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:30 -0300
Message-Id: <20180103212436.15762-20-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 19/25] sdcard: check if the card capacity is
 supported
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

The current Spec (v2.00) does not support SDXC cards (> 32GB).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/sd/trace-events |  1 +
 2 files changed, 42 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ed5874e4d6..a7cede8da6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -63,6 +63,13 @@ typedef enum {
     SD_PHY_SPEC_VER_3_01 = 301, /* not yet supported */
 } sd_phy_spec_ver_t;
 
+typedef enum {
+    sd_capacity_unknown,
+    sd_capacity_sdsc,           /* not well supported */
+    sd_capacity_sdhc,
+    sd_capacity_sdxc,           /* not yet supported */
+} sd_card_capacity_t;
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -121,6 +128,7 @@ struct SDState {
 
     int spec_version;
     bool spi;
+    sd_card_capacity_t capacity;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
@@ -161,6 +169,17 @@ static const char *sd_state_name(enum SDCardStates state)
     return state_name[state];
 }
 
+static const char *sd_capacity(sd_card_capacity_t capacity)
+{
+    static const char *capacity_name[] = {
+        [sd_capacity_unknown]   = "UNKN",
+        [sd_capacity_sdsc]      = "SDSC",
+        [sd_capacity_sdhc]      = "SDHC",
+        [sd_capacity_sdxc]      = "SDXC",
+    };
+    return capacity_name[capacity];
+}
+
 static const char *sd_cmd_abbreviation(uint8_t cmd)
 {
     static const char *cmd_abbrev[SDCARD_CMD_MAX] = {
@@ -1991,11 +2010,33 @@ static void sd_realize(DeviceState *dev, Error **errp)
     }
 
     if (sd->blk) {
+        int64_t size;
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
             return;
         }
+
+        size = blk_getlength(sd->blk);
+        if (size < 0 || size <= 2 * G_BYTE) {
+            sd->capacity = sd_capacity_sdsc;
+        } else if (size <= 32 * G_BYTE) {
+            sd->capacity = sd_capacity_sdhc;
+        } else if (size <= 2 * T_BYTE) {
+            sd->capacity = sd_capacity_sdxc;
+        } else {
+            error_setg(errp, "block size unsupported: %lld TB", size / T_BYTE);
+            return;
+        }
+        trace_sdcard_capacity(sd_capacity(sd->capacity), size);
+
+        if (sd->capacity == sd_capacity_sdxc
+                && sd->spec_version < SD_PHY_SPEC_VER_3_01) {
+            error_setg(errp, "capacity SDHC requires at least Spec v3.01");
+            return;
+        }
+
         blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
     }
 }
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 25ab339f97..215e0eec3a 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -28,6 +28,7 @@ sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(uint8_t value) "value 0x%02x"
 sdcard_read_data(int length) "len %d"
+sdcard_capacity(const char *capacity, int64_t size) "%s card (%ld B)"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
