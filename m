Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9510DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D7F2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z15sDeMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D7F2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmW5-0007um-I9
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAq-0006Wn-Gh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:12 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:55598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAo-0002r9-TU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:12 -0400
Received: by mail-pj1-x102a.google.com with SMTP id ne5so1954051pjb.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NtZuo563GEEgh3r3rqbTdmgm0tBrXJmij7aOVi/8e+k=;
 b=z15sDeMV4nqal4zoyDFLzDS/IyrcC0UH8DHVZibhhhmvI1lBO65fQO/LpaQwOAWC/F
 zzg/nVzdjp/L0njsaQBHEv1cOjzcgGvXWO9H97fcMrZuttaqLkjVrT+aYQI0waDZBug4
 OXuHzrVJNyXlLY4HZo+DzvEe+v/yjRArVtvQaXvOiegO7KM3Vs9HstijjO6KJjk5JH00
 9nXmlMY1++dKvrsZsuOYQ/LQdRru9lcf8oGNt+U0U/kHDWGAEza67AT0BwQZVGz0LShN
 CTtse/OlOyLsdYc9doagHfC0gZJcOYSntkQm0fgWmMbPZxK8mxGfPk9VZ9BBgfgps24n
 fB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NtZuo563GEEgh3r3rqbTdmgm0tBrXJmij7aOVi/8e+k=;
 b=PfE7f5Q/Ir1dmse8Q/1JihTfhJl7MlFT7h/VdOJRMbiU4oTOoM7qKD9uYQTX6yNL3P
 CoyRDejMlfBFRpsXvxlPFL2v0mop7bdPP6+lYbkbKlpGywi4VVX+WIwMjEpA7gOnj+iT
 mn6VvuL/yJQUvfLTod8LOOOeJbOdnW4ynTLFWkGD8oSrwrdqwDbcVhK5G37I2cgZ/ZEP
 p3uLzSKwUeGVwEWY3hqXbEftVgR1Ip8YxplzjTH+uH4D2lfiFYvjX/FqAdJk9BGaCA8g
 sCLDkrIyRUfp6IYTb45wr87nQm4GkVWipo05tV9LqvSrCKk+Jji/1aFbDtj3O6Rb8PNf
 kLGQ==
X-Gm-Message-State: AOAM532Q2/adRk+QybtAcL0Q/rA7+Ra020Zwr/LCm/ntLadsrnlMm71K
 EISTuShZt42ZvQyL54XHOFIcNyMpPWg=
X-Google-Smtp-Source: ABdhPJy1FwCPNFrj7b7IC1upYchoiWep+i8C07PnVFb8V3YOX+DiDX4XZKCLdh5zn2aQIx085PPWDg==
X-Received: by 2002:a17:90a:bf13:: with SMTP id
 c19mr2181320pjs.186.1592454549117; 
 Wed, 17 Jun 2020 21:29:09 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id mu17sm972324pjb.53.2020.06.17.21.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:29:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 038/100] target/arm: Implement SVE2 integer absolute
 difference and accumulate
Date: Wed, 17 Jun 2020 21:25:42 -0700
Message-Id: <20200618042644.1685561-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  6 ++++++
 target/arm/translate-sve.c | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 90a9d6552a..b5450b1d4d 100644
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
index 2bc20503e7..45b24826ac 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6004,3 +6004,24 @@ static bool trans_SLI(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_fn2i(s, a, gen_gvec_sli);
 }
+
+static bool do_sve2_fn_zzz(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zzz(s, fn, a->esz, a->rd, a->rn, a->rm);
+    }
+    return true;
+}
+
+static bool trans_SABA(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sve2_fn_zzz(s, a, gen_gvec_saba);
+}
+
+static bool trans_UABA(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sve2_fn_zzz(s, a, gen_gvec_uaba);
+}
-- 
2.25.1


