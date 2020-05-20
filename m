Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F743C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34D4206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNPpU6C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34D4206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPXD-0003FK-4N
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM2-0008Tk-Oo
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:54 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM1-0001xj-C8
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:54 -0400
Received: by mail-ej1-x643.google.com with SMTP id se13so3922029ejb.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6AuJncFd/Ok9B8fiGwq2VbdoGBxgxt1TjrXD5Ap1HKs=;
 b=tNPpU6C0A1kGGe5FJwWmzvRV2JCheNZ5RR5pmpB5Jqzpx4yFl8Dc5WzLzIUVZKuHWV
 d00BFjBmjSPHRF/UEwL41UbJcXY4/AvplY8J2NsqKwcHbPZa5lYoxozEZCmYQn6Y0OZV
 ZgXIM2fjJh4wKqJ3ZpCH23Aindr/nUJbRo/y55zdLvz6uV5rqaSzeKgBf3q6DTxHEas+
 oW5fnjYcQM6GQ4yPxGDL6Mufssf5Nh0e/QpWksBuzckKBSYt+dU+Ti3/wl9LQCMqru+z
 pIhHm+leAVRHkeUXvkRNdzynhyaMgBuusHXQxm+Y50un12Z5LBOTtADBIM+smYwb7mdu
 mbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6AuJncFd/Ok9B8fiGwq2VbdoGBxgxt1TjrXD5Ap1HKs=;
 b=tEh/0Ae52sLWMPeGTwgCz9EYIPAsYFjTcPeuXHa7Ypy5GnL+l4MJeRTkf0FWr1fQnX
 3GU3SvL+5+Wq8SLU7fZj8efyv+uCXU2Smg5YrnZT+oZkrftkxJcXd/lrDMGCO8EBZEtg
 MdV4mCJZIUyhs9jwQ/cYoMXCWIu+z9XuiXNGFou96khkSdJlx4Mma5SLxaTPmyXoX1G+
 hjTf0Hw4QKhVtAWoSnwppL3m+xf8E3VE0jR3/rvX9ub6e6Pfz/jd1IeqShe1ilSjCGS2
 kRVEZ97nvWVizeQ57gk/2JEpLW0k/+cJhAWaGBuBmpObFyzS4cTe6LSJYAsHOodOtJLb
 g6rA==
X-Gm-Message-State: AOAM533tWeOue9oTR43QtBpemDcK7y5L7BRAsGcX+/tL2SZenI8OPeFJ
 fNbiXLbVuH+9b6UiRH9SsgxOa/r6w+Y=
X-Google-Smtp-Source: ABdhPJzJ5ktxU/DFfct0/NEZuxHcZ5OPqiNYMXEZdN0C8R9s+bULExW/9OjLq/RyQP0xRdaIc1WdPg==
X-Received: by 2002:a17:906:b2c6:: with SMTP id
 cf6mr3855268ejb.210.1589983551950; 
 Wed, 20 May 2020 07:05:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b16sm1873467edu.89.2020.05.20.07.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B781B1FF92;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 06/15] tests/fp: split and audit the conversion tests
Date: Wed, 20 May 2020 15:05:32 +0100
Message-Id: <20200520140541.30256-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split the float conversion tests into separate groups and audit the
tests to check what is still broken. I was able to enable a bunch of
tests that had been missed before:

  all the float to float conversions
  ui32_to_extF80
  ui64_to_extF80
  extF80_to_ui32
  extF80_to_ui32_r_minMag
  extF80_to_ui64
  extF80_to_ui64_r_minMag

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e6d87fcbf0e..a00ccc94b8b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -687,11 +687,26 @@ test-softfloat = $(call quiet-command, \
 			(cat $2.out && exit 1;), \
 			"FLOAT TEST", $2)
 
-# Conversion Routines:
+# Conversion Routines: Float to Float
+# FIXME: f32_to_f128 (broken), f64_to_f128 (broken)
+# FIXME: f128_to_f32(broken), f128_to_f64 (broken)
+# FIXME: f128_to_extF80 (broken)
+check-softfloat-conv-f2f: $(FP_TEST_BIN)
+	$(call test-softfloat, \
+		f16_to_f32 f16_to_f64 \
+		f16_to_extF80 f16_to_f128 \
+		f32_to_f16 f32_to_f64 \
+		f32_to_extF80 \
+		f64_to_f16 f64_to_f32 \
+		extF80_to_f16 extF80_to_f32 \
+		extF80_to_f64 extF80_to_f128 \
+		f128_to_f16, \
+		float-to-float)
+
+# Conversion Routines: Int and Uint to Float
 # FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
-#        ui32_to_f128 (not implemented), extF80_roundToInt (broken)
-#
-check-softfloat-conv: $(FP_TEST_BIN)
+#        ui32_to_f128 (not implemented)
+check-softfloat-conv-to-float: $(FP_TEST_BIN)
 	$(call test-softfloat, \
 		i32_to_f16 i64_to_f16 \
 		i32_to_f32 i64_to_f32 \
@@ -701,7 +716,12 @@ check-softfloat-conv: $(FP_TEST_BIN)
 		ui32_to_f16 ui64_to_f16 \
 		ui32_to_f32 ui64_to_f32 \
 		ui32_to_f64 ui64_to_f64 \
+		ui32_to_extF80 ui64_to_extF80 \
 		ui64_to_f128, uint-to-float)
+
+# Conversion Routines: Float to integers
+# FIXME: extF80_roundToInt (broken)
+check-softfloat-conv-to-int: $(FP_TEST_BIN)
 	$(call test-softfloat, \
 		f16_to_i32 f16_to_i32_r_minMag \
 		f32_to_i32 f32_to_i32_r_minMag \
@@ -718,10 +738,12 @@ check-softfloat-conv: $(FP_TEST_BIN)
 		f16_to_ui32 f16_to_ui32_r_minMag \
 		f32_to_ui32 f32_to_ui32_r_minMag \
 		f64_to_ui32 f64_to_ui32_r_minMag \
+		extF80_to_ui32 extF80_to_ui32_r_minMag \
 		f128_to_ui32 f128_to_ui32_r_minMag \
 		f16_to_ui64 f16_to_ui64_r_minMag \
 		f32_to_ui64 f32_to_ui64_r_minMag \
 		f64_to_ui64 f64_to_ui64_r_minMag \
+		extF80_to_ui64 extF80_to_ui64_r_minMag \
 		f128_to_ui64 f128_to_ui64_r_minMag, \
 		float-to-uint)
 	$(call test-softfloat, \
@@ -729,9 +751,14 @@ check-softfloat-conv: $(FP_TEST_BIN)
 		f64_roundToInt f128_roundToInt, \
 		round-to-integer)
 
+.PHONY: check-softfloat-conv
+check-softfloat-conv: check-softfloat-conv-f2f
+check-softfloat-conv: check-softfloat-conv-to-float
+check-softfloat-conv: check-softfloat-conv-to-int
+
 # Generic rule for all float operations
 #
-# Some patterns are overidden due to broken or missing tests.
+# Some patterns are overridden due to broken or missing tests.
 # Hopefully these can be removed over time.
 
 check-softfloat-%: $(FP_TEST_BIN)
-- 
2.20.1


