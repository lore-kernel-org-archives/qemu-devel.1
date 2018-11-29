Received: from eggs.gnu.org ([2001:4830:134:3::10]:53336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNJk-0005FI-Gy
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNJj-0007kq-Q1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39648)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNJh-0007X7-QW
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:22 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 29 Nov 2018 17:29:17 +0300
Message-ID: <154350175732.8036.9184331245906503259.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
References: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 19/39] windbg: implement
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 windbgstub.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/windbgstub.c b/windbgstub.c
index f13c9a6c1e..8cbece40da 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -134,8 +134,35 @@ static void windbg_vm_stop(void)
     vm_stop(RUN_STATE_PAUSED);
 }
 
+static void windbg_process_manipulate_packet(WindbgState *state)
+{
+}
+
 static void windbg_process_data_packet(WindbgState *state)
 {
+    ParsingContext *ctx = &state->ctx;
+
+    if (state->wait_packet_type == PACKET_TYPE_KD_ACKNOWLEDGE) {
+        /* We received something different */
+        windbg_send_control_packet(state, PACKET_TYPE_KD_RESEND, 0);
+        return;
+    }
+
+    switch (ctx->packet.PacketType) {
+    case PACKET_TYPE_KD_STATE_MANIPULATE:
+        windbg_send_control_packet(state, PACKET_TYPE_KD_ACKNOWLEDGE,
+                                   ctx->packet.PacketId);
+        windbg_process_manipulate_packet(state);
+        state->curr_packet_id &= ~SYNC_PACKET_ID;
+        break;
+
+    default:
+        WINDBG_ERROR("Caught unsupported data packet 0x%x",
+                     ctx->packet.PacketType);
+
+        windbg_send_control_packet(state, PACKET_TYPE_KD_RESEND, 0);
+        break;
+    }
 }
 
 static void windbg_process_control_packet(WindbgState *state)
