Received: from eggs.gnu.org ([2001:4830:134:3::10]:48163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75Es-0002os-Ct
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75Er-0003PQ-Kk
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:50 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:57156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e75Er-0003Oy-Ch
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:49 -0400
Received: by mail-lf0-x243.google.com with SMTP id 90so25305404lfs.13
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 12:51:49 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Tue, 24 Oct 2017 21:51:29 +0200
Message-Id: <20171024195139.28179-4-frasse.iglesias@gmail.com>
In-Reply-To: <20171024195139.28179-1-frasse.iglesias@gmail.com>
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 03/13] m25p80: Add support for BRRD/BRWR and
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
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se

Add support for the bank address register access commands (BRRD/BRWR) and
the BULK_ERASE (0x60) command.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/block/m25p80.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index c85e8fa..3d2975c 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -331,6 +331,8 @@ typedef enum {
     WRDI = 0x4,
     RDSR = 0x5,
     WREN = 0x6,
+    BRRD = 0x16,
+    BRWR = 0x17,
     JEDEC_READ = 0x9f,
     BULK_ERASE = 0xc7,
     READ_FSR = 0x70,
@@ -368,6 +370,8 @@ typedef enum {
     EN_4BYTE_ADDR = 0xB7,
     EX_4BYTE_ADDR = 0xE9,
 
+    BULK_ERASE_60 = 0x60,
+
     EXTEND_ADDR_READ = 0xC8,
     EXTEND_ADDR_WRITE = 0xC5,
 
@@ -975,6 +979,15 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         }
         break;
 
+    case BRWR:
+        if (s->write_enable) {
+            s->needed_bytes = 1;
+            s->pos = 0;
+            s->len = 0;
+            s->state = STATE_COLLECTING_DATA;
+        }
+        break;
+
     case WRDI:
         s->write_enable = false;
         break;
@@ -1004,6 +1017,12 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         s->state = STATE_READING_DATA;
         break;
 
+    case BRRD:
+        s->pos = 0;
+        s->len = 1;
+        s->state = STATE_READING_DATA;
+        break;
+
     case JEDEC_READ:
         DB_PRINT_L(0, "populated jedec code\n");
         for (i = 0; i < s->pi->id_len; i++) {
@@ -1038,6 +1057,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         }
         break;
 
+    case BULK_ERASE_60:
     case BULK_ERASE:
         if (s->write_enable) {
             DB_PRINT_L(0, "chip erase\n");
-- 
2.9.3
