Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3372C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1ED2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgZsatjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1ED2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Uc-0008OW-ON
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gu-0003ze-Mu
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gs-0000ix-23
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:19 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:38703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gp-0000gV-8T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:15 -0400
Received: by mail-pg1-x52d.google.com with SMTP id e11so224308pga.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xx52JC6MANGMEBBAfqEp/mRO3ZRBD9ucqNlmZ54oyt8=;
 b=CgZsatjTMnGY6El4ng2xbpq1IVLnbLN6zm0b5U6wzXR5EQY5ssnXPpWI747kkrLX9r
 yKtJGuMsEa/8ecuZnRM3c569t7zNqKpDLKW/uSjZ7TRWVAlDpULv1Q7sKsqUPxGRKfq4
 blvTw2xX+7rxfuNExyoYiJ8eE+DmnSYu9RzYax8Vk2G/2XR4vrxdIuYC4XYflmi3DEqc
 e4+fE2Ksq0/LdITyOrxrrJY53PJDakVzJeAJwQfoJJxWJlpLeVjWo87BWer8U7THUW0l
 OqDK6EFMseTIYS4rYEF3epvZgPTYwBOLK1NiW9LVDHHV9Vr/kxM4Ghjt7HrIOrnGZDsT
 +xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xx52JC6MANGMEBBAfqEp/mRO3ZRBD9ucqNlmZ54oyt8=;
 b=UatXHAdHWI1iosdjLFHS5MVWManOWZuAaCL+9jptSMI9DljsuXrUdnOJaA+LeNdNfx
 eHhGWjhVvzpPWMHSLtTbwHy0bE4Cxq166X6Ea/JFWEjXiOoYCAMU0hTFBWwxy17kYjsf
 VcgBPqTY0l3N1+oTXIL+nj/PmfpOdUhpaFWQ9W4019h8k4FioLnxjQM6WwKH5y4mdnBe
 0VVNTpgPFgfb40VNy4MFjBaQvhpSFl7TIO2RkexY08Lp3dwO1gXzokIhfvq/utP4KpWz
 Q+Uzy5tOmAIUioIz/vlC37QyR8u7WVDgGup4sEiGM2CIBlkyrOCNJUAYLbKy5/k9LIc2
 +1Yg==
X-Gm-Message-State: APjAAAVUxS76WuIyK3CnqENfZXMaiWSPy/dWjjPVz4iU+b/YYZah3BO1
 mnu7NbJwEAGOpu1uCfplGrjJD2yB4eY=
X-Google-Smtp-Source: APXvYqwRq1U0npGr+GpkVh0BTsCcaV3wmqgb+iBcKSHfw56hX7ZvuUc0V+W3ku3yfDyvvP66WenAEQ==
X-Received: by 2002:a65:6846:: with SMTP id q6mr4827170pgt.150.1567019173561; 
 Wed, 28 Aug 2019 12:06:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:45 -0700
Message-Id: <20190828190456.30315-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PATCH v3 58/69] target/arm: Convert T16, Reverse bytes
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 18 +++---------------
 target/arm/t16.decode  |  9 +++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1dacae1a5b..ec5b095bd1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10707,7 +10707,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rn, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
     int i;
     TCGv_i32 tmp;
@@ -10904,20 +10904,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 break;
             }
 
-            /* Otherwise this is rev */
-            ARCH(6);
-            rn = (insn >> 3) & 0x7;
-            rd = insn & 0x7;
-            tmp = load_reg(s, rn);
-            switch (op1) {
-            case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-            case 1: gen_rev16(tmp, tmp); break;
-            case 3: gen_revsh(tmp, tmp); break;
-            default:
-                g_assert_not_reached();
-            }
-            store_reg(s, rd, tmp);
-            break;
+            /* Otherwise this is rev, in decodetree */
+            goto illegal_op;
         }
 
         case 6: /* setend, cps; in decodetree */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 032902a1f4..19a442b894 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &rrr_rot         !extern rd rn rm rot
+&rr              !extern rd rm
 &ri              !extern rd imm
 &r               !extern rm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
@@ -195,3 +196,11 @@ SETEND          1011 0110 010 1 E:1 000         &setend
   CPS           1011 0110 011 . 0 A:1 I:1 F:1   &cps mode=0 M=0 %imod
   CPS_v7m       1011 0110 011 im:1 00 I:1 F:1
 }
+
+# Reverse bytes
+
+@rdm            .... .... .. rm:3 rd:3          &rr
+
+REV             1011 1010 00 ... ...            @rdm
+REV16           1011 1010 01 ... ...            @rdm
+REVSH           1011 1010 11 ... ...            @rdm
-- 
2.17.1


