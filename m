Received: from eggs.gnu.org ([2001:4830:134:3::10]:58089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aL-0002ui-Ex
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aK-0004Hf-J8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cw4aK-0004HM-93
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36ANraZ032647
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 06:24:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nfmgpard-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 06:24:10 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 6 Apr 2017 20:24:08 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  6 Apr 2017 15:52:49 +0530
In-Reply-To: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
Message-Id: <20170406102249.20383-4-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v1 3/3] target/ppc: Generate fence
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
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a9c733d..87b4fe4 100644
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
 
@@ -3196,6 +3199,7 @@ static void gen_##name(DisasContext *ctx)                   \
     if (len > 1) {                                          \
         gen_check_align(ctx, t0, (len) - 1);                \
     }                                                       \
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);                  \
     gen_conditional_store(ctx, t0, rS(ctx->opcode), memop); \
     tcg_temp_free(t0);                                      \
 }
@@ -3309,6 +3313,7 @@ static void gen_sync(DisasContext *ctx)
     if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
         gen_check_tlb_flush(ctx, true);
     }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
 }
 
 /* wait */
-- 
2.9.3
