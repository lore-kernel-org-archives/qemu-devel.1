Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77916C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348AC206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348AC206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFasS-0003gT-3d
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 05:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFarg-00036i-MT
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFare-0000K1-Ou
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:24:08 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:41599)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFare-0000IC-FO
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:24:06 -0400
Received: from player694.ha.ovh.net (unknown [10.109.160.143])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 39AC61AC4F2
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 11:24:03 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id C0A4DA67597F;
 Wed,  2 Oct 2019 09:23:50 +0000 (UTC)
Subject: Re: [PATCH v3 23/34] spapr, xics, xive: Move irq claim and free from
 SpaprIrq to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-24-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4ba2ac76-974f-28f5-54cb-45da6192372a@kaod.org>
Date: Wed, 2 Oct 2019 11:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002025208.3487-24-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7832604177431104409
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeeigdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.226
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
> These methods, like cpu_intc_create, really belong to the interrupt
> controller, but need to be called on all possible intcs.
>=20
> Like cpu_intc_create, therefore, make them methods on the intc and
> always call it for all existing intcs.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive.c        |  71 ++++++++++++-----------
>  hw/intc/xics_spapr.c        |  29 ++++++++++
>  hw/ppc/spapr_irq.c          | 110 +++++++++++-------------------------
>  include/hw/ppc/spapr_irq.h  |   5 +-
>  include/hw/ppc/spapr_xive.h |   2 -
>  5 files changed, 102 insertions(+), 115 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 9338daba3d..ff1a175b44 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -487,6 +487,42 @@ static const VMStateDescription vmstate_spapr_xive=
 =3D {
>      },
>  };
> =20
> +static int spapr_xive_claim_irq(SpaprInterruptController *intc, int li=
sn,
> +                                bool lsi, Error **errp)
> +{
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> +    XiveSource *xsrc =3D &xive->source;
> +
> +    assert(lisn < xive->nr_irqs);
> +
> +    if (xive_eas_is_valid(&xive->eat[lisn])) {
> +        error_setg(errp, "IRQ %d is not free", lisn);
> +        return -EBUSY;
> +    }
> +
> +    /*
> +     * Set default values when allocating an IRQ number
> +     */
> +    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID | EAS_MASKED);
> +    if (lsi) {
> +        xive_source_irq_set_lsi(xsrc, lisn);
> +    }
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
> +    }
> +
> +    return 0;
> +}
> +
> +static void spapr_xive_free_irq(SpaprInterruptController *intc, int li=
sn)
> +{
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> +    assert(lisn < xive->nr_irqs);
> +
> +    xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> +}
> +
>  static Property spapr_xive_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
>      DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
> @@ -536,6 +572,8 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      xrc->get_tctx =3D spapr_xive_get_tctx;
> =20
>      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
> +    sicc->claim_irq =3D spapr_xive_claim_irq;
> +    sicc->free_irq =3D spapr_xive_free_irq;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> @@ -557,39 +595,6 @@ static void spapr_xive_register_types(void)
> =20
>  type_init(spapr_xive_register_types)
> =20
> -int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **=
errp)
> -{
> -    XiveSource *xsrc =3D &xive->source;
> -
> -    assert(lisn < xive->nr_irqs);
> -
> -    if (xive_eas_is_valid(&xive->eat[lisn])) {
> -        error_setg(errp, "IRQ %d is not free", lisn);
> -        return -EBUSY;
> -    }
> -
> -    /*
> -     * Set default values when allocating an IRQ number
> -     */
> -    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID | EAS_MASKED);
> -    if (lsi) {
> -        xive_source_irq_set_lsi(xsrc, lisn);
> -    }
> -
> -    if (kvm_irqchip_in_kernel()) {
> -        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
> -    }
> -
> -    return 0;
> -}
> -
> -void spapr_xive_irq_free(SpaprXive *xive, int lisn)
> -{
> -    assert(lisn < xive->nr_irqs);
> -
> -    xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> -}
> -
>  /*
>   * XIVE hcalls
>   *
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 946311b858..224fe1efcd 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -346,6 +346,33 @@ static int xics_spapr_cpu_intc_create(SpaprInterru=
ptController *intc,
>      return 0;
>  }
> =20
> +static int xics_spapr_claim_irq(SpaprInterruptController *intc, int ir=
q,
> +                                bool lsi, Error **errp)
> +{
> +    ICSState *ics =3D ICS_SPAPR(intc);
> +
> +    assert(ics);
> +    assert(ics_valid_irq(ics, irq));
> +
> +    if (!ics_irq_free(ics, irq - ics->offset)) {
> +        error_setg(errp, "IRQ %d is not free", irq);
> +        return -EBUSY;
> +    }
> +
> +    ics_set_irq_type(ics, irq - ics->offset, lsi);
> +    return 0;
> +}
> +
> +static void xics_spapr_free_irq(SpaprInterruptController *intc, int ir=
q)
> +{
> +    ICSState *ics =3D ICS_SPAPR(intc);
> +    uint32_t srcno =3D irq - ics->offset;
> +
> +    assert(ics_valid_irq(ics, irq));
> +
> +    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -355,6 +382,8 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
>      device_class_set_parent_realize(dc, ics_spapr_realize,
>                                      &isc->parent_realize);
>      sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
> +    sicc->claim_irq =3D xics_spapr_claim_irq;
> +    sicc->free_irq =3D xics_spapr_free_irq;
>  }
> =20
>  static const TypeInfo ics_spapr_info =3D {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 9cb2fc71ca..83882cfad3 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,33 +98,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *sp=
apr,
>   * XICS IRQ backend.
>   */
> =20
> -static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> -{
> -    ICSState *ics =3D spapr->ics;
> -
> -    assert(ics);
> -    assert(ics_valid_irq(ics, irq));
> -
> -    if (!ics_irq_free(ics, irq - ics->offset)) {
> -        error_setg(errp, "IRQ %d is not free", irq);
> -        return -1;
> -    }
> -
> -    ics_set_irq_type(ics, irq - ics->offset, lsi);
> -    return 0;
> -}
> -
> -static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
> -{
> -    ICSState *ics =3D spapr->ics;
> -    uint32_t srcno =3D irq - ics->offset;
> -
> -    assert(ics_valid_irq(ics, irq));
> -
> -    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> -}
> -
>  static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monito=
r *mon)
>  {
>      CPUState *cs;
> @@ -182,8 +155,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .claim       =3D spapr_irq_claim_xics,
> -    .free        =3D spapr_irq_free_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
> @@ -196,17 +167,6 @@ SpaprIrq spapr_irq_xics =3D {
>   * XIVE IRQ backend.
>   */
> =20
> -static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> -{
> -    return spapr_xive_irq_claim(spapr->xive, irq, lsi, errp);
> -}
> -
> -static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> -{
> -    spapr_xive_irq_free(spapr->xive, irq);
> -}
> -
>  static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
>                                        Monitor *mon)
>  {
> @@ -272,8 +232,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .xics        =3D false,
>      .xive        =3D true,
> =20
> -    .claim       =3D spapr_irq_claim_xive,
> -    .free        =3D spapr_irq_free_xive,
>      .print_info  =3D spapr_irq_print_info_xive,
>      .dt_populate =3D spapr_dt_xive,
>      .post_load   =3D spapr_irq_post_load_xive,
> @@ -301,33 +259,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSta=
te *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
> =20
> -static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -    int ret;
> -
> -    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return ret;
> -    }
> -
> -    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return ret;
> -    }
> -
> -    return ret;
> -}
> -
> -static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
> -{
> -    spapr_irq_xics.free(spapr, irq);
> -    spapr_irq_xive.free(spapr, irq);
> -}
> -
>  static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monito=
r *mon)
>  {
>      spapr_irq_current(spapr)->print_info(spapr, mon);
> @@ -401,8 +332,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .xics        =3D true,
>      .xive        =3D true,
> =20
> -    .claim       =3D spapr_irq_claim_dual,
> -    .free        =3D spapr_irq_free_dual,
>      .print_info  =3D spapr_irq_print_info_dual,
>      .dt_populate =3D spapr_irq_dt_populate_dual,
>      .post_load   =3D spapr_irq_post_load_dual,
> @@ -572,8 +501,11 @@ void spapr_irq_init(SpaprMachineState *spapr, Erro=
r **errp)
> =20
>          /* Enable the CPU IPIs */
>          for (i =3D 0; i < nr_servers; ++i) {
> -            if (spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i,
> -                                     false, errp) < 0) {
> +            SpaprInterruptControllerClass *sicc
> +                =3D SPAPR_INTC_GET_CLASS(spapr->xive);
> +
> +            if (sicc->claim_irq(SPAPR_INTC(spapr->xive), SPAPR_IRQ_IPI=
 + i,
> +                                false, errp) < 0) {
>                  return;
>              }
>          }
> @@ -587,21 +519,45 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> =20
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
>  {
> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> +    int i;
> +    int rc;
> +
>      assert(irq >=3D SPAPR_XIRQ_BASE);
>      assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> =20
> -    return spapr->irq->claim(spapr, irq, lsi, errp);
> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
> +        SpaprInterruptController *intc =3D intcs[i];
> +        if (intc) {
> +            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLA=
SS(intc);
> +            rc =3D sicc->claim_irq(intc, irq, lsi, errp);
> +            if (rc < 0) {
> +                return rc;
> +            }
> +        }
> +    }
> +
> +    return 0;
>  }
> =20
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>  {
> -    int i;
> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> +    int i, j;
> =20
>      assert(irq >=3D SPAPR_XIRQ_BASE);
>      assert((irq + num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> =20
>      for (i =3D irq; i < (irq + num); i++) {
> -        spapr->irq->free(spapr, i);
> +        for (j =3D 0; j < ARRAY_SIZE(intcs); j++) {
> +            SpaprInterruptController *intc =3D intcs[j];
> +
> +            if (intc) {
> +                SpaprInterruptControllerClass *sicc
> +                    =3D SPAPR_INTC_GET_CLASS(intc);
> +                sicc->free_irq(intc, i);
> +            }
> +        }
>      }
>  }
> =20
> @@ -726,8 +682,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .xics        =3D true,
>      .xive        =3D false,
> =20
> -    .claim       =3D spapr_irq_claim_xics,
> -    .free        =3D spapr_irq_free_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5e641e23c1..adfef0fcbe 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -50,6 +50,9 @@ typedef struct SpaprInterruptControllerClass {
>       */
>      int (*cpu_intc_create)(SpaprInterruptController *intc,
>                              PowerPCCPU *cpu, Error **errp);
> +    int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi=
,
> +                     Error **errp);
> +    void (*free_irq)(SpaprInterruptController *intc, int irq);
>  } SpaprInterruptControllerClass;
> =20
>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> @@ -67,8 +70,6 @@ typedef struct SpaprIrq {
>      bool        xics;
>      bool        xive;
> =20
> -    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **=
errp);
> -    void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 0df20a6590..8f875673f5 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -54,8 +54,6 @@ typedef struct SpaprXive {
>   */
>  #define SPAPR_XIVE_BLOCK_ID 0x0
> =20
> -int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **=
errp);
> -void spapr_xive_irq_free(SpaprXive *xive, int lisn);
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
>  int spapr_xive_post_load(SpaprXive *xive, int version_id);
> =20
>=20


