Received: from eggs.gnu.org ([2001:4830:134:3::10]:39134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DW-0000Dk-L3
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DS-0002Mq-Hy
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:02 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37764)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DS-0002Mb-9h
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:58 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:07:55 +0300
Message-ID: <151127327535.6888.327046308949031767.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 07/45] windbg: added chardev
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

Added chardev for listening to windbg. Target device is a parameter in the '-windbg' option.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/windbgstub.c b/windbgstub.c
index 0863da73fd..e30b8500e0 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -20,12 +20,26 @@
 typedef struct WindbgState {
     bool is_loaded;
 
+    CharBackend chr;
+
     uint32_t ctrl_packet_id;
     uint32_t data_packet_id;
 } WindbgState;
 
 static WindbgState *windbg_state;
 
+static int windbg_chr_can_receive(void *opaque)
+{
+    return PACKET_MAX_SIZE;
+}
+
+static void windbg_chr_receive(void *opaque, const uint8_t *buf, int size)
+{
+    if (windbg_state->is_loaded) {
+        /* T0D0: parse data */
+    }
+}
+
 static void windbg_exit(void)
 {
     g_free(windbg_state);
@@ -33,15 +47,31 @@ static void windbg_exit(void)
 
 int windbg_server_start(const char *device)
 {
+    Chardev *chr = NULL;
+
     if (windbg_state) {
         WINDBG_ERROR("Multiple instances of windbg are not supported.");
         exit(1);
     }
 
+    if (!strstart(device, "pipe:", NULL)) {
+        WINDBG_ERROR("Unsupported device. Supported only pipe.");
+        exit(1);
+    }
+
     windbg_state = g_new0(WindbgState, 1);
     windbg_state->ctrl_packet_id = RESET_PACKET_ID;
     windbg_state->data_packet_id = INITIAL_PACKET_ID;
 
+    chr = qemu_chr_new_noreplay(WINDBG, device);
+    if (!chr) {
+        return -1;
+    }
+
+    qemu_chr_fe_init(&windbg_state->chr, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&windbg_state->chr, windbg_chr_can_receive,
+                             windbg_chr_receive, NULL, NULL, NULL, NULL, true);
+
     atexit(windbg_exit);
     return 0;
 }
