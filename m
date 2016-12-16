Received: from eggs.gnu.org ([2001:4830:134:3::10]:32847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHt41-0005di-Ed
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHt3x-0000sm-F5
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:00:45 -0500
From: <marcin.krzeminski@nokia.com>
Date: Fri, 16 Dec 2016 14:27:42 +0100
Message-ID: <1481894862-14102-3-git-send-email-marcin.krzeminski@nokia.com>
In-Reply-To: <1481894862-14102-1-git-send-email-marcin.krzeminski@nokia.com>
References: <1481894862-14102-1-git-send-email-marcin.krzeminski@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] block: m25p80: Introduce Die Erase command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, rfsw-patches@mlist.nokia.com, clg@kaod.org

From: Marcin Krzeminski <marcin.krzeminski@nokia.com>

Big flash chips (like mt25qu01g) are consisted from dies.
Because of that some manufactures remove support for Chip
Erase giving Die Erase command instead.To avoid unnecessary
code complication, support for chip erase for mt25qu01g
is not removed.

Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>
---
 hw/block/m25p80.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 2bc7028..0bc1fbf 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -216,8 +216,8 @@ static const FlashPartInfo known_devices[] = {
     { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
     { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
     { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
-    { INFO("mt25ql01g",   0x20ba21,      0,  64 << 10, 2048, ER_4K) },
-    { INFO("mt25qu01g",   0x20bb21,      0,  64 << 10, 2048, ER_4K) },
+    { INFO("mt25ql01g",   0x20ba21, 0x1040,  64 << 10, 2048, ER_4K) },
+    { INFO("mt25qu01g",   0x20bb21, 0x1040,  64 << 10, 2048, ER_4K) },
 
     /* Spansion -- single (large) sector size only, at least
      * for the chips listed here (without boot sectors).
@@ -358,6 +358,8 @@ typedef enum {
 
     REVCR = 0x65,
     WEVCR = 0x61,
+
+    DIE_ERASE = 0xC4,
 } FlashCMD;
 
 typedef enum {
@@ -411,6 +413,7 @@ typedef struct Flash {
     bool reset_enable;
     bool quad_enable;
     uint8_t ear;
+    uint32_t die_cnt;
 
     int64_t dirty_page;
 
@@ -492,7 +495,7 @@ static inline void flash_sync_area(Flash *s, int64_t off, int64_t len)
 
 static void flash_erase(Flash *s, int offset, FlashCMD cmd)
 {
-    uint32_t len;
+    uint32_t len = 0;
     uint8_t capa_to_assert = 0;
 
     switch (cmd) {
@@ -513,6 +516,16 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
     case BULK_ERASE:
         len = s->size;
         break;
+    case DIE_ERASE:
+        if (s->die_cnt) {
+            len = s->size / s->die_cnt;
+            offset = offset & (~(len-1));
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: %d die erase not supported by"
+                          " device\n", len);
+            return;
+        }
+        break;
     default:
         abort();
     }
@@ -634,6 +647,7 @@ static void complete_collecting_data(Flash *s)
     case ERASE4_32K:
     case ERASE_SECTOR:
     case ERASE4_SECTOR:
+    case DIE_ERASE:
         flash_erase(s, s->cur_addr, s->cmd_in_progress);
         break;
     case WRSR:
@@ -684,6 +698,7 @@ static void reset_memory(Flash *s)
     s->write_enable = false;
     s->reset_enable = false;
     s->quad_enable = false;
+    s->die_cnt = 0;
 
     switch (get_man(s)) {
     case MAN_NUMONYX:
@@ -716,7 +731,15 @@ static void reset_memory(Flash *s)
             s->four_bytes_address_mode = true;
         }
         if (!(s->nonvolatile_cfg & NVCFG_LOWER_SEGMENT_MASK)) {
-            s->ear = s->size / MAX_3BYTES_SIZE - 1;
+            s->ear = ( s->size > MAX_3BYTES_SIZE ? s->size / MAX_3BYTES_SIZE - 1 : 0);
+        }
+        /* 1GiB devices */
+        if (s->pi->id[2] == 0x21) {
+            /* MT25Q00 has 2 dies N25Q00 has 4 */
+            if (s->pi->id[4] & BIT(6))
+                s->die_cnt = 2;
+            else
+                s->die_cnt = 4;
         }
         break;
     case MAN_MACRONIX:
@@ -880,6 +903,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case PP:
     case PP4:
     case PP4_4:
+    case DIE_ERASE:
         s->needed_bytes = get_addr_length(s);
         s->pos = 0;
         s->len = 0;
@@ -1217,6 +1241,7 @@ static const VMStateDescription vmstate_m25p80 = {
         VMSTATE_UINT8(spansion_cr2nv, Flash),
         VMSTATE_UINT8(spansion_cr3nv, Flash),
         VMSTATE_UINT8(spansion_cr4nv, Flash),
+        VMSTATE_UINT32(die_cnt, Flash),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
