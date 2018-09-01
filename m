Received: from eggs.gnu.org ([2001:4830:134:3::10]:35473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JD-0004r5-Uo
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JC-0007oT-OV
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:23 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:36 +0200
Message-Id: <20180901124639.19735-13-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 12/15] gdbstub: processes initialization on new
 peer connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, mark.burton@greensocs.com

When a new connection is established, we set the first process to be
attached, and the others detached. The first CPU of the first process
is selected as the current CPU.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 4874d65a30..36ed7081ea 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2217,13 +2217,14 @@ static bool gdb_accept(void)
         close(fd);
         return false;
     }
 
     s = g_malloc0(sizeof(GDBState));
-    s->c_cpu = first_cpu;
-    s->g_cpu = first_cpu;
     create_unique_process(s);
+    s->processes[0].attached = true;
+    s->c_cpu = gdb_first_cpu(s);
+    s->g_cpu = s->c_cpu;
     s->fd = fd;
     gdb_has_xml = false;
 
     gdbserver_state = s;
     return true;
@@ -2305,12 +2306,23 @@ static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
 static void gdb_chr_event(void *opaque, int event)
 {
+    int i;
+    GDBState *s = (GDBState *) opaque;
+
     switch (event) {
     case CHR_EVENT_OPENED:
+        /* Start with first process attached, others detached */
+        for (i = 0; i < s->process_num; i++) {
+            s->processes[i].attached = !i;
+        }
+
+        s->c_cpu = gdb_first_cpu(s);
+        s->g_cpu = s->c_cpu;
+
         vm_stop(RUN_STATE_PAUSED);
         gdb_has_xml = false;
         break;
     default:
         break;
@@ -2470,19 +2482,17 @@ int gdbserver_start(const char *device)
         mon_chr = s->mon_chr;
         cleanup_processes(s);
         memset(s, 0, sizeof(GDBState));
         s->mon_chr = mon_chr;
     }
-    s->c_cpu = first_cpu;
-    s->g_cpu = first_cpu;
 
     create_processes(s);
 
     if (chr) {
         qemu_chr_fe_init(&s->chr, chr, &error_abort);
         qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
-                                 gdb_chr_event, NULL, NULL, NULL, true);
+                                 gdb_chr_event, NULL, s, NULL, true);
     }
     s->state = chr ? RS_IDLE : RS_INACTIVE;
     s->mon_chr = mon_chr;
     s->current_syscall_cb = NULL;
 
-- 
2.18.0
