Received: from eggs.gnu.org ([2001:4830:134:3::10]:39288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Dv-0000cL-Mj
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Du-0002VO-OR
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:27 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37886)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Du-0002V7-G4
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:26 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:23 +0300
Message-ID: <151127330358.6888.9789211608464050166.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 12/45] windbg: send data and control packets
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

Added functions for send data and control packets to windbg.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/windbgstub.c b/windbgstub.c
index ace992e2cb..8c33e0de0a 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -60,6 +60,62 @@ typedef struct WindbgState {
 
 static WindbgState *windbg_state;
 
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
+__attribute__ ((unused)) /* unused yet */
+static void windbg_send_data_packet(uint8_t *data, uint16_t byte_count,
+                                    uint16_t type)
+{
+    uint8_t trailing_byte = PACKET_TRAILING_BYTE;
+
+    KD_PACKET packet = {
+        .PacketLeader = PACKET_LEADER,
+        .PacketType = type,
+        .ByteCount = byte_count,
+        .PacketId = windbg_state->data_packet_id,
+        .Checksum = compute_checksum(data, byte_count)
+    };
+
+    stw_p(&packet.PacketType, packet.PacketType);
+    stw_p(&packet.ByteCount, packet.ByteCount);
+    stl_p(&packet.PacketId, packet.PacketId);
+    stl_p(&packet.Checksum, packet.Checksum);
+
+    qemu_chr_fe_write(&windbg_state->chr, PTR(packet), sizeof(packet));
+    qemu_chr_fe_write(&windbg_state->chr, data, byte_count);
+    qemu_chr_fe_write(&windbg_state->chr, &trailing_byte,
+                      sizeof(trailing_byte));
+
+    windbg_state->data_packet_id ^= 1;
+}
+
+__attribute__ ((unused)) /* unused yet */
+static void windbg_send_control_packet(uint16_t type)
+{
+    KD_PACKET packet = {
+        .PacketLeader = CONTROL_PACKET_LEADER,
+        .PacketType = type,
+        .ByteCount = 0,
+        .PacketId = windbg_state->ctrl_packet_id,
+        .Checksum = 0
+    };
+
+    stw_p(&packet.PacketType, packet.PacketType);
+    stl_p(&packet.PacketId, packet.PacketId);
+
+    qemu_chr_fe_write(&windbg_state->chr, PTR(packet), sizeof(packet));
+
+    windbg_state->ctrl_packet_id ^= 1;
+}
+
 static void windbg_ctx_handler(ParsingContext *ctx)
 {}
 
