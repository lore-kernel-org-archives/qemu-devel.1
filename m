Received: from eggs.gnu.org ([209.51.188.92]:46146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoR-0004ud-Cg
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoO-0001s0-PO
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoM-0001l9-Ao
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:35 -0500
Received: by mail-wr1-x42d.google.com with SMTP id 96so1089424wrb.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:49 +0000
Message-Id: <20190107163117.16269-10-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/37] gdbstub: add multiprocess support to
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

From: Luc Michel <luc.michel@greensocs.com>

Change the thread info related packets handling to support multiprocess
extension.

Add the CPUs class name in the extra info to help differentiate
them in multiprocess mode.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181207090135.7651-8-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 1ba7aa6a28a..f70b5a326fe 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1268,7 +1268,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUState *cpu;
     CPUClass *cc;
     const char *p;
-    uint32_t thread;
     uint32_t pid, tid;
     int ch, reg_size, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
@@ -1565,26 +1564,44 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             put_packet(s, buf);
             break;
         } else if (strcmp(p,"fThreadInfo") == 0) {
-            s->query_cpu = first_cpu;
+            s->query_cpu = gdb_first_attached_cpu(s);
             goto report_cpuinfo;
         } else if (strcmp(p,"sThreadInfo") == 0) {
         report_cpuinfo:
             if (s->query_cpu) {
-                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query_cpu));
+                snprintf(buf, sizeof(buf), "m%s",
+                         gdb_fmt_thread_id(s, s->query_cpu,
+                                       thread_id, sizeof(thread_id)));
                 put_packet(s, buf);
-                s->query_cpu = CPU_NEXT(s->query_cpu);
+                s->query_cpu = gdb_next_attached_cpu(s, s->query_cpu);
             } else
                 put_packet(s, "l");
             break;
         } else if (strncmp(p,"ThreadExtraInfo,", 16) == 0) {
-            thread = strtoull(p+16, (char **)&p, 16);
-            cpu = find_cpu(thread);
+            if (read_thread_id(p + 16, &p, &pid, &tid) == GDB_READ_THREAD_ERR) {
+                put_packet(s, "E22");
+                break;
+            }
+            cpu = gdb_get_cpu(s, pid, tid);
             if (cpu != NULL) {
                 cpu_synchronize_state(cpu);
-                /* memtohex() doubles the required space */
-                len = snprintf((char *)mem_buf, sizeof(buf) / 2,
-                               "CPU#%d [%s]", cpu->cpu_index,
-                               cpu->halted ? "halted " : "running");
+
+                if (s->multiprocess && (s->process_num > 1)) {
+                    /* Print the CPU model and name in multiprocess mode */
+                    ObjectClass *oc = object_get_class(OBJECT(cpu));
+                    const char *cpu_model = object_class_get_name(oc);
+                    char *cpu_name =
+                        object_get_canonical_path_component(OBJECT(cpu));
+                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
+                                   "%s %s [%s]", cpu_model, cpu_name,
+                                   cpu->halted ? "halted " : "running");
+                    g_free(cpu_name);
+                } else {
+                    /* memtohex() doubles the required space */
+                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
+                                   "CPU#%d [%s]", cpu->cpu_index,
+                                   cpu->halted ? "halted " : "running");
+                }
                 trace_gdbstub_op_extra_info((char *)mem_buf);
                 memtohex(buf, mem_buf, len);
                 put_packet(s, buf);
-- 
2.19.2
