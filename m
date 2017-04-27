Received: from eggs.gnu.org ([2001:4830:134:3::10]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bq1-0000lC-4p
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bpx-0002Vu-WC
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48440
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3bpx-0002VS-QN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5Icp2093470
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:28 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a32a0r25w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:27 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 15:19:25 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 10:48:19 +0530
In-Reply-To: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
References: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
Message-Id: <20170427051824.30194-2-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/6] target/ppc: Emulate LL/SC using cmpxchg
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

Emulating LL/SC with cmpxchg is not correct, since it can suffer from
the ABA problem. However, portable parallel code is written assuming
only cmpxchg which means that in practice this is a viable alternative.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f40b5a1..50b6d4d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -73,6 +73,7 @@ static TCGv cpu_cfar;
 #endif
 static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
+static TCGv cpu_reserve_val;
 static TCGv cpu_fpscr;
 static TCGv_i32 cpu_access_type;
 
@@ -181,6 +182,9 @@ void ppc_translate_init(void)
     cpu_reserve = tcg_global_mem_new(cpu_env,
                                      offsetof(CPUPPCState, reserve_addr),
                                      "reserve_addr");
+    cpu_reserve_val = tcg_global_mem_new(cpu_env,
+                                     offsetof(CPUPPCState, reserve_val),
+                                     "reserve_val");
 
     cpu_fpscr = tcg_global_mem_new(cpu_env,
                                    offsetof(CPUPPCState, fpscr), "fpscr");
@@ -3023,7 +3027,7 @@ static void gen_##name(DisasContext *ctx)                            \
     }                                                                \
     tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop);                \
     tcg_gen_mov_tl(cpu_reserve, t0);                                 \
-    tcg_gen_st_tl(gpr, cpu_env, offsetof(CPUPPCState, reserve_val)); \
+    tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
     tcg_temp_free(t0);                                               \
 }
 
@@ -3155,14 +3159,27 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
 static void gen_conditional_store(DisasContext *ctx, TCGv EA,
                                   int reg, int memop)
 {
-    TCGLabel *l1;
+    TCGLabel *l1 = gen_new_label();
+    TCGLabel *l2 = gen_new_label();
+    TCGv t0;
 
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
-    l1 = gen_new_label();
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
-    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
-    tcg_gen_qemu_st_tl(cpu_gpr[reg], EA, ctx->mem_idx, memop);
+
+    t0 = tcg_temp_new();
+    tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
+                              cpu_gpr[reg], ctx->mem_idx,
+                              DEF_MEMOP(memop) | MO_ALIGN);
+    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
+    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
+    tcg_gen_or_tl(t0, t0, cpu_so);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
+    tcg_temp_free(t0);
+    tcg_gen_br(l2);
+
     gen_set_label(l1);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+
+    gen_set_label(l2);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 #endif
-- 
2.9.3
