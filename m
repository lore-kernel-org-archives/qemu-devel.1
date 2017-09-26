Received: from eggs.gnu.org ([2001:4830:134:3::10]:59232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfz-0003l5-9s
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfv-0000dT-V3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:19 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51840)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfv-0000cI-OC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:15 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:05:13 +0300
Message-ID: <150642391353.3900.18119086556871785903.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 12/43] windbg: send data and control packets
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
index 7bc3585e53..2ebc161e33 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -57,6 +57,62 @@ typedef struct WindbgState {
 
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
+    packet.PacketType = lduw_p(&packet.PacketType);
+    packet.ByteCount = lduw_p(&packet.ByteCount);
+    packet.PacketId = ldl_p(&packet.PacketId);
+    packet.Checksum = ldl_p(&packet.Checksum);
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
+    packet.PacketType = lduw_p(&packet.PacketType);
+    packet.PacketId = ldl_p(&packet.PacketId);
+
+    qemu_chr_fe_write(&windbg_state->chr, PTR(packet), sizeof(packet));
+
+    windbg_state->ctrl_packet_id ^= 1;
+}
+
 static void windbg_ctx_handler(ParsingContext *ctx)
 {}
 
