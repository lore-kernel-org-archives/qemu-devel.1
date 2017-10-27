Received: from eggs.gnu.org ([2001:4830:134:3::10]:50686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xd1-0005YB-D5
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xd0-0007m1-Ky
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:23 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:54225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e7xd0-0007ks-DJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:22 -0400
Received: by mail-lf0-x244.google.com with SMTP id l23so6114319lfk.10
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 22:56:22 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Fri, 27 Oct 2017 07:56:02 +0200
Message-Id: <20171027055612.2488-4-frasse.iglesias@gmail.com>
In-Reply-To: <20171027055612.2488-1-frasse.iglesias@gmail.com>
References: <20171027055612.2488-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v4 03/13] m25p80: Add support for BRRD/BRWR and
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
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

Add support for the bank address register access commands (BRRD/BRWR) and
the BULK_ERASE (0x60) command.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/block/m25p80.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 7a5c137..cf39e36 100644
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
@@ -1041,6 +1045,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         s->state = STATE_READING_DATA;
         break;
 
+    case BULK_ERASE_60:
     case BULK_ERASE:
         if (s->write_enable) {
             DB_PRINT_L(0, "chip erase\n");
@@ -1058,12 +1063,14 @@ static void decode_new_cmd(Flash *s, uint32_t value)
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
