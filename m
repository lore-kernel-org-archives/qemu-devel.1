Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33670C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99842145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGgEsYYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99842145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnuD-0006ts-RY
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnl-0000Mz-EC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnni-0002IU-T1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:29 -0400
Received: by mail-pg1-x544.google.com with SMTP id 34so706161pgo.13
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bN4BQE3WpGmWjjSI/j/g7Y1hlfWuKsaOhnClW7UwbZc=;
 b=yGgEsYYvI2ZZinMMfX5IsgdJkZxTpLIjnAQI/H+W+jdp7Lar0eU4fyxnvsQOw5CKX/
 82ENfPhiT85RGfo6/s7cgAFAuS5BJzGI07YgdPdUp9kyHYJe7VBIw6Vw8oCklQUdoDLv
 wydo7oqBGpxdWPJoQF+FkYrICWBH0MmOA8o79xl4Oo80WKv9yoXHlCC4jgkCG6E9NvPw
 vIdFIhW5Jsa3RYXNHRpdcqvlIiGuo4C4hnDqc0hTWKQVFgu+GNxv6zpqoEU381nV+ZOy
 Wn1WZ/OgaqAe4L9DVfWK9E4m8gtH5/DxB9Bo7FMlze9akx1XdHlVpwia1vTiIPMNZt7z
 iO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bN4BQE3WpGmWjjSI/j/g7Y1hlfWuKsaOhnClW7UwbZc=;
 b=jMM+V+fzJMwwxPY9pOw6Fu110Ql4IeQXeGLVT9kN2hCuhZ/7XhQmhhsnAhv6gdYC2T
 d7gHr7ZGC/OlKG6L5n51497Ej9PzE226PHzOJA8T6Z5aA9JLuUw42b//xk22slkAXV4k
 U5/aIqlgCMMJQASrX3DVeti9+emruDshcVo7gAl9my1WDE6ZXuKkW8Ie6ujOcbcyiPHX
 aqHoz0MUBQprAHlnUfpuOTBNqnVkq91S8Zx+5o0pq4fa5CUgG1BdyE0eg7vU9outuZgQ
 gZt0oex5/h6sK3CnVTCn9YtPcwVQgjQV8S7DYoIAeCjj+ThmIVDg1qXE7HniXdQ8O4N5
 vHBQ==
X-Gm-Message-State: AOAM533UqVOt4sZqp4c/XChHk+UJKLZGAdAQFtRSNjxIIe/2210ScLTm
 XJ+qnMNCFpcgIpt/KSqyng5q9mZNU0jr2w==
X-Google-Smtp-Source: ABdhPJwS67Zqh6ec38hYM3KYZeH6lNzF8hkJ1GRCNPlnvtMP3vTCU2L28QyBceceyGmrb4WBSSUCDA==
X-Received: by 2002:a63:b202:: with SMTP id x2mr933730pge.432.1599610645035;
 Tue, 08 Sep 2020 17:17:25 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/43] tcg: Remove movi and dupi opcodes
Date: Tue,  8 Sep 2020 17:16:32 -0700
Message-Id: <20200909001647.532249-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are now completely covered by mov from a
TYPE_CONST temporary.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        |  3 ---
 tcg/optimize.c               |  4 ----
 tcg/tcg-op-vec.c             |  1 -
 tcg/tcg.c                    | 18 +-----------------
 tcg/aarch64/tcg-target.c.inc |  3 ---
 tcg/arm/tcg-target.c.inc     |  1 -
 tcg/i386/tcg-target.c.inc    |  3 ---
 tcg/mips/tcg-target.c.inc    |  2 --
 tcg/ppc/tcg-target.c.inc     |  3 ---
 tcg/riscv/tcg-target.c.inc   |  2 --
 tcg/s390/tcg-target.c.inc    |  2 --
 tcg/sparc/tcg-target.c.inc   |  2 --
 tcg/tci/tcg-target.c.inc     |  2 --
 13 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 5a941eaa07..d63c6bcb3d 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -45,7 +45,6 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)
 DEF(mb, 0, 0, 1, 0)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
