Received: from eggs.gnu.org ([2001:4830:134:3::10]:35486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JE-0004sH-6A
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JC-0007oj-U3
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:24 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:32 +0200
Message-Id: <20180901124639.19735-9-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 08/15] gdbstub: add multiprocess support to
 gdb_vm_state_change()
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

Add support for multiprocess extension in gdb_vm_state_change()
function.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 761cb051c8..4ccd1153ce 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1693,10 +1693,11 @@ void gdb_set_stop_cpu(CPUState *cpu)
 static void gdb_vm_state_change(void *opaque, int running, RunState state)
 {
     GDBState *s = gdbserver_state;
     CPUState *cpu = s->c_cpu;
     char buf[256];
+    char thread_id[16];
     const char *type;
     int ret;
 
     if (running || s->state == RS_INACTIVE) {
         return;
@@ -1704,10 +1705,18 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
     /* Is there a GDB syscall waiting to be sent?  */
     if (s->current_syscall_cb) {
         put_packet(s, s->syscall_buf);
         return;
     }
+
+    if (cpu == NULL) {
+        /* No process attached */
+        return;
+    }
+
+    get_thread_id(s, cpu, thread_id, sizeof(thread_id));
+
     switch (state) {
     case RUN_STATE_DEBUG:
         if (cpu->watchpoint_hit) {
             switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
             case BP_MEM_READ:
@@ -1721,12 +1730,12 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
                 break;
             }
             trace_gdbstub_hit_watchpoint(type, cpu_gdb_index(cpu),
                     (target_ulong)cpu->watchpoint_hit->vaddr);
             snprintf(buf, sizeof(buf),
-                     "T%02xthread:%02x;%swatch:" TARGET_FMT_lx ";",
-                     GDB_SIGNAL_TRAP, cpu_gdb_index(cpu), type,
+                     "T%02xthread:%s;%swatch:" TARGET_FMT_lx ";",
+                     GDB_SIGNAL_TRAP, thread_id, type,
                      (target_ulong)cpu->watchpoint_hit->vaddr);
             cpu->watchpoint_hit = NULL;
             goto send_packet;
         } else {
             trace_gdbstub_hit_break();
@@ -1764,11 +1773,11 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         trace_gdbstub_hit_unknown(state);
         ret = GDB_SIGNAL_UNKNOWN;
         break;
     }
     gdb_set_stop_cpu(cpu);
-    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_gdb_index(cpu));
+    snprintf(buf, sizeof(buf), "T%02xthread:%s;", ret, thread_id);
 
 send_packet:
     put_packet(s, buf);
 
     /* disable single step if it was enabled */
-- 
2.18.0
