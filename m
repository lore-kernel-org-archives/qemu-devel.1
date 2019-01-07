Received: from eggs.gnu.org ([209.51.188.92]:46084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoM-0004r5-9W
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoK-0001jx-By
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:34 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoI-0001eH-Ca
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:32 -0500
Received: by mail-wr1-x42a.google.com with SMTP id t27so1064602wra.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:45 +0000
Message-Id: <20190107163117.16269-6-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/37] gdbstub: add multiprocess support to '?'
 packets
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

The gdb_get_cpu_pid() function does the PID lookup for the given CPU. It
checks if the CPU is a direct child of a CPU cluster. If it is, the
returned PID is the cluster ID plus one (cluster IDs start at 0, GDB
PIDs at 1). When the CPU is not a child of such a container, the PID of
the default process is returned.

The gdb_fmt_thread_id() function generates the string to be used to identify
a given thread, in a response packet for the peer. This function
supports generating thread IDs when multiprocess mode is enabled (in the
form `p<pid>.<tid>').

Use them in the reply to a '?' request.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181207090135.7651-4-luc.michel@greensocs.com
[PMM: fixed checkpatch blockquote style nit]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 9ac6f19a186..02beb44d973 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -640,6 +640,54 @@ static int memtox(char *buf, const char *mem, int len)
     return p - buf;
 }
 
+static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
+{
+#ifndef CONFIG_USER_ONLY
+    gchar *path, *name = NULL;
+    Object *obj;
+    CPUClusterState *cluster;
+    uint32_t ret;
+
+    path = object_get_canonical_path(OBJECT(cpu));
+
+    if (path == NULL) {
+        /* Return the default process' PID */
+        ret = s->processes[s->process_num - 1].pid;
+        goto out;
+    }
+
+    name = object_get_canonical_path_component(OBJECT(cpu));
+    assert(name != NULL);
+
+    /*
+     * Retrieve the CPU parent path by removing the last '/' and the CPU name
+     * from the CPU canonical path.
+     */
+    path[strlen(path) - strlen(name) - 1] = '\0';
+
+    obj = object_resolve_path_type(path, TYPE_CPU_CLUSTER, NULL);
+
+    if (obj == NULL) {
+        /* Return the default process' PID */
+        ret = s->processes[s->process_num - 1].pid;
+        goto out;
+    }
+
+    cluster = CPU_CLUSTER(obj);
+    ret = cluster->cluster_id + 1;
+
+out:
+    g_free(name);
+    g_free(path);
+
+    return ret;
+
+#else
+    /* TODO: In user mode, we should use the task state PID */
+    return s->processes[s->process_num - 1].pid;
+#endif
+}
+
 static const char *get_feature_xml(const char *p, const char **newp,
                                    CPUClass *cc)
 {
@@ -909,6 +957,19 @@ static CPUState *find_cpu(uint32_t thread_id)
     return NULL;
 }
 
+static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
+                           char *buf, size_t buf_size)
+{
+    if (s->multiprocess) {
+        snprintf(buf, buf_size, "p%02x.%02x",
+                 gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
+    } else {
+        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
+    }
+
+    return buf;
+}
+
 static int is_query_packet(const char *p, const char *query, char separator)
 {
     unsigned int query_len = strlen(query);
@@ -1020,6 +1081,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     int ch, reg_size, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
+    char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
 
@@ -1030,8 +1092,8 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     switch(ch) {
     case '?':
         /* TODO: Make this return the correct value for user-mode.  */
-        snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TRAP,
-                 cpu_gdb_index(s->c_cpu));
+        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
+                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
         put_packet(s, buf);
         /* Remove all the breakpoints when this query is issued,
          * because gdb is doing and initial connect and the state
-- 
2.19.2
