Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF435C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3382073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNXtO41R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3382073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDg1-0004Gq-JM
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdp-0001Nk-VN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdU-0000LE-E4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdR-00009C-Bc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id e16so3042370wra.7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tdNQQWE9wGAC0mH1muH1gEnZ20h4fqSH0abkP54OzAE=;
 b=mNXtO41RG3npsxp3IJbsRB3TEnEDn5hIoYivrOSJKxiG6x9r9djsgrWUKy/tPz1Txo
 7EZ+1yPfzFZ1neebWiSs90YVUlKSa8kSd7Dlrb6iqJggy3MhDpfY0fQxsyzxFP9o14fo
 YWtLiZN9uXURGJRh8yrD5Z1uBTp5vCJ1Ul3xbh/bbueyao4Ni2Xf97FRn9dANJYHAKSP
 Lt8QvJuEFVGQTwiUwPI905fPwPlBaXCbMQCPAe28PlMqY+RtCxEXAAyBSxLmD/W/GNRc
 j9bqrFQwN7Aq2nVM7Ffc03qfhER7dbSfRqXOolkYPvzRFAYkq/5fJ5KrycxylJC7hhKI
 chhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tdNQQWE9wGAC0mH1muH1gEnZ20h4fqSH0abkP54OzAE=;
 b=DVFzF1WFrOMGUBtXJ8il/COrdkrcu4HMUmH/snCkqA5MDqeuOSDCkb4XhVoeZMC+me
 C2cGCXqrDIy5DBYIQji+3CwTnVb+LYWqocImydRkRO/CzmGtSzreaILKcVqAYdvsXwa2
 dOoNPEgyeUjIFJG1ww0VPPWrrSziQZQMDSoNfOWya65LrargxM8P4u/WNFK7IPvqOOXt
 u3Ce/P6zu4lgcc6EPVvZ/I6HmoyPyMLltsFQvOkYBF4oaZ3GkLkBwY0EF8g5bE0GAJF+
 4MohJLfbUKuvC1ive2Hst4bSKpyhTnPntD/faLXWmYzcWX++PmjfQUthxBKSjUy/THb4
 FEmg==
X-Gm-Message-State: AGi0Pua2WWz0xGdrrEJ97oKU+HIOSo4Tiay8E9fd6+/uaeT0twzLxzgm
 J7JfEL88KbOBkLR0qW6UlzeCrQ==
X-Google-Smtp-Source: APiQypJGAHsuW/d+RTrzZorqjoIO9kzT6Vs3poZBodBkH8i1gvB7yTRVQZKMxOm0bKaohDx7bo/bug==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr5289201wrv.222.1588270207658; 
 Thu, 30 Apr 2020 11:10:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/36] target/arm/translate-vfp.inc.c: Remove duplicate
 simd_r32 check
Date: Thu, 30 Apr 2020 19:09:28 +0100
Message-Id: <20200430181003.21682-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Somewhere along theline we accidentally added a duplicate
"using D16-D31 when they don't exist" check to do_vfm_dp()
(probably an artifact of a patchseries rebase). Remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index b087bbd812e..e1a90175983 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1872,12 +1872,6 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
         return false;
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
-- 
2.20.1


