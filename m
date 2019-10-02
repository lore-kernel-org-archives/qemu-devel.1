Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3514C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34D8215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34D8215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFayB-0005kw-Sj
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 05:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFawp-00057x-Kd
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFawn-00039m-Oi
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:29:27 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:46228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFawn-00038W-IR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:29:25 -0400
Received: from player738.ha.ovh.net (unknown [10.109.146.211])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id C05A024FF23
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 11:29:22 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id D7062A98681B;
 Wed,  2 Oct 2019 09:29:09 +0000 (UTC)
Date: Wed, 2 Oct 2019 11:29:08 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 30/34] spapr, xics, xive: Move SpaprIrq::reset hook
 logic into activate/deactivate
Message-ID: <20191002112908.2bf1ea0b@bahia.lan>
In-Reply-To: <20191002025208.3487-31-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-31-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7922394698646985190
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeeigddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.51.82
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
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  2 Oct 2019 12:52:04 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> It turns out that all the logic in the SpaprIrq::reset hooks (and some in
> the SpaprIrq::post_load hooks) isn't really related to resetting the irq
> backend (that's handled by the backends' own reset routines).  Rather its
> about getting the backend ready to be the active interrupt controller or
> stopping being the active interrupt controller - reset (and post_load) is
> just the only time that changes at present.
> 
> To make this flow clearer, move the logic into the explicit backend
> activate and deactivate hooks.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/spapr_xive.c       | 35 ++++++++++++++++++++
>  hw/intc/xics_spapr.c       | 16 +++++++++
>  hw/ppc/spapr_irq.c         | 67 ++------------------------------------
>  include/hw/ppc/spapr_irq.h |  4 ++-
>  4 files changed, 57 insertions(+), 65 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 37ffb74ca5..e8b946982c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -640,6 +640,39 @@ static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_servers,
>                       plat_res_int_priorities, sizeof(plat_res_int_priorities)));
>  }
>  
> +static void spapr_xive_activate(SpaprInterruptController *intc, Error **errp)
> +{
> +    SpaprXive *xive = SPAPR_XIVE(intc);
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +        /* (TCG) Set the OS CAM line of the thread interrupt context. */
> +        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
> +    }
> +

I think this ^^ can go...

> +    if (kvm_enabled()) {
> +        if (spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp) < 0) {
> +            return;
> +        }
> +    }
> +

... here. If which case, spapr_irq_init_kvm() could be called from
set_active_intc() instead of being called by each backend if I get
it right. This would avoid the frontend->backend->frontend flow.

