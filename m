Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CE420679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVq9mjfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CE420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgDo-0003fN-SB
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNfdp-0007OT-7I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNfdo-0003P8-0E
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:07:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNfdn-0003Oq-QA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:07:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so21496225wrr.10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/p9vVo5M/R3Jwh7RMx/rJC/qTIVQmkfMPyGvHdPcyQY=;
 b=AVq9mjfCslj66wPKC7bcSVeU70YqPRbMobo02ExiInzSz5kM//w4li/7OltKDu7/SQ
 q2FQmCC9OTz2oX/IZbZhHWQHv0T96NAkgzm+IgMDoFsFTk7lj6yDmS/RxjUJOJ6rMqvx
 DfqWfAt/NV0N35gphGl+m8eqnh88nNkr/qtskE+bJKbMTA2sCfBDpdh9AzOPm4ITdorY
 jDh6fX37nBqs7Hq2hfXfdwFGAzj/TPerVeFaKnFnFmkRpW2X1zVtcvcBKdvv1DXMUqwO
 6rWBfSvJLeR3hfIsmEwiNEZoIW4spci87z0KGBB6kxknLgnyMDuoDRoFdDhcxOThqVl8
 L4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/p9vVo5M/R3Jwh7RMx/rJC/qTIVQmkfMPyGvHdPcyQY=;
 b=Lj3FQvuwDSW0pGRtHIZsIZQoUb/sKBSEJsMapKdPow4LZgwzf2FkTfQW9gUCkpxWRq
 JCARuL9w+O1Domppignk9shk+btybcXaLL2+xpItzC6ohrhA4TZqMla7sCFJ25syH+WO
 md1SgVSMUi/iXufP1TZeB4LWg3eCIrJKWV4NVL2lxWQfVfei06aDjDSh8UYIT7iRMXYt
 j7xNxt4iToqauhYEYPiZrU9v4Nvzyk1eZ8pEbrOEse9HNutpuN780hQtaogWfTSqxVeH
 e4UkTY/tVFQ9O2JiUuYNNedhxL7bI9JAjARU3RMLGLshDU92mGRiRjf64XnhokfRCAj9
 Hi4w==
X-Gm-Message-State: APjAAAUQZ2aUPkI7nu629Xu7YZC3Takpp2t12wHwA8Urka3lqqMcFmfn
 l4DFV4ssTRZA82mby7XhyWaw0g==
X-Google-Smtp-Source: APXvYqyU13RlA0dlNlBfb58sa7hcXSRnW2K8ue0k4uiLGIV4TguFLaCUsB77LQDNl93HBZDmIVavwA==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr4430231wrp.282.1571933230492; 
 Thu, 24 Oct 2019 09:07:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c21sm2781391wmb.46.2019.10.24.09.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:07:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4870D1FF87;
 Thu, 24 Oct 2019 17:07:09 +0100 (BST)
References: <20191024102240.2778-1-alex.bennee@linaro.org>
 <20191024102240.2778-16-alex.bennee@linaro.org>
 <c4ea7902-b3ad-47ab-ad56-42f604473922@redhat.com>
 <CAP+75-X4VY=Hk77po2pGF-qjM4dxUQdMC5QaYi=pqMnaoLRxkw@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 15/17] travis.yml: --enable-debug-tcg to check-tcg
In-reply-to: <CAP+75-X4VY=Hk77po2pGF-qjM4dxUQdMC5QaYi=pqMnaoLRxkw@mail.gmail.com>
Date: Thu, 24 Oct 2019 17:07:09 +0100
Message-ID: <87a79qm8k2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Daniel_P=2E_Berra?= =?utf-8?Q?ng=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On Thu, Oct 24, 2019 at 4:33 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>> On 10/24/19 12:22 PM, Alex Benn=C3=A9e wrote:
>> > This adds a whole bunch of asserts which will catch bugs you might
>> > introduce into the TCG code.
>>
>> Very good idea.
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> >
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > ---
>> >   .travis.yml | 4 ++--
>> >   1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/.travis.yml b/.travis.yml
>> > index c43597f1331..ba3a8d4cfc9 100644
>> > --- a/.travis.yml
>> > +++ b/.travis.yml
>> > @@ -334,14 +334,14 @@ matrix:
>> >
>> >       # Run check-tcg against linux-user
>> >       - env:
>> > -        - CONFIG=3D"--disable-system"
>> > +        - CONFIG=3D"--disable-system --enable-debug-tcg"
>> >           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>
> Hmm maybe we should change the ccache name now...
>
> CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"?

I've sent a patch that applies to my currently brewing PR.

>
>> >
>> >
>> >       # Run check-tcg against softmmu targets
>> >       - env:
>> > -        - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch6=
4-softmmu,alpha-softmmu"
>> > +        - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu=
,arm-softmmu,aarch64-softmmu,alpha-softmmu"
>> >           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>
> Here too.


--
Alex Benn=C3=A9e

