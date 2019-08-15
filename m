Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A758C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99AC206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYMMB5w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99AC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Qh-0005W8-O7
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dp-0006ao-4f
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dn-0000Z3-Uf
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:37 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c]:45757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dn-0000Yh-QG
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:35 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id u32so388576ybi.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pFADS3F1d6u0mR4HCrPET+k4id9MakH4mSbzpX9nHM8=;
 b=iYMMB5w0bUeCsTR+AhD5NV6+gOFw4u/GKvwBD5fFcTiV+tlK7ccWQqEYrFN4jnI/19
 HyVS8mltAvBI7Xt1ZfokX4dYLAO1NFH6w7b0UrX/NEYyiQPp+N9YP9MO8QtSDKQ7gdl/
 Jh61CYnmXsq0hHnrEoqVkQgvk4cgi1tXPwGhylT+mtuA4TdItkWg5j+EYGPVPNns/bKD
 gARLpvWURnrFBqwEnrmgzunHnvX+ZlCUUfYZ4XJLsUztQJ6rwyGB2a/nmxFqRsBHrReJ
 N9duhybrxi8Rtxr+RLKHfCZGgjdlUG3mF7TvtkaPLzq7+8Z071vqTm3zc2cnqMFunJKN
 3E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pFADS3F1d6u0mR4HCrPET+k4id9MakH4mSbzpX9nHM8=;
 b=ESztXYe7r6WIyRfJQILuOwU92aGaNrrYJ7t7bIw0mzh3KuAxm3TplFxyyVleSmFtM2
 2ZZezdpbMdG7+Mu2YJxeLZxNHHmGMchqmGI5ri5Qf1nrzvDMo5HO6/yKaYc9II2/VqEd
 pEPyzTrlqtpXDHDX/eliPy0K6WVV5RAD2OG04oa5J91O+KtVjj2w9pBulpgnlEEdHCwH
 93ggV0UlHAXT3Pnj0t8uOHM6J1fvakivCblTNOAi/LWMkhXNYJeeGv5dgMQjFrev7XN0
 6GA+IuS11QutBkm9xo4RQ4tX/7TB6g2b7aOSvdlzrxxStfz1GkZU6i46r+YoZhD1YKkc
 rJbw==
X-Gm-Message-State: APjAAAUYcgoZcs6x4F9+t/heSr/bLmYZn3sN3rbA9hX9ykI3UcHxcCWP
 xRYu8g1epL59hIctUf9Yh2v1xrXI
X-Google-Smtp-Source: APXvYqzEwX6ocbm49pePMuu+JBa/bNrWt86R0bk6xr59jBZ+esZCCIJ7af8CJ4cjnwVU6xPvy7tiDQ==
X-Received: by 2002:a25:c486:: with SMTP id u128mr1986161ybf.428.1565835035102; 
 Wed, 14 Aug 2019 19:10:35 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:34 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:27 -0400
Message-Id: <20190815020928.9679-46-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b2c
Subject: [Qemu-devel] [RFC PATCH v3 45/46] target/i386: introduce SSE3 code
 generators
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce code generators required by SSE3 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index c72138014a..9da3fbb611 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5627,6 +5627,63 @@ GEN_INSN2(movmskpd, Gq, Udq)
     tcg_temp_free_i32(arg1_r32);
 }
 
+GEN_INSN2(lddqu, Vdq, Mdq)
+{
+    assert(arg2 == s->A0);
+    gen_ldo_env_A0(s, arg1);
+}
+
+GEN_INSN2(movshdup, Vdq, Wdq)
+{
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(1)));
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(1)));
+    }
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(3)));
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(2)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(3)));
+    }
+
+    tcg_temp_free_i32(r32);
+}
+
+GEN_INSN2(movsldup, Vdq, Wdq)
+{
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+    }
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(1)));
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(2)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(2)));
+    }
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(3)));
+
+    tcg_temp_free_i32(r32);
+}
+
+GEN_INSN2(movddup, Vdq, Wq)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    }
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+
+    tcg_temp_free_i64(r64);
+}
+
 DEF_GEN_INSN3_GVEC_MM(paddb, add, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_XMM(paddb, add, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(paddw, add, Pq, Pq, Qq, MO_16)
@@ -5647,6 +5704,8 @@ DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(addpd, addpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addsd, addsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(haddps, haddps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(haddpd, haddpd, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_GVEC_MM(psubb, sub, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_XMM(psubb, sub, Vdq, Vdq, Wdq, MO_8)
@@ -5668,6 +5727,11 @@ DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subpd, subpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subss, subss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(subsd, subsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(hsubps, hsubps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(hsubpd, hsubpd, Vdq, Vdq, Wdq)
+
+DEF_GEN_INSN3_HELPER_EPP(addsubps, addsubps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(addsubpd, addsubpd, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
-- 
2.20.1


