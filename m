Received: from eggs.gnu.org ([2001:4830:134:3::10]:55300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1caga5-0003Fv-3X
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1caga2-0007fQ-4W
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50826
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1caga1-0007fF-VX
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v16ASigg131319
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 05:31:29 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28dbu482xd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 05:31:29 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 6 Feb 2017 20:31:25 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon,  6 Feb 2017 15:59:58 +0530
In-Reply-To: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486377000-25701-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] target-ppc: implement store atomic
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
 target/ppc/translate.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f59184f..eae85f0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3024,6 +3024,52 @@ LD_ATOMIC(lwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32, extu_i32_tl)
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
+    case 8: /* Swap */                                                  \
+        tcg_gen_atomic_xchg_##tp(t1, EA, t0, ctx->mem_idx, memop);      \
+        break;                                                          \
+    default: /* invoke data storage error handler */                    \
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);             \
+        break;                                                          \
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
@@ -6279,11 +6325,13 @@ GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
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
