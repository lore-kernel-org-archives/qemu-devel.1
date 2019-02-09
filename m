Received: from eggs.gnu.org ([209.51.188.92]:49671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0R-0005gF-N7
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0P-0007L6-S2
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:31 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 01:00:24 +0000
Message-ID: <324185f0d64e77f4c16896fa160e1b81d23eb47f.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 07/11] RISC-V: linux-user support for RVE ABI
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

From: Kito Cheng <kito.cheng@gmail.com>

This change checks elf_flags for EF_RISCV_RVE and if
present uses the RVE linux syscall ABI which uses t0
for the syscall number instead of a7.

Warn and exit if a non-RVE ABI binary is run on a
cpu with the RVE extension as it is incompatible.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Co-authored-by: Kito Cheng <kito.cheng@gmail.com>
Co-authored-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/cpu_loop.c | 15 ++++++++++++++-
 target/riscv/cpu.h          |  4 ++++
 target/riscv/cpu_user.h     |  3 ++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 4cf3e94632..a9bac4ca79 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -18,8 +18,10 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
+#include "elf.h"
=20
 void cpu_loop(CPURISCVState *env)
 {
@@ -53,7 +55,8 @@ void cpu_loop(CPURISCVState *env)
                 ret =3D 0;
             } else {
                 ret =3D do_syscall(env,
-                                 env->gpr[xA7],
+                                 env->gpr[(env->elf_flags & EF_RISCV_RVE)
+                                    ? xT0 : xA7],
                                  env->gpr[xA0],
                                  env->gpr[xA1],
                                  env->gpr[xA2],
@@ -113,6 +116,16 @@ void cpu_loop(CPURISCVState *env)
=20
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    CPUState *cpu =3D ENV_GET_CPU(env);
+    TaskState *ts =3D cpu->opaque;
+    struct image_info *info =3D ts->info;
+
     env->pc =3D regs->sepc;
     env->gpr[xSP] =3D regs->sp;
+    env->elf_flags =3D info->elf_flags;
+
+    if ((env->misa & RVE) && !(env->elf_flags & EF_RISCV_RVE)) {
+        error_report("Incompatible ELF: RVE cpu requires RVE ABI binary");
+        exit(EXIT_FAILURE);
+    }
 }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a0b3c22dec..8e4b5cfe26 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -123,6 +123,10 @@ struct CPURISCVState {
=20
     uint32_t features;
=20
+#ifdef CONFIG_USER_ONLY
+    uint32_t elf_flags;
+#endif
+
 #ifndef CONFIG_USER_ONLY
     target_ulong priv;
     target_ulong resetvec;
diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
index c2199610ab..52d380aa98 100644
--- a/target/riscv/cpu_user.h
+++ b/target/riscv/cpu_user.h
@@ -10,4 +10,5 @@
 #define xA4 14
 #define xA5 15
 #define xA6 16
-#define xA7 17  /* syscall number goes here */
+#define xA7 17  /* syscall number for RVI ABI */
+#define xT0 5   /* syscall number for RVE ABI */
--=20
2.20.1
