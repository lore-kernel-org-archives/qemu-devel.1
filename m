Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4196BC73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE9120820
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNjk2n86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE9120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmcS8-0001QO-UB
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 07:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR9-0005nQ-U2
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR8-0006OY-T2
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmcR8-0006OC-N6
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f9so14098213wre.12
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sH3HXM90i35Znfmo2ZGAwhUVyrLtmUH4wH93sEFL2IQ=;
 b=FNjk2n86XqOV+bcaFG3i2ym7stY8kbk3QuTSCTKFYAGFtzJ9OOCK6xJluyGrcmz3dp
 8z8Pjo9NY9M5JVT5CDvtA5DnyuTm43b/4Ru6FBLGt+62jFbsmuFyCn1tvyF08Hy6py7W
 k+HuWlUuuFiXVbTn6InvKQfBb4schKihRliARlYCbNE3Sd4GRZDnBwuvhmd/eKf5C1dr
 OGHTjHOmlbMGtaA6101E/uateFO5i0bCfHfvAOBlwwvY4bPitqDVdlZTBm7r9iotyAGx
 SQQyki+zoSmiWaaW7wf9sVJ8QBWkLJHbvPtjrLg+bQzRoJkXkp/YphPpGW2ku3OkNC+V
 toeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sH3HXM90i35Znfmo2ZGAwhUVyrLtmUH4wH93sEFL2IQ=;
 b=dNr/3Uf1tx9E/JQpXfzQ0Y8sIdQ2nJdLBwAKcKFCW8JjwYbALprSvhUSFuop8asNEz
 XKKDcrRMyqTienDOffgDv69fm9vgQ7elATTXD79VOfYzYe+zYoj2yOgZIDTQ+Tk58Nmf
 h+hHVPUiSlfoNsiQImSd0sMumZwLwiTUXxlEUFrhN5PPS9OYFBqeXGK0ilwBg3PDX0x1
 aZjc3QA2gK5tdLZJ1oMazLyJyDZf5OdAzhKfNLtJJKs1Fmyj4XWr0tZnqj9lmhb4Cc2P
 67aLEnMyv80q/P5nbXTn4ngUrzV4d3ck9IxQZtyL1PfpATZqj6z0BfiX6g+Iu5WLye2s
 xwYw==
X-Gm-Message-State: APjAAAUumxIZ9kBhK9WRYFKFVmg4XlPMfZkIMvB68vKJVteNDkdRX8Yb
 nUjKAlaTU79xNUn6ZXFxzCFEGAMqPLrMlw==
X-Google-Smtp-Source: APXvYqymTMlX2BPX2VST7yjowfRSyrq39BCwy+CORj5ciOTPhHCJ3KqSmCU3icXZYcZDa54T8WWs+g==
X-Received: by 2002:adf:e602:: with SMTP id p2mr16142780wrm.306.1563102777433; 
 Sun, 14 Jul 2019 04:12:57 -0700 (PDT)
Received: from localhost.localdomain ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id f17sm12675795wmf.27.2019.07.14.04.12.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 04:12:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 11:12:48 +0000
Message-Id: <20190714111249.13859-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190714111249.13859-1-richard.henderson@linaro.org>
References: <20190714111249.13859-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL for-4.1 6/7] tcg: Remove duplicate #if
 !defined(CODE_ACCESS)
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

This code block is already surrounded by #ifndef CODE_ACCESS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_useronly_template.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 8c7a2c6cd7..d663826ac2 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -118,11 +118,9 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-#if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, true));
-#endif
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
 }
 
-- 
2.17.1


