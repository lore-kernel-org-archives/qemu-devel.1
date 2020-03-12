Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA369C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A958B20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjnJenYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A958B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTm5-0005Vb-Q4
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiw-0004oc-My
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiv-0001kM-8i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:36111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTiv-0001jo-2h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id g2so569031plo.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/pGqR0ZT/lu7yV5pm4MglVp61s4Mp3dEdpOqchZImpI=;
 b=ZjnJenYdXVG6ygE/hvwGUgJolEbNN7rTg4fkKZlbbgupjYkXXQpCk5HCZaC/BRndAg
 Sb2EC7oePEBHntT7+/ntA22H6yJ8EdKr79Qw4nUcT/O1YaVEE4UTIBRFNbekNmnDYJKl
 W2Yltewzxm04aQie/Qs+zlIZodGj85e5JlaZlt6qonWkzt9cu+TKUVljnHDMW1vBiu8t
 xdqNi6kOadEmGDExWf0aLVYMo8cfT3S4NPA7NDnv/ueaG4b91LRLZVDPNYEyzT/kUfAD
 v0OUYnYjwPzcSTQIIRFwZssBgvDk+8Xa63ur6oT4fDF4MySzIHQ1IqS9W0qh9LZM9c8h
 WSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/pGqR0ZT/lu7yV5pm4MglVp61s4Mp3dEdpOqchZImpI=;
 b=AQ3KhLVpXRER8KQLutMohjabm8sItCp7LtNQw3JSlMgV1/OwpXw7BCHcnY8rvE3/AK
 oylMCgZrZ4HGjox8N+Jf73in82GNdCvGLY2m4GOK58vEPdSgo8kLz3Plwfm7Uu/FMQ41
 g75ZCT4HGrAZYoAKMgAkTDAWYAiBFzB6Lkpz3ZHxjnZIdTGt1YSJWYjs3I9UCzrOiuk9
 wAjPxRiPEJWJZ12xrvl12CzA9baOvslc4IvmpnqPE0zQojisPsSa3n/XO7gHczvr/VYp
 fPMdyoZNILAI/k1fXMIGhHw/aOvlLYGcikqMdG+/bfrZIF+GU1RatFIkeOrPiQOVxqqU
 4adw==
X-Gm-Message-State: ANhLgQ3qyuz+Hh9dI05h4hrVF9X3qV338FoFG62KeZ3ox6Upp04lxvnk
 lOX3VUgD5O/zVskCm/oaOT0HbDVR7Zs=
X-Google-Smtp-Source: ADFU+vs5jLyNuoDQREiDOpSSrTfH2SYhM8rP0b36Jhg4f7MZ9bdvTvUYbVaU5wxZLfquXJb/q36xjg==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr5721193pjq.5.1584042147577; 
 Thu, 12 Mar 2020 12:42:27 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/42] target/arm: Rename DISAS_UPDATE to DISAS_UPDATE_EXIT
Date: Thu, 12 Mar 2020 12:41:42 -0700
Message-Id: <20200312194219.24406-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::631
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Emphasize that the is_jmp option exits to the main loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h         | 14 ++++++++------
 target/arm/translate-a64.c     |  8 ++++----
 target/arm/translate-vfp.inc.c |  2 +-
 target/arm/translate.c         | 12 ++++++------
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index d9ea0c99cc..41d6cc8db5 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -148,7 +148,8 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 
 /* is_jmp field values */
 #define DISAS_JUMP      DISAS_TARGET_0 /* only pc was modified dynamically */
-#define DISAS_UPDATE    DISAS_TARGET_1 /* cpu state was modified dynamically */
+/* CPU state was modified dynamically; exit to main loop for interrupts. */
+#define DISAS_UPDATE_EXIT  DISAS_TARGET_1
 /* These instructions trap after executing, so the A32/T32 decoder must
  * defer them until after the conditional execution state has been updated.
  * WFI also needs special handling when single-stepping.
@@ -164,11 +165,12 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  * custom end-of-TB code)
  */
 #define DISAS_BX_EXCRET DISAS_TARGET_8
-/* For instructions which want an immediate exit to the main loop,
- * as opposed to attempting to use lookup_and_goto_ptr. Unlike
- * DISAS_UPDATE this doesn't write the PC on exiting the translation
- * loop so you need to ensure something (gen_a64_set_pc_im or runtime
- * helper) has done so before we reach return from cpu_tb_exec.
+/*
+ * For instructions which want an immediate exit to the main loop, as opposed
+ * to attempting to use lookup_and_goto_ptr.  Unlike DISAS_UPDATE_EXIT, this
+ * doesn't write the PC on exiting the translation loop so you need to ensure
+ * something (gen_a64_set_pc_im or runtime helper) has done so before we reach
+ * return from cpu_tb_exec.
  */
 #define DISAS_EXIT      DISAS_TARGET_9
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8fffb52203..a793ec9ee1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1661,7 +1661,7 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         gen_helper_msr_i_daifclear(cpu_env, t1);
         tcg_temp_free_i32(t1);
         /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
         break;
 
     default:
@@ -1840,7 +1840,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
 
     if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
     }
     if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /*
@@ -1855,7 +1855,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
     }
 }
 
@@ -14456,7 +14456,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
         default:
-        case DISAS_UPDATE:
+        case DISAS_UPDATE_EXIT:
             gen_a64_set_pc_im(dc->base.pc_next);
             /* fall through */
         case DISAS_EXIT:
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index b087bbd812..454bff6d01 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2867,6 +2867,6 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
     tcg_temp_free_i32(fptr);
 
     /* End the TB, because we have updated FP control bits */
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
     return true;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6259064ea7..5a21766cce 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2935,7 +2935,7 @@ static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_reg);
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
 }
 
 static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
@@ -2957,7 +2957,7 @@ static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     store_reg(s, rn, tcg_reg);
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
 }
 
 /* Store value to PC as for an exception return (ie don't
@@ -7635,7 +7635,7 @@ static void gen_srs(DisasContext *s,
         tcg_temp_free_i32(tmp);
     }
     tcg_temp_free_i32(addr);
-    s->base.is_jmp = DISAS_UPDATE;
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
 }
 
 /* Generate a label used for skipping this instruction */
@@ -10682,7 +10682,7 @@ static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
     }
     if (a->E != (s->be_data == MO_BE)) {
         gen_helper_setend(cpu_env);
-        s->base.is_jmp = DISAS_UPDATE;
+        s->base.is_jmp = DISAS_UPDATE_EXIT;
     }
     return true;
 }
@@ -11419,7 +11419,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
-        case DISAS_UPDATE:
+        case DISAS_UPDATE_EXIT:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
@@ -11446,7 +11446,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
-        case DISAS_UPDATE:
+        case DISAS_UPDATE_EXIT:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
-- 
2.20.1


