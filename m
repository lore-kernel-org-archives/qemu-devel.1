Received: from eggs.gnu.org ([2001:4830:134:3::10]:39275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Dt-0000a3-Ar
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Dp-0002UB-7V
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:25 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37856)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Do-0002Tu-SF
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:21 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:18 +0300
Message-ID: <151127329797.6888.2001141534114518453.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 11/45] windbg: parsing data stream
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

Added function of parsing data stream from windbg to packet.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/windbgstub.c b/windbgstub.c
index 395f244d4f..ace992e2cb 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -60,6 +60,105 @@ typedef struct WindbgState {
 
 static WindbgState *windbg_state;
 
+static void windbg_ctx_handler(ParsingContext *ctx)
+{}
+
+static void windbg_read_byte(ParsingContext *ctx, uint8_t byte)
+{
+    switch (ctx->state) {
+    case STATE_LEADER:
+        ctx->result = RESULT_NONE;
+        if (byte == PACKET_LEADER_BYTE || byte == CONTROL_PACKET_LEADER_BYTE) {
+            if (ctx->index > 0 && byte != PTR(ctx->packet.PacketLeader)[0]) {
+                ctx->index = 0;
+            }
+            PTR(ctx->packet.PacketLeader)[ctx->index] = byte;
+            ++ctx->index;
+            if (ctx->index == sizeof(ctx->packet.PacketLeader)) {
+                ctx->state = STATE_PACKET_TYPE;
+                ctx->index = 0;
+            }
+        } else if (byte == BREAKIN_PACKET_BYTE) {
+            ctx->result = RESULT_BREAKIN_BYTE;
+            ctx->index = 0;
+        } else {
+            ctx->index = 0;
+        }
+        break;
+
+    case STATE_PACKET_TYPE:
+        PTR(ctx->packet.PacketType)[ctx->index] = byte;
+        ++ctx->index;
+        if (ctx->index == sizeof(ctx->packet.PacketType)) {
+            ctx->packet.PacketType = lduw_p(&ctx->packet.PacketType);
+            if (ctx->packet.PacketType >= PACKET_TYPE_MAX) {
+                ctx->state = STATE_LEADER;
+                ctx->result = RESULT_UNKNOWN_PACKET;
+            } else {
+                ctx->state = STATE_PACKET_BYTE_COUNT;
+            }
+            ctx->index = 0;
+        }
+        break;
+
+    case STATE_PACKET_BYTE_COUNT:
+        PTR(ctx->packet.ByteCount)[ctx->index] = byte;
+        ++ctx->index;
+        if (ctx->index == sizeof(ctx->packet.ByteCount)) {
+            ctx->packet.ByteCount = lduw_p(&ctx->packet.ByteCount);
+            ctx->state = STATE_PACKET_ID;
+            ctx->index = 0;
+        }
+        break;
+
+    case STATE_PACKET_ID:
+        PTR(ctx->packet.PacketId)[ctx->index] = byte;
+        ++ctx->index;
+        if (ctx->index == sizeof(ctx->packet.PacketId)) {
+            ctx->packet.PacketId = ldl_p(&ctx->packet.PacketId);
+            ctx->state = STATE_PACKET_CHECKSUM;
+            ctx->index = 0;
+        }
+        break;
+
+    case STATE_PACKET_CHECKSUM:
+        PTR(ctx->packet.Checksum)[ctx->index] = byte;
+        ++ctx->index;
+        if (ctx->index == sizeof(ctx->packet.Checksum)) {
+            ctx->packet.Checksum = ldl_p(&ctx->packet.Checksum);
+            if (ctx->packet.PacketLeader == CONTROL_PACKET_LEADER) {
+                ctx->state = STATE_LEADER;
+                ctx->result = RESULT_CONTROL_PACKET;
+            } else if (ctx->packet.ByteCount > PACKET_MAX_SIZE) {
+                ctx->state = STATE_LEADER;
+                ctx->result = RESULT_ERROR;
+            } else {
+                ctx->state = STATE_PACKET_DATA;
+            }
+            ctx->index = 0;
+        }
+        break;
+
+    case STATE_PACKET_DATA:
+        ctx->data.buf[ctx->index] = byte;
+        ++ctx->index;
+        if (ctx->index == ctx->packet.ByteCount) {
+            ctx->state = STATE_TRAILING_BYTE;
+            ctx->index = 0;
+        }
+        break;
+
+    case STATE_TRAILING_BYTE:
+        if (byte == PACKET_TRAILING_BYTE) {
+            ctx->result = RESULT_DATA_PACKET;
+        } else {
+            ctx->result = RESULT_ERROR;
+        }
+        ctx->state = STATE_LEADER;
+        break;
+    }
+}
+
 static int windbg_chr_can_receive(void *opaque)
 {
     return PACKET_MAX_SIZE;
@@ -67,8 +166,18 @@ static int windbg_chr_can_receive(void *opaque)
 
 static void windbg_chr_receive(void *opaque, const uint8_t *buf, int size)
 {
+    static ParsingContext ctx = {
+        .state = STATE_LEADER,
+        .result = RESULT_NONE,
+        .name = ""
+    };
+
     if (windbg_state->is_loaded) {
-        /* T0D0: parse data */
+        int i;
+        for (i = 0; i < size; i++) {
+            windbg_read_byte(&ctx, buf[i]);
+            windbg_ctx_handler(&ctx);
+        }
     }
 }
 
