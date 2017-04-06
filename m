Received: from eggs.gnu.org ([2001:4830:134:3::10]:58084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aL-0002u9-1Z
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aG-0004Fg-4z
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cw4aF-0004FE-RA
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36ANpX1088738
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 06:24:06 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nkk513cn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 06:24:06 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 6 Apr 2017 20:24:03 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  6 Apr 2017 15:52:47 +0530
In-Reply-To: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
Message-Id: <20170406102249.20383-2-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v1 1/3] target/ppc: Emulate LL/SC using
 cmpxchg helpers
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

Emulating LL/SC with cmpxchg is not correct, since it can suffer from
the ABA problem. However, portable parallel code is written assuming
only cmpxchg which means that in practice this is a viable alternative.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b6abc60..a9c733d 100644
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
 
@@ -3156,14 +3160,28 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
                                   int reg, int memop)
 {
     TCGLabel *l1;
+    TCGv_i32 tmp = tcg_temp_local_new_i32();
+    TCGv t0;
 
+    tcg_gen_movi_i32(tmp, 0);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
     l1 = gen_new_label();
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
-    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
-    tcg_gen_qemu_st_tl(cpu_gpr[reg], EA, ctx->mem_idx, memop);
+
+    t0 = tcg_temp_new();
+    tcg_gen_atomic_cmpxchg_tl(t0, EA, cpu_reserve_val, cpu_gpr[reg],
+                              ctx->mem_idx, DEF_MEMOP(memop));
+    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
+    tcg_gen_trunc_tl_i32(tmp, t0);
+
     gen_set_label(l1);
+    tcg_gen_shli_i32(tmp, tmp, CRF_EQ_BIT);
+    tcg_gen_or_i32(cpu_crf[0], cpu_crf[0], tmp);
     tcg_gen_movi_tl(cpu_reserve, -1);
+    tcg_gen_movi_tl(cpu_reserve_val, 0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free_i32(tmp);
 }
 #endif
 
-- 
2.9.3
