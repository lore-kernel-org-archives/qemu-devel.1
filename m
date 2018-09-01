Received: from eggs.gnu.org ([2001:4830:134:3::10]:35646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JZ-00068Q-7N
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JY-0007yF-6J
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:45 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:30 +0200
Message-Id: <20180901124639.19735-7-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 06/15] gdbstub: add multiprocess support to
 (f|s)ThreadInfo and ThreadExtraInfo
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

Change the thread info related packets handling to support multiprocess
extension.

Add the CPUs class name in the extra info to help differentiate
them in multiprocess mode.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c15250ce65..43015f7792 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1249,11 +1249,10 @@ out:
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
     CPUClass *cc;
     const char *p;
-    uint32_t thread;
     uint32_t pid, tid;
     int ch, reg_size, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1541,30 +1540,43 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             snprintf(buf, sizeof(buf), "QC%s",
                      get_thread_id(s, cpu, thread_id, sizeof(thread_id)));
             put_packet(s, buf);
             break;
         } else if (strcmp(p,"fThreadInfo") == 0) {
-            s->query_cpu = first_cpu;
+            s->query_cpu = gdb_first_cpu(s);
             goto report_cpuinfo;
         } else if (strcmp(p,"sThreadInfo") == 0) {
         report_cpuinfo:
             if (s->query_cpu) {
-                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query_cpu));
+                snprintf(buf, sizeof(buf), "m%s",
+                         get_thread_id(s, s->query_cpu,
+                                       thread_id, sizeof(thread_id)));
                 put_packet(s, buf);
-                s->query_cpu = CPU_NEXT(s->query_cpu);
+                s->query_cpu = gdb_next_cpu(s, s->query_cpu);
             } else
                 put_packet(s, "l");
             break;
         } else if (strncmp(p,"ThreadExtraInfo,", 16) == 0) {
-            thread = strtoull(p+16, (char **)&p, 16);
-            cpu = find_cpu(thread);
+            read_thread_id(p + 16, &p, &pid, &tid);
+            cpu = gdb_get_cpu(s, pid, tid);
             if (cpu != NULL) {
                 cpu_synchronize_state(cpu);
-                /* memtohex() doubles the required space */
-                len = snprintf((char *)mem_buf, sizeof(buf) / 2,
-                               "CPU#%d [%s]", cpu->cpu_index,
-                               cpu->halted ? "halted " : "running");
+
+                if (s->multiprocess && (s->process_num > 1)) {
+                    /* Print the CPU model in multiprocess mode */
+                    ObjectClass *oc = object_get_class(OBJECT(cpu));
+                    const char *cpu_model = object_class_get_name(oc);
+                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
+                                   "CPU#%d %s [%s]", cpu->cpu_index,
+                                   cpu_model,
+                                   cpu->halted ? "halted " : "running");
+                } else {
+                    /* memtohex() doubles the required space */
+                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
+                                   "CPU#%d [%s]", cpu->cpu_index,
+                                   cpu->halted ? "halted " : "running");
+                }
                 trace_gdbstub_op_extra_info((char *)mem_buf);
                 memtohex(buf, mem_buf, len);
                 put_packet(s, buf);
             }
             break;
-- 
2.18.0
