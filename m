Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A32C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3AB206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhAalsFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3AB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Qem-0001tc-R7
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qe3-0000sk-Uz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qe2-0004iU-Ly
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:12:27 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:38737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Qe2-0004iH-Eb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:12:26 -0500
Received: by mail-pl1-x62b.google.com with SMTP id p7so507680pli.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gr+IW3tVLO2ZQy7a3f3KRrgoIj/Adh7ezfztRLmO/DQ=;
 b=OhAalsFlpPaT5DQI0l8JEA3vAJ4o7YMrb5LmuKPLdn5qkmsOVu9L4NPnhplQBR+lCy
 OA9QcmkpTD+xy1WrUlI2IEl9mGjdWpIpbQocusO36PWg04EBYfVGn9Az5cHurgPJqG5N
 lxa444xCd1Q7xpGyIyjVtCw608gJ9BZBbDN9YUKsOS93OF+2zhaQlTyIymCVLWYvhTsG
 nm/WKp3m0GKFFrfLt/BGwW1LtXXn1dOXGywpq95xmO7xqQi4+6ra1ivBoD8nGXOFs5Uf
 b4oKoCWyp4MzwJxAglhO1y7M3/d9lbZErtyLFKpfNCw/Dvul/uDvoZlzUyRApBQ8bkuC
 +HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gr+IW3tVLO2ZQy7a3f3KRrgoIj/Adh7ezfztRLmO/DQ=;
 b=iuy1FDck0ymX8i3nRHbs37s4G3izNQhJlDKT7AAUlzaEaaKQ4KDponTaDTE3M+9Hk+
 w6lqWKVIbG5jnmSY9QJOOmnT+mhnkhWsESalL6Wxn3Z8wLYkQ5JYe0Y0xp6wLsx7Swjx
 dB+6gLKLwm+I5UkdolqbrIdiYKWQKTZuXfFo8Klfz7VVcvYaVIhktbgyz3vgRgs3VCr1
 cVXQp7VdBOj+F5rdDHOa9LhdE2H/jgKbSxEw9QkfLWzKWQAJI+6olOPxef8ZJsaA+gjf
 Jr7wKFQJ7RQ7oqoU0ynwK6jhJVDhkRNuLZ9i14t35uCKwf4RlT4u2FvJcZw29JqDS37r
 hWxA==
X-Gm-Message-State: APjAAAVjNNQuXNZG2Zi0H38IDSJNZXyINuygydTk1k/yfG5JjTxOJT1s
 uUeOoXJvwzjNEFoyNnhgZxpGsmJcyIY=
X-Google-Smtp-Source: APXvYqyPBdtRQPEMpuZ6uSreEBzlh82O3m0KJgj4vQ3FqjCsmhS1ccocuu+yK/mVNvstQ7qI43deGQ==
X-Received: by 2002:a17:90a:8586:: with SMTP id
 m6mr2608886pjn.121.1582600344948; 
 Mon, 24 Feb 2020 19:12:24 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id gc1sm884747pjb.20.2020.02.24.19.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 19:12:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] target/arm: Misc cleanups surrounding TBI
Date: Mon, 24 Feb 2020 19:12:10 -0800
Message-Id: <20200225031222.15434-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62b
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a bug at present wherein we do not supply the memory tag to
the memory system, so that on fault FAR_ELx does not contain the
correct value.

For system mode, we already handle ignoring TBI in get_phys_addr_lpae,
as long as we don't actually drop the tag during translation.
For user mode, we don't have that option, so for now we must simply
accept that we'll get the wrong value in the siginfo_t.

In the process of looking at all that I found:

  * Exception return was not applying TBI in copying ELR_ELx to PC,
    - Extracting the current mmu_idx can be improved,
    - Replicating the TBI bits can allow bit 55 to be used
      unconditionally, eliminating a test.

  * DC_ZVA was not handling TBI (now only for user-mode)
    - The helper need not have been in op_helper.c,
    - The helper could have better tcg markup.

  * TBI still applies when translation is disabled, and we weren't
    raising AddressSpace for bad physical addresses.

  * SVE hasn't been updated to handle TBI.  I have done nothing about
    this for now.  For the moment, system mode will work properly, while
    user-only will only work without tags.  I'll have to touch the same
    places to add MTE support, so it'll get done shortly.


r~


Richard Henderson (8):
  target/arm: Replicate TBI/TBID bits for single range regimes
  target/arm: Optimize cpu_mmu_index
  target/arm: Apply TBI to ESR_ELx in helper_exception_return
  target/arm: Move helper_dc_zva to helper-a64.c
  target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
  target/arm: Clean address for DC ZVA
  target/arm: Check addresses for disabled regimes
  target/arm: Disable clean_data_tbi for system mode

 target/arm/cpu.h           |  23 ++++----
 target/arm/helper-a64.h    |   1 +
 target/arm/helper.h        |   1 -
 target/arm/helper-a64.c    | 114 ++++++++++++++++++++++++++++++++++++-
 target/arm/helper.c        |  44 +++++++++++---
 target/arm/op_helper.c     |  93 ------------------------------
 target/arm/translate-a64.c |  13 ++++-
 7 files changed, 175 insertions(+), 114 deletions(-)

-- 
2.20.1


