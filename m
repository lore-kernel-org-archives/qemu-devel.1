Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570DAC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2382C22DBF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiXvcy6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2382C22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5TSW-0005j1-7g
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TQe-000453-BX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TQc-0005HI-2Z
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:26:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5TQb-0005Fh-RL
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:26:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id r17so2295648wme.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0Ph505Sko4VKojkMB9G8zO1GOo2FlzNfi0vK+RDs9UM=;
 b=OiXvcy6xmC4wE5RfNGijhneZezWU1qlIr7DpBzqlpmIKauLbQs4/sOCagjfTypzEHb
 pRni09V6S87NCmI4D1cor50ndgNGab6+2YIpcN/BJvQvCo3tvaQKX1opwXxysq0Lb1Zc
 b4vKu9T2x9vGcYs8cPSKjId7qtEVEjNLnVW0nuDGKXTXJfyqAuuELxSGt/FEhdnNpqkz
 t7e0RFP3DKlh5+AQTEi1ckCazIufZUHOio9EqJcw70GNHGFxymmxQJbPfvMK4tCceS4O
 c5I9KCpJcEjbDIiymLiLYRqnrmJlEHyNfVTkOukrVvsySqifgsV/e2AL0Nx0aL9S9s1R
 tENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0Ph505Sko4VKojkMB9G8zO1GOo2FlzNfi0vK+RDs9UM=;
 b=fOlBsDi1+b9w8TXMet7yVZuVG0XNZCAb4p6kYyXVsvm4151jJyyU0F3somP3ew224N
 U7yuVIBq7ZXuRqqD/VLkEHAkWwxkxB/pALM+A0Y2mC6GcxvBQi8XI1yyrMyhpX/+uAjO
 SEje7BCc9dz6Qra7b7qwqJD20EW0SEpu9to1YOVoW/avCwncA0NS7geMdLCkJFHUH5vN
 9PXnKZA8Y9IISNGt1sIzuIa82ZnH4/HtnS4kttb5bz3xJ3qkDkUg+UL4RLmZw19SF6/j
 pfysNlNTuHz+5MK6ijwz4F7vnk7r84kLBwb8jwtI8JR1sM0PFk1iSBGd7EvzY0oO8f9N
 vvng==
X-Gm-Message-State: APjAAAUuTxGJOAZE1NktBuEX3m/DxEoyC+F7itZKH9UlH6V8f4EJl6Tm
 YCHSEfGeVZJqhj+xx5+MmJ+v4A==
X-Google-Smtp-Source: APXvYqw/2x8nf/d9mLHSeJZHLgNcElMkDNSIH2+/HHytYDGK40rnHcTBsO2+GALV9mnQkYvOW2p1CA==
X-Received: by 2002:a05:600c:34d:: with SMTP id
 u13mr3828161wmd.97.1567596379042; 
 Wed, 04 Sep 2019 04:26:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s26sm16919914wrs.63.2019.09.04.04.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:26:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 505DA1FF87;
 Wed,  4 Sep 2019 12:26:17 +0100 (BST)
References: <20190903132649.20226-1-philmd@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190903132649.20226-1-philmd@redhat.com>
Date: Wed, 04 Sep 2019 12:26:17 +0100
Message-ID: <87d0gg715y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 00/10] travis: Use caching when possible
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This series tries to reduce Travis CI failures due to network
> issues, and tries to speed builds a bit, reducing failures due
> to job timeouting.

Looking good.

Queued to testing/next, thanks.

>
> Travis feature: https://docs.travis-ci.com/user/caching/
>
> To see improvement over time, I recommend to apply this series
> on top of different merge commit on master, to see changes in
> cache use.
>
> Few patches come from:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04935.html
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (10):
>   .travis.yml: Enable multiple caching features
>   .travis.yml: Increase cache timeout from 3min to 20min
>   .travis.yml: Cache Python PIP packages
>   .travis.yml: Cache Avocado cache
>   .travis.yml: Improve ccache use
>   .travis.yml: Enable ccache on OSX
>   .travis.yml: Document how the build matrix use caches
>   .travis.yml: Cache Linux/GCC 'debug profile' jobs together
>   .travis.yml: Cache Linux/GCC 'non-debug profile' jobs together
>   .travis.yml: Cache Linux/Clang jobs together
>
>  .travis.yml | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)


--
Alex Benn=C3=A9e

