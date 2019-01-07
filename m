Received: from eggs.gnu.org ([209.51.188.92]:46027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoI-0004nw-AW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoG-0001dy-DN
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoF-0001bi-Rl
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id b11so1465566wmj.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:44 +0000
Message-Id: <20190107163117.16269-5-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/37] gdbstub: introduce GDB processes
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

Add a structure GDBProcess that represents processes from the GDB
semantic point of view.

CPUs can be split into different processes, by grouping them under
different cpu-cluster objects.  Each occurrence of a cpu-cluster object
implies the existence of the corresponding process in the GDB stub. The
GDB process ID is derived from the corresponding cluster ID as follows:

  GDB PID = cluster ID + 1

This is because PIDs -1 and 0 are reserved in GDB and cannot be used by
processes.

A default process is created to handle CPUs that are not in a cluster.
This process gets the PID of the last process PID + 1.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181207090135.7651-3-luc.michel@greensocs.com
[PMM: fixed checkpatch nit about block comment style]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index c4e4f9f0821..9ac6f19a186 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -29,6 +29,7 @@
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "exec/gdbstub.h"
+#include "hw/cpu/cluster.h"
 #endif
 
 #define MAX_PACKET_LENGTH 4096
@@ -296,6 +297,11 @@ typedef struct GDBRegisterState {
     struct GDBRegisterState *next;
 } GDBRegisterState;
 
+typedef struct GDBProcess {
+    uint32_t pid;
+    bool attached;
+} GDBProcess;
+
 enum RSState {
     RS_INACTIVE,
     RS_IDLE,
@@ -324,6 +330,9 @@ typedef struct GDBState {
     CharBackend chr;
     Chardev *mon_chr;
 #endif
+    bool multiprocess;
+    GDBProcess *processes;
+    int process_num;
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
 } GDBState;
@@ -1751,6 +1760,30 @@ void gdb_exit(CPUArchState *env, int code)
 #endif
 }
 
+/*
+ * Create the process that will contain all the "orphan" CPUs (that are not
+ * part of a CPU cluster). Note that if this process contains no CPUs, it won't
+ * be attachable and thus will be invisible to the user.
+ */
+static void create_default_process(GDBState *s)
+{
+    GDBProcess *process;
+    int max_pid = 0;
+
+    if (s->process_num) {
+        max_pid = s->processes[s->process_num - 1].pid;
+    }
+
+    s->processes = g_renew(GDBProcess, s->processes, ++s->process_num);
+    process = &s->processes[s->process_num - 1];
+
+    /* We need an available PID slot for this process */
+    assert(max_pid < UINT32_MAX);
+
+    process->pid = max_pid + 1;
+    process->attached = false;
+}
+
 #ifdef CONFIG_USER_ONLY
 int
 gdb_handlesig(CPUState *cpu, int sig)
@@ -1848,6 +1881,7 @@ static bool gdb_accept(void)
     s = g_malloc0(sizeof(GDBState));
     s->c_cpu = first_cpu;
     s->g_cpu = first_cpu;
+    create_default_process(s);
     s->fd = fd;
     gdb_has_xml = false;
 
@@ -2004,6 +2038,65 @@ static const TypeInfo char_gdb_type_info = {
     .class_init = char_gdb_class_init,
 };
 
+static int find_cpu_clusters(Object *child, void *opaque)
+{
+    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
+        GDBState *s = (GDBState *) opaque;
+        CPUClusterState *cluster = CPU_CLUSTER(child);
+        GDBProcess *process;
+
+        s->processes = g_renew(GDBProcess, s->processes, ++s->process_num);
+
+        process = &s->processes[s->process_num - 1];
+
+        /*
+         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors at
+         * runtime, we enforce here that the machine does not use a cluster ID
+         * that would lead to PID 0.
+         */
+        assert(cluster->cluster_id != UINT32_MAX);
+        process->pid = cluster->cluster_id + 1;
+        process->attached = false;
+
+        return 0;
+    }
+
+    return object_child_foreach(child, find_cpu_clusters, opaque);
+}
+
+static int pid_order(const void *a, const void *b)
+{
+    GDBProcess *pa = (GDBProcess *) a;
+    GDBProcess *pb = (GDBProcess *) b;
+
+    if (pa->pid < pb->pid) {
+        return -1;
+    } else if (pa->pid > pb->pid) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+static void create_processes(GDBState *s)
+{
+    object_child_foreach(object_get_root(), find_cpu_clusters, s);
+
+    if (s->processes) {
+        /* Sort by PID */
+        qsort(s->processes, s->process_num, sizeof(s->processes[0]), pid_order);
+    }
+
+    create_default_process(s);
+}
+
+static void cleanup_processes(GDBState *s)
+{
+    g_free(s->processes);
+    s->process_num = 0;
+    s->processes = NULL;
+}
+
 int gdbserver_start(const char *device)
 {
     trace_gdbstub_op_start(device);
@@ -2060,11 +2153,15 @@ int gdbserver_start(const char *device)
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
         mon_chr = s->mon_chr;
+        cleanup_processes(s);
         memset(s, 0, sizeof(GDBState));
         s->mon_chr = mon_chr;
     }
     s->c_cpu = first_cpu;
     s->g_cpu = first_cpu;
+
+    create_processes(s);
+
     if (chr) {
         qemu_chr_fe_init(&s->chr, chr, &error_abort);
         qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
-- 
2.19.2
