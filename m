Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A17AC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27803208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVHp5i6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27803208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctHB-0002PX-9r
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsib-0003pu-QL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsia-0008I0-2y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiX-0008Ff-LA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:42 -0400
Received: by mail-wr1-x429.google.com with SMTP id n9so10259275wru.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HRNOi6ICfUn/2quaFaB6uVzcnt5OTh3SvAEE3S908PQ=;
 b=rVHp5i6mIKYkQ0TlSbSVOO5oo2WrzkzdJgj6SOLL6kAWn2xmQ1w57jkpU7hz5cWdnp
 Jq09qll9pCgO/PP8cNu4M1s4lm7dJowW++VyONJGNG0eGtcn8fxL+Qj/a11mGBAa2G9V
 7OxanCZI2qDVUY9f66kv5qzi2mAeTQ+3nXs2rZnzhvL3bg/vcAM+2hyI4F7ReUOtA+Hx
 JlpjN9X3KXTKTFH13GQNC8aDM8Aaihj6dL3lJwclQyxLGIGQZJPbUj1l/V34nngHOkOy
 vSZsq+qOND4chLwnPS0zFQ1UpFi+586RHuMDxP3mofMzeOBIEoDfJcaSrSqtPesQZERo
 XiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HRNOi6ICfUn/2quaFaB6uVzcnt5OTh3SvAEE3S908PQ=;
 b=EZNWDlya3fIu/+KAnla+VUe31dqQe3P+L+QQe5MtPmWx2hlz/amTEpammMUl4pIOPB
 dY1syLLMQnXyRumsDdQgNW5bM1EPnBOe6/QRVaFHExVzd61YSSVrdOgseQMZCQQICmv2
 Ql728/xlfhVzdHG/geo9iGf5HDXvxVP9XfsWh0gfO1d9H99aAkqfsYhc1yH5ODjYih8W
 szh0ZDl9Kz+2GYY/DdWOZul6/nWnfT+bV8peVj7UDUvPm2/2ZP4olw1kHjBTOKcxcNx6
 4kIlxRVm6DmyV9CZUmSjCXdCavC6bm5F9GJIWja3D1OyaDDsiPNj6uZtOH51mQRGGtUa
 DDvA==
X-Gm-Message-State: APjAAAVylMkTlv3uEyDSJ8qGLrWO1wXaEHMmqZepdwebmTAlfMpeiVqC
 SngN2wqnvEtd5dkNjnlk1sEuEXS3nprrIw==
X-Google-Smtp-Source: APXvYqxEoOqpoz0lysC9VREAN1dyH8CQWi1QKEwHcY1hlrKttOsx+YwIQCnLIfvGouRpBpjnoFlfvQ==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr14240622wrj.37.1560782079347; 
 Mon, 17 Jun 2019 07:34:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:11 +0100
Message-Id: <20190617143412.5734-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 23/24] target/arm: Fix typos in trans function
 prototypes
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

In several places cut and paste errors meant we were using the wrong
type for the 'arg' struct in trans_ functions called by the
decodetree decoder, because we were using the _sp version of the
struct in the _dp function.  These were harmless, because the two
structs were identical and so decodetree made them typedefs of the
same underlying structure (and we'd have had a compile error if they
were not harmless), but we should clean them up anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190614104457.24703-2-peter.maydell@linaro.org
---
 target/arm/translate-vfp.inc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 8b732761f26..390441a1104 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -868,7 +868,7 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
     return true;
 }
 
-static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_sp *a)
+static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
 {
     TCGv_i32 tmp;
 
@@ -943,7 +943,7 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
     return true;
 }
 
-static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
+static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
 {
     uint32_t offset;
     TCGv_i32 addr;
@@ -1533,7 +1533,7 @@ static void gen_VMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_sp *a)
+static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLA_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1571,7 +1571,7 @@ static void gen_VMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_sp *a)
+static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1613,7 +1613,7 @@ static void gen_VNMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
+static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1647,7 +1647,7 @@ static void gen_VNMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
+static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1657,7 +1657,7 @@ static bool trans_VMUL_sp(DisasContext *s, arg_VMUL_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_muls, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_sp *a)
+static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_muld, a->vd, a->vn, a->vm, false);
 }
@@ -1681,7 +1681,7 @@ static void gen_VNMUL_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     gen_helper_vfp_negd(vd, vd);
 }
 
-static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_sp *a)
+static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMUL_dp, a->vd, a->vn, a->vm, false);
 }
@@ -1691,7 +1691,7 @@ static bool trans_VADD_sp(DisasContext *s, arg_VADD_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_adds, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
+static bool trans_VADD_dp(DisasContext *s, arg_VADD_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
 }
@@ -1701,7 +1701,7 @@ static bool trans_VSUB_sp(DisasContext *s, arg_VSUB_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_subs, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
+static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
 }
@@ -1711,7 +1711,7 @@ static bool trans_VDIV_sp(DisasContext *s, arg_VDIV_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_divs, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_sp *a)
+static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
@@ -1774,7 +1774,7 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
     return true;
 }
 
-static bool trans_VFM_dp(DisasContext *s, arg_VFM_sp *a)
+static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
 {
     /*
      * VFNMA : fd = muladd(-fd,  fn, fm)
@@ -2214,7 +2214,7 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
     return true;
 }
 
-static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_sp *a)
+static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
 {
     TCGv_ptr fpst;
     TCGv_i64 tmp;
@@ -2270,7 +2270,7 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
     return true;
 }
 
-static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_sp *a)
+static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
 {
     TCGv_ptr fpst;
     TCGv_i64 tmp;
-- 
2.20.1


