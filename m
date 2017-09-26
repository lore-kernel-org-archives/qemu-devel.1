Received: from eggs.gnu.org ([2001:4830:134:3::10]:59535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngi-0004US-Bv
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnge-00013b-Hm
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52010)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnge-00013F-AL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:00 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:05:58 +0300
Message-ID: <150642395807.3900.7896904473365407621.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 20/43] windbg: implemented
 windbg_process_data_packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/windbgstub.c b/windbgstub.c
index b8053102dd..b9993c90d4 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -122,9 +122,27 @@ static void windbg_vm_stop(void)
     SBUF_FREE(buf);
 }
 
-static void windbg_process_data_packet(ParsingContext *ctx)
+static void windbg_process_manipulate_packet(ParsingContext *ctx)
 {}
 
+static void windbg_process_data_packet(ParsingContext *ctx)
+{
+    switch (ctx->packet.PacketType) {
+    case PACKET_TYPE_KD_STATE_MANIPULATE:
+        windbg_send_control_packet(PACKET_TYPE_KD_ACKNOWLEDGE);
+        windbg_process_manipulate_packet(ctx);
+        break;
+
+    default:
+        WINDBG_ERROR("Catched unsupported data packet 0x%x",
+                     ctx->packet.PacketType);
+
+        windbg_state->ctrl_packet_id = 0;
+        windbg_send_control_packet(PACKET_TYPE_KD_RESEND);
+        break;
+    }
+}
+
 static void windbg_process_control_packet(ParsingContext *ctx)
 {
     switch (ctx->packet.PacketType) {
