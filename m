Received: from eggs.gnu.org ([2001:4830:134:3::10]:41535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsK2-0008C9-1I
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJx-0004nz-DV
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:01 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59978)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJw-0004nm-Vv
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:57 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:51 +0300
Message-ID: <154409759149.5432.7433579017265187980.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 13/39] windbg: parsing data stream
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

Add parsing data stream to packets from windbg client.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |   11 +++
 windbgstub.c                    |  139 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2760684cfb..a28068eecd 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -53,6 +53,17 @@ typedef struct InitedAddr {
     bool is_init;
 } InitedAddr;
 
+typedef struct PacketData {
+    union {
+        struct {
+            DBGKD_MANIPULATE_STATE64 m64;
+            uint8_t extra[0];
+        };
+        uint8_t buf[PACKET_MAX_SIZE];
+    };
+    uint16_t extra_size;
+} PacketData;
+
 const char *kd_api_name(int id);
 const char *kd_pkt_type_name(int id);
 
diff --git a/windbgstub.c b/windbgstub.c
index d7fadda096..2869d94389 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -19,12 +19,43 @@
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
 
+typedef enum ParsingState {
+    STATE_LEADER,
+    STATE_PACKET_TYPE,
+    STATE_PACKET_BYTE_COUNT,
+    STATE_PACKET_ID,
+    STATE_PACKET_CHECKSUM,
+    STATE_PACKET_DATA,
+    STATE_TRAILING_BYTE,
+} ParsingState;
+
+typedef enum ParsingResult {
+    RESULT_NONE,
+    RESULT_BREAKIN_BYTE,
+    RESULT_UNKNOWN_PACKET,
+    RESULT_CONTROL_PACKET,
+    RESULT_DATA_PACKET,
+    RESULT_ERROR,
+} ParsingResult;
+
+typedef struct ParsingContext {
+    /* index in the current buffer,
+       which depends on the current state */
+    int index;
+    ParsingState state;
+    ParsingResult result;
+    KD_PACKET packet;
+    PacketData data;
+    const char *name;
+} ParsingContext;
+
 typedef struct WindbgState {
     bool is_loaded;
     bool catched_breakin_byte;
     uint32_t wait_packet_type;
     uint32_t curr_packet_id;
 
+    ParsingContext ctx;
     CharBackend chr;
 } WindbgState;
 
@@ -36,6 +67,108 @@ static void windbg_state_clean(WindbgState *state)
     state->catched_breakin_byte = false;
     state->wait_packet_type = 0;
     state->curr_packet_id = INITIAL_PACKET_ID | SYNC_PACKET_ID;
+    state->ctx.state = STATE_LEADER;
+    state->ctx.result = RESULT_NONE;
+}
+
+static void windbg_ctx_handler(WindbgState *state)
+{
+}
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
 }
 
 static int windbg_chr_can_receive(void *opaque)
@@ -45,6 +178,11 @@ static int windbg_chr_can_receive(void *opaque)
 
 static void windbg_chr_receive(void *opaque, const uint8_t *buf, int size)
 {
+    int i;
+    for (i = 0; i < size; i++) {
+        windbg_read_byte(&windbg_state->ctx, buf[i]);
+        windbg_ctx_handler(windbg_state);
+    }
 }
 
 static void windbg_exit(void)
@@ -87,6 +225,7 @@ int windbg_server_start(const char *device)
     }
 
     windbg_state = g_new0(WindbgState, 1);
+    windbg_state->ctx.name = "Windbg";
     windbg_state_clean(windbg_state);
 
     chr = qemu_chr_new_noreplay("windbg", device, true);
