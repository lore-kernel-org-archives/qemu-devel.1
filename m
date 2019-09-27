Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE223C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94248217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94248217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsGO-0002F1-33
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDrDW-0003dW-1S
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDrDU-0004wv-6O
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:27:29 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:39122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDrDU-0004wO-0Y
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:27:28 -0400
Received: from player737.ha.ovh.net (unknown [10.109.143.145])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9B8C310C7B6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 16:27:24 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 384B6E1118A;
 Fri, 27 Sep 2019 14:27:13 +0000 (UTC)
Date: Fri, 27 Sep 2019 16:27:12 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 24/33] spapr, xics, xive: Move set_irq from SpaprIrq
 to SpaprInterruptController
Message-ID: <20190927162712.049286e1@bahia.lan>
In-Reply-To: <20190927055028.11493-25-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-25-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2039004731314444774
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.51.249
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

On Fri, 27 Sep 2019 15:50:19 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This method depends only on the active irq controller.  Now that we've
> formalized the notion of active controller we can dispatch directly through
> that, rather than dispatching via SpaprIrq with the dual version having
> to do a second conditional dispatch.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/spapr_xive.c       | 12 +++++++++++
>  hw/intc/xics_spapr.c       |  9 +++++++++
>  hw/ppc/spapr_irq.c         | 41 ++++++++++----------------------------
>  include/hw/ppc/spapr_irq.h |  4 +++-
>  4 files changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index ff1a175b44..52d5e71793 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -553,6 +553,17 @@ static int spapr_xive_cpu_intc_create(SpaprInterruptController *intc,
>      return 0;
>  }
>  
> +static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
> +{
> +    SpaprXive *xive = SPAPR_XIVE(intc);
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        kvmppc_xive_source_set_irq(&xive->source, irq, val);
> +    } else {
> +        xive_source_set_irq(&xive->source, irq, val);
> +    }
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -574,6 +585,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      sicc->cpu_intc_create = spapr_xive_cpu_intc_create;
>      sicc->claim_irq = spapr_xive_claim_irq;
>      sicc->free_irq = spapr_xive_free_irq;
> +    sicc->set_irq = spapr_xive_set_irq;
>  }
>  
>  static const TypeInfo spapr_xive_info = {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 224fe1efcd..02372697f6 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -373,6 +373,14 @@ static void xics_spapr_free_irq(SpaprInterruptController *intc, int irq)
>      memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
>  }
>  
> +static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq, int val)
> +{
> +    ICSState *ics = ICS_SPAPR(intc);
> +    uint32_t srcno = irq - ics->offset;
> +
> +    ics_set_irq(ics, srcno, val);

And we have:

void ics_set_irq(void *opaque, int srcno, int val)
{
    ICSState *ics = (ICSState *)opaque;

    if (kvm_irqchip_in_kernel()) {
        ics_kvm_set_irq(ics, srcno, val);
        return;
    }

    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
        ics_set_irq_lsi(ics, srcno, val);
    } else {
        ics_set_irq_msi(ics, srcno, val);
    }
}

The kvm_irqchip_in_kernel() block would fit better in xics_spapr_set_irq(),
like it is already the case for XIVE. Maybe do it now while here ?

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -384,6 +392,7 @@ static void ics_spapr_class_init(ObjectClass *klass, void *data)
>      sicc->cpu_intc_create = xics_spapr_cpu_intc_create;
>      sicc->claim_irq = xics_spapr_claim_irq;
>      sicc->free_irq = xics_spapr_free_irq;
> +    sicc->set_irq = xics_spapr_set_irq;
>  }
>  
>  static const TypeInfo ics_spapr_info = {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index dfa875b7cd..4922062908 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -123,14 +123,6 @@ static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
>      return 0;
>  }
>  
> -static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
> -{
> -    SpaprMachineState *spapr = opaque;
> -    uint32_t srcno = irq - spapr->ics->offset;
> -
> -    ics_set_irq(spapr->ics, srcno, val);
> -}
> -
>  static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
>  {
>      Error *local_err = NULL;
> @@ -159,7 +151,6 @@ SpaprIrq spapr_irq_xics = {
>      .dt_populate = spapr_dt_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
> -    .set_irq     = spapr_irq_set_irq_xics,
>      .init_kvm    = spapr_irq_init_kvm_xics,
>  };
>  
> @@ -208,17 +199,6 @@ static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
>      spapr_xive_mmio_set_enabled(spapr->xive, true);
>  }
>  
> -static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
> -{
> -    SpaprMachineState *spapr = opaque;
> -
> -    if (kvm_irqchip_in_kernel()) {
> -        kvmppc_xive_source_set_irq(&spapr->xive->source, irq, val);
> -    } else {
> -        xive_source_set_irq(&spapr->xive->source, irq, val);
> -    }
> -}
> -
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **errp)
>  {
>      if (kvm_enabled()) {
> @@ -236,7 +216,6 @@ SpaprIrq spapr_irq_xive = {
>      .dt_populate = spapr_dt_xive,
>      .post_load   = spapr_irq_post_load_xive,
>      .reset       = spapr_irq_reset_xive,
> -    .set_irq     = spapr_irq_set_irq_xive,
>      .init_kvm    = spapr_irq_init_kvm_xive,
>  };
>  
> @@ -316,13 +295,6 @@ static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
>      spapr_irq_current(spapr)->reset(spapr, errp);
>  }
>  
> -static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
> -{
> -    SpaprMachineState *spapr = opaque;
> -
> -    spapr_irq_current(spapr)->set_irq(spapr, irq, val);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -336,7 +308,6 @@ SpaprIrq spapr_irq_dual = {
>      .dt_populate = spapr_irq_dt_populate_dual,
>      .post_load   = spapr_irq_post_load_dual,
>      .reset       = spapr_irq_reset_dual,
> -    .set_irq     = spapr_irq_set_irq_dual,
>      .init_kvm    = NULL, /* should not be used */
>  };
>  
> @@ -422,6 +393,15 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>      return 0;
>  }
>  
> +static void spapr_set_irq(void *opaque, int irq, int level)
> +{
> +    SpaprMachineState *spapr = SPAPR_MACHINE(opaque);
> +    SpaprInterruptControllerClass *sicc
> +        = SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +
> +    sicc->set_irq(spapr->active_intc, irq, level);
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -510,7 +490,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          spapr_xive_hcall_init(spapr);
>      }
>  
> -    spapr->qirqs = qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> +    spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
>                                        spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
>  
>  out:
> @@ -744,7 +724,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .dt_populate = spapr_dt_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
> -    .set_irq     = spapr_irq_set_irq_xics,
>      .init_kvm    = spapr_irq_init_kvm_xics,
>  };
>  
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 3102d152b2..8286a9aa63 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -56,6 +56,9 @@ typedef struct SpaprInterruptControllerClass {
>      int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
>                       Error **errp);
>      void (*free_irq)(SpaprInterruptController *intc, int irq);
> +
> +    /* These methods should only be called on the active intc */
> +    void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
>  } SpaprInterruptControllerClass;
>  
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> @@ -83,7 +86,6 @@ typedef struct SpaprIrq {
>                          void *fdt, uint32_t phandle);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
> -    void (*set_irq)(void *opaque, int srcno, int val);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
>  


