Received: from eggs.gnu.org ([2001:4830:134:3::10]:46630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7r-00087r-Sf
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7p-0000Am-BI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:36 +1100
Message-Id: <20170301044405.1792-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/50] target/ppc: add ov32 flag for multiply
 low insns
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

For Multiply Word:
SO, OV, and OV32 bits reflects overflow of the 32-bit result

For Multiply DoubleWord:
SO, OV, and OV32 bits reflects overflow of the 64-bit result

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index d4d9941..ccf3bff 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1285,6 +1285,9 @@ static void gen_mullwo(DisasContext *ctx)
     tcg_gen_sari_i32(t0, t0, 31);
     tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
     tcg_gen_extu_i32_tl(cpu_ov, t0);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 
     tcg_temp_free_i32(t0);
@@ -1346,6 +1349,9 @@ static void gen_mulldo(DisasContext *ctx)
 
     tcg_gen_sari_i64(t0, t0, 63);
     tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
+    }
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 
     tcg_temp_free_i64(t0);
-- 
2.9.3
