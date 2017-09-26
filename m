Received: from eggs.gnu.org ([2001:4830:134:3::10]:59458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngX-0004JY-DU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngT-0000y6-Ho
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51972)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngT-0000xk-9W
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:49 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:05:47 +0300
Message-ID: <150642394703.3900.4773733429269296011.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 18/43] windbg: windbg_vm_stop
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

Added function for stop vm. Also, ExceptionStateChange data is generated and sent here.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/windbgstub.c b/windbgstub.c
index d22eea70aa..3a13d22349 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -68,7 +68,6 @@ static uint32_t compute_checksum(uint8_t *data, uint16_t len)
     return checksum;
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void windbg_send_data_packet(uint8_t *data, uint16_t byte_count,
                                     uint16_t type)
 {
@@ -113,6 +112,16 @@ static void windbg_send_control_packet(uint16_t type)
     windbg_state->ctrl_packet_id ^= 1;
 }
 
+static void windbg_vm_stop(void)
+{
+    CPUState *cpu = qemu_get_cpu(0);
+    vm_stop(RUN_STATE_PAUSED);
+
+    SizedBuf buf = kd_gen_exception_sc(cpu);
+    windbg_send_data_packet(buf.data, buf.size, PACKET_TYPE_KD_STATE_CHANGE64);
+    SBUF_FREE(buf);
+}
+
 static void windbg_process_data_packet(ParsingContext *ctx)
 {}
 
@@ -126,7 +135,7 @@ static void windbg_ctx_handler(ParsingContext *ctx)
         break;
 
     case RESULT_BREAKIN_BYTE:
-        vm_stop(RUN_STATE_PAUSED);
+        windbg_vm_stop();
         break;
 
     case RESULT_CONTROL_PACKET:
