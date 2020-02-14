Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390BEC3B1B5
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080D622314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upfqOujZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080D622314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fWc-0006GI-8z
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVV-0004TM-BA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVU-0000FY-Dm
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVU-0000FK-7H
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:04 -0500
Received: by mail-pl1-x644.google.com with SMTP id ay11so4028780plb.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hc+/AucXa0inxq9dbV/arLbbzIae9WxdVjI4zl5RMxY=;
 b=upfqOujZGWqMRFNIe2Y4HrByxOI+hj3ayK33nXTKGLh9nQgtl7T2uG7bkQyxpUfpgE
 ZmgP10cb/8yOXuRakIVq4khHPFm/Wx0fOdOuvYJtthyjxbYjVPu9fLAJ6R66UMxjGQm6
 u83i07TWr+DXx7tjIGC0AObz47i7a90B0tdWpb51vFN4wFQIzQjknvGNkvJcUItzhqpz
 P+hA0TvbSKBomcEECSUbRln2jdEU7krQ+XMVN26zQUje6KWoq9+DPzAjesGKRB25Nm4v
 ccdFeIo8jKQpVqX1b9mkuz7KLDnQhJblXLxhXF8AXrLHj9bBlTQVw1nAzyr7vOtWYjEH
 XF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hc+/AucXa0inxq9dbV/arLbbzIae9WxdVjI4zl5RMxY=;
 b=KncrELX3+PPxgMbagT80tmnezGRC8brw7NmroCN8yrW65/BLQoGRgAD/Wlfkuakb96
 I3cZbVNKOI/fXnuHcmqa2zjudjHM+XP7BVRbHYkZs/KBM6D1ccOdLFkCLxuUwT/pOu8M
 TY9xJc2YvJ4VUakHl2/xUaIuW9ZWM8mdeLr5OfZZotiegy8+gqaJ4lzmeWB1z76XXd5w
 4JoWIjQ8KMDaoMG7YUbH1MTbhTOaCC6E7EXzV8Zeg3eLYVfNOpazbDKabvzYcbbW2G0h
 fLRpSo2InlwRnHmxc2O4kaDaSSmKPxu8qFNizSwO3sc/86DMq31KH7WUEoLfKSuWBanC
 76FA==
X-Gm-Message-State: APjAAAVyy5hLW3VG6VNEPI2XOfOJ2CVL0aPqf/Xv4kZ4lL38p/R2QPRs
 Ccu37QufgxZwByub9vO3IAK43sqsPX8=
X-Google-Smtp-Source: APXvYqxqulXxdG7hk382vvxsBn259LGCN4zy9eER1fHDr7Q40c5Qzx6a1VRmv9v/Ide+z1V4gXWeEw==
X-Received: by 2002:a17:902:a5c4:: with SMTP id
 t4mr4694242plq.242.1581704162920; 
 Fri, 14 Feb 2020 10:16:02 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/19] target/arm: Remove ARM_FEATURE_VFP check from
 disas_vfp_insn
Date: Fri, 14 Feb 2020 10:15:40 -0800
Message-Id: <20200214181547.21408-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

We now have proper ISA checks within each trans_* function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0da780102c..e8c3d4f26f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2652,10 +2652,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
  */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP)) {
-        return 1;
-    }
-
     /*
      * If the decodetree decoder handles this insn it will always
      * emit code to either execute the insn or generate an appropriate
-- 
2.20.1


