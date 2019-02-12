Received: from eggs.gnu.org ([209.51.188.92]:41054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1gtfuH-0005bE-Go
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1gtfuG-0004i4-Ge
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:47:57 -0500
From: Sandra Loosemore <sandra@codesourcery.com>
Date: Tue, 12 Feb 2019 14:47:13 -0700
Message-ID: <1550008033-26540-1-git-send-email-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] gdbstub: Send a reply to the vKill packet.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Per the GDB remote protocol documentation

https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#index-vKill-packet

the debug stub is expected to send a reply to the 'vKill' packet.  At
least some versions of GDB crash if the gdb stub simply exits without
sending a reply.  This patch fixes QEMU's gdb stub to conform to the
expected behavior.

Note that QEMU's existing handling of the legacy 'k' packet is
correct: in that case GDB does not expect a reply, and QEMU does not
send one.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
---
 gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub.c b/gdbstub.c
index 70cf330..eb129f6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1363,6 +1363,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             break;
         } else if (strncmp(p, "Kill;", 5) == 0) {
             /* Kill the target */
+            put_packet(s, "OK");
             error_report("QEMU: Terminated via GDBstub");
             exit(0);
         } else {
-- 
2.8.1
