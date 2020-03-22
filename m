Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B64CC54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4028D20714
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIKlVQ8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4028D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFxVa-0008GI-F5
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 06:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFxUx-0007ZI-7f
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFxUw-0000Ki-3z
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:06:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFxUv-0000KB-Pu
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:06:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id a6so10392690otb.10
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 03:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ryzb8jsMV/qdGmn+hrgo/gcbGJo4ASGPLNLkL8no564=;
 b=vIKlVQ8Oy+dRcEuCUppjO0yTQji57IE4tafgPNj0yxJIbO/jfVhiI1H5X4fMbWiGYZ
 K9wl7dbTgPJj4JrnEknjWMGO+47NhT+bE4pl8FRDNVpYihAcBWqDvjC2ZwoCOhQfD5ar
 MWgpk4NhFUeIGU68+emRwkDtrzGJr5bi1him+RqWvh0PCKCCaEouH3uVB7NJxwJtOUkG
 ukDiuCP6wv99gMLW5q3dC+WIdqJ1JWUPHIqRAQ+ql9WVqRNLNDUX+fGRR7LSnBdk4epv
 NkmJjnmvwYofiAKIwAh8FH1p1C5z3/q7mURKf7gL0c0EZza/Kq/k5E5ZJ+kJ2M+UNed3
 MXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ryzb8jsMV/qdGmn+hrgo/gcbGJo4ASGPLNLkL8no564=;
 b=Et6o5uVW/Zvmwz0EISdIBcKB5M8EUYZ+Y01PJB88b3zCDJ+rEpljiiLtNsxP412LsY
 ULMU7a540/b3FmNsebmqgzYPR+1vjrlewN45muokgiILHawGebVXO9PhlK9m3exxEc/+
 qMW9s7qBVG0N+gHBUQMO8Nwj3rB8KaLJbcfNhfPjjIBMXHfnyZR37S7Uoh6JstMKq/pN
 dRQ1gm/sGRcQIsAtV+nY1M8NeAjoG4Vd2HWIBbl79CBKfdwHHPa0whHy89ZHNNIo/8NH
 rCH5Kejztf0bCFGMHR+b1pi2z3VSasYD4gPGHwvkuo4SHvT2n9oOVHG8cEqnmFiR6Lg+
 te6w==
X-Gm-Message-State: ANhLgQ3ep5BOrJrSLLLALE+4YockRtGWBhwOHfrehOUyQ6mmbSIWLkDb
 io1uuTXB0VK1IjiWWLiLr00D6wM1GEJTak9cNb1orw==
X-Google-Smtp-Source: ADFU+vuEgVqPXo1eIWrGVx4TuDXYSOm0lUGe+Xpk8ug6wb5T4BnGOradRSTddq6tql84H0rVSSKkKS4wUm1fnQj3RfI=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr13144887ota.221.1584871584821; 
 Sun, 22 Mar 2020 03:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200320155740.5342-1-philmd@redhat.com>
 <20200322084608.GI781112@umbus.fritz.box>
In-Reply-To: <20200322084608.GI781112@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Mar 2020 10:06:13 +0000
Message-ID: <CAFEAcA-TPqVN98T=tYAOyQ4JPj8iu+eB3Zi-txgV+GUgcHNjCQ@mail.gmail.com>
Subject: Re: [PATCH] ppc/ppc405_boards: Remove unnecessary NULL check
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 08:50, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> On Fri, Mar 20, 2020 at 04:57:40PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > This code is inside the "if (dinfo)" condition, so testing
> > again here whether it is NULL is unnecessary.
> >
> > Fixes: dd59bcae7 (Don't size flash memory to match backing image)
> > Reported-by: Coverity (CID 1421917)
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Applied to ppc-for-5.1.

This would be OK for 5.0 too at this stage.

thanks
-- PMM

