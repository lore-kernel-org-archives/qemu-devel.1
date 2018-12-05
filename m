Received: from eggs.gnu.org ([2001:4830:134:3::10]:34038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgZ-00029o-Ei
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgV-0006Ac-Et
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:53:51 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50384)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgU-0006AC-D0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:53:46 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:53:44 +0300
Message-ID: <154401442404.8440.8514373860556140264.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 18/39] windbg: implement
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 windbgstub.c |   35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/windbgstub.c b/windbgstub.c
index fe0b007a06..f13c9a6c1e 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -91,7 +91,6 @@ static void windbg_store_packet(KD_PACKET *packet)
     stl_p(&packet->Checksum, packet->Checksum);
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void windbg_send_data_packet(WindbgState *state, uint8_t *data,
                                     uint16_t byte_count, uint16_t type)
 {
@@ -141,6 +140,40 @@ static void windbg_process_data_packet(WindbgState *state)
 
 static void windbg_process_control_packet(WindbgState *state)
 {
+    ParsingContext *ctx = &state->ctx;
+
+    switch (ctx->packet.PacketType) {
+    case PACKET_TYPE_KD_ACKNOWLEDGE:
+        if (state->wait_packet_type == PACKET_TYPE_KD_ACKNOWLEDGE &&
+            (ctx->packet.PacketId == (state->curr_packet_id &
+                                      ~SYNC_PACKET_ID))) {
+            state->curr_packet_id ^= 1;
+            state->wait_packet_type = 0;
+        }
+        break;
+
+    case PACKET_TYPE_KD_RESET: {
+        state->curr_packet_id = INITIAL_PACKET_ID;
+        windbg_send_control_packet(state, PACKET_TYPE_KD_RESET, 0);
+
+        DBGKD_ANY_WAIT_STATE_CHANGE *sc = kd_state_change_ls(qemu_get_cpu(0));
+        windbg_send_data_packet(state, (uint8_t *) sc,
+                                sizeof(DBGKD_ANY_WAIT_STATE_CHANGE),
+                                PACKET_TYPE_KD_STATE_CHANGE64);
+        g_free(sc);
+        break;
+    }
+
+    case PACKET_TYPE_KD_RESEND:
+        break;
+
+    default:
+        WINDBG_ERROR("Caught unsupported control packet 0x%x",
+                     ctx->packet.PacketType);
+
+        windbg_send_control_packet(state, PACKET_TYPE_KD_RESEND, 0);
+        break;
+    }
 }
 
 static void windbg_ctx_handler(WindbgState *state)
