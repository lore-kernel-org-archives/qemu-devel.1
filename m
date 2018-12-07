Received: from eggs.gnu.org ([2001:4830:134:3::10]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1O-00081p-A3
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1K-0005ZB-HV
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:05 -0500
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri,  7 Dec 2018 10:01:23 +0100
Message-Id: <20181207090135.7651-6-luc.michel@greensocs.com>
In-Reply-To: <20181207090135.7651-1-luc.michel@greensocs.com>
References: <20181207090135.7651-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 05/16] gdbstub: add multiprocess support to
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

Add the gdb_first_attached_cpu() and gdb_next_attached_cpu() to iterate
over all the CPUs in currently attached processes.

Add the gdb_first_cpu_in_process() and gdb_next_cpu_in_process() to
iterate over CPUs of a given process.

Use them to add multiprocess extension support to vCont packets.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 gdbstub.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 15 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 911faa225a..77b3dbb2c8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -721,10 +721,40 @@ static CPUState *find_cpu(uint32_t thread_id)
     }
=20
     return NULL;
 }
=20
+static CPUState *get_first_cpu_in_process(const GDBState *s,
+                                          GDBProcess *process)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (gdb_get_cpu_pid(s, cpu) =3D=3D process->pid) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+static CPUState *gdb_next_cpu_in_process(const GDBState *s, CPUState *cp=
u)
+{
+    uint32_t pid =3D gdb_get_cpu_pid(s, cpu);
+    cpu =3D CPU_NEXT(cpu);
+
+    while (cpu) {
+        if (gdb_get_cpu_pid(s, cpu) =3D=3D pid) {
+            break;
+        }
+
+        cpu =3D CPU_NEXT(cpu);
+    }
+
+    return cpu;
+}
+
 static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t t=
id)
 {
     GDBProcess *process;
     CPUState *cpu;
=20
@@ -750,10 +780,41 @@ static CPUState *gdb_get_cpu(const GDBState *s, uin=
t32_t pid, uint32_t tid)
     }
=20
     return cpu;
 }
=20
+/* Return the cpu following @cpu, while ignoring
+ * unattached processes.
+ */
+static CPUState *gdb_next_attached_cpu(const GDBState *s, CPUState *cpu)
+{
+    cpu =3D CPU_NEXT(cpu);
+
+    while (cpu) {
+        if (gdb_get_cpu_process(s, cpu)->attached) {
+            break;
+        }
+
+        cpu =3D CPU_NEXT(cpu);
+    }
+
+    return cpu;
+}
+
+/* Return the first attached cpu */
+static CPUState *gdb_first_attached_cpu(const GDBState *s)
+{
+    CPUState *cpu =3D first_cpu;
+    GDBProcess *process =3D gdb_get_cpu_process(s, cpu);
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
     size_t len;
     int i;
@@ -1088,14 +1149,16 @@ static int is_query_packet(const char *p, const c=
har *query, char separator)
  * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if t=
here is
  *         a format error, 0 on success.
  */
 static int gdb_handle_vcont(GDBState *s, const char *p)
 {
-    int res, idx, signal =3D 0;
+    int res, signal =3D 0;
     char cur_action;
     char *newstates;
     unsigned long tmp;
+    uint32_t pid, tid;
+    GDBProcess *process;
     CPUState *cpu;
 #ifdef CONFIG_USER_ONLY
     int max_cpus =3D 1; /* global variable max_cpus exists only in syste=
m mode */
=20
     CPU_FOREACH(cpu) {
@@ -1134,29 +1197,52 @@ static int gdb_handle_vcont(GDBState *s, const ch=
ar *p)
         } else if (cur_action !=3D 'c' && cur_action !=3D 's') {
             /* unknown/invalid/unsupported command */
             res =3D -ENOTSUP;
             goto out;
         }
-        /* thread specification. special values: (none), -1 =3D all; 0 =3D=
 any */
-        if ((p[0] =3D=3D ':' && p[1] =3D=3D '-' && p[2] =3D=3D '1') || (=
p[0] !=3D ':')) {
-            if (*p =3D=3D ':') {
-                p +=3D 3;
-            }
-            for (idx =3D 0; idx < max_cpus; idx++) {
-                if (newstates[idx] =3D=3D 1) {
-                    newstates[idx] =3D cur_action;
+
+        if (*p++ !=3D ':') {
+            res =3D -ENOTSUP;
+            goto out;
+        }
+
+        switch (read_thread_id(p, &p, &pid, &tid)) {
+        case GDB_READ_THREAD_ERR:
+            res =3D -EINVAL;
+            goto out;
+
+        case GDB_ALL_PROCESSES:
+            cpu =3D gdb_first_attached_cpu(s);
+            while (cpu) {
+                if (newstates[cpu->cpu_index] =3D=3D 1) {
+                    newstates[cpu->cpu_index] =3D cur_action;
                 }
+
+                cpu =3D gdb_next_attached_cpu(s, cpu);
             }
-        } else if (*p =3D=3D ':') {
-            p++;
-            res =3D qemu_strtoul(p, &p, 16, &tmp);
-            if (res) {
+            break;
+
+        case GDB_ALL_THREADS:
+            process =3D gdb_get_process(s, pid);
+
+            if (!process->attached) {
+                res =3D -EINVAL;
                 goto out;
             }
=20
-            /* 0 means any thread, so we pick the first valid CPU */
-            cpu =3D tmp ? find_cpu(tmp) : first_cpu;
+            cpu =3D get_first_cpu_in_process(s, process);
+            while (cpu) {
+                if (newstates[cpu->cpu_index] =3D=3D 1) {
+                    newstates[cpu->cpu_index] =3D cur_action;
+                }
+
+                cpu =3D gdb_next_cpu_in_process(s, cpu);
+            }
+            break;
+
+        case GDB_ONE_THREAD:
+            cpu =3D gdb_get_cpu(s, pid, tid);
=20
             /* invalid CPU/thread specified */
             if (!cpu) {
                 res =3D -EINVAL;
                 goto out;
@@ -1164,10 +1250,11 @@ static int gdb_handle_vcont(GDBState *s, const ch=
ar *p)
=20
             /* only use if no previous match occourred */
             if (newstates[cpu->cpu_index] =3D=3D 1) {
                 newstates[cpu->cpu_index] =3D cur_action;
             }
+            break;
         }
     }
     s->signal =3D signal;
     gdb_continue_partial(s, newstates);
=20
--=20
2.19.2
