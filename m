Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A64C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5646B2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5646B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXeg-00025V-G7
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 01:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFXcQ-00007X-8i
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFXcP-0002vh-1V
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:56:10 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:49332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFXcO-0002uU-RQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:56:08 -0400
Received: from player730.ha.ovh.net (unknown [10.109.146.211])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id E961D10BC19
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 07:56:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 50799A55B410;
 Wed,  2 Oct 2019 05:55:56 +0000 (UTC)
Subject: Re: [PATCH v3 15/34] spapr: Handle freeing of multiple irqs in
 frontend only
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-16-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <983df092-b6c8-1171-7a19-147f9ca667f5@kaod.org>
Date: Wed, 2 Oct 2019 07:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002025208.3487-16-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4320640894082648985
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeehgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.73.133
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
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2019 04:51, David Gibson wrote:
> spapr_irq_free() can be used to free multiple irqs at once. That's usef=
ul
> for its callers, but there's no need to make the individual backend hoo=
ks
> handle this.  We can loop across the irqs in spapr_irq_free() itself an=
d
> have the hooks just do one at time.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_irq.c         | 27 ++++++++++++---------------
>  include/hw/ppc/spapr_irq.h |  2 +-
>  2 files changed, 13 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 9919910a86..d2ac35bbe1 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -133,16 +133,13 @@ static int spapr_irq_claim_xics(SpaprMachineState=
 *spapr, int irq, bool lsi,
>      return 0;
>  }
> =20
> -static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq, int=
 num)
> +static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
>  {
>      ICSState *ics =3D spapr->ics;
>      uint32_t srcno =3D irq - ics->offset;
> -    int i;
> =20
>      if (ics_valid_irq(ics, irq)) {
> -        for (i =3D srcno; i < srcno + num; ++i) {
> -            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> -        }
> +        memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
>      }
>  }
> =20
> @@ -269,13 +266,9 @@ static int spapr_irq_claim_xive(SpaprMachineState =
*spapr, int irq, bool lsi,
>      return 0;
>  }
> =20
> -static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq, int=
 num)
> +static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
>  {
> -    int i;
> -
> -    for (i =3D irq; i < irq + num; ++i) {
> -        spapr_xive_irq_free(spapr->xive, i);
> -    }
> +    spapr_xive_irq_free(spapr->xive, irq);
>  }
> =20
>  static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
> @@ -433,10 +426,10 @@ static int spapr_irq_claim_dual(SpaprMachineState=
 *spapr, int irq, bool lsi,
>      return ret;
>  }
> =20
> -static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq, int=
 num)
> +static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
>  {
> -    spapr_irq_xics.free(spapr, irq, num);
> -    spapr_irq_xive.free(spapr, irq, num);
> +    spapr_irq_xics.free(spapr, irq);
> +    spapr_irq_xive.free(spapr, irq);
>  }
> =20
>  static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monito=
r *mon)
> @@ -635,7 +628,11 @@ int spapr_irq_claim(SpaprMachineState *spapr, int =
irq, bool lsi, Error **errp)
> =20
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>  {
> -    spapr->irq->free(spapr, irq, num);
> +    int i;
> +
> +    for (i =3D irq; i < (irq + num); i++) {
> +        spapr->irq->free(spapr, i);
> +    }
>  }
> =20
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 9b60378e28..ed88b4599a 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -43,7 +43,7 @@ typedef struct SpaprIrq {
> =20
>      void (*init)(SpaprMachineState *spapr, Error **errp);
>      int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **=
errp);
> -    void (*free)(SpaprMachineState *spapr, int irq, int num);
> +    void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
>=20


