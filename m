Received: from eggs.gnu.org ([2001:4830:134:3::10]:47635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPv-000121-6R
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPs-0005FZ-It
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPs-00051T-9o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPZ-00034L-G4
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:09:57 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:22 +0000
Message-Id: <1484834995-26826-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/36] block: m25p80: Introduce die erase command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Marcin Krzeminski <mar.krzeminski@gmail.com>

Modern big flash NOR devices consist of more than one die.
Some of them do not support chip erase and instead have a die
erase command that can erase one die only. This commit adds
support for defining the number of dies in the chip, and adds
support for die erase command.

The NOR flash model is not strict, so no option to
disable chip erase has been added.

Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20170108083854.5006-3-mar.krzeminski@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 4ad67ac..74c6e39 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -74,6 +74,12 @@ typedef struct FlashPartInfo {
     uint32_t n_sectors;
     uint32_t page_size;
     uint16_t flags;
+    /*
+     * Big sized spi nor are often stacked devices, thus sometime
+     * replace chip erase with die erase.
+     * This field inform how many die is in the chip.
+     */
+    uint8_t die_cnt;
 } FlashPartInfo;
 
 /* adapted from linux */
@@ -91,7 +97,8 @@ typedef struct FlashPartInfo {
     .sector_size = (_sector_size),\
     .n_sectors = (_n_sectors),\
     .page_size = 256,\
-    .flags = (_flags),
+    .flags = (_flags),\
+    .die_cnt = 0
 
 #define INFO6(_part_name, _jedec_id, _ext_id, _sector_size, _n_sectors, _flags)\
     .part_name = _part_name,\
@@ -108,6 +115,24 @@ typedef struct FlashPartInfo {
     .n_sectors = (_n_sectors),\
     .page_size = 256,\
     .flags = (_flags),\
+    .die_cnt = 0
+
+#define INFO_STACKED(_part_name, _jedec_id, _ext_id, _sector_size, _n_sectors,\
+                    _flags, _die_cnt)\
+    .part_name = _part_name,\
+    .id = {\
+        ((_jedec_id) >> 16) & 0xff,\
+        ((_jedec_id) >> 8) & 0xff,\
+        (_jedec_id) & 0xff,\
+        ((_ext_id) >> 8) & 0xff,\
+        (_ext_id) & 0xff,\
+          },\
+    .id_len = (!(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))),\
+    .sector_size = (_sector_size),\
+    .n_sectors = (_n_sectors),\
+    .page_size = 256,\
+    .flags = (_flags),\
+    .die_cnt = _die_cnt
 
 #define JEDEC_NUMONYX 0x20
 #define JEDEC_WINBOND 0xEF
@@ -360,6 +385,8 @@ typedef enum {
 
     REVCR = 0x65,
     WEVCR = 0x61,
+
+    DIE_ERASE = 0xC4,
 } FlashCMD;
 
 typedef enum {
@@ -517,6 +544,16 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
     case BULK_ERASE:
         len = s->size;
         break;
+    case DIE_ERASE:
+        if (s->pi->die_cnt) {
+            len = s->size / s->pi->die_cnt;
+            offset = offset & (~(len - 1));
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: die erase is not supported"
+                          " by device\n");
+            return;
+        }
+        break;
     default:
         abort();
     }
@@ -638,6 +675,7 @@ static void complete_collecting_data(Flash *s)
     case ERASE4_32K:
     case ERASE_SECTOR:
     case ERASE4_SECTOR:
+    case DIE_ERASE:
         flash_erase(s, s->cur_addr, s->cmd_in_progress);
         break;
     case WRSR:
@@ -884,6 +922,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case PP:
     case PP4:
     case PP4_4:
+    case DIE_ERASE:
         s->needed_bytes = get_addr_length(s);
         s->pos = 0;
         s->len = 0;
-- 
2.7.4
