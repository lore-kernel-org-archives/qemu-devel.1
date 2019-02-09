Received: from eggs.gnu.org ([209.51.188.92]:49786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0q-0005vq-4x
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0p-0007mJ-0m
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:56 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 01:00:51 +0000
Message-ID: <539d54b254204d3bcafb60af6d3b9bc7c9fab28b.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 10/11] RISC-V: Convert trap debugging to
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Makefile.objs             |  1 +
 target/riscv/cpu_helper.c | 12 +++---------
 target/riscv/trace-events |  2 ++
 3 files changed, 6 insertions(+), 9 deletions(-)
 create mode 100644 target/riscv/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index b7aae33367..a2c5b2d186 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -196,6 +196,7 @@ trace-events-subdirs +=3D target/arm
 trace-events-subdirs +=3D target/i386
 trace-events-subdirs +=3D target/mips
 trace-events-subdirs +=3D target/ppc
+trace-events-subdirs +=3D target/riscv
 trace-events-subdirs +=3D target/s390x
 trace-events-subdirs +=3D target/sparc
 trace-events-subdirs +=3D ui
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a02f4dad8c..6d3fbc3401 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -22,8 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
-
-#define RISCV_DEBUG_INTERRUPT 0
+#include "trace.h"
=20
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -493,13 +492,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
     }
=20
-    if (RISCV_DEBUG_INTERRUPT) {
-        qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": %s %s, "
-            "epc 0x" TARGET_FMT_lx ": tval 0x" TARGET_FMT_lx "\n",
-            env->mhartid, async ? "intr" : "trap",
-            (async ? riscv_intr_names : riscv_excp_names)[cause],
-            env->pc, tval);
-    }
+    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 16=
 ?
+        (async ? riscv_intr_names : riscv_excp_names)[cause] : "(unknown)"=
);
=20
     if (env->priv <=3D PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
new file mode 100644
index 0000000000..48af0373df
--- /dev/null
+++ b/target/riscv/trace-events
@@ -0,0 +1,2 @@
+# target/riscv/cpu_helper.c
+riscv_trap(uint64_t hartid, bool async, uint64_t cause, uint64_t epc, uint=
64_t tval, const char *desc) "hart:%"PRId64", async:%d, cause:%"PRId64", ep=
c:0x%"PRIx64", tval:0x%"PRIx64", desc=3D%s"
--=20
2.20.1
