Received: from eggs.gnu.org ([209.51.188.92]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoP-0004tM-VD
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoM-0001nT-BH
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:36 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoK-0001hp-AO
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id q18so1047302wrx.9
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.28 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:47 +0000
Message-Id: <20190107163117.16269-8-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/37] gdbstub: add multiprocess support to
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

From: Luc Michel <luc.michel@greensocs.com>

Add the gdb_first_attached_cpu() and gdb_next_attached_cpu() to iterate
over all the CPUs in currently attached processes.

Add the gdb_first_cpu_in_process() and gdb_next_cpu_in_process() to
iterate over CPUs of a given process.

Use them to add multiprocess extension support to vCont packets.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181207090135.7651-6-luc.michel@greensocs.com
[PMM: corrected checkpatch comment style nit]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 100 insertions(+), 15 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 644377db9f5..09114ea7769 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -724,6 +724,36 @@ static CPUState *find_cpu(uint32_t thread_id)
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
@@ -753,6 +783,35 @@ static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
     return cpu;
 }
 
+/* Return the cpu following @cpu, while ignoring unattached processes. */
+static CPUState *gdb_next_attached_cpu(const GDBState *s, CPUState *cpu)
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
+static CPUState *gdb_first_attached_cpu(const GDBState *s)
+{
+    CPUState *cpu = first_cpu;
+    GDBProcess *process = gdb_get_cpu_process(s, cpu);
+
+    if (!process->attached) {
+        return gdb_next_attached_cpu(s, cpu);
+    }
+
+    return cpu;
+}
+
 static const char *get_feature_xml(const char *p, const char **newp,
                                    CPUClass *cc)
 {
@@ -1091,10 +1150,12 @@ static int is_query_packet(const char *p, const char *query, char separator)
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
@@ -1137,25 +1198,48 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
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
+            cpu = gdb_first_attached_cpu(s);
+            while (cpu) {
+                if (newstates[cpu->cpu_index] == 1) {
+                    newstates[cpu->cpu_index] = cur_action;
                 }
+
+                cpu = gdb_next_attached_cpu(s, cpu);
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
@@ -1167,6 +1251,7 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
             if (newstates[cpu->cpu_index] == 1) {
                 newstates[cpu->cpu_index] = cur_action;
             }
+            break;
         }
     }
     s->signal = signal;
-- 
2.19.2
