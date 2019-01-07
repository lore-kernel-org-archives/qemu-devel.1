Received: from eggs.gnu.org ([209.51.188.92]:46086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoM-0004r6-9a
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoK-0001k1-CS
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoJ-0001fn-EA
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:32 -0500
Received: by mail-wm1-x32d.google.com with SMTP id t200so1538751wmt.0
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:46 +0000
Message-Id: <20190107163117.16269-7-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/37] gdbstub: add multiprocess support to 'H'
 and 'T' packets
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

Add a couple of helper functions to cope with GDB threads and processes.

The gdb_get_process() function looks for a process given a pid.

The gdb_get_cpu() function returns the CPU corresponding to the (pid,
tid) pair given as parameters.

The read_thread_id() function parses the thread-id sent by the peer.
This function supports the multiprocess extension thread-id syntax.  The
return value specifies if the parsing failed, or if a special case was
encountered (all processes or all threads).

Use them in 'H' and 'T' packets handling to support the multiprocess
extension.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181207090135.7651-5-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 136 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 02beb44d973..644377db9f5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -688,6 +688,71 @@ out:
 #endif
 }
 
+static GDBProcess *gdb_get_process(const GDBState *s, uint32_t pid)
+{
+    int i;
+
+    if (!pid) {
+        /* 0 means any process, we take the first one */
+        return &s->processes[0];
+    }
+
+    for (i = 0; i < s->process_num; i++) {
+        if (s->processes[i].pid == pid) {
+            return &s->processes[i];
+        }
+    }
+
+    return NULL;
+}
+
+static GDBProcess *gdb_get_cpu_process(const GDBState *s, CPUState *cpu)
+{
+    return gdb_get_process(s, gdb_get_cpu_pid(s, cpu));
+}
+
+static CPUState *find_cpu(uint32_t thread_id)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu_gdb_index(cpu) == thread_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
+{
+    GDBProcess *process;
+    CPUState *cpu;
+
+    if (!tid) {
+        /* 0 means any thread, we take the first one */
+        tid = 1;
+    }
+
+    cpu = find_cpu(tid);
+
+    if (cpu == NULL) {
+        return NULL;
+    }
+
+    process = gdb_get_cpu_process(s, cpu);
+
+    if (process->pid != pid) {
+        return NULL;
+    }
+
+    if (!process->attached) {
+        return NULL;
+    }
+
+    return cpu;
+}
+
 static const char *get_feature_xml(const char *p, const char **newp,
                                    CPUClass *cc)
 {
@@ -944,19 +1009,6 @@ static void gdb_set_cpu_pc(GDBState *s, target_ulong pc)
     cpu_set_pc(cpu, pc);
 }
 
-static CPUState *find_cpu(uint32_t thread_id)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (cpu_gdb_index(cpu) == thread_id) {
-            return cpu;
-        }
-    }
-
-    return NULL;
-}
-
 static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
                            char *buf, size_t buf_size)
 {
@@ -970,6 +1022,60 @@ static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
     return buf;
 }
 
+typedef enum GDBThreadIdKind {
+    GDB_ONE_THREAD = 0,
+    GDB_ALL_THREADS,     /* One process, all threads */
+    GDB_ALL_PROCESSES,
+    GDB_READ_THREAD_ERR
+} GDBThreadIdKind;
+
+static GDBThreadIdKind read_thread_id(const char *buf, const char **end_buf,
+                                      uint32_t *pid, uint32_t *tid)
+{
+    unsigned long p, t;
+    int ret;
+
+    if (*buf == 'p') {
+        buf++;
+        ret = qemu_strtoul(buf, &buf, 16, &p);
+
+        if (ret) {
+            return GDB_READ_THREAD_ERR;
+        }
+
+        /* Skip '.' */
+        buf++;
+    } else {
+        p = 1;
+    }
+
+    ret = qemu_strtoul(buf, &buf, 16, &t);
+
+    if (ret) {
+        return GDB_READ_THREAD_ERR;
+    }
+
+    *end_buf = buf;
+
+    if (p == -1) {
+        return GDB_ALL_PROCESSES;
+    }
+
+    if (pid) {
+        *pid = p;
+    }
+
+    if (t == -1) {
+        return GDB_ALL_THREADS;
+    }
+
+    if (tid) {
+        *tid = t;
+    }
+
+    return GDB_ONE_THREAD;
+}
+
 static int is_query_packet(const char *p, const char *query, char separator)
 {
     unsigned int query_len = strlen(query);
@@ -1078,12 +1184,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t thread;
+    uint32_t pid, tid;
     int ch, reg_size, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
+    GDBThreadIdKind thread_kind;
 
     trace_gdbstub_io_command(line_buf);
 
@@ -1291,12 +1399,18 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     case 'H':
         type = *p++;
-        thread = strtoull(p, (char **)&p, 16);
-        if (thread == -1 || thread == 0) {
+
+        thread_kind = read_thread_id(p, &p, &pid, &tid);
+        if (thread_kind == GDB_READ_THREAD_ERR) {
+            put_packet(s, "E22");
+            break;
+        }
+
+        if (thread_kind != GDB_ONE_THREAD) {
             put_packet(s, "OK");
             break;
         }
-        cpu = find_cpu(thread);
+        cpu = gdb_get_cpu(s, pid, tid);
         if (cpu == NULL) {
             put_packet(s, "E22");
             break;
@@ -1316,8 +1430,12 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'T':
-        thread = strtoull(p, (char **)&p, 16);
-        cpu = find_cpu(thread);
+        thread_kind = read_thread_id(p, &p, &pid, &tid);
+        if (thread_kind == GDB_READ_THREAD_ERR) {
+            put_packet(s, "E22");
+            break;
+        }
+        cpu = gdb_get_cpu(s, pid, tid);
 
         if (cpu != NULL) {
             put_packet(s, "OK");
-- 
2.19.2
