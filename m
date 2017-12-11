Received: from eggs.gnu.org ([2001:4830:134:3::10]:33926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO34-0001kO-T3
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO34-0002Y4-1h
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:10 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43618)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO33-0002XX-Po
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:09 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:22:54 +0300
Message-ID: <151299857436.4808.6569264827627731017.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 17/46] windbg: windbg_vm_stop
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
index b71449e369..6eb9517e24 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -71,7 +71,6 @@ static uint32_t compute_checksum(uint8_t *data, uint16_t len)
     return checksum;
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void windbg_send_data_packet(uint8_t *data, uint16_t byte_count,
                                     uint16_t type)
 {
@@ -116,6 +115,16 @@ static void windbg_send_control_packet(uint16_t type)
     windbg_state->ctrl_packet_id ^= 1;
 }
 
+static void windbg_vm_stop(void)
+{
+    CPUState *cpu = qemu_get_cpu(0);
+    vm_stop(RUN_STATE_PAUSED);
+
+    SizedBuf buf = kd_gen_exception_sc(cpu);
+    windbg_send_data_packet(buf.data, buf.size, PACKET_TYPE_KD_STATE_CHANGE64);
+    g_free(buf.data);
+}
+
 static void windbg_process_data_packet(ParsingContext *ctx)
 {}
 
@@ -129,7 +138,7 @@ static void windbg_ctx_handler(ParsingContext *ctx)
         break;
 
     case RESULT_BREAKIN_BYTE:
-        vm_stop(RUN_STATE_PAUSED);
+        windbg_vm_stop();
         break;
 
     case RESULT_CONTROL_PACKET:
