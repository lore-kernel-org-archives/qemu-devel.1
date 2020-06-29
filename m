Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D8AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199A623750
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJbKnIZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199A623750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqXO-0002dA-Bf
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpqWa-0001iG-Nq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:56:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpqWY-0003fE-QF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:56:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id 5so12903609oty.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZxwnIuUKslX+EdvmDjDmhB6SXS+YQYrPNaAYIk502BU=;
 b=VJbKnIZ3Dvo7s2BkK+N1HqUXbWkBsR+lyWvIt6coMGs28A7rWTBfEj6v/THb8Ig0LL
 NJRW8ezA+8gQL8kZaueQE8aWUYdrMjsGVWsNqaxON8jH/mZCjyAtVyrh7sXAk+Lo2haX
 wUw0Y+mmPnJ+GbnIDj0tBhQ6Lq0lXFZa8ponFK94zDjxI/nR89TlnC9rvUFilj3GYpju
 VA0YwL00SSF55i9eWiSLC90zGkEH9u/86VWAqIoF2eq4LAqUMTjq+MevaSP4Wf1heJ96
 d1YK0Tubd0uiE5umaTgfS5OIImT0SC+HYXxoDnleVjZmn5uHicxT03QEwfy+h4cMKmnc
 GjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZxwnIuUKslX+EdvmDjDmhB6SXS+YQYrPNaAYIk502BU=;
 b=Mp1UdpTcRWPQfhzPZZT9CQ1bTXJ7K+870u4Hfy52VB2N2BPWeIJ5J6wlb3kjf0KJ2G
 2MKGYTQpxhcsSxNVsXycYvEtRFxQxN7uCzgQNn+Dw9KipcpN/AnyhvvrCEgV2QmOgZy5
 6BgRE1AqcKrsYwanj+/GuYPAHIqqxwO733SQr6WIj0vvi/NOzdkoo6KIxQzTXU+/ix/4
 cEs/aA2i+Mfm1VK2dyrOUG+1ufWf01EHMspv1IwjX0EvHpxkRSjyfo0UehF+Z4WLskDt
 9V4vu1W0ddYiW/ImyG9sOvem3jtnfVfj3+9qlK/qyJtgrgSUMkVDWvKPJfRFLkg/Gw8L
 +a3g==
X-Gm-Message-State: AOAM530XvLEMP8qtfKVMh4ydJMOlOvj1S/JvumBWwamarGMlDyJGn7Fg
 wguDN50WaXlYYqdPmtbzuPiQBlWe7OaXFwSN2pc=
X-Google-Smtp-Source: ABdhPJzj/3wNmAiNYqKPy6/rfub+kzbDEbg3ZyR20wxXH0CVJTT0KEPsN8UvgYCvl81sGvYFj89D+UEjnrdiEY4u6rw=
X-Received: by 2002:a9d:787:: with SMTP id 7mr381903oto.333.1593424585546;
 Mon, 29 Jun 2020 02:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-7-ppandit@redhat.com>
 <20200625014125.GC69292@umbus.fritz.box>
In-Reply-To: <20200625014125.GC69292@umbus.fritz.box>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Jun 2020 17:55:49 +0800
Message-ID: <CAKXe6S+rO3tpiOaK4wQgRn_H+Ffy4UiWVzoffqbEtgH5Z9mf0A@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] spapr_pci: add spapr msi read method
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> =E4=BA=8E2020=E5=B9=B46=E6=9C=88=
25=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:09=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Thu, Jun 25, 2020 at 12:25:20AM +0530, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > Add spapr msi mmio read method to avoid NULL pointer dereference
> > issue.
> >
> > Reported-by: Lei Sun <slei.casper@gmail.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>
> > ---
> >  hw/ppc/spapr_pci.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 329002ac04..7033352834 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -52,6 +52,7 @@
> >  #include "sysemu/kvm.h"
> >  #include "sysemu/hostmem.h"
> >  #include "sysemu/numa.h"
> > +#include "qemu/log.h"
> >
> >  /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
> >  #define RTAS_QUERY_FN           0
> > @@ -738,6 +739,12 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(vo=
id *opaque, int pin)
> >      return route;
> >  }
> >
> > +static uint64_t spapr_msi_read(void *opaque, hwaddr addr, unsigned siz=
e)
> > +{
> > +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> > +    return 0;
> > +}
> > +
> >  /*
> >   * MSI/MSIX memory region implementation.
> >   * The handler handles both MSI and MSIX.
> > @@ -755,8 +762,10 @@ static void spapr_msi_write(void *opaque, hwaddr a=
ddr,
> >  }
> >
> >  static const MemoryRegionOps spapr_msi_ops =3D {
> > -    /* There is no .read as the read result is undefined by PCI spec *=
/
> > -    .read =3D NULL,
> > +    /* .read result is undefined by PCI spec
> > +     * define .read method to avoid assert failure in memory_region_in=
it_io
> > +     */
> > +    .read =3D spapr_msi_read,
> >      .write =3D spapr_msi_write,
> >      .endianness =3D DEVICE_LITTLE_ENDIAN
> >  };
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson

