Received: from eggs.gnu.org ([2001:4830:134:3::10]:56702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpZ-0002TX-Um
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpW-0004cL-V4
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpW-0004bv-Hg
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:26 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 25 Jul 2018 16:04:13 -0700
Message-Id: <557e98d2a46b8bccd0379e9a538fd617c07e06e6.1532559484.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1532559484.git.alistair.francis@wdc.com>
References: <cover.1532559484.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 3/4] target/riscv: Implement the stval
 illegal instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

The stval register can optionally contain the faulting instruction
on an illegal instruction exception. This patch adds support for setting
the stval register based on the CPU feature.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h    |  3 ++-
 target/riscv/helper.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1bc46aa952..b797850816 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -86,7 +86,8 @@
    so a cpu features bitfield is required */
 enum {
     RISCV_FEATURE_MMU,
-    RISCV_FEATURE_MTVAL_INST
+    RISCV_FEATURE_MTVAL_INST,
+    RISCV_FEATURE_STVAL_INST
 };
 
 #define USER_VERSION_2_02_0 0x00020200
diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index bd78bcff28..924a49d06f 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -466,9 +466,18 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
             env->stval = env->badaddr;
+        } else if (cs->exception_index & RISCV_EXCP_ILLEGAL_INST) {
+            if (riscv_feature(env, RISCV_FEATURE_STVAL_INST)) {
+                /* The stval register can optionally also be used to
+                 * return the faulting instruction bits on an illegal
+                 * instruction exception.
+                 */
+                env->stval = env->bins;
+            } else {
+                env->stval = 0;
+            }
         } else {
-            /* otherwise we must clear sbadaddr/stval
-             * todo: support populating stval on illegal instructions */
+            /* Otherwise we must clear mbadaddr/stval */
             env->stval = 0;
         }
 
-- 
2.17.1
