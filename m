Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F52BC47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F282073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLKhqxp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F282073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDgL-0004fz-Fy
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdt-0001OF-23
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdX-0000V1-F1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdW-0000A6-Hd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id r26so3079462wmh.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dm8eT7i1ZIH8eOPph0oKfFrt8J+uhOMpHYDcUQLS3eU=;
 b=jLKhqxp3K+yE1TmGDjvpITvWaQDy3WYx6DPrtvIcAvMS2GxR9OhZKRtadRBk7yq6oV
 8B8c1Cn5XJ1yHMHR5QhLc6nl+PJY9gzu0PPqx5dhczifT9kaJzwPxqPGqyb7jt84mJ3g
 dF5oGesY//ZKyqXcgBuA7MDZSA8NDWkWMKYKNxrQFeAfD1IaJHTS5KbVzYnOOa9NwC6q
 5JLSvLYRh9UrN4eDQKIFGyshjOc6nkOQjWqvkiLv04JOfQsoGe6S2bHX1uoa9l4sBUxt
 sEhhLaRl8mFTKQhFZummvd86px9CPgpoEjwl/GdIYAec6qkXT/I7ekVJh/MEhN8vtMN5
 Wk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dm8eT7i1ZIH8eOPph0oKfFrt8J+uhOMpHYDcUQLS3eU=;
 b=E8QAjoc+isHhBhRPp8imDVHNEEn2TLUxKV1pH5cKnEDtils2+sG3nUvLfmtgki1m7O
 ksrV9KbiBYPAp9TBCgqaSNBJx/do2GPFBMHShGxrl3vDmegokollWvNOxIAL9P8bHOv1
 GxfFIrWSL4l6C4fVzl+BaSmI5Ua4jon0wEBpWdIfgpvKuME+jJ4zXOYkXUciCnOXtz+3
 HCn8CzvHCJ/kpf0oK3dSPLh4a264kv8+SsiRgyOd0oT2qEIvFeTtAbMH/7avGygFgjxP
 Kx99QxFvdoO2RWxzrkw0bh/vOF2JCp6eyDeZtigu1l50yUG+G8DYB0wUujb6lCj0CnBQ
 /nkw==
X-Gm-Message-State: AGi0PuZiN7vBBaz3FA2M+LuBr8TkhA8MTdU8guvMhihr/YlTmIJu/lSM
 9FYV+VyBM0VQosnSYS2AXUUq+Q==
X-Google-Smtp-Source: APiQypLOkr2PBLgL8Kl6Y193ldX6Gm249kWnIQUREstrORaj+HW8/La0/5XXCo3NBzOL8RihmkoJDw==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr4183993wmi.72.1588270209043; 
 Thu, 30 Apr 2020 11:10:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/36] target/arm: Don't allow Thumb Neon insns without
 FEATURE_NEON
Date: Thu, 30 Apr 2020 19:09:29 +0100
Message-Id: <20200430181003.21682-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were accidentally permitting decode of Thumb Neon insns even if
the CPU didn't have the FEATURE_NEON bit set, because the feature
check was being done before the call to disas_neon_data_insn() and
disas_neon_ls_insn() in the Arm decoder but was omitted from the
Thumb decoder.  Push the feature bit check down into the called
functions so it is done for both Arm and Thumb encodings.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d4ad2028f12..ab5324a5aaa 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3258,6 +3258,10 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 tmp2;
     TCGv_i64 tmp64;
 
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return 1;
+    }
+
     /* FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
@@ -5002,6 +5006,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     TCGv_ptr ptr1, ptr2, ptr3;
     TCGv_i64 tmp64;
 
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return 1;
+    }
+
     /* FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
@@ -10948,10 +10956,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
 
         if (((insn >> 25) & 7) == 1) {
             /* NEON Data processing.  */
-            if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-                goto illegal_op;
-            }
-
             if (disas_neon_data_insn(s, insn)) {
                 goto illegal_op;
             }
@@ -10959,10 +10963,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         }
         if ((insn & 0x0f100000) == 0x04000000) {
             /* NEON load/store.  */
-            if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-                goto illegal_op;
-            }
-
             if (disas_neon_ls_insn(s, insn)) {
                 goto illegal_op;
             }
-- 
2.20.1


