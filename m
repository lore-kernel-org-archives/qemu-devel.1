Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD7EC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA932054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA932054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1tB-0006QV-Rx
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1dg-0000Fb-Lj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1df-0007zd-F1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:23:04 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:52914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1df-0007yD-8t
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:23:03 -0400
Received: from player789.ha.ovh.net (unknown [10.109.143.208])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id B9E1610C1E6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:23:00 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 2BDA3A273B93;
 Wed, 25 Sep 2019 07:22:49 +0000 (UTC)
Subject: Re: [PATCH 16/20] spapr, xics, xive: Better use of assert()s on irq
 claim/free paths
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-17-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <56f89d62-2cd7-1300-1ad9-b373fccde0e6@kaod.org>
Date: Wed, 25 Sep 2019 09:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-17-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1572882171449805784
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.36.172
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/2019 08:45, David Gibson wrote:
> The irq claim and free paths for both XICS and XIVE check for some
> validity conditions.  Some of these represent genuine runtime failures,
> however others - particularly checking that the basic irq number is in =
a
> sane range - could only fail in the case of bugs in the callin code.
> Therefore use assert()s instead of runtime failures for those.
>=20
> In addition the non backend-specific part of the claim/free paths shoul=
d
> only be used for PAPR external irqs, that is in the range SPAPR_XIRQ_BA=
SE
> to the maximum irq number.  Put assert()s for that into the top level
> dispatchers as well.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive.c |  8 ++------
>  hw/ppc/spapr_irq.c   | 18 ++++++++++--------
>  2 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index c1c97192a7..47b5ec0b56 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -532,9 +532,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t=
 lisn, bool lsi)
>  {
>      XiveSource *xsrc =3D &xive->source;
> =20
> -    if (lisn >=3D xive->nr_irqs) {
> -        return false;
> -    }
> +    assert(lisn < xive->nr_irqs);
> =20
>      /*
>       * Set default values when allocating an IRQ number
> @@ -559,9 +557,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t=
 lisn, bool lsi)
> =20
>  bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
>  {
> -    if (lisn >=3D xive->nr_irqs) {
> -        return false;
> -    }
> +    assert(lisn < xive->nr_irqs);
> =20
>      xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
>      return true;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index c40357a985..261d66ba17 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -118,11 +118,7 @@ static int spapr_irq_claim_xics(SpaprMachineState =
*spapr, int irq, bool lsi,
>      ICSState *ics =3D spapr->ics;
> =20
>      assert(ics);
> -
> -    if (!ics_valid_irq(ics, irq)) {
> -        error_setg(errp, "IRQ %d is invalid", irq);
> -        return -1;
> -    }
> +    assert(ics_valid_irq(ics, irq));
> =20
>      if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
> @@ -138,9 +134,9 @@ static void spapr_irq_free_xics(SpaprMachineState *=
spapr, int irq)
>      ICSState *ics =3D spapr->ics;
>      uint32_t srcno =3D irq - ics->offset;
> =20
> -    if (ics_valid_irq(ics, irq)) {
> -        memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> -    }
> +    assert(ics_valid_irq(ics, irq));
> +
> +    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
>  }
> =20
>  static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monito=
r *mon)
> @@ -628,6 +624,9 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> =20
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
>  {
> +    assert(irq >=3D SPAPR_XIRQ_BASE);
> +    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +
>      return spapr->irq->claim(spapr, irq, lsi, errp);
>  }
> =20
> @@ -635,6 +634,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int i=
rq, int num)
>  {
>      int i;
> =20
> +    assert(irq >=3D SPAPR_XIRQ_BASE);
> +    assert((irq+num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +
>      for (i =3D irq; i < (irq + num); i++) {
>          spapr->irq->free(spapr, irq);
>      }
>=20


