Received: from eggs.gnu.org ([2001:4830:134:3::10]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gFxUI-0000gX-De
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gFxJD-0004oZ-Js
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:17:33 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 26 Oct 2018 10:16:39 +0200
Message-Id: <20181026081653.24602-3-luc.michel@greensocs.com>
In-Reply-To: <20181026081653.24602-1-luc.michel@greensocs.com>
References: <20181026081653.24602-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/16] gdbstub: introduce GDB processes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

Add a structure GDBProcess that represent processes from the GDB
semantic point of view.

CPUs can be split into different processes, by grouping them under
different cpu-cluster objects.  Each occurrence of a cpu-cluster object
implies the existence of the corresponding process in the GDB stub. The
GDB process ID is derived from the corresponding cluster ID as follows:

  GDB PID =3D cluster ID + 1

This is because PIDs -1 and 0 are reserved in GDB and cannot be used by
processes.

When no such container are found, all the CPUs are put in a unique GDB
process (create_unique_process()). This is also the case when compiled
in user mode, where multi-processes do not make much sense for now.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index c4e4f9f082..096ac8e99c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -27,10 +27,11 @@
 #include "monitor/monitor.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "exec/gdbstub.h"
+#include "hw/cpu/cluster.h"
 #endif
=20
 #define MAX_PACKET_LENGTH 4096
=20
 #include "qemu/sockets.h"
@@ -294,10 +295,15 @@ typedef struct GDBRegisterState {
     gdb_reg_cb set_reg;
     const char *xml;
     struct GDBRegisterState *next;
 } GDBRegisterState;
=20
+typedef struct GDBProcess {
+    uint32_t pid;
+    bool attached;
+} GDBProcess;
+
 enum RSState {
     RS_INACTIVE,
     RS_IDLE,
     RS_GETLINE,
     RS_GETLINE_ESC,
@@ -322,10 +328,13 @@ typedef struct GDBState {
     int running_state;
 #else
     CharBackend chr;
     Chardev *mon_chr;
 #endif
+    bool multiprocess;
+    GDBProcess *processes;
+    int process_num;
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
 } GDBState;
=20
 /* By default use no IRQs and no timers while single stepping so as to
@@ -1749,10 +1758,24 @@ void gdb_exit(CPUArchState *env, int code)
 #ifndef CONFIG_USER_ONLY
   qemu_chr_fe_deinit(&s->chr, true);
 #endif
 }
=20
+/*
+ * Create a unique process containing all the CPUs.
+ */
+static void create_unique_process(GDBState *s)
+{
+    GDBProcess *process;
+
+    s->processes =3D g_malloc0(sizeof(GDBProcess));
+    s->process_num =3D 1;
+    process =3D &s->processes[0];
+
+    process->pid =3D 1;
+}
+
 #ifdef CONFIG_USER_ONLY
 int
 gdb_handlesig(CPUState *cpu, int sig)
 {
     GDBState *s;
@@ -1846,10 +1869,11 @@ static bool gdb_accept(void)
     }
=20
     s =3D g_malloc0(sizeof(GDBState));
     s->c_cpu =3D first_cpu;
     s->g_cpu =3D first_cpu;
+    create_unique_process(s);
     s->fd =3D fd;
     gdb_has_xml =3D false;
=20
     gdbserver_state =3D s;
     return true;
@@ -2002,10 +2026,57 @@ static const TypeInfo char_gdb_type_info =3D {
     .name =3D TYPE_CHARDEV_GDB,
     .parent =3D TYPE_CHARDEV,
     .class_init =3D char_gdb_class_init,
 };
=20
+static int find_cpu_clusters(Object *child, void *opaque)
+{
+    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
+        GDBState *s =3D (GDBState *) opaque;
+        CPUClusterState *cluster =3D CPU_CLUSTER(child);
+
+        s->processes =3D g_renew(GDBProcess, s->processes, ++s->process_=
num);
+
+        GDBProcess *process =3D &s->processes[s->process_num - 1];
+
+        /* GDB process IDs -1 and 0 are reserved */
+        process->pid =3D cluster->cluster_id + 1;
+        process->attached =3D false;
+        return 0;
+    }
+
+    return object_child_foreach(child, find_cpu_clusters, opaque);
+}
+
+static int pid_order(const void *a, const void *b)
+{
+    GDBProcess *pa =3D (GDBProcess *) a;
+    GDBProcess *pb =3D (GDBProcess *) b;
+
+    return pa->pid - pb->pid;
+}
+
+static void create_processes(GDBState *s)
+{
+    object_child_foreach(object_get_root(), find_cpu_clusters, s);
+
+    if (!s->processes) {
+        /* No CPU cluster specified by the machine */
+        create_unique_process(s);
+    } else {
+        /* Sort by PID */
+        qsort(s->processes, s->process_num, sizeof(s->processes[0]), pid=
_order);
+    }
+}
+
+static void cleanup_processes(GDBState *s)
+{
+    g_free(s->processes);
+    s->process_num =3D 0;
+    s->processes =3D NULL;
+}
+
 int gdbserver_start(const char *device)
 {
     trace_gdbstub_op_start(device);
=20
     GDBState *s;
@@ -2058,15 +2129,19 @@ int gdbserver_start(const char *device)
                                    NULL, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
         mon_chr =3D s->mon_chr;
+        cleanup_processes(s);
         memset(s, 0, sizeof(GDBState));
         s->mon_chr =3D mon_chr;
     }
     s->c_cpu =3D first_cpu;
     s->g_cpu =3D first_cpu;
+
+    create_processes(s);
+
     if (chr) {
         qemu_chr_fe_init(&s->chr, chr, &error_abort);
         qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_r=
eceive,
                                  gdb_chr_event, NULL, NULL, NULL, true);
     }
--=20
2.19.1
