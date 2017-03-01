Received: from eggs.gnu.org ([2001:4830:134:3::10]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7m-0007zW-8a
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7j-0008WT-Nj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:34 +1100
Message-Id: <20170301044405.1792-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/50] target/ppc: update overflow flags for
 add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

* SO and OV reflects overflow of the 64-bit result in 64-bit mode and
  overflow of the low-order 32-bit result in 32-bit mode

* OV32 reflects overflow of the low-order 32-bit independent of the mode

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e083082..16f422f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -810,9 +810,16 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
     }
     tcg_temp_free(t0);
     if (NARROW_MODE(ctx)) {
-        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
+        tcg_gen_extract_tl(cpu_ov, cpu_ov, 31, 1);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+        }
+    } else {
+        if (is_isa300(ctx)) {
+            tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
+        }
+        tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
     }
-    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }
 
-- 
2.9.3
