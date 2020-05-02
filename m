Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E0C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066A6206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xm+FxQsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066A6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0xb-0003iu-32
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sf-00033r-P4
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0se-0004SE-R0
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:09 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:35928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0se-0004Ox-9B
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:08 -0400
Received: by mail-pj1-x1031.google.com with SMTP id a31so1865394pje.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L+mjihK8N8U7blFol1sDsEomAd7AICYz+OB/p8BHKpY=;
 b=Xm+FxQscAERiVmiSdIYRuudahE+y+Gy1wd/znu8i/W/v4DeMOzSpM9G+QzOgEySupt
 D1X1jWcSSS0PQhRzmZVw2tqiVBYEby1kG7mAgekqPNlTFp3IBfVXpKhj1A7ERrTHbtaY
 vvBHLARLD0TsV+PTMa9QJ/TBIciW5wpIuxR/5vgHFgDmOqODMasfPiI+heW2AIv69MY4
 cIgQy8O+/Am5AAvh2KygwXvtROW2t8pE8EElsJRKhhGH7xC3M8HreSDMEvGgv2DarLWg
 7hLdH8cfUEOFfLJO3GTjZRPSpNCHyjWxhxsTHaROiwV5YSaeBMisN4wl7/Rq4uERYe2r
 nXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L+mjihK8N8U7blFol1sDsEomAd7AICYz+OB/p8BHKpY=;
 b=DvXpbdOyg+0dMGOnFtzYB+2Tmw5jDUwdltMg2o6Kvfi20cZVDyDeWAC8CWsDYNCsKd
 95TRuH4nPPc8yrAysl/fcgrZ6WSSq56sQEpgWZPg6zmz9OxvKNVeIValUqLYSOePQHQM
 Dw4y070LMclOWdAPrG3ffHfiO1q1/nzjuY9jdUfy9kOwcq57ifY4KrWHynL1bZw1ygJD
 63WyRZ13MWOIZOBYhVOVoUHPgTh3jzYTuD7SqLeCdFyMuTAoJskzQ2DKuZ3QToeqyMxc
 cPOLlBzfo92DC2hJx0ZzHekISIER48RLI6ECOvbFokFf2H4NxarXk/UWUkKbpT7EQ46A
 mmKA==
X-Gm-Message-State: AGi0Puag5vCMN8Hp9iZJZy2c/9WU+Dd7Rx/fPKVNg3chv6zP0a3n6pUj
 lqs4CcxWisTVMKCmi2MPwuA/jMtoZ8E=
X-Google-Smtp-Source: APiQypKK1fby3tyo1WT0TEGc4wWRwD4AieICtH8vOSZl3R+mttw2b4oor8cMCVyqiZYetGTByA0f5Q==
X-Received: by 2002:a17:902:7793:: with SMTP id
 o19mr11216037pll.107.1588459505723; 
 Sat, 02 May 2020 15:45:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] target/arm: partial vector cleanup
Date: Sat,  2 May 2020 15:44:48 -0700
Message-Id: <20200502224503.2282-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1031
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

This is not complete, but shows the direction I'd like to go.

It may well help what Peter is doing with the neon decodetree
conversion.  It may be helpful to apply before the conversion
in order to reduce the number of special cases.  As may
continuing with the cleanup; I'll probably work on that more
next week.

Version 2 extracts more bits from my sve2 branch.  There's
still more to pull back, especially for crypto_helper.c, where
there are also tail clearing bugs to fix.


r~


Richard Henderson (15):
  target/arm: Create gen_gvec_[us]sra
  target/arm: Create gen_gvec_{u,s}{rshr,rsra}
  target/arm: Create gen_gvec_{sri,sli}
  target/arm: Remove unnecessary range check for VSHL
  target/arm: Tidy handle_vec_simd_shri
  target/arm: Wrap vector compare zero GVecGen2 in GVecGen2Fn
  target/arm: Wrap vector mla/mls GVecGen3 in GVecGen3Fn
  target/arm: Wrap vector cmtst/ushl/sshl GVecGen3 in GVecGen3Fn
  target/arm: Wrap vector uqadd/sqadd/uqsub/sqsub GVecGen4 in GVecGen3Fn
  target/arm: Remove fp_status from helper_{recpe,rsqrte}_u32
  target/arm: Wrap vector qrdmla/qrdmls in GVecGen3Fn
  target/arm: Pass pointer to qc to qrdmla/qrdmls
  target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_*
  target/arm: Vectorize SABD/UABD
  target/arm: Vectorize SABA/UABA

 target/arm/helper.h        |   71 +-
 target/arm/translate.h     |   84 +-
 target/arm/neon_helper.c   |   10 -
 target/arm/translate-a64.c |  210 ++--
 target/arm/translate.c     | 1948 ++++++++++++++++++++++++------------
 target/arm/vec_helper.c    |  233 ++++-
 target/arm/vfp_helper.c    |    4 +-
 7 files changed, 1679 insertions(+), 881 deletions(-)

-- 
2.20.1


