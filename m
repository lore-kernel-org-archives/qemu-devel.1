Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWT-0004ah-Td
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWS-0007bF-QJ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWS-0007Ts-If
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWO-0007Zn-GR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:44 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:01 +0000
Message-Id: <1513188761-20784-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/43] m25p80: Add support for BRRD/BRWR and
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

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Add support for the bank address register access commands (BRRD/BRWR) and
the BULK_ERASE (0x60) command.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20171126231634.9531-4-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
