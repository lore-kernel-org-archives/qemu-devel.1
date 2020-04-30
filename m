Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F1CC83003
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B83208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEXZ2Da2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B83208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyga-0007x7-5v
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYz-0006yW-Ri
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXk-0004kZ-TF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:33 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:54284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXk-0004kQ-G4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:16 -0400
Received: by mail-pj1-x102a.google.com with SMTP id y6so56703pjc.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cf10Ltp+LjL7U9fSobfmU538FUNhYdLaUawwYU85+AA=;
 b=lEXZ2Da2l0IswFDgh0qW9nxV/bsE1I6HDZLXcKaZmlcRzgsHYP84JnJNk2E0zLmwZa
 /U4pXFjowlyXxRtRn8NzN3PRzaLLi+xjcmqOvQG8HGICZx6yEXqB3AllVP0YZkSTickZ
 Jw6geE9GqP7KpMkSGXUCjHb5hkqbuaZF/qZZxy4gH3QMnMZoypfCBC/g7pBRzO6mpzTz
 qmOh/pR1CwVovtvtU0PF59o75a4nuxdoyJGYnYlWUtq0x6EXpS33KUvW4hV8hm8rVT9u
 ENx5nxlHqv0SH455VqfbYJhEyNBoUs8pFwwYl3WT/W7Hun1/nZR2nSEM9C925ulBFqBb
 JOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cf10Ltp+LjL7U9fSobfmU538FUNhYdLaUawwYU85+AA=;
 b=i7n4aDVgcq38xMqipnHEoXYk61bePlxDT4RraT424m16lstnaSCz/vg9rYXUgNY178
 P1uEGF7L252Cj/tGwg7/o/LIp/uetET40+TOk4wBefM4+XhnCzMe4MRWwuVC6lyx+zZE
 1/rnPGbf2BCQvQnXts+h7/6Ftl7gYJnMrDrSKh1GacX3zR3+WoJcZh700Q+vw+ucMxvt
 mODcWBbLRyZew677ZYRGDjhtndmoKG7KdnLjc4lnX9mLFeKzVsO/jIu62Lz39JqXknN2
 iMhZi5zqtJcO1oEgRGZvPMoX0oLbJWUvDEXP+Tr7Vqc922tBHGdnWkMnHecCn23Pe68N
 J8Tg==
X-Gm-Message-State: AGi0PuYFcUHB1o6G3GuY2W4Dvvil34PH5pcBqbTY5rdHb7jwE9YeRLv4
 tFWfPttIYXfS61onmGyHDidN+98eyxY=
X-Google-Smtp-Source: APiQypI9wG6qDmbA3qPRWx6iqBPUUH71BInJKioZwBzM7kdTTAmlMp+2NeOxcvtxVOygN0MnA7MrUQ==
X-Received: by 2002:a17:902:9a03:: with SMTP id
 v3mr1337175plp.272.1588212194808; 
 Wed, 29 Apr 2020 19:03:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] target/arm: Implement SVE2 crypto destructive binary
 operations
Date: Wed, 29 Apr 2020 19:03:02 -0700
Message-Id: <20200430020303.20264-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::102a
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 +++++
 target/arm/sve.decode      |  7 ++++++
 target/arm/translate-sve.c | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 332c67bbb0..4f09dd42ba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3870,6 +3870,11 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
+}
+
 static inline bool isar_feature_aa64_sve2_i8mm(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, I8MM) != 0;
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 04985d2bb8..149de7949b 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -118,6 +118,8 @@
 @pd_pn_pm       ........ esz:2 .. rm:4 ....... rn:4 . rd:4      &rrr_esz
 @rdn_rm         ........ esz:2 ...... ...... rm:5 rd:5 \
                 &rrr_esz rn=%reg_movprfx
+@rdn_rm_e0      ........ .. ...... ...... rm:5 rd:5 \
+                &rrr_esz rn=%reg_movprfx esz=0
 @rdn_sh_i8u     ........ esz:2 ...... ...... ..... rd:5 \
                 &rri_esz rn=%reg_movprfx imm=%sh8_i8u
 @rdn_i8u        ........ esz:2 ...... ... imm:8 rd:5 \
@@ -1557,3 +1559,8 @@ STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
 # SVE2 crypto unary operations
 # AESMC and AESIMC
 AESMC           01000101 00 10000011100 decrypt:1 00000 rd:5
+
+# SVE2 crypto destructive binary operations
+AESE            01000101 00 10001 0 11100 0 ..... .....  @rdn_rm_e0
+AESD            01000101 00 10001 0 11100 1 ..... .....  @rdn_rm_e0
+SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 44dd1fe2b0..91e71882d6 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8188,3 +8188,48 @@ static bool trans_AESMC(DisasContext *s, arg_AESMC *a)
     }
     return true;
 }
+
+static bool do_aese(DisasContext *s, arg_rrr_esz *a, bool decrypt)
+{
+    if (!dc_isar_feature(aa64_sve2_aes, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, decrypt, gen_helper_crypto_aese);
+    }
+    return true;
+}
+
+static bool trans_AESE(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_aese(s, a, false);
+}
+
+static bool trans_AESD(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_aese(s, a, true);
+}
+
+static bool do_sm4(DisasContext *s, arg_rrr_esz *a, gen_helper_gvec_3 *fn)
+{
+    if (!dc_isar_feature(aa64_sve2_sm4, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
+static bool trans_SM4E(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sm4(s, a, gen_helper_crypto_sm4e);
+}
-- 
2.20.1


