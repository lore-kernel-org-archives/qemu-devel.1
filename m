Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B29DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469E52077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Su51Dp/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469E52077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKN6p-0001vH-Dm
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKN5s-0001JE-Do
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKN5r-0000sO-9C
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:14:48 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKN5r-0000qH-0H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:14:47 -0400
Received: by mail-oi1-x242.google.com with SMTP id d3so6234757oic.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e1HaIQXkpHa1yj7z7dXrSSTl+pvmyeEFc/LJeeVH4AM=;
 b=Su51Dp/waOKvg89XPaXjizWFwIftwj9iI4Oe8l+tfBwh5N2ivA1RrEdy/Vpa8hehAP
 9Wpl/x8fD1ILwsCFGmCzMc+Tkw5zgwOnAVHjBnrjK3/lJXHvVIZmi/gZqdg7025vK3vB
 kL8Pq/DZq1R4QvhJJByJmkEQZjRrTpQWe8Vdzj1XMd76nDg0GT9V/l3VsBWFMa1F1LvA
 b0kj8nzInxxrbj6d/adyQH40oSxcalrbE4vSffSNlDYlcxTbAFAz/6oUBosiJES5qF9Q
 Zf5XMd760FNPK7ufsEaAvFKZtUi3iQyr7jZrTuPQgcLVALjsq9Bmc13z3e4T66z/bhXb
 9Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e1HaIQXkpHa1yj7z7dXrSSTl+pvmyeEFc/LJeeVH4AM=;
 b=YTRXTIDcgqrorn10XOzi0wewQ67UF9snSokW1kvRy59CMQEnMLdOcoHDzlWqMG1ZaR
 4KgElt9Dd+KcFkiXbc6LzN6ET38SLWyxY9UpvliDYy06zRzOhJymoqoXavGX5+N+qmSI
 C30Ukc66ted+1Gqy1t2jyzhl9s+JrcJQEBptcjqJDOkqKq/0dNKscXkQhC5zLUl7nak4
 KWh5bpnfnMzEHMVLwaN3+B3vnaPhhLTdaYJvPcIqbbUU7ETakK49Oss6ZP2gMv9ckSa9
 d7xMaDcQIJpVgRzmZQRbfFbCIo9ger7RTcJWnSwi/08RgPxwiTL1EOI1TeBUMIFURIPj
 odXQ==
X-Gm-Message-State: AGi0PuYZC9cG/vRMEryJwqoplw0NsPOy+n4sk41lhBOx22aYuTPmYLwP
 7s3QfrHpqxcBprefQGUDSbOC1Ch6jZIUivvsbusAmA==
X-Google-Smtp-Source: APiQypIxhjDn24R2infGtPWxFac4HGDH8gf4ipXBYVIATrGqzYkObvov1WqX6pfXL58b9QcKD4uu/87ys/aynUJmV4w=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr2951529oij.48.1585923285947; 
 Fri, 03 Apr 2020 07:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200403140018.13531-1-imammedo@redhat.com>
 <CAFEAcA_cyK+1+BjYqVB+nu70jiShx861NM=W0ezp_8g5eV6qcw@mail.gmail.com>
 <20200403161259.6af638b7@redhat.com>
In-Reply-To: <20200403161259.6af638b7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 15:14:34 +0100
Message-ID: <CAFEAcA8pi6Kd40PRz8SPdLUb_K-KFkVy47LUTJJdbNBT6Sx_qQ@mail.gmail.com>
Subject: Re: [PATCH] nvdimm-utils: clean up headers and add license comment
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 15:13, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri, 3 Apr 2020 15:06:14 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Fri, 3 Apr 2020 at 15:00, Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > Fixes: 3f350f6bb36233be50fc2bc18dc78b6a948a5dbe
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  include/qemu/nvdimm-utils.h |  2 --
> > >  util/nvdimm-utils.c         | 29 +++++++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
> > > index 4b8b198ba7..1f1dae477f 100644
> > > --- a/include/qemu/nvdimm-utils.h
> > > +++ b/include/qemu/nvdimm-utils.h
> > > @@ -1,7 +1,5 @@
> > >  #ifndef NVDIMM_UTILS_H
> > >  #define NVDIMM_UTILS_H
> > >
> >
> > .h file still missing the copyright-n-license comment ?
> do we have to add that for headers as well?

Yes; ideally every source file should state its license.

thanks
-- PMM

