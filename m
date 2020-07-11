Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699CC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46DB2078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cenM+MWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46DB2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDX8-0005Gw-07
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMV-0004oU-My
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:41698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMT-0006Pe-Qq
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id q17so3687814pfu.8
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wa+AHpqfEWhhgAfAEPD77aSGzH6coLYk43PBINkaick=;
 b=cenM+MWvd+q6dS1fWa9dcryCtU9tqFv/J5LhnPRuWstqtD7yp/fSGrylY09E0VfRvu
 MSnoZTO82M4tyin7O58AzWzZzQtrrjTApFdnwisZ9YxCG8yZZ5GcTBCNS3bncTaLnQLY
 o65NWo/fC8rF34acA8uAXv7X+gjx5cscQwYaJ6pnN8nxN2eHzXTnzolHzMLonZUqh/uS
 vdCUNokm4Y50eh/NH0exwuYc9PAS2w+jPOmj4A9TfAlsJeE5AxMcr2ED2aBw0geWt1W/
 9TsqSaMf5uvZ3XVyoim9z06YoG4/y7qLVu0ztxTh0AbzfvUxbvl0fiqqWBYPBnGmKII3
 1KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wa+AHpqfEWhhgAfAEPD77aSGzH6coLYk43PBINkaick=;
 b=IqeD4tmbzSox7zf48bkkpsCs8/SK9iF76dJkYZ8ZWV00qYL4NVVOT/xNGLpsFJO9BH
 FfyG882pBbLlhlzt5ZGdT/khO1onlIDBIk8ymYIyEc9+IuPfvHinrUt/6xFzk2m1YsFl
 TR9vWaeB/RxLOJ/LItQJbK+Ly5FLpsQkho4KRyWjz7gC4azfNacbViGlfJsPCSWqFFJk
 vc2WPkGF7XvQ5+gr3ipCu1Hz0XGbEo286QaR+4EhH/45F4jUV9MwLwRDKr+br6Df0Tiu
 64LfJlJuKsEXM/12f8LKG6kR6J6+49C4LE4h6MvJPYpUaY8Uw0zQtISwThQDLaENSsF4
 uang==
X-Gm-Message-State: AOAM5317zlEV98C9/0g4awj8nTaykE5xGLBOfPZlCvl8zK/9rezP5Zki
 HPv+kaNi8nJHvTtFBKGlZ2j21A/9
X-Google-Smtp-Source: ABdhPJzb1N+4NndDuty7Lfk8Zfzw4BKwTPdq8tnl/Gzch2gYc2MXqeqFuHgrBGc6BF3SNjot8O/eaA==
X-Received: by 2002:a62:7942:: with SMTP id u63mr25753350pfc.54.1594465683819; 
 Sat, 11 Jul 2020 04:08:03 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:08:03 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/22] tests/tcg/xtensa: add fp0 div and sqrt tests
Date: Sat, 11 Jul 2020 04:06:53 -0700
Message-Id: <20200711110655.20287-19-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test exact division/sqrt DFPU sequences.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_fp0_div.S  | 82 ++++++++++++++++++++++++++++++++
 tests/tcg/xtensa/test_fp0_sqrt.S | 76 +++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_fp0_div.S
 create mode 100644 tests/tcg/xtensa/test_fp0_sqrt.S

