Received: from eggs.gnu.org ([2001:4830:134:3::10]:51383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWU-0004bd-MG
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWT-0007cx-N4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWT-0007Ts-Fn
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:49 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWN-0007Z1-Q7
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:43 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:00 +0000
Message-Id: <1513188761-20784-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/43] m25p80: Add support for SST READ ID
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

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Add support for SST READ ID 0x90/0xAB commands for reading out the flash
manufacturer ID and device ID.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20171126231634.9531-3-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index d50acc1..092c0c6 100644
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
@@ -711,6 +716,31 @@ static void complete_collecting_data(Flash *s)
     case WEVCR:
         s->enh_volatile_cfg = s->data[0];
         break;
+    case RDID_90:
+    case RDID_AB:
+        if (get_man(s) == MAN_SST) {
+            if (s->cur_addr <= 1) {
+                if (s->cur_addr) {
+                    s->data[0] = s->pi->id[2];
+                    s->data[1] = s->pi->id[0];
+                } else {
+                    s->data[0] = s->pi->id[0];
+                    s->data[1] = s->pi->id[2];
+                }
+                s->pos = 0;
+                s->len = 2;
+                s->data_read_loop = true;
+                s->state = STATE_READING_DATA;
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "M25P80: Invalid read id address\n");
+            }
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M25P80: Read id (command 0x90/0xAB) is not supported"
+                          " by device\n");
+        }
+        break;
     default:
         break;
     }
@@ -926,6 +956,8 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case PP4:
     case PP4_4:
     case DIE_ERASE:
+    case RDID_90:
+    case RDID_AB:
         s->needed_bytes = get_addr_length(s);
         s->pos = 0;
         s->len = 0;
-- 
2.7.4
