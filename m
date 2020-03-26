Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC0DC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE45208FE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khvwLdZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE45208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbsT-0003GF-QQ
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcm-0003DX-RU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcl-00025T-O3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:20 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:38921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcl-00024Q-H3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:19 -0400
Received: by mail-pg1-x52f.google.com with SMTP id b22so3651273pgb.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y9AW+fkUrXuwDSItggnbypCfN/Kt8Ehf1WvwBsOiyX4=;
 b=khvwLdZab3bGspZGQIaKRdwlLVP1QxMoQh23OPqJ9bvQ0EaDbAH8hdQF9ns2qOh9+Y
 5xDTzqwa9KB5x2bpqlMI0WYts9IWOfgKn/M6T/EvrVYh39mDqEO9DGodcUjyjqATD5L1
 Z+adzhVsC1oe7IEciDLGylE+8OEhrgV9KIZOR1L0fKSTzVzkVnssBVTi7mF2oGOmFIIX
 wDhMMPndHWwPVxMkGspGsevtspvHPhqsxvjLmcRi+vYJ+uvl5K8evme7HZ7Iaq+hH6IO
 gf2YUtR2yWM6ZPiYulrCzlEoBrtEqUj1W/tZSKgKai/Bo2yVtjyKY67CpngbpsbA6YcV
 P/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y9AW+fkUrXuwDSItggnbypCfN/Kt8Ehf1WvwBsOiyX4=;
 b=onLZePLaTvqFBOz4Be9P87sO7FSyNL+HoF6s+88tJGzaif4FGS+6LshSXNZpy5F2JX
 M/T3aAa3XgL9kNTw+D08c2uFP+oqpJngJsjgAoz515XLNm5aSUJoHOzkY5FiMdiSyk+X
 tV+wOS2B7HfB84i2wAPgaS1u8kBO/yFySqG4BEM+/RQ8nRQWSYuJLwNEuIUylhLeKdwy
 qD+7zTsBBfYst2cmJfimtwiBV9ziZygl5JW5J4iOTINyM5QMucJQr57XRKGgjw9Jbjk4
 1atCUSGb/UFhk8TYeTBfkz4GsONb6lhSs45obR91hYrclKe3WarZG+XWcSqlMc23G6iw
 h5Jw==
X-Gm-Message-State: ANhLgQ1qmvY/yZHty+bKau7JxoLB2A/oQLH7uu7CDjMN1HVzerrrkqwk
 Z/EewFObKtIxMChkSPSX9+VJy0/Ctpk=
X-Google-Smtp-Source: ADFU+vt2KQ7hy70StOZQwy3l8qK2rwGMuNtgStNN+sDz9xiUxITSahfKKJUxkP4MjyciFoRYJD6vbQ==
X-Received: by 2002:a62:7a82:: with SMTP id v124mr10983254pfc.10.1585264158220; 
 Thu, 26 Mar 2020 16:09:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/31] target/arm: Implement SVE2 integer absolute difference
 and accumulate
Date: Thu, 26 Mar 2020 16:08:38 -0700
Message-Id: <20200326230838.31112-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  6 ++++++
 target/arm/translate-sve.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 9bf66e8ad4..6d565912e3 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1266,3 +1266,9 @@ URSRA           01000101 .. 0 ..... 1110 11 ..... .....  @rd_rn_tszimm_shr
 
 SRI             01000101 .. 0 ..... 11110 0 ..... .....  @rd_rn_tszimm_shr
 SLI             01000101 .. 0 ..... 11110 1 ..... .....  @rd_rn_tszimm_shl
+
+## SVE2 integer absolute difference and accumulate
+
+# TODO: Use @rda and %reg_movprfx here.
+SABA            01000101 .. 0 ..... 11111 0 ..... .....  @rd_rn_rm
+UABA            01000101 .. 0 ..... 11111 1 ..... .....  @rd_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7556cecfb3..42ef031b77 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6361,3 +6361,28 @@ static bool trans_SLI(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_fn2i(s, a, arm_gen_gvec_sli);
 }
+
+static bool do_sve2_fn3(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        unsigned rd_ofs = vec_full_reg_offset(s, a->rd);
+        unsigned rn_ofs = vec_full_reg_offset(s, a->rn);
+        unsigned rm_ofs = vec_full_reg_offset(s, a->rm);
+        fn(a->esz, rd_ofs, rn_ofs, rm_ofs, vsz, vsz);
+    }
+    return true;
+}
+
+static bool trans_SABA(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sve2_fn3(s, a, arm_gen_gvec_saba);
+}
+
+static bool trans_UABA(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sve2_fn3(s, a, arm_gen_gvec_uaba);
+}
-- 
2.20.1


