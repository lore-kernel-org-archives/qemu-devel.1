Received: from eggs.gnu.org ([2001:4830:134:3::10]:59989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gFxU8-0000gN-ID
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gFxJY-0004yP-Hl
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:17:53 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 26 Oct 2018 10:16:47 +0200
Message-Id: <20181026081653.24602-11-luc.michel@greensocs.com>
In-Reply-To: <20181026081653.24602-1-luc.michel@greensocs.com>
References: <20181026081653.24602-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/16] gdbstub: add multiprocess support to
 'D' packets
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

'D' packets are used by GDB to detach from a process. In multiprocess
mode, the PID to detach from is sent in the request.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 gdbstub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 39b1766f28..4d8474204f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1036,24 +1036,39 @@ static int gdb_breakpoint_remove(target_ulong add=
r, target_ulong len, int type)
     default:
         return -ENOSYS;
     }
 }
=20
+static inline void gdb_cpu_breakpoint_remove_all(CPUState *cpu)
+{
+    cpu_breakpoint_remove_all(cpu, BP_GDB);
+#ifndef CONFIG_USER_ONLY
+    cpu_watchpoint_remove_all(cpu, BP_GDB);
+#endif
+}
+
+static void gdb_process_breakpoint_remove_all(const GDBState *s, GDBProc=
ess *p)
+{
+    CPUState *cpu =3D get_first_cpu_in_process(s, p);
+
+    while (cpu) {
+        gdb_cpu_breakpoint_remove_all(cpu);
+        cpu =3D gdb_next_cpu_in_process(s, cpu);
+    }
+}
+
 static void gdb_breakpoint_remove_all(void)
 {
     CPUState *cpu;
=20
     if (kvm_enabled()) {
         kvm_remove_all_breakpoints(gdbserver_state->c_cpu);
         return;
     }
=20
     CPU_FOREACH(cpu) {
-        cpu_breakpoint_remove_all(cpu, BP_GDB);
-#ifndef CONFIG_USER_ONLY
-        cpu_watchpoint_remove_all(cpu, BP_GDB);
-#endif
+        gdb_cpu_breakpoint_remove_all(cpu);
     }
 }
=20
 static void gdb_set_cpu_pc(GDBState *s, target_ulong pc)
 {
@@ -1328,13 +1343,44 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
         exit(0);
     case 'D':
         /* Detach packet */
-        gdb_breakpoint_remove_all();
-        gdb_syscall_mode =3D GDB_SYS_DISABLED;
-        gdb_continue(s);
+        pid =3D 1;
+
+        if (s->multiprocess) {
+            unsigned long lpid;
+            if (*p !=3D ';') {
+                put_packet(s, "E22");
+                break;
+            }
+
+            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
+                put_packet(s, "E22");
+                break;
+            }
+
+            pid =3D lpid;
+        }
+
+        process =3D gdb_get_process(s, pid);
+        gdb_process_breakpoint_remove_all(s, process);
+        process->attached =3D false;
+
+        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
+            s->c_cpu =3D gdb_first_cpu(s);
+        }
+
+        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
+            s->g_cpu =3D gdb_first_cpu(s);
+        }
+
+        if (s->c_cpu =3D=3D NULL) {
+            /* No more process attached */
+            gdb_syscall_mode =3D GDB_SYS_DISABLED;
+            gdb_continue(s);
+        }
         put_packet(s, "OK");
         break;
     case 's':
         if (*p !=3D '\0') {
             addr =3D strtoull(p, (char **)&p, 16);
--=20
2.19.1
