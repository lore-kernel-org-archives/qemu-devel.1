Received: from eggs.gnu.org ([2001:4830:134:3::10]:35960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwN52-0005kQ-Ko
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwN4y-00012W-5i
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36434
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cwN4y-00012A-0d
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3763sJE129995
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 02:09:03 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29p3vekwqr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 02:09:02 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 7 Apr 2017 16:09:00 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  7 Apr 2017 11:37:52 +0530
In-Reply-To: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
Message-Id: <20170407060752.31313-4-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/3] target/ppc: Generate fence operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 50b6d4d..4a1f24a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2971,6 +2971,7 @@ static void gen_stswx(DisasContext *ctx)
 /* eieio */
 static void gen_eieio(DisasContext *ctx)
 {
+    tcg_gen_mb(TCG_MO_LD_ST | TCG_BAR_SC);
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -3008,6 +3009,7 @@ static void gen_isync(DisasContext *ctx)
     if (!ctx->pr) {
         gen_check_tlb_flush(ctx, false);
     }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     gen_stop_exception(ctx);
 }
 
@@ -3028,6 +3030,7 @@ static void gen_##name(DisasContext *ctx)                            \
     tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop);                \
     tcg_gen_mov_tl(cpu_reserve, t0);                                 \
     tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);                           \
     tcg_temp_free(t0);                                               \
 }
 
@@ -3177,6 +3180,10 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
     tcg_gen_br(l2);
 
     gen_set_label(l1);
+
+    /* Address mismatch implies failure.  But we still need to provide the
+       memory barrier semantics of the instruction.  */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(l2);
@@ -3308,6 +3315,7 @@ static void gen_sync(DisasContext *ctx)
     if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
         gen_check_tlb_flush(ctx, true);
     }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
 }
 
 /* wait */
-- 
2.9.3
