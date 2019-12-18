Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E0CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2580A20715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbDrWp/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2580A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPtQ-0005Sx-Jm
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPry-00042v-Vm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPrx-0002ck-NA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:26 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPrx-0002bb-GV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:25 -0500
Received: by mail-pg1-x543.google.com with SMTP id s64so438166pgb.9
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ihZfE8DpETfNLV/nWFmOLomurxv8JcwHssCMdL8p5Hw=;
 b=HbDrWp/Kx8GI+OrkUCx5RnC0BUMSA5xpmeAUdxPENjKfpe3Bp86SnV+QbRHAUbCc56
 ZvF2LXy2NmcPTSPfsligSAAJYqWmBYDddYOr+mDFzSuprEJImZcMVgYGXhK9BO43ZE+H
 mffzY42BRxJEK3OVbyjICAnYhv5d54XEWpK4oT2edqvejOzTFv8iBlpTtRxc29R9QYQr
 LOdQcx+KiLWoprcEhxAtVh+HtxItQlqy3vkn0mPVyYunhp5NTwU6SgPhuD5iOXTv6cye
 z70g7SQZ1/aw9wX6AwRghBsRXI+XtJK7Qm+r/umsGF/1D3LX2Dz8OI7u2c0OsXxCRgXM
 GrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ihZfE8DpETfNLV/nWFmOLomurxv8JcwHssCMdL8p5Hw=;
 b=OqWcCsBGe7K59BKRyQ1wAqbczs5MtlV8RLSt9Fmc4QjHoZLiM6Rf5E7aeCHlBNoqwn
 6rIGOZ+wQ+96EXI2Xb0c3tm8qZiSN0VcPsRtcbja7ri+5iDvrIiWtK64/nB/V7Au+JjL
 j4VUMBPfF4qn0TIWmyqlCZ93fWwYNqfCwHlCOnIRS0Gs3EGu5F4vJLXLq+joQQg/+GMS
 IQwhqeLC5TBdZ69V5LNwft9MXcCHIIbwDn07lLRjmRNaGjFCblRGFqmW6596AWBv5XTo
 vQuv2KMv9SoXafHNRhpu3vDZev/f1bI23quxpzj7+EF2GLPjhFY+BpWhv3Xj45HKJgmL
 me2w==
X-Gm-Message-State: APjAAAWhnIp6IOdlV4qji7Lc0+J3xBY47FoL85khOgx8ubAIs7WqrmaI
 0CyF+uo9mnsyYbS0Mv+vE2xaqI+m+sM=
X-Google-Smtp-Source: APXvYqziJqCu+JXRn1VtvNT/eimbQUHIPbWF5Uceyg7HkemjZfSK/k32Pxsygkq4VRcoo7GK5+MehQ==
X-Received: by 2002:aa7:9f47:: with SMTP id h7mr454686pfr.13.1576639163415;
 Tue, 17 Dec 2019 19:19:23 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] configure: Improve PIE and other linkage
Date: Tue, 17 Dec 2019 17:19:13 -1000
Message-Id: <20191218031920.6414-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This begins by dropping the -Ttext-segment stuff, which Fangrui Song
correctly points out does not work with lld.  But it's also obsolete,
so instead of adding support for lld's --image-base, remove it all.

Then, remove some other legacy random addresses that were supposed
to apply to softmmu, but didn't really make any sense, and aren't
used anyway when PIE is used, which is the default with a modern
linux distribution.

Then, clean up some of the configure logic surrounding PIE, and its
current non-application to non-x86.

Finally, add support for static-pie linking.


r~


Richard Henderson (7):
  configure: Drop adjustment of textseg
  tcg: Remove softmmu code_gen_buffer fixed address
  configure: Do not force pie=no for non-x86
  configure: Always detect -no-pie toolchain support
  configure: Unnest detection of -z,relro and -z,now
  configure: Override the os default with --disable-pie
  configure: Support -static-pie if requested

 accel/tcg/translate-all.c |  37 ++----------
 configure                 | 120 ++++++++++++--------------------------
 2 files changed, 41 insertions(+), 116 deletions(-)

-- 
2.20.1


