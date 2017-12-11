Received: from eggs.gnu.org ([2001:4830:134:3::10]:34034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3I-0001z1-B9
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3F-0002en-7M
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43658)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3E-0002ed-VM
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:21 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:23:05 +0300
Message-ID: <151299858560.4808.17586394848452889553.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 19/46] windbg: implemented
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
index 07a1815b79..cd46649278 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -125,9 +125,27 @@ static void windbg_vm_stop(void)
     g_free(buf.data);
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
+        WINDBG_ERROR("Caught unsupported data packet 0x%x",
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
