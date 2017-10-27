Received: from eggs.gnu.org ([2001:4830:134:3::10]:50660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xd0-0005Y1-2B
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xcz-0007ki-B3
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:22 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:50168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e7xcz-0007jf-3d
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:21 -0400
Received: by mail-lf0-x243.google.com with SMTP id w21so6148550lfc.6
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 22:56:20 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Fri, 27 Oct 2017 07:56:01 +0200
Message-Id: <20171027055612.2488-3-frasse.iglesias@gmail.com>
In-Reply-To: <20171027055612.2488-1-frasse.iglesias@gmail.com>
References: <20171027055612.2488-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v4 02/13] m25p80: Add support for SST READ ID
 0x90/0xAB commands
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

Add support for SST READ ID 0x90/0xAB commands for reading out the flash
manufacuter ID and device ID.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/block/m25p80.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 2971519..7a5c137 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -355,6 +355,8 @@ typedef enum {
     DPP = 0xa2,
     QPP = 0x32,
     QPP_4 = 0x34,
+    RDID_90 = 0x90,
+    RDID_AB = 0xab,
 
     ERASE_4K = 0x20,
     ERASE4_4K = 0x21,
@@ -405,6 +407,7 @@ typedef enum {
     MAN_MACRONIX,
     MAN_NUMONYX,
     MAN_WINBOND,
+    MAN_SST,
     MAN_GENERIC,
 } Manufacturer;
 
@@ -476,6 +479,8 @@ static inline Manufacturer get_man(Flash *s)
         return MAN_SPANSION;
     case 0xC2:
         return MAN_MACRONIX;
+    case 0xBF:
+        return MAN_SST;
     default:
         return MAN_GENERIC;
     }
@@ -711,6 +716,22 @@ static void complete_collecting_data(Flash *s)
     case WEVCR:
         s->enh_volatile_cfg = s->data[0];
         break;
+    case RDID_90:
+    case RDID_AB:
+        if (get_man(s) == MAN_SST && s->cur_addr <= 1) {
+            if (s->cur_addr) {
+                s->data[0] = s->pi->id[2];
+                s->data[1] = s->pi->id[0];
+            } else {
+                s->data[0] = s->pi->id[0];
+                s->data[1] = s->pi->id[2];
+            }
+            s->pos = 0;
+            s->len = 2;
+            s->data_read_loop = true;
+            s->state = STATE_READING_DATA;
+        }
+        break;
     default:
         break;
     }
@@ -926,6 +947,8 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case PP4:
     case PP4_4:
     case DIE_ERASE:
+    case RDID_90:
+    case RDID_AB:
         s->needed_bytes = get_addr_length(s);
         s->pos = 0;
         s->len = 0;
-- 
2.9.3
