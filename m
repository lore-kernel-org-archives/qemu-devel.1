Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BBC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1883321D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1883321D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDDza-0005sT-0n
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 16:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDDvo-0003Ls-Lv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDDvm-0006r1-VC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:30:36 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:58538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDDvm-0006iW-ML
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:30:34 -0400
Received: from player773.ha.ovh.net (unknown [10.108.57.183])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 041A1141BA3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:30:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 75443A3CBCAB;
 Wed, 25 Sep 2019 20:30:16 +0000 (UTC)
Date: Wed, 25 Sep 2019 22:30:15 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 12/20] spapr: Simplify spapr_qirq() handling
Message-ID: <20190925223015.67ac8ea1@bahia.lan>
In-Reply-To: <20190925064534.19155-13-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-13-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14871448921947085286
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdduheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.79.46
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
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 16:45:26 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently spapr_qirq() used to find the qemu_irq for an spapr global irq
> number, redirects through the SpaprIrq::qirq method.  But the array of
> qemu_irqs is allocated in the PAPR layer, not the backends, and so the
> method implementations all return the same thing, just differing in the
> preliminary checks they make.
> 
> So, we can remove the method, and just implement spapr_qirq() directly,
> including all the relevant checks in one place.  We change all those
> checks into assert()s as well, since a failure here indicates an error in
> the calling code.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c         | 47 ++++++++++----------------------------
>  include/hw/ppc/spapr_irq.h |  1 -
>  2 files changed, 12 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 9a9e486eb5..038bfffff4 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -150,17 +150,6 @@ static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq, int num)
>      }
>  }
>  
> -static qemu_irq spapr_qirq_xics(SpaprMachineState *spapr, int irq)
> -{
> -    ICSState *ics = spapr->ics;
> -
> -    if (ics_valid_irq(ics, irq)) {
> -        return spapr->qirqs[irq];
> -    }
> -
> -    return NULL;
> -}
> -
>  static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor *mon)
>  {
>      CPUState *cs;
> @@ -242,7 +231,6 @@ SpaprIrq spapr_irq_xics = {
>      .init        = spapr_irq_init_xics,
>      .claim       = spapr_irq_claim_xics,
>      .free        = spapr_irq_free_xics,
> -    .qirq        = spapr_qirq_xics,
>      .print_info  = spapr_irq_print_info_xics,
>      .dt_populate = spapr_dt_xics,
>      .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
> @@ -300,20 +288,6 @@ static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq, int num)
>      }
>  }
>  
> -static qemu_irq spapr_qirq_xive(SpaprMachineState *spapr, int irq)
> -{
> -    SpaprXive *xive = spapr->xive;
> -
> -    if ((irq < SPAPR_XIRQ_BASE) || (irq >= xive->nr_irqs)) {
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
> @@ -413,7 +387,6 @@ SpaprIrq spapr_irq_xive = {
>      .init        = spapr_irq_init_xive,
>      .claim       = spapr_irq_claim_xive,
>      .free        = spapr_irq_free_xive,
> -    .qirq        = spapr_qirq_xive,
>      .print_info  = spapr_irq_print_info_xive,
>      .dt_populate = spapr_dt_xive,
>      .cpu_intc_create = spapr_irq_cpu_intc_create_xive,
> @@ -487,11 +460,6 @@ static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq, int num)
>      spapr_irq_xive.free(spapr, irq, num);
>  }
>  
> -static qemu_irq spapr_qirq_dual(SpaprMachineState *spapr, int irq)
> -{
> -    return spapr_irq_current(spapr)->qirq(spapr, irq);
> -}
> -
>  static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor *mon)
>  {
>      spapr_irq_current(spapr)->print_info(spapr, mon);
> @@ -586,7 +554,6 @@ SpaprIrq spapr_irq_dual = {
>      .init        = spapr_irq_init_dual,
>      .claim       = spapr_irq_claim_dual,
>      .free        = spapr_irq_free_dual,
> -    .qirq        = spapr_qirq_dual,
>      .print_info  = spapr_irq_print_info_dual,
>      .dt_populate = spapr_irq_dt_populate_dual,
>      .cpu_intc_create = spapr_irq_cpu_intc_create_dual,
> @@ -700,7 +667,18 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>  
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>  {
> -    return spapr->irq->qirq(spapr, irq);
> +    assert(irq >= SPAPR_XIRQ_BASE);
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
>  
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
> @@ -803,7 +781,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .init        = spapr_irq_init_xics,
>      .claim       = spapr_irq_claim_xics,
>      .free        = spapr_irq_free_xics,
> -    .qirq        = spapr_qirq_xics,
>      .print_info  = spapr_irq_print_info_xics,
>      .dt_populate = spapr_dt_xics,
>      .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 7e26288fcd..a4e790ef60 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -44,7 +44,6 @@ typedef struct SpaprIrq {
>      void (*init)(SpaprMachineState *spapr, Error **errp);
>      int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
>      void (*free)(SpaprMachineState *spapr, int irq, int num);
> -    qemu_irq (*qirq)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);


