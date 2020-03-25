Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F081EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE4E2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="a1KZuhHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE4E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2wQ-0003Dm-Uz
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vR-00023W-Jk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vQ-0006no-9X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:17 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jH2vP-0006lG-Eq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585130732; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=qMWTxxz/WaHyFQ7Puh8tAQtBhAcUMn+n2qm0HZxj5zM=;
 b=a1KZuhHFnGEmnd/+f2mwbSgnMIif2q2CVybKFDiHkf4vA0ne0umnqfnBob2B57FV
 6Sr2h0acyxdxbVjAGQ3FBCmONwYejDMVDFLq3d8wGcZx1fkJ2SZgvd1Qql4BfIqUwaa
 39pLNMw+KkNb95V6jr3kJ5ktfMUaLwCPCSJtHkz4=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by
 mx.zoho.com.cn with SMTPS id 1585130731039892.8143082035314;
 Wed, 25 Mar 2020 18:05:31 +0800 (CST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Message-ID: <20200325100520.206210-3-jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] target/mips: Add loongson ext lsdc2 instrustions
Date: Wed, 25 Mar 2020 18:05:19 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
References: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
instructions by loongson-ext ASE.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/translate.c | 157 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2d556e0dea..255d999f74 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -460,6 +460,24 @@ enum {
     R6_OPC_SCD         =3D 0x27 | OPC_SPECIAL3,
 };
=20
+/* Loongson EXT LDC2/SDC2 opcodes */
+#define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op & 0x7))
+
+enum {
+    OPC_GSLBX      =3D 0x0 | OPC_LDC2,
+    OPC_GSLHX      =3D 0x1 | OPC_LDC2,
+    OPC_GSLWX      =3D 0x2 | OPC_LDC2,
+    OPC_GSLDX      =3D 0x3 | OPC_LDC2,
+    OPC_GSLWXC1    =3D 0x6 | OPC_LDC2,
+    OPC_GSLDXC1    =3D 0x7 | OPC_LDC2,
+    OPC_GSSBX      =3D 0x0 | OPC_SDC2,
+    OPC_GSSHX      =3D 0x1 | OPC_SDC2,
+    OPC_GSSWX      =3D 0x2 | OPC_SDC2,
+    OPC_GSSDX      =3D 0x3 | OPC_SDC2,
+    OPC_GSSWXC1    =3D 0x6 | OPC_SDC2,
+    OPC_GSSDXC1    =3D 0x7 | OPC_SDC2,
+};
+
 /* BSHFL opcodes */
 #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)=
))
=20
@@ -5910,6 +5928,143 @@ no_rd:
     tcg_temp_free_i64(t1);
 }
=20
+/* Loongson EXT LDC2/SDC2 */
+static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
+                                int rs, int rd)
+{
+    int offset =3D (int8_t)(ctx->opcode >> 3);
+    uint32_t opc =3D MASK_LOONGSON_LSDC2(ctx->opcode);
+    TCGv t0, t1;
+    TCGv_i32 t32;
+    TCGv_i64 t64;
+
+    /* Pre-conditions */
+    switch (opc) {
+    case OPC_GSLBX:
+    case OPC_GSLHX:
+    case OPC_GSLWX:
+    case OPC_GSLDX:
+        /* prefetch, implement as NOP */
+        if (rt =3D=3D 0) {
+            return;
+        }
+        break;
+    case OPC_GSSBX:
+    case OPC_GSSHX:
+    case OPC_GSSWX:
+    case OPC_GSSDX:
+        break;
+    case OPC_GSLWXC1:
+    case OPC_GSLDXC1:
+        check_cp1_enabled(ctx);
+        /* prefetch, implement as NOP */
+        if (rt =3D=3D 0) {
+            return;
+        }
+        break;
+    case OPC_GSSWXC1:
+    case OPC_GSSDXC1:
+        check_cp1_enabled(ctx);
+        break;
+    default:
+        MIPS_INVAL("loongson_lsdc2");
+        generate_exception_end(ctx, EXCP_RI);
+        return;
+        break;
+    }
+
+    t0 =3D tcg_temp_new();
+    gen_base_offset_addr(ctx, t0, rs, offset);
+    if (rd !=3D 0) {
+        gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+    }
+
+    switch (opc) {
+    case OPC_GSLBX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
+        gen_store_gpr(t0, rt);
+        break;
+    case OPC_GSLHX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, rt);
+        break;
+    case OPC_GSLWX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, rt);
+        break;
+#if defined(TARGET_MIPS64)
+    case OPC_GSLDX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, rt);
+        break;
+#endif
+    case OPC_GSLWXC1:
+        t32 =3D tcg_temp_new_i32();
+        tcg_gen_qemu_ld_i32(t32, t0, ctx->mem_idx, MO_TESL |
+                            ctx->default_tcg_memop_mask);
+        gen_store_fpr32(ctx, t32, rt);
+        tcg_temp_free_i32(t32);
+        break;
+    case OPC_GSLDXC1:
+        t64 =3D tcg_temp_new_i64();
+        tcg_gen_qemu_ld_i64(t64, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_fpr64(ctx, t64, rt);
+        tcg_temp_free_i64(t64);
+        break;
+    case OPC_GSSBX:
+        t1 =3D tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_SB);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSHX:
+        t1 =3D tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSWX:
+        t1 =3D tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+#if defined(TARGET_MIPS64)
+    case OPC_GSSDX:
+        t1 =3D tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+#endif
+    case OPC_GSSWXC1:
+        t32 =3D tcg_temp_new_i32();
+        gen_load_fpr32(ctx, t32, rt);
+        tcg_gen_qemu_st_i32(t32, t0, ctx->mem_idx, MO_TEUL |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free_i32(t32);
+        break;
+    case OPC_GSSDXC1:
+        t64 =3D tcg_temp_new_i64();
+        gen_load_fpr64(ctx, t64, rt);
+        tcg_gen_qemu_st_i64(t64, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free_i64(t64);
+        break;
+    default:
+        break;
+    }
+
+    tcg_temp_free(t0);
+}
+
 /* Traps */
 static void gen_trap(DisasContext *ctx, uint32_t opc,
                      int rs, int rt, int16_t imm)
@@ -30635,6 +30790,8 @@ static void decode_opc(CPUMIPSState *env, DisasCont=
ext *ctx)
                 /* OPC_JIC, OPC_JIALC */
                 gen_compute_compact_branch(ctx, op, 0, rt, imm);
             }
+        } else if (ctx->insn_flags & ASE_LOONGSON_EXT) {
+            gen_loongson_lsdc2(ctx, rt, rs, rd);
         } else {
             /* OPC_LWC2, OPC_SWC2 */
             /* COP2: Not implemented. */
--=20
2.26.0.rc2



