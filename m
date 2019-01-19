Received: from eggs.gnu.org ([209.51.188.92]:36807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gkrAq-0003G7-LJ
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 09:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gkrAp-0000n9-7b
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 09:00:36 -0500
Received: from greensocs.com ([193.104.36.180]:35888)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gkrAo-0000cN-I2
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 09:00:35 -0500
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat, 19 Jan 2019 15:00:00 +0100
Message-Id: <20190119140000.11767-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] gdbstub: fix gdb_get_cpu(s, pid,
 tid) when pid and/or tid are 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@wdc.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, mark.burton@greensocs.com

a TID or PID value means "any thread" (resp. "any process"). This commit
fixes the different combinations when at least one value is 0.

When both are 0, the function now returns the first attached CPU,
instead of the CPU with TID 1, which is not necessarily attached or even
existent.

When PID is specified but TID is 0, the function returns the first CPU
in the process, or NULL if the process does not exist or is not
attached.

In other cases, it returns the corresponding CPU, while ignoring the PID
check when PID is 0.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 72 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb509..d4cc6ecf99 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -754,39 +754,10 @@ static CPUState *gdb_next_cpu_in_process(const GDBS=
tate *s, CPUState *cpu)
     }
=20
     return cpu;
 }
=20
-static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t t=
id)
-{
-    GDBProcess *process;
-    CPUState *cpu;
-
-    if (!tid) {
-        /* 0 means any thread, we take the first one */
-        tid =3D 1;
-    }
-
-    cpu =3D find_cpu(tid);
-
-    if (cpu =3D=3D NULL) {
-        return NULL;
-    }
-
-    process =3D gdb_get_cpu_process(s, cpu);
-
-    if (process->pid !=3D pid) {
-        return NULL;
-    }
-
-    if (!process->attached) {
-        return NULL;
-    }
-
-    return cpu;
-}
-
 /* Return the cpu following @cpu, while ignoring unattached processes. *=
/
 static CPUState *gdb_next_attached_cpu(const GDBState *s, CPUState *cpu)
 {
     cpu =3D CPU_NEXT(cpu);
=20
@@ -812,10 +783,53 @@ static CPUState *gdb_first_attached_cpu(const GDBSt=
ate *s)
     }
=20
     return cpu;
 }
=20
+static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t t=
id)
+{
+    GDBProcess *process;
+    CPUState *cpu;
+
+    if (!pid && !tid) {
+        /* 0 means any process/thread, we take the first attached one */
+        return gdb_first_attached_cpu(s);
+    } else if (pid && !tid) {
+        /* any thread in a specific process */
+        process =3D gdb_get_process(s, pid);
+
+        if (process =3D=3D NULL) {
+            return NULL;
+        }
+
+        if (!process->attached) {
+            return NULL;
+        }
+
+        return get_first_cpu_in_process(s, process);
+    } else {
+        /* a specific thread */
+        cpu =3D find_cpu(tid);
+
+        if (cpu =3D=3D NULL) {
+            return NULL;
+        }
+
+        process =3D gdb_get_cpu_process(s, cpu);
+
+        if (pid && process->pid !=3D pid) {
+            return NULL;
+        }
+
+        if (!process->attached) {
+            return NULL;
+        }
+
+        return cpu;
+    }
+}
+
 static const char *get_feature_xml(const GDBState *s, const char *p,
                                    const char **newp, GDBProcess *proces=
s)
 {
     size_t len;
     int i;
--=20
2.20.1
