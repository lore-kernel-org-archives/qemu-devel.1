Received: from eggs.gnu.org ([2001:4830:134:3::10]:33080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cPZaT-0004dl-Hn
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cPZaR-0006cN-Tw
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:50:01 -0500
From: Marcin Krzeminski <mar.krzeminski@gmail.com>
Date: Fri,  6 Jan 2017 19:49:46 +0100
Message-Id: <20170106184948.3422-2-mar.krzeminski@gmail.com>
In-Reply-To: <20170106184948.3422-1-mar.krzeminski@gmail.com>
References: <20170106184948.3422-1-mar.krzeminski@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/3] block: m25p80: Add Quad Page Program
 4byte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, clg@kaod.org

Some flash chips have additional page program opcode that
takes only 4 byte address. This commit adds support
for such command in Qemu.

Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/block/m25p80.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index e3c1166..6dff81b 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -326,6 +326,7 @@ typedef enum {
     PP4_4 = 0x3e,
     DPP = 0xa2,
     QPP = 0x32,
+    QPP_4 = 0x34,
 
     ERASE_4K = 0x20,
     ERASE4_4K = 0x21,
@@ -574,6 +575,7 @@ static inline int get_addr_length(Flash *s)
    switch (s->cmd_in_progress) {
    case PP4:
    case PP4_4:
+   case QPP_4:
    case READ4:
    case QIOR4:
    case ERASE4_4K:
@@ -607,6 +609,7 @@ static void complete_collecting_data(Flash *s)
     switch (s->cmd_in_progress) {
     case DPP:
     case QPP:
+    case QPP_4:
     case PP:
     case PP4:
     case PP4_4:
@@ -874,6 +877,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case READ4:
     case DPP:
     case QPP:
+    case QPP_4:
     case PP:
     case PP4:
     case PP4_4:
-- 
2.9.3
