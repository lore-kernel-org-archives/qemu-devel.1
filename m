Received: from eggs.gnu.org ([2001:4830:134:3::10]:60891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDOH-0006dY-3D
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDOA-0002NK-OY
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44999
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ciDOA-0002Ms-JX
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:58:22 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R4s62M065400
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:58:22 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28u8vt2mau-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:58:21 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 10:28:18 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 10:28:00 +0530
In-Reply-To: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1488171481-21699-8-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 7/8] target/ppc: add ov32 flag in divide
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Add helper_div_compute_ov() in the int_helper for updating the overflow
flags.

For Divide Word:
SO, OV, and OV32 bits reflects overflow of the 32-bit result

For Divide DoubleWord:
SO, OV, and OV32 bits reflects overflow of the 64-bit result

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ccf3bff..982e66f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1021,6 +1021,9 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
     if (compute_ov) {
         tcg_gen_extu_i32_tl(cpu_ov, t2);
+        if (is_isa300(ctx)) {
+            tcg_gen_extu_i32_tl(cpu_ov32, t2);
+        }
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
     tcg_temp_free_i32(t0);
@@ -1092,6 +1095,9 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
     if (compute_ov) {
         tcg_gen_mov_tl(cpu_ov, t2);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ov32, t2);
+        }
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
     tcg_temp_free_i64(t0);
@@ -1110,10 +1116,10 @@ static void glue(gen_, name)(DisasContext *ctx)
                       cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
                       sign, compute_ov);                                      \
 }
-/* divwu  divwu.  divwuo  divwuo.   */
+/* divdu  divdu.  divduo  divduo.   */
 GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0);
 GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1);
-/* divw  divw.  divwo  divwo.   */
+/* divd  divd.  divdo  divdo.   */
 GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0);
 GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1);
 
-- 
2.7.4
