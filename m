Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F420C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCFA2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWfdMf6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCFA2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6xgr-0007R6-K2
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 09:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6xg9-0006Wn-KT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6xg8-0003QP-GR
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:28:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6xg8-0003Q4-8h
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:28:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id a141so2552845wme.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XDmPZZy1+OtCumfJwoDCbHz71zet+3fA3q72iAo9Jk4=;
 b=hWfdMf6CmN7p27mGSGIjK6IUDH43c5Xbi6WE0wV6sQOQuLehHfRASq/o8ownV66dCL
 A6k9Hi9WXB15QBnDnFqDiDvn299RSr9ijLP+Er3JjGtE9BQAXVcr5m08ivT1M6DtIFL5
 z0YVRZyXxSx9Lde/nKBNYU7XUJX0lmFRZTlftG570p0o1byNSdP/gVLyoxTbYEohlClz
 Apy2g0MfjNTXfy+eAER7Q2R2Ng7nFJeWgHPyX51jgcmiIwco0ljVBmPXFxUvU6gS64OD
 m0KWAwJbktNrE5Uw+zXfIFC4BZkXRQVUFNDSYHvrNR6Y8KVE2+gAS/erXLZLpMFXpdDD
 kYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XDmPZZy1+OtCumfJwoDCbHz71zet+3fA3q72iAo9Jk4=;
 b=GND1AsQX7RZDICC2do05YV2zu3Olv51C0/Jz5h6T/t7o2iSULMzBImpolx2XGHzwMJ
 NTQMgTxeQ2k/B+oYSzMadwDtQOfsb6A/SZmcG8LJq/2B5zquOFSzccZCjvH0O4My68oV
 sGLkJBZeoxRhoKAyqVKKMhoBsQMrodPJKbYCzmWlOGjaeg0Il4We2kmIjYHIOAFb9vrW
 mLzjFeO1B9fIum9066jhJFeezIhr6HfkrDKyffoRVuBjv5j/4/uM3EijTsaVvsOscMZe
 kZEHI7tu0y2C0BMlE1GjrTypkA8bjXMih5SwlptZXrHpAwSLxcDx8MYYdD8xeR/F98Pt
 INaw==
X-Gm-Message-State: APjAAAVM5hU0M/Te/TZfbUylagimTvEkGmeQ2c1s+vnAxq6ysCv14VwP
 734i2p44wydqlWPpezNJjTew/g==
X-Google-Smtp-Source: APXvYqxpWw9qETRptqUb7iW032n3TKWGTivSw/wAlmU/qxXcE0yCWBMeu3d/nfiHY3kxNYPHTVyINA==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr5791221wmk.15.1582727326836; 
 Wed, 26 Feb 2020 06:28:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r6sm3400772wrq.92.2020.02.26.06.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 06:28:45 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 170BD1FF87;
 Wed, 26 Feb 2020 14:28:45 +0000 (GMT)
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dino Papararo <skizzato73@msn.com>
Subject: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-reply-to: <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
Date: Wed, 26 Feb 2020 14:28:45 +0000
Message-ID: <87eeuhxw0y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel@nongnu.org, Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dino Papararo <skizzato73@msn.com> writes:

> Please let's go with hardfloat pps support, it's really a good feature to=
 implement.
> Even if in a first step it could lead to inaccuracy results, later it
> could solved with other patches.

That's the wrong way around. We have regression tests for a reason. I'll
happily accept patches to turn on hardfloat for PPC if:

 a) they don't cause regressions in our fairly extensive floating point
 tests
 b) the PPC maintainers are happy with the new performance profile

The way forward would be to:

 1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)
 2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any unneeded
 splatting of flags (if any)
 3. measure the before/after performance effect and decide if on balance
 it's worth keeping

> I think it's important for qemu to as global as possible and don't
> target only recent hardware.

Are you referring to guests or hosts? For guests we will always favour
accuracy of speed of emulation. For hosts we need to have IEEE compliant
FPU HW to even stand a chance of using hardfloat.

--=20
Alex Benn=C3=A9e

