Received: from eggs.gnu.org ([2001:4830:134:3::10]:33891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgG-0001r2-Jm
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgC-0005zt-Gd
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:53:32 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50270)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWg8-0005wv-QI
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:53:26 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:53:22 +0300
Message-ID: <154401440182.8440.1942830012511299931.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 14/39] windbg: send data and control packets
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
 windbgstub.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/windbgstub.c b/windbgstub.c
index 2869d94389..c45faec43f 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -71,6 +71,65 @@ static void windbg_state_clean(WindbgState *state)
     state->ctx.result = RESULT_NONE;
 }
 
+static uint32_t compute_checksum(uint8_t *data, uint16_t len)
+{
+    uint32_t checksum = 0;
+    while (len) {
+        --len;
+        checksum += *data++;
+    }
+    return checksum;
+}
+
+static void windbg_store_packet(KD_PACKET *packet)
+{
+    stw_p(&packet->PacketLeader, packet->PacketLeader);
+    stw_p(&packet->PacketType, packet->PacketType);
+    stw_p(&packet->ByteCount, packet->ByteCount);
+    stl_p(&packet->PacketId, packet->PacketId);
+    stl_p(&packet->Checksum, packet->Checksum);
+}
+
+__attribute__ ((unused)) /* unused yet */
+static void windbg_send_data_packet(WindbgState *state, uint8_t *data,
+                                    uint16_t byte_count, uint16_t type)
+{
+    const uint8_t trailing_byte = PACKET_TRAILING_BYTE;
+
+    KD_PACKET packet = {
+        .PacketLeader = PACKET_LEADER,
+        .PacketType = type,
+        .ByteCount = byte_count,
+        .PacketId = state->curr_packet_id,
+        .Checksum = compute_checksum(data, byte_count),
+    };
+
+    windbg_store_packet(&packet);
+
+    qemu_chr_fe_write(&state->chr, PTR(packet), sizeof(packet));
+    qemu_chr_fe_write(&state->chr, data, byte_count);
+    qemu_chr_fe_write(&state->chr, &trailing_byte, sizeof(trailing_byte));
+
+    state->wait_packet_type = PACKET_TYPE_KD_ACKNOWLEDGE;
+}
+
+__attribute__ ((unused)) /* unused yet */
+static void windbg_send_control_packet(WindbgState *state, uint16_t type,
+                                       uint32_t id)
+{
+    KD_PACKET packet = {
+        .PacketLeader = CONTROL_PACKET_LEADER,
+        .PacketType = type,
+        .ByteCount = 0,
+        .PacketId = id,
+        .Checksum = 0,
+    };
+
+    windbg_store_packet(&packet);
+
+    qemu_chr_fe_write(&state->chr, PTR(packet), sizeof(packet));
+}
+
 static void windbg_ctx_handler(WindbgState *state)
 {
 }