> +    /* Activate the XIVE MMIOs */
> +    spapr_xive_mmio_set_enabled(xive, true);
> +}
> +
> +static void spapr_xive_deactivate(SpaprInterruptController *intc)
> +{
> +    SpaprXive *xive = SPAPR_XIVE(intc);
> +
> +    spapr_xive_mmio_set_enabled(xive, false);
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        kvmppc_xive_disconnect(intc);
> +    }
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -658,6 +691,8 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      xrc->write_nvt = spapr_xive_write_nvt;
>      xrc->get_tctx = spapr_xive_get_tctx;
>  
> +    sicc->activate = spapr_xive_activate;
> +    sicc->deactivate = spapr_xive_deactivate;
>      sicc->cpu_intc_create = spapr_xive_cpu_intc_create;
>      sicc->claim_irq = spapr_xive_claim_irq;
>      sicc->free_irq = spapr_xive_free_irq;
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 4eabafc7e1..8abbc799ba 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -395,6 +395,20 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
>      ics_pic_print_info(ics, mon);
>  }
>  
> +static void xics_spapr_activate(SpaprInterruptController *intc, Error **errp)
> +{
> +    if (kvm_enabled()) {
> +        spapr_irq_init_kvm(xics_kvm_connect, intc, errp);
> +    }
> +}
> +
> +static void xics_spapr_deactivate(SpaprInterruptController *intc)
> +{
> +    if (kvm_irqchip_in_kernel()) {
> +        xics_kvm_disconnect(intc);
> +    }
> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -403,6 +417,8 @@ static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  
>      device_class_set_parent_realize(dc, ics_spapr_realize,
>                                      &isc->parent_realize);
> +    sicc->activate = xics_spapr_activate;
> +    sicc->deactivate = xics_spapr_deactivate;
>      sicc->cpu_intc_create = xics_spapr_cpu_intc_create;
>      sicc->claim_irq = xics_spapr_claim_irq;
>      sicc->free_irq = xics_spapr_free_irq;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 7cd18e5b15..f70b331f44 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -65,9 +65,9 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)
>      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>  }
>  
> -static int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
> -                              SpaprInterruptController *intc,
> -                              Error **errp)
> +int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
> +                       SpaprInterruptController *intc,
> +                       Error **errp)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>      Error *local_err = NULL;
> @@ -112,11 +112,6 @@ static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
>      return 0;
>  }
>  
> -static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
> -{
> -    spapr_irq_init_kvm(xics_kvm_connect, SPAPR_INTC(spapr->ics), errp);
> -}
> -
>  SpaprIrq spapr_irq_xics = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
> @@ -124,7 +119,6 @@ SpaprIrq spapr_irq_xics = {
>      .xive        = false,
>  
>      .post_load   = spapr_irq_post_load_xics,
> -    .reset       = spapr_irq_reset_xics,
>  };
>  
>  /*
> @@ -136,26 +130,6 @@ static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int version_id)
>      return spapr_xive_post_load(spapr->xive, version_id);
>  }
>  
> -static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
> -{
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -
> -        /* (TCG) Set the OS CAM line of the thread interrupt context. */
> -        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
> -    }
> -
> -    if (spapr_irq_init_kvm(kvmppc_xive_connect,
> -                           SPAPR_INTC(spapr->xive), errp) < 0) {
> -        return;
> -    }
> -
> -    /* Activate the XIVE MMIOs */
> -    spapr_xive_mmio_set_enabled(spapr->xive, true);
> -}
> -
>  SpaprIrq spapr_irq_xive = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
> @@ -163,7 +137,6 @@ SpaprIrq spapr_irq_xive = {
>      .xive        = true,
>  
>      .post_load   = spapr_irq_post_load_xive,
> -    .reset       = spapr_irq_reset_xive,
>  };
>  
>  /*
> @@ -187,37 +160,9 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
>  
>  static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int version_id)
>  {
> -    /*
> -     * Force a reset of the XIVE backend after migration. The machine
> -     * defaults to XICS at startup.
> -     */
> -    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> -        if (kvm_irqchip_in_kernel()) {
> -            xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
> -        }
> -        spapr_irq_xive.reset(spapr, &error_fatal);
> -    }
> -
>      return spapr_irq_current(spapr)->post_load(spapr, version_id);
>  }
>  
> -static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
> -{
> -    /*
> -     * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
> -     * if selected.
> -     */
> -    spapr_xive_mmio_set_enabled(spapr->xive, false);
> -
> -    /* Destroy all KVM devices */
> -    if (kvm_irqchip_in_kernel()) {
> -        xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
> -        kvmppc_xive_disconnect(SPAPR_INTC(spapr->xive));
> -    }
> -
> -    spapr_irq_current(spapr)->reset(spapr, errp);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -228,7 +173,6 @@ SpaprIrq spapr_irq_dual = {
>      .xive        = true,
>  
>      .post_load   = spapr_irq_post_load_dual,
> -    .reset       = spapr_irq_reset_dual,
>  };
>  
>  
> @@ -512,10 +456,6 @@ void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
>      assert(!spapr->irq_map || bitmap_empty(spapr->irq_map, spapr->irq_map_nr));
>  
>      spapr_irq_update_active_intc(spapr);
> -
> -    if (spapr->irq->reset) {
> -        spapr->irq->reset(spapr, errp);
> -    }
>  }
>  
>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp)
> @@ -651,7 +591,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .xive        = false,
>  
>      .post_load   = spapr_irq_post_load_xics,
> -    .reset       = spapr_irq_reset_xics,
>  };
>  
>  static void spapr_irq_register_types(void)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index a5fdb963a8..1aff1c2eb7 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -84,7 +84,6 @@ typedef struct SpaprIrq {
>      bool        xive;
>  
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
> -    void (*reset)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
>  
>  extern SpaprIrq spapr_irq_xics;
> @@ -99,6 +98,9 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
>  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp);
>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp);
> +int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
> +                       SpaprInterruptController *intc,
> +                       Error **errp);
>  
>  /*
>   * XICS legacy routines


