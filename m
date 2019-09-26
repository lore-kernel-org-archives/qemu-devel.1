Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD34C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A01F222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCb0TpPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A01F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYsS-0008RW-OJ
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcV-0007tt-71
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcS-0006Pq-V7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcS-0006Oz-NE
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id a6so3882713wma.5
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i0QkvpolJsshCsGgdChMl33I7vxXQro3P2qj7QMswZM=;
 b=QCb0TpPLkbNs1+QxQ5OqqwBgFiXWiARZjlN2eQlc3fnBrVs/X/q3UEp6HiNvLamm+m
 tc9nlMH7VI1XJAwk2UZdycXlft7wEMty9OoiTtiPRmDu64SUvqhZbPsuvi2su/ByV6MW
 HFxvVko7eQHeQZsG4irKL3wVyyDegFg5K0Whb0rj9mO+Dk9VTYdpL+55TdO77qB5RaJm
 ddtN9vLAJO23fQgi41osV1CjkEcujdKpPKQgjgQT8CoEFwUNhwVeRySy+yevx/PcNd8Y
 CQeGjThZ3sozLFB4F9ydjqsYYCW8oKfsXU37VceuP/XfqHiEunR/k/l6U8MFeAkdy28N
 kTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i0QkvpolJsshCsGgdChMl33I7vxXQro3P2qj7QMswZM=;
 b=W30nQoUSG3T5+zzzpn5thRYJA7Bz6E86H3rxo5e83PA75hdqKoKTstqShB/v4BpAsu
 FJnDRNrzPwroS47D/TkcO2CFPXUltZVBG+hT91HfxWZak2+oCRmDRoM4k0Coc4cbxQnr
 BjZwcCamR60M6VsbTDuXrQ5okHK2WIJEYOcazOAx63+GetbCI8NJAzNhfqYPinsuyshY
 72kFQk6QLSDmZcyOHRUz0rZlP9Sr52rrMxB9fdrIBw0e4n2LfQSHX4UHdy0krSR/o5nA
 Qb1zPvu6cPdlbptM8tDwKbEeRY3BRJhb0GPg3u/IPxDEA3Q5DTh4SIa9GMSo6Nql+ZwJ
 BmmA==
X-Gm-Message-State: APjAAAVc7DBxK2RcSpEggJzKx1gw5WEpxkryJlTvGQhl2o7NgnrYZiOP
 MbOyalXPOyCuBCPjlnPQXsYFkA==
X-Google-Smtp-Source: APXvYqyoiAm1s+ekYU4pciXdOgKFaZWZVVQB7F9/fkv5DaS1GFlaDSVKUg3AIk8gDATNUldKaqt3mQ==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr3816061wmk.148.1569522959493; 
 Thu, 26 Sep 2019 11:35:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p7sm4650225wma.34.2019.09.26.11.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B76021FF93;
 Thu, 26 Sep 2019 19:35:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/28] target/alpha: Mask IOV exception with INV for user-only
Date: Thu, 26 Sep 2019 19:35:31 +0100
Message-Id: <20190926183553.13895-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The kernel masks the integer overflow exception with the
software invalid exception mask.  Include IOV in the set
of exception bits masked by fpcr_exc_enable.

Fixes the new float_convs test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-7-richard.henderson@linaro.org>

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 1b3479738b..55d7274d94 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -58,6 +58,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
      */
     uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
     fpcr |= soft_fpcr & (FPCR_STATUS_MASK | FPCR_DNZ);
+
+    /*
+     * The IOV exception is disabled by the kernel with SWCR_TRAP_ENABLE_INV,
+     * which got mapped by alpha_ieee_swcr_to_fpcr to FPCR_INVD.
+     * Add FPCR_IOV to fpcr_exc_enable so that it is handled identically.
+     */
+    t |= CONVERT_BIT(soft_fpcr, FPCR_INVD, FPCR_IOV);
 #endif
 
     t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
-- 
2.20.1


