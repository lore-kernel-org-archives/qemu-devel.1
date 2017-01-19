Received: from eggs.gnu.org ([2001:4830:134:3::10]:47625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPu-00011a-Tn
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPs-0005FV-JY
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPs-000582-9e
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPZ-00033x-14
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:09:57 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:21 +0000
Message-Id: <1484834995-26826-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/36] block: m25p80: Add Quad Page Program 4byte
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

Some flash chips have additional page program opcode that
takes only 4 byte address. This commit adds support
for such command in Qemu.

Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20170108083854.5006-2-mar.krzeminski@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 4c5f8c3..4ad67ac 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -327,6 +327,7 @@ typedef enum {
     PP4_4 = 0x3e,
     DPP = 0xa2,
     QPP = 0x32,
+    QPP_4 = 0x34,
 
     ERASE_4K = 0x20,
     ERASE4_4K = 0x21,
@@ -577,6 +578,7 @@ static inline int get_addr_length(Flash *s)
    switch (s->cmd_in_progress) {
    case PP4:
    case PP4_4:
+   case QPP_4:
    case READ4:
    case QIOR4:
    case ERASE4_4K:
@@ -610,6 +612,7 @@ static void complete_collecting_data(Flash *s)
     switch (s->cmd_in_progress) {
     case DPP:
     case QPP:
+    case QPP_4:
     case PP:
     case PP4:
     case PP4_4:
@@ -877,6 +880,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case READ4:
     case DPP:
     case QPP:
+    case QPP_4:
     case PP:
     case PP4:
     case PP4_4:
-- 
2.7.4
