Received: from eggs.gnu.org ([2001:4830:134:3::10]:50812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHu1I-0000FB-BW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHu1F-0005Pq-7y
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:02:00 -0500
From: <marcin.krzeminski@nokia.com>
Date: Fri, 16 Dec 2016 14:27:41 +0100
Message-ID: <1481894862-14102-2-git-send-email-marcin.krzeminski@nokia.com>
In-Reply-To: <1481894862-14102-1-git-send-email-marcin.krzeminski@nokia.com>
References: <1481894862-14102-1-git-send-email-marcin.krzeminski@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] block: m25p80: Add Quad Page Program 4byte
 version op
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

Some flash chips has additional page program opcode that
takes only 4 byte address. This commit adds support
for such command in Qemu.

Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>
---
 hw/block/m25p80.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index d29ff4c..2bc7028 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -325,6 +325,7 @@ typedef enum {
     PP4_4 = 0x3e,
     DPP = 0xa2,
     QPP = 0x32,
+    QPP_4 = 0x34,
 
     ERASE_4K = 0x20,
     ERASE4_4K = 0x21,
@@ -573,6 +574,7 @@ static inline int get_addr_length(Flash *s)
    switch (s->cmd_in_progress) {
    case PP4:
    case PP4_4:
+   case QPP_4:
    case READ4:
    case QIOR4:
    case ERASE4_4K:
@@ -606,6 +608,7 @@ static void complete_collecting_data(Flash *s)
     switch (s->cmd_in_progress) {
     case DPP:
     case QPP:
+    case QPP_4:
     case PP:
     case PP4:
     case PP4_4:
@@ -873,6 +876,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case READ4:
     case DPP:
     case QPP:
+    case QPP_4:
     case PP:
     case PP4:
     case PP4_4:
-- 
2.7.4