-DEF(movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, IMPL(TCG_TARGET_HAS_movcond_i32))
 /* load/store */
@@ -110,7 +109,6 @@ DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
 DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
-DEF(movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
 DEF(movcond_i64, 1, 4, 1, IMPL64 | IMPL(TCG_TARGET_HAS_movcond_i64))
 /* load/store */
@@ -215,7 +213,6 @@ DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
 #define IMPLVEC  TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)
 
 DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
-DEF(dupi_vec, 1, 0, 1, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
 
 DEF(dup_vec, 1, 1, 0, IMPLVEC)
 DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS == 32))
diff --git a/tcg/optimize.c b/tcg/optimize.c
index af07c6f628..1a94e9a41b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1099,10 +1099,6 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(mov):
             tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
             break;
-        CASE_OP_32_64(movi):
-        case INDEX_op_dupi_vec:
-            tcg_opt_gen_movi(s, &temps_used, op, op->args[0], op->args[1]);
-            break;
 
         case INDEX_op_dup_vec:
             if (arg_is_const(op->args[1])) {
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 9fbed1366c..ce0d2f6e0e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -83,7 +83,6 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_xor_vec:
         case INDEX_op_mov_vec:
         case INDEX_op_dup_vec:
-        case INDEX_op_dupi_vec:
         case INDEX_op_dup2_vec:
         case INDEX_op_ld_vec:
         case INDEX_op_st_vec:
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b63da0b603..f9c6450837 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1503,7 +1503,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_goto_ptr;
 
     case INDEX_op_mov_i32:
-    case INDEX_op_movi_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_ld8u_i32:
@@ -1597,7 +1596,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_REG_BITS == 32;
 
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i64:
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_ld8u_i64:
@@ -1703,7 +1701,6 @@ bool tcg_op_supported(TCGOpcode op)
 
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
-    case INDEX_op_dupi_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
@@ -3542,7 +3539,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
 }
 
 /*
- * Specialized code generation for INDEX_op_movi_*.
+ * Specialized code generation for INDEX_op_mov_* with a constant.
  */
 static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
                                   tcg_target_ulong val, TCGLifeData arg_life,
@@ -3565,14 +3562,6 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     }
 }
 
-static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
-{
-    TCGTemp *ots = arg_temp(op->args[0]);
-    tcg_target_ulong val = op->args[1];
-
-    tcg_reg_alloc_do_movi(s, ots, val, op->life, op->output_pref[0]);
-}
-
 /*
  * Specialized code generation for INDEX_op_mov_*.
  */
@@ -4353,11 +4342,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
-        case INDEX_op_movi_i32:
-        case INDEX_op_movi_i64:
-        case INDEX_op_dupi_vec:
-            tcg_reg_alloc_movi(s, op);
-            break;
         case INDEX_op_dup_vec:
             tcg_reg_alloc_dup(s, op);
             break;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 5692607087..fdc118391c 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2252,8 +2252,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         g_assert_not_reached();
@@ -2461,7 +2459,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 62c37a954b..30d30874c7 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2065,7 +2065,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6b7cbaa47a..819ee25cff 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2692,8 +2692,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -2979,7 +2977,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 98c6a41caf..3e282c1bde 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2152,8 +2152,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index ff56f1971f..3d23a6b226 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2973,8 +2973,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 
     case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32:  /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -3322,7 +3320,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         return;
 
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
-    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d536f3ccc1..aaef1c5eed 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1602,8 +1602,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         g_assert_not_reached();
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index c5e096449b..824a07aa7a 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -2306,8 +2306,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 44373d742b..af480115c5 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -1586,8 +1586,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c8c8386a72..25ed868505 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -814,8 +814,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
-    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
-- 
2.25.1


