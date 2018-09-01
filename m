Received: from eggs.gnu.org ([2001:4830:134:3::10]:35525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JE-0004wq-WD
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JD-0007p9-9o
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:24 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:27 +0200
Message-Id: <20180901124639.19735-4-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 03/15] gdbstub: add multiprocess support to 'H'
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, mark.burton@greensocs.com

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
---
 gdbstub.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 131 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index ec3105dbc1..33fa1b9c5f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -667,10 +667,74 @@ static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
     }
 
     return pid + 1;
 }
 
+static GDBProcess *gdb_get_process(const GDBState *s, uint32_t pid)
+{
+    uint32_t process_idx;
+
+    if (!pid) {
+        /* 0 means any process, we take the first one */
+        pid = 1;
+    }
+
+    /* GDB PIDs are in the range [1;n] */
+    process_idx = pid - 1;
+
+    if (process_idx >= s->process_num) {
+        return NULL;
+    }
+
+    return &s->processes[process_idx];
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
+    CPUState *cpu = find_cpu(tid);
+
+    if (!tid) {
+        /* 0 means any thread, we take the first one */
+        tid = 1;
+    }
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
     size_t len;
     int i;
@@ -923,23 +987,10 @@ static void gdb_set_cpu_pc(GDBState *s, target_ulong pc)
 
     cpu_synchronize_state(cpu);
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
 static char *get_thread_id(const GDBState *s, CPUState *cpu,
                            char *buf, size_t buf_size)
 {
     if (s->multiprocess) {
         snprintf(buf, buf_size, "p%02x.%02x",
@@ -950,10 +1001,64 @@ static char *get_thread_id(const GDBState *s, CPUState *cpu,
     }
 
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
 
     return strncmp(p, query, query_len) == 0 &&
@@ -1058,16 +1163,18 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
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
 
     p = line_buf;
     ch = *p++;
@@ -1271,16 +1378,22 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         else
             put_packet(s, "E22");
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
         }
         switch (type) {
@@ -1296,12 +1409,12 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
              put_packet(s, "E22");
              break;
         }
         break;
     case 'T':
-        thread = strtoull(p, (char **)&p, 16);
-        cpu = find_cpu(thread);
+        read_thread_id(p, &p, &pid, &tid);
+        cpu = gdb_get_cpu(s, pid, tid);
 
         if (cpu != NULL) {
             put_packet(s, "OK");
         } else {
             put_packet(s, "E22");
-- 
2.18.0
