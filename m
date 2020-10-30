Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185EAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683CE2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/NdlHXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683CE2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJ09-0001fs-CA
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbs-0004AK-R0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbm-0001qM-Ed
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:38 -0400
Received: by mail-pg1-x541.google.com with SMTP id f38so3768549pgm.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=alqQYelMXWjNhanmkXDU3kFUA3e6wfcwRkF58Vk9Jvs=;
 b=c/NdlHXjz5NacAxi0ZJTbJmgxHvaQsjKBWMaZtHuigzQyrQi9UetponnberhehH5gm
 0j/kjPiZDa0qlOBC5HXHXcwCf2WKIudmRKA68wvdnz1C+IdkG0yNHdoCvWL0kW9MuVHL
 rulrJdd0uFB7HYXhuUTE6ImUKUwPWs4ZpybaVgXKFsV0JpRheJ/8famdgrW3tIGc1XGt
 M7N1y5nZTIknoOFNMAhl4tw2WNQ/HlNVJUPW5s7MzJOy7MlrvO6k10HdNpsxbx3xkYVr
 bKMcfU8Z1ndPjlsF2F/Ea/bbIQwsaUJBlA+CYPs85aar4WV/sYPqAP6hzTuMzSAW1ydc
 Fzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=alqQYelMXWjNhanmkXDU3kFUA3e6wfcwRkF58Vk9Jvs=;
 b=b1aTrWb9aojAaonouoSmoXVPLmM0WvbLKo8vRHkYJiEA0dFv7p280aKmq5wOV1ul7a
 pRHMTiHKGTO7Lx6ihk4Ux47G0v0ozhoqNiXiqBXeMgbv5J7la+MgzoEcHcBjGmAIKcdN
 wz84tgBkAbLfJDlZXBWdgtvwO8clTmM+7sEuQan/PM6XSaCzCgzy/WIm/RSEZZyfO46d
 fD3bLBaYKsbOb2u/5eX2CFuAz1XLtwlxXmMv3m6oUZw/XuJ7ZeszZUZIfstvvEFkaGjY
 UXrlR2avO5gc9jMOpnpMOe9g6gLDfdM0tFBTn/OlfWQuRtzY7MeRRxV+D8HaW+91hrJx
 EOOQ==
X-Gm-Message-State: AOAM532VDq/4zHsBxArdpKbTPwBabLNM4r01YRm/Hq7NhrX3+PUktfCO
 V6VBk3XLjNg3AobxDzhJYy0/xtFA+c9xEQ==
X-Google-Smtp-Source: ABdhPJymIYwiFLOIWN9FF0rPOCGzPFyTP3ouLnT7/ZoAxUYtKnrz2bGOrB8fQN0v41IUybYY+ETQtA==
X-Received: by 2002:a63:1466:: with SMTP id 38mr5805040pgu.29.1604018971774;
 Thu, 29 Oct 2020 17:49:31 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/19] tcg: Adjust tcg_out_label for const
Date: Thu, 29 Oct 2020 17:49:08 -0700
Message-Id: <20201030004921.721096-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify the arguments to always use s->code_ptr instead of
take it as an argument.  That makes it easy to ensure that
the value_ptr is always the rx version.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                 |  6 +++---
 tcg/i386/tcg-target.c.inc | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ddc38b8c50..da16378d1c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -301,11 +301,11 @@ static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
     QSIMPLEQ_INSERT_TAIL(&l->relocs, r, next);
 }
 
-static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
+static void tcg_out_label(TCGContext *s, TCGLabel *l)
 {
     tcg_debug_assert(!l->has_value);
     l->has_value = 1;
-    l->u.value_ptr = tcg_mirror_rw_to_rx(ptr);
+    l->u.value_ptr = tcg_mirror_rw_to_rx(s->code_ptr);
 }
 
 TCGLabel *gen_new_label(void)
@@ -4270,7 +4270,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
             break;
         case INDEX_op_set_label:
             tcg_reg_alloc_bb_end(s, s->reserved_regs);
-            tcg_out_label(s, arg_label(op->args[0]), s->code_ptr);
+            tcg_out_label(s, arg_label(op->args[0]));
             break;
         case INDEX_op_call:
             tcg_reg_alloc_call(s, op);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 095553ce28..0ac1ef3d82 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1452,7 +1452,7 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
     default:
         tcg_abort();
     }
-    tcg_out_label(s, label_next, s->code_ptr);
+    tcg_out_label(s, label_next);
 }
 #endif
 
@@ -1494,10 +1494,10 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 
         tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
         tcg_out_jxx(s, JCC_JMP, label_over, 1);
-        tcg_out_label(s, label_true, s->code_ptr);
+        tcg_out_label(s, label_true);
 
         tcg_out_movi(s, TCG_TYPE_I32, args[0], 1);
-        tcg_out_label(s, label_over, s->code_ptr);
+        tcg_out_label(s, label_over);
     } else {
         /* When the destination does not overlap one of the arguments,
            clear the destination first, jump if cond false, and emit an
@@ -1511,7 +1511,7 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
         tcg_out_brcond2(s, new_args, const_args+1, 1);
 
         tgen_arithi(s, ARITH_ADD, args[0], 1, 0);
-        tcg_out_label(s, label_over, s->code_ptr);
+        tcg_out_label(s, label_over);
     }
 }
 #endif
@@ -1525,7 +1525,7 @@ static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
         TCGLabel *over = gen_new_label();
         tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
         tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
-        tcg_out_label(s, over, s->code_ptr);
+        tcg_out_label(s, over);
     }
 }
 
-- 
2.25.1


