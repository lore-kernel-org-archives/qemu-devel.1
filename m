Received: from eggs.gnu.org ([2001:4830:134:3::10]:45899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhMi-0003YZ-O6
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhMe-0004vP-1o
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45272
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbhMd-0004vE-UJ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:52 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v195XcY9020458
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:33:51 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28gburn5ew-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:33:50 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 11:03:47 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 11:03:30 +0530
In-Reply-To: <1486618411-7018-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486618411-7018-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486618411-7018-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/2] target-ppc: implement load atomic
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

lwat: Load Word Atomic
ldat: Load Doubleword Atomic

The instruction includes as function code (5 bits) which gives a detail
on the operation to be performed. The patch implements five such
functions.

Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Harish S <harisrir@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
[ combine both lwat/ldat implementation using macro ]
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/internal.h  |  2 ++
 target/ppc/translate.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 5b5b180..1f441c6 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -133,6 +133,8 @@ EXTRACT_HELPER(UIMM4, 16, 4);
 EXTRACT_HELPER(NB, 11, 5);
 /* Shift count */
 EXTRACT_HELPER(SH, 11, 5);
+/* lwat/stwat/ldat/lwat */
+EXTRACT_HELPER(FC, 11, 5);
 /* Vector shift count */
 EXTRACT_HELPER(VSH, 6, 4);
 /* Mask start */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b48abae..ea2ec44 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2976,6 +2976,63 @@ LARX(lbarx, DEF_MEMOP(MO_UB))
 LARX(lharx, DEF_MEMOP(MO_UW))
 LARX(lwarx, DEF_MEMOP(MO_UL))
 
+#define LD_ATOMIC(name, memop, tp, op, eop)                             \
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
+    case 0: /* Fetch and add */                                         \
+        tcg_gen_atomic_fetch_add_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 1: /* Fetch and xor */                                         \
+        tcg_gen_atomic_fetch_xor_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 2: /* Fetch and or */                                          \
+        tcg_gen_atomic_fetch_or_##tp(t1, EA, t0, ctx->mem_idx, memop);  \
+        break;                                                          \
+    case 3: /* Fetch and 'and' */                                       \
+        tcg_gen_atomic_fetch_and_##tp(t1, EA, t0, ctx->mem_idx, memop); \
+        break;                                                          \
+    case 8: /* Swap */                                                  \
+        tcg_gen_atomic_xchg_##tp(t1, EA, t0, ctx->mem_idx, memop);      \
+        break;                                                          \
+    case 4:  /* Fetch and max unsigned */                               \
+    case 5:  /* Fetch and max signed */                                 \
+    case 6:  /* Fetch and min unsigned */                               \
+    case 7:  /* Fetch and min signed */                                 \
+    case 16: /* compare and swap not equal */                           \
+    case 24: /* Fetch and increment bounded */                          \
+    case 25: /* Fetch and increment equal */                            \
+    case 28: /* Fetch and decrement bounded */                          \
+        gen_invalid(ctx);                                               \
+        break;                                                          \
+    default:                                                            \
+        /* invoke data storage error handler */                         \
+        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);   \
+    }                                                                   \
+    tcg_gen_##eop(cpu_gpr[rD(ctx->opcode)], t1);                        \
+    tcg_temp_free_##tp(t0);                                             \
+    tcg_temp_free_##tp(t1);                                             \
+    tcg_temp_free(EA);                                                  \
+}
+
+LD_ATOMIC(lwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32, extu_i32_tl)
+#if defined(TARGET_PPC64)
+LD_ATOMIC(ldat, DEF_MEMOP(MO_Q), i64, mov_i64, mov_i64)
+#endif
+
 #if defined(CONFIG_USER_ONLY)
 static void gen_conditional_store(DisasContext *ctx, TCGv EA,
                                   int reg, int memop)
@@ -6230,10 +6287,12 @@ GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
+GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(sthcx_, 0x1F, 0x16, 0x16, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
 #if defined(TARGET_PPC64)
+GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
 GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
 GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
-- 
2.7.4
