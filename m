Received: from eggs.gnu.org ([2001:4830:134:3::10]:50169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eJ6AI-0004LR-79
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 18:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eJ6AH-0000qu-Al
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 18:16:46 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eJ6AH-0000qD-2w
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 18:16:45 -0500
Received: by mail-lf0-x241.google.com with SMTP id m1so30656768lfj.9
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 15:16:45 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Mon, 27 Nov 2017 00:16:24 +0100
Message-Id: <20171126231634.9531-4-frasse.iglesias@gmail.com>
In-Reply-To: <20171126231634.9531-1-frasse.iglesias@gmail.com>
References: <20171126231634.9531-1-frasse.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 03/13] m25p80: Add support for BRRD/BRWR and
 BULK_ERASE (0x60)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com, peter.maydell@linaro.org, f4bug@amsat.org

Add support for the bank address register access commands (BRRD/BRWR) and
the BULK_ERASE (0x60) command.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/block/m25p80.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 092c0c6..35efdf0 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -331,7 +331,10 @@ typedef enum {
     WRDI = 0x4,
     RDSR = 0x5,
     WREN = 0x6,
+    BRRD = 0x16,
+    BRWR = 0x17,
     JEDEC_READ = 0x9f,
+    BULK_ERASE_60 = 0x60,
     BULK_ERASE = 0xc7,
     READ_FSR = 0x70,
     RDCR = 0x15,
@@ -704,6 +707,7 @@ static void complete_collecting_data(Flash *s)
             s->write_enable = false;
         }
         break;
+    case BRWR:
     case EXTEND_ADDR_WRITE:
         s->ear = s->data[0];
         break;
@@ -1050,6 +1054,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         s->state = STATE_READING_DATA;
         break;
 
+    case BULK_ERASE_60:
     case BULK_ERASE:
         if (s->write_enable) {
             DB_PRINT_L(0, "chip erase\n");
@@ -1067,12 +1072,14 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case EX_4BYTE_ADDR:
         s->four_bytes_address_mode = false;
         break;
+    case BRRD:
     case EXTEND_ADDR_READ:
         s->data[0] = s->ear;
         s->pos = 0;
         s->len = 1;
         s->state = STATE_READING_DATA;
         break;
+    case BRWR:
     case EXTEND_ADDR_WRITE:
         if (s->write_enable) {
             s->needed_bytes = 1;
-- 
2.9.3
