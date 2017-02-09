Received: from eggs.gnu.org ([2001:4830:134:3::10]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhMi-0003YY-O2
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhMe-0004va-3d
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbhMd-0004v2-Rf
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:52 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v195Xhjl035589
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:33:50 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28gcn7kgen-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:33:50 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 11:03:47 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 11:03:31 +0530
In-Reply-To: <1486618411-7018-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486618411-7018-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486618411-7018-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 2/2] target-ppc: implement store atomic
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, Balamuruhan S <bala24@linux.vnet.ibm.com>, Harish S <harisrir@linux.vnet.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>

From: Balamuruhan S <bala24@linux.vnet.ibm.com>

stwat: Store Word Atomic
stdat: Store Doubleword Atomic

The instruction includes as function code (5 bits) which gives a detail
on the operation to be performed. The patch implements five such
functions.

Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Harish S <harisrir@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
[ implement stdat, use macro and combine both implementation ]
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ea2ec44..255735a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3033,6 +3033,56 @@ LD_ATOMIC(lwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32, extu_i32_tl)
 LD_ATOMIC(ldat, DEF_MEMOP(MO_Q), i64, mov_i64, mov_i64)
 #endif
 
+#define ST_ATOMIC(name, memop, tp, op)                                  \
+static void gen_##name(DisasContext *ctx)                               \
+{                                                                       \
+    int len = MEMOP_GET_SIZE(memop);                                    \
+    uint32_t gpr_FC = FC(ctx->opcode);                                  \
+    TCGv EA = tcg_temp_local_new();                                     \
+    TCGv_##tp t0, t1;                                                   \
+                                                                        \
+    gen_addr_register(ctx, EA);                                         \
+    if (len > 1) {                                                      \
+        gen_check_align(ctx, EA, len - 1);                              \
+    }                                                                   \
+    t0 = tcg_temp_new_##tp();                                           \
+    t1 = tcg_temp_new_##tp();                                           \
+    tcg_gen_##op(t0, cpu_gpr[rD(ctx->opcode) + 1]);                     \
+                                                                        \
+    switch (gpr_FC) {                                                   \
+    case 0: /* add and Store */                                         \
+        tcg_gen_atomic_add_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 1: /* xor and Store */                                         \
+        tcg_gen_atomic_xor_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 2: /* Or and Store */                                          \
+        tcg_gen_atomic_or_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop);  \
+        break;                                                          \
+    case 3: /* 'and' and Store */                                       \
+        tcg_gen_atomic_and_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 4:  /* Store max unsigned */                                   \
+    case 5:  /* Store max signed */                                     \
+    case 6:  /* Store min unsigned */                                   \
+    case 7:  /* Store min signed */                                     \
+    case 24: /* Store twin  */                                          \
+        gen_invalid(ctx);                                               \
+        break;                                                          \
+    default:                                                            \
+        /* invoke data storage error handler */                         \
+        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);   \
+    }                                                                   \
+    tcg_temp_free_##tp(t0);                                             \
+    tcg_temp_free_##tp(t1);                                             \
+    tcg_temp_free(EA);                                                  \
+}
+
+ST_ATOMIC(stwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32)
+#if defined(TARGET_PPC64)
+ST_ATOMIC(stdat, DEF_MEMOP(MO_Q), i64, mov_i64)
+#endif
+
 #if defined(CONFIG_USER_ONLY)
 static void gen_conditional_store(DisasContext *ctx, TCGv EA,
                                   int reg, int memop)
@@ -6288,11 +6338,13 @@ GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
 GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(sthcx_, 0x1F, 0x16, 0x16, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
 GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
 GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
-- 
2.7.4
