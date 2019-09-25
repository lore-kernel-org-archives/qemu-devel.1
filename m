Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C215C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611A8222CC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611A8222CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1dC-0007Xg-GF
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1Sd-0006G1-Ch
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1Sc-0002W1-8O
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:11:39 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:50136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1Sc-0002TK-30
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:11:38 -0400
Received: from player715.ha.ovh.net (unknown [10.109.143.79])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3DA0824FDCA
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:11:34 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id C9067A056037;
 Wed, 25 Sep 2019 07:11:23 +0000 (UTC)
Subject: Re: [PATCH 11/20] spapr: Fix indexing of XICS irqs
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-12-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <38ceb5d3-650a-d678-a90c-b4fa50e7a2cb@kaod.org>
Date: Wed, 25 Sep 2019 09:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-12-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1379790336625576920
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.173.103
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
> spapr global irq numbers are different from the source numbers on the I=
CS
> when using XICS - they're offset by XICS_IRQ_BASE (0x1000).  But
> spapr_irq_set_irq_xics() was passing through the global irq number to
> the ICS code unmodified.
>=20
> We only got away with this because of a counteracting bug - we were
> incorrectly adjusting the qemu_irq we returned for a requested global i=
rq
> number.
>=20
> That approach mostly worked but is very confusing, incorrectly relies o=
n
> the way the qemu_irq array is allocated, and undermines the intention o=
f
> having the global array of qemu_irqs for spapr have a consistent meanin=
g
> regardless of irq backend.
>=20
> So, fix both set_irq and qemu_irq indexing.  We rename some parameters =
at
> the same time to make it clear that they are referring to spapr global
> irq numbers.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

The commit log clearly reflects what you think of the current solution=20
in the code :)=20

It is hideous, but it worked fine and this is even better :)=20

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_irq.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 300c65be3a..9a9e486eb5 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -153,10 +153,9 @@ static void spapr_irq_free_xics(SpaprMachineState =
*spapr, int irq, int num)
>  static qemu_irq spapr_qirq_xics(SpaprMachineState *spapr, int irq)
>  {
>      ICSState *ics =3D spapr->ics;
> -    uint32_t srcno =3D irq - ics->offset;
> =20
>      if (ics_valid_irq(ics, irq)) {
> -        return spapr->qirqs[srcno];
> +        return spapr->qirqs[irq];
>      }
> =20
>      return NULL;
> @@ -204,9 +203,10 @@ static int spapr_irq_post_load_xics(SpaprMachineSt=
ate *spapr, int version_id)
>      return 0;
>  }
> =20
> -static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
> +static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
>  {
>      SpaprMachineState *spapr =3D opaque;
> +    uint32_t srcno =3D irq - spapr->ics->offset;
> =20
>      ics_set_irq(spapr->ics, srcno, val);
>  }
> @@ -377,14 +377,14 @@ static void spapr_irq_reset_xive(SpaprMachineStat=
e *spapr, Error **errp)
>      spapr_xive_mmio_set_enabled(spapr->xive, true);
>  }
> =20
> -static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
> +static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
>  {
>      SpaprMachineState *spapr =3D opaque;
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        kvmppc_xive_source_set_irq(&spapr->xive->source, srcno, val);
> +        kvmppc_xive_source_set_irq(&spapr->xive->source, irq, val);
>      } else {
> -        xive_source_set_irq(&spapr->xive->source, srcno, val);
> +        xive_source_set_irq(&spapr->xive->source, irq, val);
>      }
>  }
> =20
> @@ -563,11 +563,11 @@ static void spapr_irq_reset_dual(SpaprMachineStat=
e *spapr, Error **errp)
>      spapr_irq_current(spapr)->reset(spapr, errp);
>  }
> =20
> -static void spapr_irq_set_irq_dual(void *opaque, int srcno, int val)
> +static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
>  {
>      SpaprMachineState *spapr =3D opaque;
> =20
> -    spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
> +    spapr_irq_current(spapr)->set_irq(spapr, irq, val);
>  }
> =20
>  static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spap=
r)
>=20


