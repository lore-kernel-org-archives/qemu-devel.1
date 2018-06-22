Received: from eggs.gnu.org ([2001:4830:134:3::10]:43567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWGzb-0000OH-EP
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWGzV-0001KR-DB
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:00:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 22 Jun 2018 09:00:08 +0100
Message-Id: <20180622080009.5707-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180622080009.5707-1-mark.cave-ayland@ilande.co.uk>
References: <20180622080009.5707-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/2] mac_dbdma: only dump commands for debug
 enabled channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This enables us to apply the same filter in DEBUG_DBDMA_CHANMASK to the
DBDMA command execution debug output.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/mac_dbdma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 1b2a69b3ef..87ae246d37 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -71,18 +71,19 @@ static DBDMAState *dbdma_from_ch(DBDMA_channel *ch)
 }
 
 #if DEBUG_DBDMA
-static void dump_dbdma_cmd(dbdma_cmd *cmd)
+static void dump_dbdma_cmd(DBDMA_channel *ch, dbdma_cmd *cmd)
 {
-    printf("dbdma_cmd %p\n", cmd);
-    printf("    req_count 0x%04x\n", le16_to_cpu(cmd->req_count));
-    printf("    command 0x%04x\n", le16_to_cpu(cmd->command));
-    printf("    phy_addr 0x%08x\n", le32_to_cpu(cmd->phy_addr));
-    printf("    cmd_dep 0x%08x\n", le32_to_cpu(cmd->cmd_dep));
-    printf("    res_count 0x%04x\n", le16_to_cpu(cmd->res_count));
-    printf("    xfer_status 0x%04x\n", le16_to_cpu(cmd->xfer_status));
+    DBDMA_DPRINTFCH(ch, "dbdma_cmd %p\n", cmd);
+    DBDMA_DPRINTFCH(ch, "    req_count 0x%04x\n", le16_to_cpu(cmd->req_count));
+    DBDMA_DPRINTFCH(ch, "    command 0x%04x\n", le16_to_cpu(cmd->command));
+    DBDMA_DPRINTFCH(ch, "    phy_addr 0x%08x\n", le32_to_cpu(cmd->phy_addr));
+    DBDMA_DPRINTFCH(ch, "    cmd_dep 0x%08x\n", le32_to_cpu(cmd->cmd_dep));
+    DBDMA_DPRINTFCH(ch, "    res_count 0x%04x\n", le16_to_cpu(cmd->res_count));
+    DBDMA_DPRINTFCH(ch, "    xfer_status 0x%04x\n",
+                    le16_to_cpu(cmd->xfer_status));
 }
 #else
-static void dump_dbdma_cmd(dbdma_cmd *cmd)
+static void dump_dbdma_cmd(DBDMA_channel *ch, dbdma_cmd *cmd)
 {
 }
 #endif
@@ -448,7 +449,7 @@ static void channel_run(DBDMA_channel *ch)
     uint32_t phy_addr;
 
     DBDMA_DPRINTFCH(ch, "channel_run\n");
-    dump_dbdma_cmd(current);
+    dump_dbdma_cmd(ch, current);
 
     /* clear WAKE flag at command fetch */
 
-- 
2.11.0
