Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2DDC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4898520720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRZKy1XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4898520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01VS-0002dd-Cs
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01Uj-0001Zy-D8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01Ui-0006s6-Dj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:08:21 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01Ui-0006rK-6s
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:08:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id t23so2152361wmi.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=J7c+Ha7fby1s54zZh9Z03UnSGI2nmeaQh1TBDyyU1qA=;
 b=yRZKy1XPKM57uuLmW85GWpSKHWGJF6fTrWy+O5i8pigtaZEuRuItx7UhOoglc5AnIV
 Qnaicx4MxaM+f2RJ2Bk+V9rQ8hkSdCD5UfH+zPcF91XAcNSbH0Gtju2OhExTj+59YdN4
 PQqJJc5Phcs7r+cOj0DDwP2aTL9DSKSifmBG9Gq/RcFwhGPsqsq5ix7GqI87voyIOLLQ
 QPlf30rXZUD8awL/USsxVT8jpPrY5wEG0m5UZvvabk1W+mtOIhvjC3mgdN5qVvCl/roE
 /SmQNuNtYEt4oS3SLNKfgtFrDH3btrt35jeV6266GJC8RKKV6PXaXzw7SvLRzsoue1Lx
 I/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=J7c+Ha7fby1s54zZh9Z03UnSGI2nmeaQh1TBDyyU1qA=;
 b=D86h3wdQHupeTWQDCFaHuzjlKLTApSXFmrnnaA8MJwqozcqT1L8poqVtyX5xfyrFI3
 bSm+OXQjPazwUI+pNbPRTVjrN9nHnCqvuKi7WYudM/rYpFGEie60enWg1STEkSE2vFNQ
 12P41ekEGXrbOCRpAvrdJfrMFuucPSRN9w1avTX1GoBoAd9opkmE1NcxrZXU7Fs0IqO6
 /ux97Y8MhrWzU8AZPibUHg2soDwOftJ7dLgHZXMFN87lYHDVQOTLQg/3c6l9v8jKbe5O
 yj0qlF2dFTsMjJyeoZtJfDgVxApW6lpAXxrYon2mJJQ2+G3o6GWvek1tIXxHHSwhIpzV
 fdqQ==
X-Gm-Message-State: APjAAAXY1wlcfohor7nVdcrUiWi/g1vF0GvvZOzqMb4xtzTEawxBTcuk
 bWBY+WgETILGIuDDcR8dbsO5qw==
X-Google-Smtp-Source: APXvYqx6rn0ZxdMwdpXhEz1yScMm+1M33D2NofQBDCpk3fwooX2Frw9K8lPtntxK9rJ4qbLJ053wgw==
X-Received: by 2002:a05:600c:294a:: with SMTP id
 n10mr3960856wmd.11.1581073697621; 
 Fri, 07 Feb 2020 03:08:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f127sm3038354wma.4.2020.02.07.03.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:08:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93D861FF87;
 Fri,  7 Feb 2020 11:08:15 +0000 (GMT)
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
In-reply-to: <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
Date: Fri, 07 Feb 2020 11:08:15 +0000
Message-ID: <87v9oi7izk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 03/02/2020 04.23, Cleber Rosa wrote:
>> This is a crude and straightforward mapping of Peter's
>> "remake-merge-builds" and "pull-buildtest" scripts.
<snip>
>
> Thanks for doing this! The patch looks basically fine to me, but some
> comments below...
>
<snip>
>
> Question to Peter/Alex/Stefan/Howevermergespullreqsinthefuture:
>
> Should the above jobs really be skipped for pull requests, or would it
> be ok to include them there, too? (in the latter case, the above changes
> could just be dropped)

I think there is certainly value in having different stages of testing.
At least initially we'll want to match as closely to the current system
and then I imagine as we go on there will be trade-offs to be made in
how much is gating PRs and how much is retroactive and catches things
that slip through. While more testing is good we can't exponentially
grow what is reasonable to test for on all PRs.

<snip>

--=20
Alex Benn=C3=A9e

