Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260B6C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE55F2465D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmrUFjhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE55F2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fcU-0002Uz-5i
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVc-0004jg-Hn
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVb-0000M1-71
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:12 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVb-0000L1-18
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:11 -0500
Received: by mail-pf1-x442.google.com with SMTP id k29so5238023pfp.13
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=08YWOW4uPN/K//8Sv/iAQdt6yoHtAxwQIa1pxOQkXxw=;
 b=CmrUFjhRgBmeKXvH7NHnFbQpBEyRRrlSu7RRgr3lzAklwKujje0eh+AYgMgXpK6m4N
 TVLWc9TCl7MoM3pCMiJdrqqxOqQm44RpTr2wTO9iOD9gFB3o4eWjrWZxCGo1rFoY845U
 9lWE8hrarjlIhuEKpHXDjqhRUNs2Rzqv86OLZYRMUph/vabVocw7b+PDYLeEhVZYg9cp
 BMVOi5HW5+IW/nLMeGMhZMSRx5thMi/Cw1w5mKg2WpXDHrNuKj+K5Zpl8sfBlJpvYId1
 9jVeP/jQIZ3HUY13+F2IMHAoTwaGJ4UOX8lioPP9A3s1NyEPtv/jBtVjK147BzLISkZQ
 DYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=08YWOW4uPN/K//8Sv/iAQdt6yoHtAxwQIa1pxOQkXxw=;
 b=iiAWhF/s9T5s/bqEjXPZfbB6smzYMOIqwfkfL6mNlhpVYxHAMRv9KWloaRxBnW6JIo
 2ezEcNhFwu85JFxYem1PoXvr5HBdqyaU2vk7lQlHf8iKA/cqDEtHVg5u9KeuDdFwbOSD
 aHjLqMFaLEdGepog0nm+omM1Jjk9D2lFoDYtOPB7lFddX0J2SvnWIZpQa8eoHzy+nZ0D
 jih3VqA59W4yL78WlLXyn79qmeAqRQxdIa/Nd467F6dHK/9/DiVwpwq1MuEnBpLenqRR
 mTORytGlWyJA5jM8nzCHVXgDUAAV9VqmpGSMwLT6NcF2pqV47QY27UUr4kG2i9OiOltr
 qz7g==
X-Gm-Message-State: APjAAAVDCY7fY+m5hR4FiO4qElDMFBvBkPgWak2Drw/Fo3XuGzlBxREO
 Nyn5FLYEfOgzEM4QfpDitsLCAfxyH/U=
X-Google-Smtp-Source: APXvYqyjCEfys8bdeZTdZ9W4WCUhcOq/eaMvVeUl90poWPjK0vBSR9M5n70oPGLiQuS0YOLDyNPcXw==
X-Received: by 2002:a63:7f5c:: with SMTP id p28mr4977435pgn.212.1581704169483; 
 Fri, 14 Feb 2020 10:16:09 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/19] target/arm: Split VFM decode
Date: Fri, 14 Feb 2020 10:15:46 -0800
Message-Id: <20200214181547.21408-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Passing the raw o1 and o2 fields from the manual is less
instructive than it might be.  Do the full decode and let
the trans_* functions pass in booleans to a helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp.decode          | 17 +++++------
 target/arm/translate-vfp.inc.c | 52 ++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 4f294f88be..5fd70f975a 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -130,14 +130,15 @@ VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 ....        @vfp_dnm_d
 VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
-VFM_sp       ---- 1110 1.01 .... .... 1010 . o2:1 . 0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=1
-VFM_dp       ---- 1110 1.01 .... .... 1011 . o2:1 . 0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=1
-VFM_sp       ---- 1110 1.10 .... .... 1010 . o2:1 . 0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=2
-VFM_dp       ---- 1110 1.10 .... .... 1011 . o2:1 . 0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=2
+VFMA_sp      ---- 1110 1.10 .... .... 1010 .0. 0 ....       @vfp_dnm_s
+VFMS_sp      ---- 1110 1.10 .... .... 1010 .1. 0 ....       @vfp_dnm_s
+VFNMA_sp     ---- 1110 1.01 .... .... 1010 .0. 0 ....       @vfp_dnm_s
+VFNMS_sp     ---- 1110 1.01 .... .... 1010 .1. 0 ....       @vfp_dnm_s
+
+VFMA_dp      ---- 1110 1.10 .... .... 1011 .0.0 ....        @vfp_dnm_d
+VFMS_dp      ---- 1110 1.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
+VFNMA_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
+VFNMS_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
 VMOV_imm_sp  ---- 1110 1.11 .... .... 1010 0000 .... \
              vd=%vd_sp imm=%vmov_imm
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 8f2b97e0e7..b5f3feaf8d 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1784,7 +1784,7 @@ static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
+static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
 {
     /*
      * VFNMA : fd = muladd(-fd,  fn, fm)
@@ -1823,12 +1823,12 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
 
     neon_load_reg32(vn, a->vn);
     neon_load_reg32(vm, a->vm);
-    if (a->o2) {
+    if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negs(vn, vn);
     }
     neon_load_reg32(vd, a->vd);
-    if (a->o1 & 1) {
+    if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negs(vd, vd);
     }
@@ -1844,7 +1844,27 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
     return true;
 }
 
-static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
+static bool trans_VFMA_sp(DisasContext *s, arg_VFMA_sp *a)
+{
+    return do_vfm_sp(s, a, false, false);
+}
+
+static bool trans_VFMS_sp(DisasContext *s, arg_VFMS_sp *a)
+{
+    return do_vfm_sp(s, a, true, false);
+}
+
+static bool trans_VFNMA_sp(DisasContext *s, arg_VFNMA_sp *a)
+{
+    return do_vfm_sp(s, a, false, true);
+}
+
+static bool trans_VFNMS_sp(DisasContext *s, arg_VFNMS_sp *a)
+{
+    return do_vfm_sp(s, a, true, true);
+}
+
+static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 {
     /*
      * VFNMA : fd = muladd(-fd,  fn, fm)
@@ -1893,12 +1913,12 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
 
     neon_load_reg64(vn, a->vn);
     neon_load_reg64(vm, a->vm);
-    if (a->o2) {
+    if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negd(vn, vn);
     }
     neon_load_reg64(vd, a->vd);
-    if (a->o1 & 1) {
+    if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negd(vd, vd);
     }
@@ -1914,6 +1934,26 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
     return true;
 }
 
+static bool trans_VFMA_dp(DisasContext *s, arg_VFMA_dp *a)
+{
+    return do_vfm_dp(s, a, false, false);
+}
+
+static bool trans_VFMS_dp(DisasContext *s, arg_VFMS_dp *a)
+{
+    return do_vfm_dp(s, a, true, false);
+}
+
+static bool trans_VFNMA_dp(DisasContext *s, arg_VFNMA_dp *a)
+{
+    return do_vfm_dp(s, a, false, true);
+}
+
+static bool trans_VFNMS_dp(DisasContext *s, arg_VFNMS_dp *a)
+{
+    return do_vfm_dp(s, a, true, true);
+}
+
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
     uint32_t delta_d = 0;
-- 
2.20.1


