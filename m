Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5FC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA6E2176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHF8Q9QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA6E2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MED-0008El-QY
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7u-0004lz-6c
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7s-0005yf-Uu
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:58 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7s-0005yJ-PI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:56 -0500
Received: by mail-pj1-x1041.google.com with SMTP id f2so320041pjq.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N2dqLxgdt7qGgHLw+VE7Z3TBav3OjyXi4mGQvjqJ7no=;
 b=dHF8Q9QAoA5L8xBMfhYW2OB4bDW1HYNPABGNrIYqYAG9fRvqaMdPbdjSCfeElQEpQy
 PwCiAAwsvjKtQ+3h0B0tP+eINa904zjIyQS61S53tcPJzYG34vjzfhgXPiveG9siUzGG
 DsK1Wz1XoSVZVWxXU+WOkbMXiOb4L0wmW8XestPSjCD4mNMxNQZPR4Xt2VKp1wtzYiPV
 NpQhAqncAKVGABN3DLqYIXbcAF0yGrb8pRON8JDmBnXFSxAvAST+BAetVXmttlwLsF0T
 oraing11oa0ncQMSbXq5/27Y1/jYfHP+Xl15hvb2h4zU3i9/RdL7V0Pe2N+Y9fgdnSeZ
 5KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N2dqLxgdt7qGgHLw+VE7Z3TBav3OjyXi4mGQvjqJ7no=;
 b=hmXhnCQsxw7h8zeybwEpZqZaJX3fQFmVyRq5aYKeM1WDP+5IFQ6UA008updt2/rsC/
 01NythYBOzd1GeFQKgbi5UWv+3uUTxlU1KqR1GIWWHhQGg1qCaSXVTOc0l1mOiK7cEWa
 tqsDSw+T9J021L+uYzYsd6IeJUWzitPFTIi2jbPbpP2OF165xXCCUVpTaNgvnLK5rYSk
 F85vhY/ENtyR0pXbvPtFTiiNTUkQuC5xUSmmU1srllm0kwOjh1tn3rfN8qveFy1I5CUz
 wiYwZutfWMDH9HW2Gzqm+c62xnDJJiz1hvnzoop1hMjcj4g6UkETtX7Vrd9M7MIe9yrw
 FwJw==
X-Gm-Message-State: APjAAAV1q4vWsxlJc4wGtvrUfmW6MGzb84nRYIxUVE/H7FBsCofO5vo7
 gM/IeHxhdOlYbAtvfnqXXaR1GPt+wEk=
X-Google-Smtp-Source: APXvYqwQHolY16JPMYvm/XiQA0Pb4sHKf6Eu1WC73tpmslS7U5qCI/Wmd0hTmX8z0urWh5LgJKgvXw==
X-Received: by 2002:a17:90a:36af:: with SMTP id
 t44mr1414093pjb.25.1582582975279; 
 Mon, 24 Feb 2020 14:22:55 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/17] target/arm: Split VFM decode
Date: Mon, 24 Feb 2020 14:22:31 -0800
Message-Id: <20200224222232.13807-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

Passing the raw o1 and o2 fields from the manual is less
instructive than it might be.  Do the full decode and let
the trans_* functions pass in booleans to a helper.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 1964af3ea5..41aa67c133 100644
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
@@ -1828,12 +1828,12 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
 
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
@@ -1849,7 +1849,27 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
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
@@ -1905,12 +1925,12 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
 
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
@@ -1926,6 +1946,26 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
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