diff --git a/tests/tcg/xtensa/test_fp0_div.S b/tests/tcg/xtensa/test_fp0_div.S
new file mode 100644
index 000000000000..c3e7ad7bb5b3
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp0_div.S
@@ -0,0 +1,82 @@
+#include "macros.inc"
+#include "fpu.h"
+
+test_suite fp0_div
+
+#if XCHAL_HAVE_FP_DIV
+
+.macro  divs_seq q, a, b, r, y, y0, an, bn, e, ex
+    div0.s      \y0, \b
+    nexp01.s    \bn, \b
+    const.s     \e, 1
+    maddn.s     \e, \bn, \y0
+    mov.s       \y, \y0
+    mov.s       \ex, \b
+    nexp01.s    \an, \a
+    maddn.s     \y, \e, \y0
+    const.s     \e, 1
+    const.s     \q, 0
+    neg.s       \r, \an
+    maddn.s     \e, \bn, \y
+    maddn.s     \q, \r, \y0
+    mkdadj.s    \ex, \a
+    maddn.s     \y, \e, \y
+    maddn.s     \r, \bn, \q
+    const.s     \e, 1
+    maddn.s     \e, \bn, \y
+    maddn.s     \q, \r, \y
+    neg.s       \r, \an
+    maddn.s     \y, \e, \y
+    maddn.s     \r, \bn, \q
+    addexpm.s   \q, \ex
+    addexp.s    \y, \ex
+    divn.s      \q, \r, \y
+.endm
+
+.macro div_s fr0, fr1, fr2
+    divs_seq    \fr0, \fr1, \fr2, f9, f10, f11, f12, f13, f14, f15
+.endm
+
+.macro movfp fr, v
+    movi        a2, \v
+    wfr         \fr, a2
+.endm
+
+.macro check_res fr, r, sr
+    rfr         a2, \fr
+    dump        a2
+    movi        a3, \r
+    assert      eq, a2, a3
+    rur         a2, fsr
+    movi        a3, \sr
+    assert      eq, a2, a3
+.endm
+
+test div_s
+    movi        a2, 1
+    wsr         a2, cpenable
+
+    test_op2    div_s, f0, f1, f2, 0x40000000, 0x40400000, \
+        0x3f2aaaab, 0x3f2aaaaa, 0x3f2aaaab, 0x3f2aaaaa, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
+    test_op2    div_s, f3, f4, f5, F32_1, F32_0, \
+        F32_PINF, F32_PINF, F32_PINF, F32_PINF, \
+           FSR_Z,    FSR_Z,    FSR_Z,    FSR_Z
+    test_op2    div_s, f6, f7, f8, F32_0, F32_0, \
+        F32_DNAN, F32_DNAN, F32_DNAN, F32_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+
+    /* MAX_FLOAT / 0.5 = +inf/MAX_FLOAT  */
+    test_op2    div_s, f0, f1, f2, F32_MAX, F32_0_5, \
+        F32_PINF, F32_MAX, F32_PINF, F32_MAX, \
+          FSR_OI,  FSR_OI,   FSR_OI,  FSR_OI
+
+    /* 0.5 / MAX_FLOAT = denorm  */
+    test_op2    div_s, f0, f1, f2, F32_0_5, F32_MAX, \
+        0x00100000, 0x00100000, 0x00100001, 0x00100000, \
+            FSR_UI,     FSR_UI,     FSR_UI,     FSR_UI
+test_end
+
+#endif
+
+test_suite_end
diff --git a/tests/tcg/xtensa/test_fp0_sqrt.S b/tests/tcg/xtensa/test_fp0_sqrt.S
new file mode 100644
index 000000000000..585973dce6bc
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp0_sqrt.S
@@ -0,0 +1,76 @@
+#include "macros.inc"
+#include "fpu.h"
+
+test_suite fp0_sqrt
+
+#if XCHAL_HAVE_FP_SQRT
+
+.macro  sqrt_seq r, a, y, t1, hn, h2, t5, h
+    sqrt0.s     \y, \a
+    const.s     \t1, 0
+    maddn.s     \t1, \y, \y
+    nexp01.s    \hn, \a
+    const.s     \r, 3
+    addexp.s    \hn, \r
+    maddn.s     \r, \t1, \hn
+    nexp01.s    \t1, \a
+    neg.s       \h2, \t1
+    maddn.s     \y, \r, \y
+    const.s     \r, 0
+    const.s     \t5, 0
+    const.s     \h, 0
+    maddn.s     \r, \h2, \y
+    maddn.s     \t5, \y, \hn
+    const.s     \hn, 3
+    maddn.s     \h, \hn, \y
+    maddn.s     \t1, \r, \r
+    maddn.s     \hn, \t5, \y
+    neg.s       \y, \h
+    maddn.s     \r, \t1, \y
+    maddn.s     \h, \hn, \h
+    mksadj.s    \y, \a
+    nexp01.s    \a, \a
+    maddn.s     \a, \r, \r
+    neg.s       \t1, \h
+    addexpm.s   \r, \y
+    addexp.s    \t1, \y
+    divn.s      \r, \a, \t1
+.endm
+
+.macro sqrt_s fr0, fr1
+    sqrt_seq    \fr0, \fr1, f10, f11, f12, f13, f14, f15
+.endm
+
+.macro movfp fr, v
+    movi        a2, \v
+    wfr         \fr, a2
+.endm
+
+.macro check_res fr, r, sr
+    rfr         a2, \fr
+    dump        a2
+    movi        a3, \r
+    assert      eq, a2, a3
+    rur         a2, fsr
+    movi        a3, \sr
+    assert      eq, a2, a3
+.endm
+
+test sqrt_s
+    movi        a2, 1
+    wsr         a2, cpenable
+
+    test_op1    sqrt_s, f0, f1, 0x40000000, \
+        0x3fb504f3, 0x3fb504f3, 0x3fb504f4, 0x3fb504f3, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
+    test_op1    sqrt_s, f3, f4, F32_1, \
+        F32_1, F32_1, F32_1, F32_1, \
+        FSR__, FSR__, FSR__, FSR__
+    test_op1    sqrt_s, f6, f7, F32_MINUS | F32_1, \
+        F32_DNAN, F32_DNAN, F32_DNAN, F32_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+test_end
+
+#endif
+
+test_suite_end
-- 
2.20.1


