Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92252C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5952524655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7F/kV+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5952524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucDi-0003ql-4o
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iub1X-0000NK-Ah
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iub1W-0000hb-7a
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:51:47 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iub1W-0000h4-2E
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:51:46 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so2590190oif.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bFml8qLCtmp1P0vb5uVGW4L9+hW902mtdxUueUM/0nA=;
 b=q7F/kV+Dfh+sJ+nI37Gzpj3gGuHJXFnUcwe+dPvRVWh5dqGGNeW51I4fTNX1d8zM5a
 o8wwN+EoUNKLSE7fSHFVnZrEHXHJE/VwFMM66Ojxn1sW9byTEDQksDFb2WD24v9QVdUI
 5n9nnep26dbrZv6q2PgvsqayCvQtkhPrN3L7Y7CsrB5w4YfvW22fUZUAQc79Z0+Jf1Fr
 iQLRCPDKlb3AxlvP6dkFkaBOt8O+pNzpH5PqHdOa4ZNN50I88DcRLYsHtdHV3xKvC0uA
 6Zz74FJN/TAtwwG8rqYyLSrS60852DH+zYxhDnv8o9qkBI+1JMxajDHYRXvUpw1j9NBP
 V6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bFml8qLCtmp1P0vb5uVGW4L9+hW902mtdxUueUM/0nA=;
 b=UJ/I0uJP2QtOgIdKT+c5Q4nEDu6iQADpSFXsIjey0E3rkD1b/bfBZLZyTWLwVJLqUj
 mt8l3N4CpJX7127TP7eu/pKEgmF9VhSvfM5xT4t649HCryIC9OPiXp3nCmictAATqNRD
 Mm0zyc9zpGZykpT9XqwBGNZQ8Of3lva4GYy8iP9R4MNJyslFHo4vCDnq2fzzBiq3B0g9
 m9T2rqGfTCc+l3Zcp3iyk83qQ+BnJ9qehBWa1g1waisxf7Rc9+0h2DXDJM9DgZoLB6DD
 FtsEuICv63Wl/UxXj3iwOkFtpfb6nU5FREvK2vu/59IdWy73vREmSpnq+Hf6B9Rd6wsi
 63Fw==
X-Gm-Message-State: APjAAAV3wu20/bvlTs557ebBppXEszos05WuAI8euk7iSDidesDQfp/c
 wjxoQAdXUyf6qWoWwR1Tb3oXKhthr+JfcVpx59zqBg==
X-Google-Smtp-Source: APXvYqxPTL/97ECH1J4qMtpZIPP0gROYbsp3ND4AYDartm+CUX8hMMBiaype5o7pIR5kCnkwWoWakQyN0pHtPOn5egs=
X-Received: by 2002:aca:570d:: with SMTP id l13mr10000574oib.146.1579780304900; 
 Thu, 23 Jan 2020 03:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20200116141511.16849-1-peter.maydell@linaro.org>
 <20200116141511.16849-3-peter.maydell@linaro.org>
 <CAFEAcA80NezC=oXMWNmbKTGWp2_xJVS1MFeOe58d3wMrH1mQug@mail.gmail.com>
 <87h80nz5c8.fsf@linaro.org>
In-Reply-To: <87h80nz5c8.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 11:51:33 +0000
Message-ID: <CAFEAcA84RUT=eZnnjZET9f=fsVuy1gYhtQkrQBCjbrmysqnG4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: Create stub system manual
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 at 18:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > diff --git a/docs/index.html.in b/docs/index.html.in
> > index 94eb782cf7e..573c543c02b 100644
> > --- a/docs/index.html.in
> > +++ b/docs/index.html.in
> > @@ -11,6 +11,7 @@
> >              <li><a href=3D"qemu-qmp-ref.html">QMP Reference Manual</a>=
</li>
> >              <li><a href=3D"qemu-ga-ref.html">Guest Agent Protocol
> > Reference</a></li>
> >              <li><a href=3D"interop/index.html">System Emulation
> > Management and Interoperability Guide</a></li>
> > +            <li><a href=3D"system/index.html">System Emulation User's
> > Guide</a></li>
> >              <li><a href=3D"specs/index.html">System Emulation Guest
> > Hardware Specifications</a></li>
> >          </ul>
> >      </body>
>
>
> This didn't seem to make a difference on readthedocs so I assume this is
> for different tooling?

It's for when you build manuals via the makefile, in which
case you get multiple separate Sphinx manuals and want a
top level index that links to those and also to our legacy
non-Sphinx docs. So it's what you'll see in the installed
version of the docs if you do a 'make install'.

thanks
-- PMM

