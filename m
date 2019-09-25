Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2993C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A24021D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A24021D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1pf-0002ET-Nm
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1Y0-0002dg-71
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1Xx-0005iK-MV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:17:11 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:45722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1Xx-0005ha-0K
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:17:09 -0400
Received: from player738.ha.ovh.net (unknown [10.108.35.103])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8692D1AC7B4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:17:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 0E0F0A515297;
 Wed, 25 Sep 2019 07:16:55 +0000 (UTC)
Subject: Re: [PATCH 12/20] spapr: Simplify spapr_qirq() handling
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-13-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7187a6fb-b0d2-e317-4a42-169d5d8fa12a@kaod.org>
Date: Wed, 25 Sep 2019 09:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-13-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1472958555233881048
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.165.38
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
> Currently spapr_qirq() used to find the qemu_irq for an spapr global ir=
q
> number, redirects through the SpaprIrq::qirq method.  But the array of
> qemu_irqs is allocated in the PAPR layer, not the backends, and so the
> method implementations all return the same thing, just differing in the
> preliminary checks they make.
>=20
> So, we can remove the method, and just implement spapr_qirq() directly,
> including all the relevant checks in one place.  We change all those
> checks into assert()s as well, since a failure here indicates an error =
in
> the calling code.

nice,
=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/ppc/spapr_irq.c         | 47 ++++++++++----------------------------
>  include/hw/ppc/spapr_irq.h |  1 -
>  2 files changed, 12 insertions(+), 36 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 9a9e486eb5..038bfffff4 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -150,17 +150,6 @@ static void spapr_irq_free_xics(SpaprMachineState =
*spapr, int irq, int num)
>      }
>  }
> =20
> -static qemu_irq spapr_qirq_xics(SpaprMachineState *spapr, int irq)
> -{
> -    ICSState *ics =3D spapr->ics;
> -
> -    if (ics_valid_irq(ics, irq)) {
> -        return spapr->qirqs[irq];
> -    }
> -
> -    return NULL;
> -}
> -
>  static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monito=
r *mon)
>  {
>      CPUState *cs;
> @@ -242,7 +231,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
>      .free        =3D spapr_irq_free_xics,
> -    .qirq        =3D spapr_qirq_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> @@ -300,20 +288,6 @@ static void spapr_irq_free_xive(SpaprMachineState =
*spapr, int irq, int num)
>      }
>  }
> =20
> -static qemu_irq spapr_qirq_xive(SpaprMachineState *spapr, int irq)
> -{
> -    SpaprXive *xive =3D spapr->xive;
> -
> -    if ((irq < SPAPR_XIRQ_BASE) || (irq >=3D xive->nr_irqs)) {
> -        return NULL;
> -    }
> -
> -    /* The sPAPR machine/device should have claimed the IRQ before */
> -    assert(xive_eas_is_valid(&xive->eat[irq]));
> -
> -    return spapr->qirqs[irq];
> -}
> -
>  static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
>                                        Monitor *mon)
>  {
> @@ -413,7 +387,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .init        =3D spapr_irq_init_xive,
>      .claim       =3D spapr_irq_claim_xive,
>      .free        =3D spapr_irq_free_xive,
> -    .qirq        =3D spapr_qirq_xive,
>      .print_info  =3D spapr_irq_print_info_xive,
>      .dt_populate =3D spapr_dt_xive,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
> @@ -487,11 +460,6 @@ static void spapr_irq_free_dual(SpaprMachineState =
*spapr, int irq, int num)
>      spapr_irq_xive.free(spapr, irq, num);
>  }
> =20
> -static qemu_irq spapr_qirq_dual(SpaprMachineState *spapr, int irq)
> -{
> -    return spapr_irq_current(spapr)->qirq(spapr, irq);
> -}
> -
>  static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monito=
r *mon)
>  {
>      spapr_irq_current(spapr)->print_info(spapr, mon);
> @@ -586,7 +554,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .init        =3D spapr_irq_init_dual,
>      .claim       =3D spapr_irq_claim_dual,
>      .free        =3D spapr_irq_free_dual,
> -    .qirq        =3D spapr_qirq_dual,
>      .print_info  =3D spapr_irq_print_info_dual,
>      .dt_populate =3D spapr_irq_dt_populate_dual,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
> @@ -700,7 +667,18 @@ void spapr_irq_free(SpaprMachineState *spapr, int =
irq, int num)
> =20
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>  {
> -    return spapr->irq->qirq(spapr, irq);
> +    assert(irq >=3D SPAPR_XIRQ_BASE);
> +    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +
> +    if (spapr->ics) {
> +        assert(ics_valid_irq(spapr->ics, irq));
> +    }
> +    if (spapr->xive) {
> +        assert(irq < spapr->xive->nr_irqs);
> +        assert(xive_eas_is_valid(&spapr->xive->eat[irq]));
> +    }
> +
> +    return spapr->qirqs[irq];
>  }
> =20
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
> @@ -803,7 +781,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
>      .free        =3D spapr_irq_free_xics,
> -    .qirq        =3D spapr_qirq_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 7e26288fcd..a4e790ef60 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -44,7 +44,6 @@ typedef struct SpaprIrq {
>      void (*init)(SpaprMachineState *spapr, Error **errp);
>      int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **=
errp);
>      void (*free)(SpaprMachineState *spapr, int irq, int num);
> -    qemu_irq (*qirq)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
>=20


