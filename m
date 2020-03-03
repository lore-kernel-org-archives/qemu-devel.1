Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF72C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF6C206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sb2HGiqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF6C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BhC-0000wz-VN
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg4-0007V5-RO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg3-0006K0-RM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:56 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9Bg3-0006Jb-Li
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:55 -0500
Received: by mail-wm1-x341.google.com with SMTP id i10so2891060wmd.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=++P9RdISn12IMj2NdnjcFp9KnKYuoL4/wTvl1xQS+Gw=;
 b=Sb2HGiqGWJw+URWcfjeZ6XvDQmnlaKryWB6to+KJ0e0QcFNJ4TTvM4chhG/5Sucqyc
 W++mC9X8HzAMXuEaR4w0jKzi+ikjhtXC5HxLJNJRQ+rF5+G5ML55fUE+LwNWQQhEIu93
 gPABx4jKnifMS6NKJcQJjO5r+6OZchswCGEwqnjvCBvSNuKch0D8GwmgkVd3aMlUq1XK
 E6tI7mPmHQBVx0TsQaopZXZWIemE7yJQtH+TzJe27PU8GBPN/LsodSrQKA3wxsReDPgT
 Pdg5H7vB8hY51Pty0IzssZS9xN5ePOy3MiZLoxaGiUgHZDe0ZmBBp86a3xW5uO2EWr73
 CRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=++P9RdISn12IMj2NdnjcFp9KnKYuoL4/wTvl1xQS+Gw=;
 b=Adq/Led/sYDUkB3RAJSDv0kXyfVFVtgmCZ7eZCyA2/5JgiSqa35kqbeVZanuEloIFM
 goJLcanoHHPsHhgwUVF/IZoPry2+wyL71ae/XEyxGl7RI57A3riLlNk6MflixoIj9iZF
 /uI/2yEHRjluMPb28qGHd6IgIa5vwbVA0OLtoiGio74Md7OLCf/mFbr4DxTzmsn0YAGU
 ZIjfeFt4oDWu59a/mVSANnv9ZUNLGFcxUTMneiaJMyQkTc3TnaNxhQnMj2Ex1GGRq+HP
 D/ttSMvFMBZWpwKM5VVCyjYHMMFpb9bAZNs/y4c2qU8nbUbaN2JBiB6yh2pF60eVsXNj
 jM1Q==
X-Gm-Message-State: ANhLgQ0lXW+XfVxubDYWJK6puvvZ8zUN9kMreO0ZxUznjCJ9sQbe6nV9
 VWlh+SkmCZYjxhrrWT8KpJPz4w==
X-Google-Smtp-Source: ADFU+vtUCD3eszDzWo5fF6fkO5Fu5wKAa6L20hf5s3VlOg9jBgextiPsDqDAu1pZjUnO1KWX0l5amg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr5159852wmf.75.1583257794709; 
 Tue, 03 Mar 2020 09:49:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm4867576wmd.44.2020.03.03.09.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 09:49:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/arm: Update hflags in trans_CPS_v7m()
Date: Tue,  3 Mar 2020 17:49:48 +0000
Message-Id: <20200303174950.3298-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303174950.3298-1-peter.maydell@linaro.org>
References: <20200303174950.3298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

For M-profile CPUs, the FAULTMASK value affects the CPU's MMU index
(it changes the NegPri bit). We update the hflags after calls
to the v7m_msr helper in trans_MSR_v7m() but forgot to do so
in trans_CPS_v7m().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6259064ea7c..7f0154194cf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10590,7 +10590,7 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
 
 static bool trans_CPS_v7m(DisasContext *s, arg_CPS_v7m *a)
 {
-    TCGv_i32 tmp, addr;
+    TCGv_i32 tmp, addr, el;
 
     if (!arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
@@ -10613,6 +10613,9 @@ static bool trans_CPS_v7m(DisasContext *s, arg_CPS_v7m *a)
         gen_helper_v7m_msr(cpu_env, addr, tmp);
         tcg_temp_free_i32(addr);
     }
+    el = tcg_const_i32(s->current_el);
+    gen_helper_rebuild_hflags_m32(cpu_env, el);
+    tcg_temp_free_i32(el);
     tcg_temp_free_i32(tmp);
     gen_lookup_tb(s);
     return true;
-- 
2.20.1


