Received: from eggs.gnu.org ([2001:4830:134:3::10]:39656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Ee-0001Dd-0V
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EY-0002ml-6F
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38068)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EX-0002mM-UW
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:06 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:09:03 +0300
Message-ID: <151127334297.6888.6977131257577184018.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 19/45] windbg: implemented
 windbg_process_control_packet
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
 windbgstub.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/windbgstub.c b/windbgstub.c
index dc9eba3e3c..b2d4881ee8 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -129,7 +129,31 @@ static void windbg_process_data_packet(ParsingContext *ctx)
 {}
 
 static void windbg_process_control_packet(ParsingContext *ctx)
-{}
+{
+    switch (ctx->packet.PacketType) {
+    case PACKET_TYPE_KD_ACKNOWLEDGE:
+        break;
+
+    case PACKET_TYPE_KD_RESET:
+    {
+        SizedBuf buf = kd_gen_load_symbols_sc(qemu_get_cpu(0));
+
+        windbg_send_data_packet(buf.data, buf.size,
+                                PACKET_TYPE_KD_STATE_CHANGE64);
+        windbg_send_control_packet(ctx->packet.PacketType);
+        windbg_state->ctrl_packet_id = INITIAL_PACKET_ID;
+        SBUF_FREE(buf);
+        break;
+    }
+    default:
+        WINDBG_ERROR("Caught unsupported control packet 0x%x",
+                     ctx->packet.PacketType);
+
+        windbg_state->ctrl_packet_id = 0;
+        windbg_send_control_packet(PACKET_TYPE_KD_RESEND);
+        break;
+    }
+}
 
 static void windbg_ctx_handler(ParsingContext *ctx)
 {
