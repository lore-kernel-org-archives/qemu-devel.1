Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90612C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA44218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqb8bBC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA44218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Pz-0007o3-7V
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mk-0002Cg-34
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mh-0007cb-KX
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mh-0007Ze-Dl
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:47 -0400
Received: by mail-pf1-x442.google.com with SMTP id f17so20863474pfn.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6AlrLPoHEa++V99L7+ZXhJHR2MnP9U+NbGuctJWMxJE=;
 b=mqb8bBC+RsDkqdEMK9OWURwjjLzi83s/2TP/cn0X/bcMBMFQt9jPUJkzStfa+59HBK
 VPfzXXkPsdu6+vc1IGIME0HhVU4rjindrTnDcc2gsfOmvMEuxo/Wby2TgPPhaj74alAh
 3Rrn9UUznq3sT9Qb/hxM61DUtZgUPB8OYHG/B2WRCnebxf7M5KL4W6NMfCHg49MzTWiQ
 8J9jGvodc2fCCXPPFtZ5i6l3aYJMIESIxRBPzVrd+RMBx5JgcOOOhdL6a8h4FoVj98Uo
 A1pPHfz96ZQCZmXlpsD2V/JWP+5Zh45+415MhmiXeNhmOROQpD04BLmMV+u5K3AaquZB
 88wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6AlrLPoHEa++V99L7+ZXhJHR2MnP9U+NbGuctJWMxJE=;
 b=f6BVbJAo+INOLeqfD+WPkagReXhn+e5Me4OHPt0K8SymZL3l/mZz+z6i2n7lb5z4KM
 zc70RP9UqBXhBj1e5+ern0y5W2CMuIdZlv43UiWI1flh1iLshUWO+t1e5Uj1Nult464C
 N4IT5kv3xlQvHxILWC6p1QbmJfCpPl+PDmOKxPMgegNttM8u/BV5gUvDE4RbxBceaxNV
 tz/+xHZ7KINky6OLwQesAydZdRMr3mwnBzR9lMCL0ihbbYJzNH7reUxCNGvQc4Ue8b4U
 Q2/FYwBmz/Wi8swsiqO9kKHCit7Pz+dFhgqR0S5XaZEo9DF6y1M9T1fcLyVLGRi3yJFw
 QW+Q==
X-Gm-Message-State: APjAAAVGxMMOB4dBCjLwiS4SbXDz/f5U/6V7aLLdgeJPhooy3kH0URUl
 idAiYoBgeh8r7qeZdCUyY3BopTIdBEg=
X-Google-Smtp-Source: APXvYqzi+sVHu8VG0O+VlkBK5lFI8X3/Vo1+1+1uShW6w4ASsOmFlmZxT/6ZdjwhL7XMnBAVU1eTwg==
X-Received: by 2002:a63:ec48:: with SMTP id r8mr16802349pgj.387.1564163446138; 
 Fri, 26 Jul 2019 10:50:46 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:35 -0700
Message-Id: <20190726175032.6769-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 10/67] target/arm: Move test for AL into
 arm_skip_unless
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

We will shortly be calling this function much more often.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 53c46fcdc4..36419025db 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7705,8 +7705,14 @@ static void arm_gen_condlabel(DisasContext *s)
 /* Skip this instruction if the ARM condition is false */
 static void arm_skip_unless(DisasContext *s, uint32_t cond)
 {
-    arm_gen_condlabel(s);
-    arm_gen_test_cc(cond ^ 1, s->condlabel);
+    /*
+     * Conditionally skip the insn. Note that both 0xe and 0xf mean
+     * "always"; 0xf is not "never".
+     */
+    if (cond < 0xe) {
+        arm_gen_condlabel(s);
+        arm_gen_test_cc(cond ^ 1, s->condlabel);
+    }
 }
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
@@ -7944,11 +7950,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         }
         goto illegal_op;
     }
-    if (cond != 0xe) {
-        /* if not always execute, we generate a conditional jump to
-           next instruction */
-        arm_skip_unless(s, cond);
-    }
+
+    arm_skip_unless(s, cond);
+
     if ((insn & 0x0f900000) == 0x03000000) {
         if ((insn & (1 << 21)) == 0) {
             ARCH(6T2);
@@ -12095,15 +12099,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->insn = insn;
 
     if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
-        uint32_t cond = dc->condexec_cond;
-
-        /*
-         * Conditionally skip the insn. Note that both 0xe and 0xf mean
-         * "always"; 0xf is not "never".
-         */
-        if (cond < 0x0e) {
-            arm_skip_unless(dc, cond);
-        }
+        arm_skip_unless(dc, dc->condexec_cond);
     }
 
     if (is_16bit) {
-- 
2.17.1


