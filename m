Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F46C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A872080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BH0RYrek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A872080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLNb-0007RR-NZ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIS-0004tt-HT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:40042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIQ-0000lK-MM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:16 -0400
Received: by mail-pf1-x42e.google.com with SMTP id c142so8933537pfb.7
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxvKwmePa50MKIg8eLv8VBXTLXGDs/q8gqEzTKISHeQ=;
 b=BH0RYrek4GEPFXrTFgIyrJ4XsZQdSHl2fA7vTiIbZqNoCwTotKOOhFzLbhtMM8F1KT
 K43+3mzn/0FcXzKF7aoqm4HBg8X0nkVsrPhIORY0ynjhWbuc2+t3XQrsocnkVSoNphb+
 1fVuug2xEyFEo265sb/0PWcZ2ZUiUqbWYGPdX4F6m3ocOEocdZE0xr7JgKIRdCAoILBx
 WmoJoxcuzuKIsbLqrTiaIJvwrTIXt2Eqb0mwrm0RCEkwsTHRUT7E8GOKlKMmNEtp+48L
 V5agDAp1vAZqpGLZGrEonCeLzoU7zOyU/sKY0CFBX0rbixVb/NVXxTc3M4698jCzUHPo
 18xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxvKwmePa50MKIg8eLv8VBXTLXGDs/q8gqEzTKISHeQ=;
 b=CCji7tNj/Th43pJ038oT7NgJBNnuzRq04GjZy5Tek9eYbDwGMnXRwi4FVRGf9PMrKz
 j/xRT4sTRTtd1HloWOxd4T6PbMGBVSGpxvXUv4KmU3e3YvVJQbanXRK+0aCUWgujsjOY
 /ARnUIAhdJ/nKr8ZC+UOe9L1uKRQHgFrbryCpoWbxlRoinKlOQ395xSRBFpVHWfg1409
 66/OIU7DREZnLAJsoSNGDaOqJ4sG3/r3plwQnnmJN83ncGXptnlKYTqdPKyfmZW5Og7k
 oD2CKGqQ8TLidJQvYzu2UIPNePnTusJEisLrfTkrEzV1Dg2EKYf0ARli6XFdCTHZMBCN
 /5vg==
X-Gm-Message-State: AOAM531/PDUNSjcri8m4MNoOzGkGAxhIO9YlrdIh7vq10ODOnu1Fnyls
 92z8HUjoK4wflQYfxEDKqQgNPJ+djd2RJw==
X-Google-Smtp-Source: ABdhPJxBnr1r7m2GlIACEmHPC3IOB42HZfiyLSL8mJ4pB8/5w6GXEDIu9B0KUinPk8KkymTIVqhlNg==
X-Received: by 2002:aa7:864c:0:b029:13c:1611:6591 with SMTP id
 a12-20020aa7864c0000b029013c16116591mr19152951pfo.14.1599501072903; 
 Mon, 07 Sep 2020 10:51:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ga3sm1651496pjb.18.2020.09.07.10.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 10:51:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] target/microblaze: Introduce DISAS_EXIT_NEXT,
 DISAS_EXIT_JUMP
Date: Mon,  7 Sep 2020 10:50:49 -0700
Message-Id: <20200907175102.28027-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907175102.28027-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like DISAS_EXIT, except we need to update cpu_pc,
either to pc_next or to btarget respectively.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8ceb04f4f0..2abef328a3 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -39,6 +39,11 @@
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_EXIT    DISAS_TARGET_1 /* all cpu state modified dynamically */
 
+/* cpu state besides pc was modified dynamically; update pc to next */
+#define DISAS_EXIT_NEXT DISAS_TARGET_2
+/* cpu state besides pc was modified dynamically; update pc to btarget */
+#define DISAS_EXIT_JUMP DISAS_TARGET_3
+
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
@@ -1712,8 +1717,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     /* Force an exit if the per-tb cpu state has changed.  */
     if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
-        dc->base.is_jmp = DISAS_EXIT;
-        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+        dc->base.is_jmp = DISAS_EXIT_NEXT;
     }
 }
 
@@ -1734,12 +1738,14 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         return;
 
     case DISAS_EXIT:
-        if (unlikely(cs->singlestep_enabled)) {
-            gen_raise_exception(dc, EXCP_DEBUG);
-        } else {
-            tcg_gen_exit_tb(NULL, 0);
-        }
-        return;
+        break;
+    case DISAS_EXIT_NEXT:
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+        break;
+    case DISAS_EXIT_JUMP:
+        tcg_gen_mov_i32(cpu_pc, cpu_btarget);
+        tcg_gen_discard_i32(cpu_btarget);
+        break;
 
     case DISAS_JUMP:
         if (dc->jmp_dest != -1 && !cs->singlestep_enabled) {
@@ -1781,6 +1787,13 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
     default:
         g_assert_not_reached();
     }
+
+    /* Finish DISAS_EXIT_* */
+    if (unlikely(cs->singlestep_enabled)) {
+        gen_raise_exception(dc, EXCP_DEBUG);
+    } else {
+        tcg_gen_exit_tb(NULL, 0);
+    }
 }
 
 static void mb_tr_disas_log(const DisasContextBase *dcb, CPUState *cs)
-- 
2.25.1


