Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E748C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD938216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sq1oGuQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD938216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPzI-0000ZQ-43
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjPxo-0008NI-1z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjPxl-0003oq-UD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:17:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjPxl-0002gl-OT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:17:25 -0400
Received: by mail-ot1-x342.google.com with SMTP id o101so9377483ota.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VegkK88KP3ctyR23gUoOSRsawo/TTK0q4QFJWKTi25o=;
 b=sq1oGuQbdlNZCOVMSKndvKZ9fSsnEffkaCDo8uwyNdFSeYP35IWV0TauCwFdIHsuOe
 UkfECLVeksOy6x4MAecCyALnaVES+5AcDxxPcDFXqt/74Rhz8q04tkZIMtmH0lL3G9LI
 YY/oEE8hWj10Crw1mPmIPMW2wyolqunb84Wu/PxdXmTLf04j4yi7y5fCzGsHZBt559jW
 ia8bkWYvw9onKzIISk0MI8b2GFB23w3l/mwlSBtHI53E1SJ3nkainfjnYOVZnMQVcv0T
 Ln4iXjFdljPc6Lfh+wnuas6ZDNZapIPTmkgzwPRqgiDWSkTOd7tk2joFKTOUf+E22KFt
 wpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VegkK88KP3ctyR23gUoOSRsawo/TTK0q4QFJWKTi25o=;
 b=EivgR+A4IiKpzheKX1z8TpmIIucQCy7PIz4G2E1I3nlCf6DIaQW8apIFioRzcdxe9X
 blbKKvmrF/3jzFRoK6k5iCAzC4aLJKxVev8OvyFMYFZlzCIrAoSuhEGPgzK6cnqZAyoO
 BfpdU5WdN0EVoU4v35xIXpKU+fYihoMp9sZlAHVXsAN7ebYDn5iCyjSdD9tHvdZ68PtK
 CeY736+wj1xFR+4roShg4bGnwIdvN5kH1xhOQRlSKOsdPjV+M8i1FuE4xOBuDwcvCh7g
 MnESYz93WGzS53TExOv+CfQXkrcn0/+kKOHBMYsYo0lgJw3XkAf1TXULe1OkwZOzQosR
 AETw==
X-Gm-Message-State: APjAAAUGJLX0v7TsPhyI7uyqk6rWcB6aJbOAaweD/1kMwozo73bcdRbm
 y9EmPXNl92eviJzZc/1uqYw2P9pVg5z2oUKuVzl465RNmow=
X-Google-Smtp-Source: APXvYqx8S36Tc74/sOZ1S5RXfsYdDAYNxFRGissvq1htBNHiyOsAmF4i7vnsuWs27wCuPJskq8AyATcXVT3VbSJqkL0=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr3406631otn.135.1562339831078; 
 Fri, 05 Jul 2019 08:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <156217961567.21218.1941224583128986225@c4a48874b076>
 <0a0abd7a-ce36-6faa-cba8-b6a40e7b503e@vivier.eu>
In-Reply-To: <0a0abd7a-ce36-6faa-cba8-b6a40e7b503e@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 16:16:59 +0100
Message-ID: <CAFEAcA96z+9kMG1iDmBLa-MXuRez7XNyN7TigdaiNCBiy=2UuA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL v2 0/2] Trivial branch patches
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
Cc: no-reply@patchew.org, QEMU Trivial <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 16:10, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 03/07/2019 =C3=A0 20:46, no-reply@patchew.org a =C3=A9crit :
> > Patchew URL: https://patchew.org/QEMU/20190703152513.29166-1-laurent@vi=
vier.eu/
> >
> ...
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D12708=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 32 byte(s) in 1 object(s) allocated from:
> >     #0 0x56164f580b6e in calloc (/tmp/qemu-test/build/x86_64-softmmu/qe=
mu-system-x86_64+0x19f9b6e)
> > ---
>
> It seems not related. Does it prevent the series to be merged?

Yeah, it's unrelated (an issue in master which is now fixed), but I
had missed your v2 pullreq amongst all the noise. Thanks for the ping --
I'm running it through the test process now.

-- PMM

