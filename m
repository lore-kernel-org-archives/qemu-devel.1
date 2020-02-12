Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290DEC35242
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 02:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E52206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 02:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL7rScRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E52206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1i8z-0004BW-2T
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 21:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1i7y-00036G-HX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1i7x-0008Hb-Dv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:51:50 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:41608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1i7x-0008Fs-7f
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:51:49 -0500
Received: by mail-pg1-x529.google.com with SMTP id 70so404843pgf.8
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 18:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QYV8Aaq6yWeGQbS6j19mMWL1mJ6k9R/5v/tqn3mxJx8=;
 b=gL7rScRmtf991U0Mp5CtmXZCIDu3M6YI51JpAU2fBpUj5nK/Q1XTYiBNSLDIBK/VC/
 eJBIOCmh9ZL0Rhq13scVpuMLTSNcAq4dSTfVfv7gsBDE3GbjFhLY/M8uK9I2NogflmIA
 z4Sm1t1e6C6usJX5V3c7yjlERq2aM5z3qmG8kDayxvEmG+ricNqgzJ49aMIqIFZ+5Jas
 RTjcvKmLWU3A2jD/Ah6OHpWsiGdSImRDvC4393XBnsg8YwxBhMiKENZHgpTdfC25Q8cd
 TL8138qA9EaoFxdEwW3FjfAKmgmIpwzx2Ru9Z/qlMJTGMe7PHWzy/vosTpuPQL6GxMRc
 V66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QYV8Aaq6yWeGQbS6j19mMWL1mJ6k9R/5v/tqn3mxJx8=;
 b=W9+8UKrhlxANpALqwqfI27yvoqWdabbD+m3ucp99fvR970SJA/eoO4KrKxYE1pqCbm
 TXpzeRE9gHOXgGWf3NBgHTWX44+EjlfSn1xwDhNfXMjz32T4nnC8cfFUL7SrYOTrrlnU
 hg8TD0mIdYWqoL6YSI/gFeWnHGdGhlo19IEt33KXQgYbqFo1WQBnpz8OY5OYI9uTCZpV
 bxFxyngSGft7WX6Aqve67hbcqmQI+txHXU0QFfDPAucOvr/eKi4Q2bUCMsiA67mn7XcD
 o1kxpEu5ArcdSkOo+QmzCI2KJWYWgD/FWD+xvvf+/5YGSNUjkaU76VZtY99zkiWXBQrW
 nMOg==
X-Gm-Message-State: APjAAAWRBNcLw6l7L+yqVxnlqrBCisZhz09h25fkIxIhlcjVddeveQPb
 oR/XYTajqualTiyLtdigWmUajasGR0Q=
X-Google-Smtp-Source: APXvYqwvBZMg6G46Fy/e2rSl9tGSyamjbCdTsqQmX4WghmHEiJSmkxc7x04CayUVFbDG8Y4DePctAQ==
X-Received: by 2002:a63:fe50:: with SMTP id x16mr9839289pgj.31.1581475907610; 
 Tue, 11 Feb 2020 18:51:47 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id d4sm4815749pjg.19.2020.02.11.18.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 18:51:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: Pass arguments by value for sve FMLA/FCMLA
Date: Tue, 11 Feb 2020 18:51:43 -0800
Message-Id: <20200212025145.24300-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: peter.maydell@linaro.org, tsimpson@quicinc.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>

These functions had been passing arguments by regno,
encoded into simd_data, because we couldn't pass 7 args.


r~


Richard Henderson (2):
  tcg: Add tcg_gen_gvec_5_ptr
  target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA

 include/tcg/tcg-op-gvec.h  |   7 ++
 target/arm/helper-sve.h    |  45 +++++++----
 target/arm/sve_helper.c    | 157 ++++++++++++++-----------------------
 target/arm/translate-sve.c |  68 ++++++----------
 tcg/tcg-op-gvec.c          |  32 ++++++++
 5 files changed, 153 insertions(+), 156 deletions(-)

-- 
2.20.1


