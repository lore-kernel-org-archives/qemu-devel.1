Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CB0206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tT4hHnxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CB0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstB9-0001XT-CG
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hstAl-00018Z-C6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hstAj-0008HA-BV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:17:59 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:33766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hstAh-0008FB-LI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:17:57 -0400
Received: by mail-ot1-x332.google.com with SMTP id q20so71102117otl.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zTdxbrjSp1ZCi1t7O0VZS1Qi+RyV9gKcBv1Quz6lno4=;
 b=tT4hHnxH3e+Cu1k9fGyTTwN+JOOazZhenDrIIahFaYrfZMBGCNFCaGODKJcTQue7YE
 A2BlJkj7V5oZB3Zmrd9TdQF4cqWEPzfvB4CkhjhuSCf8fNsPHeLD7/bwIyqUxjotOqOS
 ST2fAuMei2aqG0I/ta3aii/v0fW6vaP4fst7eGI7zWpL6BnK5Ib803qMj5IpODfeuCEn
 DNgCF4HWtwwnMPgksrdBCM3OU9PnR+9QqNil8GAuTYM+qWu9luBMmtCYV1w+xEWBbo1T
 Khkpe5KN1NpHogmT/4efuArmfA4s5Iv8J33W4Mnk89LzHOY03zmOGi+XTn+3J7dkF59Q
 7tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zTdxbrjSp1ZCi1t7O0VZS1Qi+RyV9gKcBv1Quz6lno4=;
 b=ioh5+2PFDOAhM30FHAwyYLvcrfNZ07QjaZqQcZz7pCEhojCrC9Nk4tvaCwz6qZBhD+
 YpiLsufVHL0UQwP0Nb8YRTvdeiDN17269o9KmZqB4ADkTvcc3mU6192n3Ufkq93bPsjH
 het5DmhUnkxEcPNG/8MWfa4ny2hSKI1Bddy3Macv8HAK9g6L2pw2jJQuQEH2Jj3Z4GHO
 2M0FNELpUBaYmKdBf6gG0gHYRACFFbbPV95kbhDvpSZXOx28JmcXd8YRVx8+V39z+sAh
 Wbo6qxhd1AykzEcMugt7hWEQIYpewOJRtD/CIbBjANXczz1JENurhs/Tyzg8eSjQysnF
 cE5Q==
X-Gm-Message-State: APjAAAVV7OepOlxREfX5qCKiluOX9kREu09qNof7uXxaT67QZYOqazU4
 2wX9T0CCf0JEzJztBRluKDtmFKB8NzB/e2UhxScuZg==
X-Google-Smtp-Source: APXvYqy8xYmQ00FJn7eKxiw3YxdWRBsmUgmtHs6EHD8kRsTUDK4HhoWpQ2SXwZxrFwfGP6Wv2t6zYxLvG+F275ZEQvM=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr62504093otn.135.1564597073861; 
 Wed, 31 Jul 2019 11:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <156452993884.16169.12168229409049273970@sif>
 <3c6ebc55-9416-a467-cfbe-73d2df6a64f2@redhat.com>
In-Reply-To: <3c6ebc55-9416-a467-cfbe-73d2df6a64f2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2019 19:17:42 +0100
Message-ID: <CAFEAcA9Vs=N_kaO1_DHM=Azttp=1Ju=bKFMU3iZdt6-+J=Oq4Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc3 is now available
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Samuel Thibault <samuel.thibault@gnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 31 Jul 2019 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> >   Unless there are any release critical bugs discovered, this
> >   will be the last release candidate before final release of 4.1.0
> >   on the 6th August. Otherwise we'll do an rc4 and release on
> >   the 13th August.
>
> We forgot to update the slirp submodule :(

Were there any RC bugs in it?

thanks
-- PMM

