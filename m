Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A001C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6EC206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgyXmKF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6EC206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47167 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8MP-0004pK-4m
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Sn-00015d-KQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Se-000270-7V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:07:47 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4Sc-000264-7e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:07:44 -0400
Received: by mail-wr1-f54.google.com with SMTP id c2so15453590wrm.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kvmRawPGPmElWaZn3Ee6CrEYDJliNT9WQgA2cgByzq0=;
 b=RgyXmKF1Azn3zawAGqyGiQQVgYJ2nV1x8DwVmPZGcQU/NtEQcKVATbRFkMVWbjQ4Ke
 asSYAnGDisiZoaGDhI7K75WNJiXTWcghdKTUapfB3AnzJxxWjyNNnfbo841iTn3rbNDk
 JOjtuFCj3BN0g++slmnAsemuYS4oQVW7hztq98cQNZV9/P5Uj1+N5fxfA8C+bnon5zHk
 kf+aifEaF7XR4bxQiuhvX2QWKJJnJDtOcJFjiInI63rkZv4vcOf9PumaoZTX8iNuywn7
 4oOd7LqeJHeTvFD9q0UsJ3Yk4Z6HK1VIoxSzb6NGr4UwfwDA3kHeZTDE8BJ/92iac876
 1F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kvmRawPGPmElWaZn3Ee6CrEYDJliNT9WQgA2cgByzq0=;
 b=dCHAGdesC3hmFbozMuTpDGuI6/Xv6Iqgi2CbMBlu8Y6SZ+Q8ekuTPzOFGJ0pwroo4Q
 a3A86ly1Lkz8KBqHuHDnOE4p+QOzqrnTg8PzJi1ZUC7XptmkllvKzJR24dBjmmQ3/d9v
 88UEp00PPtCgNapKhce/WIT5wYpYrXGrpJWgRhw+O5SrzBPYqptRUm5fe5sHbHWFXbvQ
 4TjutSj/I1ZaXOgFuXRorWi/Q8XcRBiqR393hvHGISJ6DSWbeb+lnCVACoARq898dVjB
 I3RailzIIV2RY43zpVefMlLnVpGQDth4KKU/edm1MfO89bPcloAjTYQ/JxX7SVcEqMDa
 fZNQ==
X-Gm-Message-State: APjAAAVB9Da2RvbGRoh37nwWLGJWxt4s+3y+ChHuIGZ8TW8I4JpEaISQ
 U4cFJJp7lVJHYQ5ZyT0M2chf8CY9TczDrA==
X-Google-Smtp-Source: APXvYqwr/B6FgjDNoshZoyySt8Den7g3/hNz1yPFuglMZP3rA7hb9o/KwMze3Acuka/zSRy9laPZnA==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr14428598wrw.337.1561999224904; 
 Mon, 01 Jul 2019 09:40:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:32 +0100
Message-Id: <20190701163943.22313-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
Subject: [Qemu-devel] [PULL 35/46] target/arm: Fix coding style issues
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since we'll move this code around, fix its style first.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-9-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c  | 11 ++++++-----
 target/arm/vfp_helper.c | 36 ++++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4750b9fa1bb..c6bdf026b45 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9109,7 +9109,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 loaded_base = 0;
                 loaded_var = NULL;
                 n = 0;
-                for(i=0;i<16;i++) {
+                for (i = 0; i < 16; i++) {
                     if (insn & (1 << i))
                         n++;
                 }
@@ -9132,7 +9132,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                 }
                 j = 0;
-                for(i=0;i<16;i++) {
+                for (i = 0; i < 16; i++) {
                     if (insn & (1 << i)) {
                         if (is_load) {
                             /* load */
@@ -12353,12 +12353,13 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         return;
     }
 
-    for(i=0;i<16;i++) {
+    for (i = 0; i < 16; i++) {
         qemu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
-        if ((i % 4) == 3)
+        if ((i % 4) == 3) {
             qemu_fprintf(f, "\n");
-        else
+        } else {
             qemu_fprintf(f, " ");
+        }
     }
 
     if (arm_feature(env, ARM_FEATURE_M)) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 7ece78e987b..121bdbd3aff 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -34,18 +34,24 @@ static inline int vfp_exceptbits_from_host(int host_bits)
 {
     int target_bits = 0;
 
-    if (host_bits & float_flag_invalid)
+    if (host_bits & float_flag_invalid) {
         target_bits |= 1;
-    if (host_bits & float_flag_divbyzero)
+    }
+    if (host_bits & float_flag_divbyzero) {
         target_bits |= 2;
-    if (host_bits & float_flag_overflow)
+    }
+    if (host_bits & float_flag_overflow) {
         target_bits |= 4;
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal))
+    }
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
         target_bits |= 8;
-    if (host_bits & float_flag_inexact)
+    }
+    if (host_bits & float_flag_inexact) {
         target_bits |= 0x10;
-    if (host_bits & float_flag_input_denormal)
+    }
+    if (host_bits & float_flag_input_denormal) {
         target_bits |= 0x80;
+    }
     return target_bits;
 }
 
@@ -80,18 +86,24 @@ static inline int vfp_exceptbits_to_host(int target_bits)
 {
     int host_bits = 0;
 
-    if (target_bits & 1)
+    if (target_bits & 1) {
         host_bits |= float_flag_invalid;
-    if (target_bits & 2)
+    }
+    if (target_bits & 2) {
         host_bits |= float_flag_divbyzero;
-    if (target_bits & 4)
+    }
+    if (target_bits & 4) {
         host_bits |= float_flag_overflow;
-    if (target_bits & 8)
+    }
+    if (target_bits & 8) {
         host_bits |= float_flag_underflow;
-    if (target_bits & 0x10)
+    }
+    if (target_bits & 0x10) {
         host_bits |= float_flag_inexact;
-    if (target_bits & 0x80)
+    }
+    if (target_bits & 0x80) {
         host_bits |= float_flag_input_denormal;
+    }
     return host_bits;
 }
 
-- 
2.20.1


