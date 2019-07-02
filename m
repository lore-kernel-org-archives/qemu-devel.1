Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9AAC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A8620659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNuTbdqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A8620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGXB-0002KX-F8
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51131)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiGKH-0005zu-5W
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiGKG-0008Ve-48
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiGKF-00081H-O6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id u18so710075wru.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=dFW5jDXd47eVSqWLVl3XFZrae6CQN8W7M3/mFqL/1BQ=;
 b=RNuTbdqRYnqxHkpVXF+a4IgBnoP7Dk/E0esPNj1XgmnlHR2ZaFxt/VFh36jBxQXWKb
 nrgn8Zgo8y7vNbjHTZo6AtYUvO2b6NCdzUKDbY/lK1C8pRbqgRGmP+BUtwwgNpNPWivs
 xY0uiyEUSifY/IOYs/MBJ3/qzFvCeqjPEYqvHZkaT2qa/ghh2t35b2WIptUJjCVBJMT/
 mqa3LN6JNqVjULiG80SsNMQ6MFJSnZOiv3084KH0hWYvKV5g7BSyRh3+GeiNbgXtrgKS
 fnO7wAwBLbytf/Hc+oLtBh88oJ4RlX8WsMNXos4MK0cj2mi9zpOJCOppFQdYWAI78d/b
 uVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dFW5jDXd47eVSqWLVl3XFZrae6CQN8W7M3/mFqL/1BQ=;
 b=hcRzQ8LxNmcaKC8PuEKfK66dlhaVWjcYDZgmGqh7YMMlnQ9TbRxSImgYdCX34d+dAx
 N04hxCBcqH60Iam2BB7TM2SSRRhEykDIdSTnvHwtBh3fdKVK68gwQbdheien7f5qwus7
 aKNFaiDWkRc3/6n74e4by/A4ooAR5RiZ8Lg3eH8lj6LcIv0lmQ9P3FwsyirOSOQo2Ra0
 dyMi3Z3rZHZWSCl9ylDZEZK2kcDJvKC9DF33RxpILE89rwgTUrPms7NKnYSjo/8lgRfR
 8rvVO5QFbvrNGerlQ8XrGgIRJE3PCCOy1hYfc1lCQ/iKFox5na7PkRT2cHuFbvrWrl+i
 Wybw==
X-Gm-Message-State: APjAAAVjgpaLAEj/HFYTWRmmfLcCtwFUhJbqAQQA4PrcXFt88WgABMNG
 D50bJ74L9K992XmoGGZrnfCJs2f5szW1eg==
X-Google-Smtp-Source: APXvYqyx4883bHkDua9NksEdabG+NP2IL4XKvNp3QkORzM7+RoTBhrDMPqQ8i6fQTP9/sDpG/wlbBg==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr22952767wrs.105.1562064454008; 
 Tue, 02 Jul 2019 03:47:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id f7sm16460138wrv.38.2019.07.02.03.47.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 03:47:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:32 +0200
Message-Id: <20190702104732.31154-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH for-4.1] target/arm: Fix sve_zcr_len_for_el
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

Off by one error in the EL2 and EL3 tests.  Remove the test
against EL3 entirely, since it must always be true.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

This bug resulted in an infinite loop in the kernel's initialization
of SVE with EL2 and VHE enabled.  It's probably worth including in 4.1,
even though VHE itself won't be included.


r~

---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b87bf903a1..210fa06188 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5570,10 +5570,10 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
     if (el <= 1) {
         zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
     }
-    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+    if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
     }
-    if (el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
         zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
     }
     return zcr_len;
-- 
2.17.1


