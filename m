Received: from eggs.gnu.org ([2001:4830:134:3::10]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JE-0004ve-LX
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JD-0007ov-3e
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:24 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:28 +0200
Message-Id: <20180901124639.19735-5-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 04/15] gdbstub: add multiprocess support to
 vCont packets
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

Add the gdb_first_cpu() and gdb_next_cpu() to iterate over all
the CPUs in currently attached processes.

Add the gdb_first_cpu_in_process() and gdb_next_cpu_in_process() to
iterate over CPUs of a given process.

Use them to add multiprocess extension support to vCont packets.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 15 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 33fa1b9c5f..2cb9cb6d97 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -704,10 +704,40 @@ static CPUState *find_cpu(uint32_t thread_id)
     }
 
     return NULL;
 }
 
+static CPUState *get_first_cpu_in_process(const GDBState *s,
+                                          GDBProcess *process)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (gdb_get_cpu_pid(s, cpu) == process->pid) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+static CPUState *gdb_next_cpu_in_process(const GDBState *s, CPUState *cpu)
+{
+    uint32_t pid = gdb_get_cpu_pid(s, cpu);
+    cpu = CPU_NEXT(cpu);
+
+    while (cpu) {
+        if (gdb_get_cpu_pid(s, cpu) == pid) {
+            break;
+        }
+
+        cpu = CPU_NEXT(cpu);
+    }
+
+    return cpu;
+}
+
 static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
 {
     GDBProcess *process;
     CPUState *cpu = find_cpu(tid);
 
@@ -731,10 +761,41 @@ static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
     }
 
     return cpu;
 }
 
+/* Return the cpu following @cpu, while ignoring
+ * unattached processes.
+ */
+static CPUState *gdb_next_cpu(const GDBState *s, CPUState *cpu)
+{
+    cpu = CPU_NEXT(cpu);
+
+    while (cpu) {
+        if (gdb_get_cpu_process(s, cpu)->attached) {
+            break;
+        }
+
+        cpu = CPU_NEXT(cpu);
+    }
+
+    return cpu;
+}
+
+/* Return the first attached cpu */
+static CPUState *gdb_first_cpu(const GDBState *s)
+{
+    CPUState *cpu = first_cpu;
+    GDBProcess *process = gdb_get_cpu_process(s, cpu);
+
+    if (!process->attached) {
+        return gdb_next_cpu(s, cpu);
+    }
+
+    return cpu;
+}
+
 static const char *get_feature_xml(const char *p, const char **newp,
                                    CPUClass *cc)
 {
     size_t len;
     int i;
@@ -1070,14 +1131,16 @@ static int is_query_packet(const char *p, const char *query, char separator)
  * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if there is
  *         a format error, 0 on success.
  */
 static int gdb_handle_vcont(GDBState *s, const char *p)
 {
-    int res, idx, signal = 0;
+    int res, signal = 0;
     char cur_action;
     char *newstates;
     unsigned long tmp;
+    uint32_t pid, tid;
+    GDBProcess *process;
     CPUState *cpu;
 #ifdef CONFIG_USER_ONLY
     int max_cpus = 1; /* global variable max_cpus exists only in system mode */
 
     CPU_FOREACH(cpu) {
@@ -1116,29 +1179,52 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
         } else if (cur_action != 'c' && cur_action != 's') {
             /* unknown/invalid/unsupported command */
             res = -ENOTSUP;
             goto out;
         }
-        /* thread specification. special values: (none), -1 = all; 0 = any */
-        if ((p[0] == ':' && p[1] == '-' && p[2] == '1') || (p[0] != ':')) {
-            if (*p == ':') {
-                p += 3;
-            }
-            for (idx = 0; idx < max_cpus; idx++) {
-                if (newstates[idx] == 1) {
-                    newstates[idx] = cur_action;
+
+        if (*p++ != ':') {
+            res = -ENOTSUP;
+            goto out;
+        }
+
+        switch (read_thread_id(p, &p, &pid, &tid)) {
+        case GDB_READ_THREAD_ERR:
+            res = -EINVAL;
+            goto out;
+
+        case GDB_ALL_PROCESSES:
+            cpu = gdb_first_cpu(s);
+            while (cpu) {
+                if (newstates[cpu->cpu_index] == 1) {
+                    newstates[cpu->cpu_index] = cur_action;
                 }
+
+                cpu = gdb_next_cpu(s, cpu);
             }
-        } else if (*p == ':') {
-            p++;
-            res = qemu_strtoul(p, &p, 16, &tmp);
-            if (res) {
+            break;
+
+        case GDB_ALL_THREADS:
+            process = gdb_get_process(s, pid);
+
+            if (!process->attached) {
+                res = -EINVAL;
                 goto out;
             }
 
-            /* 0 means any thread, so we pick the first valid CPU */
-            cpu = tmp ? find_cpu(tmp) : first_cpu;
+            cpu = get_first_cpu_in_process(s, process);
+            while (cpu) {
+                if (newstates[cpu->cpu_index] == 1) {
+                    newstates[cpu->cpu_index] = cur_action;
+                }
+
+                cpu = gdb_next_cpu_in_process(s, cpu);
+            }
+            break;
+
+        case GDB_ONE_THREAD:
+            cpu = gdb_get_cpu(s, pid, tid);
 
             /* invalid CPU/thread specified */
             if (!cpu) {
                 res = -EINVAL;
                 goto out;
@@ -1146,10 +1232,11 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
 
             /* only use if no previous match occourred */
             if (newstates[cpu->cpu_index] == 1) {
                 newstates[cpu->cpu_index] = cur_action;
             }
+            break;
         }
     }
     s->signal = signal;
     gdb_continue_partial(s, newstates);
 
-- 
2.18.0
