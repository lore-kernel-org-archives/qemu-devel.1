Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452AC2067B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brBZfapf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452AC2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJ7R-000201-7R
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc4-0004Tj-9A
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:37425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbz-0001s7-P4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id 13so3813658pfy.4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5sZj0iMK7ubylfsLHfG7ZnZlvOfpvu4oqHrbQTSE0h8=;
 b=brBZfapfvv/dF8l0rMBK5wXWMgZ92uTv18ETaALqmWMYfav6qJR+1gHFK98fJ0JRtD
 ktjuUgJlFMaTgBpKc6WQqW74YSSBRM8F8gaFgai+ehoP4pMzN1cUd5BbSoI1XZ1LJejl
 uwIbScuRokd9GLwIu+ss5+z9+TUTbA4S75eh3YHZWUPY3zFBxQONZYORARlVV28vctn2
 YxttnW/qge1Qhw43lih97T3Tpk5yTMQtgR8CSyaXl3yE0OCoykDdXPl+9cuKqTwvA4Lu
 6nnaSMZ2AivndisNtyM+VS4fAkfzy14R+zZHxEbQv70i3SwIxlYFZrF0BCCTTlDUxryo
 HJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5sZj0iMK7ubylfsLHfG7ZnZlvOfpvu4oqHrbQTSE0h8=;
 b=REd7etlPsOc7YEHhR8wuM9sCprKSU7OPgXiMoFYjUoTMR+oL7BVwIoyq65yDbRv5DK
 DQt2SIX3/TkEqOH6vgvnQ37L+IlNMeiedv0YNPvlBYJubC1qu6QQXSKh8nOsSwUJO2hr
 K6r0Ylx2aC0pyQHSrX3eKaimt0oSqcvqMmKx0b08OJfHP+JO6qy0wTkxTH5WEaOJCP9y
 BiCIB87sb3EwoVGtEbK2n6j7yhgJsZERw4w7sAGmHFG+p5Aw+ilnqILPX8Zq4Phjgi+A
 bwwEfT8eF6GD+uzbH6yfT+SqrHsb6z7h20b3nB/+hYUWfYOzHVKCeRPLuv3G5gKKHuF6
 ua3g==
X-Gm-Message-State: AOAM533doHUdefyQ0KIqLroqCfJJGhpYjWcthGuX3fnzOeScEFEhWEGO
 wbEHDO1tfp3IYS8DmZlc9ZxjJkNwgATyPA==
X-Google-Smtp-Source: ABdhPJy4Fv4f4G5ylFAk5xj1caGQ+fXv7mfd0SEE2L8eWH3X0jzbYeI7Dqihl6x9m32YpmGlaSVKsQ==
X-Received: by 2002:a63:e847:: with SMTP id a7mr2753160pgk.192.1604018985101; 
 Thu, 29 Oct 2020 17:49:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/19] tcg/i386: Support split-rwx code generation
Date: Thu, 29 Oct 2020 17:49:18 -0700
Message-Id: <20201030004921.721096-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.c.inc | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 1b9d41bd56..bbbd1c2d4a 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -236,6 +236,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7f74c77d7f..e2c85381cd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -165,7 +165,7 @@ static bool have_lzcnt;
 # define have_lzcnt 0
 #endif
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
@@ -173,7 +173,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     value += addend;
     switch(type) {
     case R_386_PC32:
-        value -= (uintptr_t)code_ptr;
+        value -= (uintptr_t)tcg_mirror_rw_to_rx(code_ptr);
         if (value != (int32_t)value) {
             return false;
         }
@@ -182,7 +182,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         tcg_patch32(code_ptr, value);
         break;
     case R_386_PC8:
-        value -= (uintptr_t)code_ptr;
+        value -= (uintptr_t)tcg_mirror_rw_to_rx(code_ptr);
         if (value != (int8_t)value) {
             return false;
         }
@@ -1006,7 +1006,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 
     /* Try a 7 byte pc-relative lea before the 10 byte movq.  */
-    diff = arg - ((uintptr_t)s->code_ptr + 7);
+    diff = tcg_pcrel_diff(s, (const void *)arg) - 7;
     if (diff == (int32_t)diff) {
         tcg_out_opc(s, OPC_LEA | P_REXW, ret, 0, 0);
         tcg_out8(s, (LOWREGMASK(ret) << 3) | 5);
@@ -1615,7 +1615,7 @@ static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
     tcg_out_branch(s, 1, dest);
 }
 
-static void tcg_out_jmp(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_jmp(TCGContext *s, const tcg_insn_unit *dest)
 {
     tcg_out_branch(s, 0, dest);
 }
@@ -1786,7 +1786,8 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, bool is_64,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_mirror_rw_to_rx(raddr);
     label->label_ptr[0] = label_ptr[0];
     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
         label->label_ptr[1] = label_ptr[1];
@@ -2280,7 +2281,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             /* jump displacement must be aligned for atomic patching;
              * see if we need to add extra nops before jump
              */
-            gap = tcg_pcrel_diff(s, QEMU_ALIGN_PTR_UP(s->code_ptr + 1, 4));
+            gap = QEMU_ALIGN_PTR_UP(s->code_ptr + 1, 4) - s->code_ptr;
             if (gap != 1) {
                 tcg_out_nopn(s, gap - 1);
             }
@@ -3825,11 +3826,12 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_mirror_rw_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);
 
     /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+    tb_ret_addr = tcg_mirror_rw_to_rx(s->code_ptr);
 
     tcg_out_addi(s, TCG_REG_CALL_STACK, stack_addend);
 
-- 
2.25.1


