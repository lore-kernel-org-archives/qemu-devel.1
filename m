Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7075AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98238206B2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98238206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3k85-0006if-8J
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 13:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3k7G-000624-Ho; Thu, 06 Aug 2020 13:55:46 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:57789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3k7C-0005KU-WD; Thu, 06 Aug 2020 13:55:46 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.59])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 3556B5475BDA;
 Thu,  6 Aug 2020 19:55:31 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 19:55:30 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003cabd08b2-0e58-4f73-a075-b57124cc823a,
 96EDEDBD7B7627A0205C40E9E2B74F8D513A659B) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 for-5.2 3/5] ppc/xive: Introduce dedicated
 kvm_irqchip_in_kernel() wrappers
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159673295739.766512.2950380687630225803.stgit@bahia.lan>
 <159673298011.766512.17389427967409788911.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <64551e66-e867-037e-bf2e-efa22ebdd324@kaod.org>
Date: Thu, 6 Aug 2020 19:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159673298011.766512.17389427967409788911.stgit@bahia.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 6c7ffe20-f65f-40cd-82be-8b15857f9c28
X-Ovh-Tracer-Id: 4904982945362643875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgedvieejfedvhfduhfffueevheeludffhfdvkeehleegtddttdfhieegveeghfffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 13:55:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 6:56 PM, Greg Kurz wrote:
> Calls to the KVM XIVE device are guarded by kvm_irqchip_in_kernel(). This
> ensures that QEMU won't try to use the device if KVM is disabled or if
> an in-kernel irqchip isn't required.
> 
> When using ic-mode=dual with the pseries machine, we have two possible
> interrupt controllers: XIVE and XICS. The kvm_irqchip_in_kernel() helper
> will return true as soon as any of the KVM device is created. It might
> lure QEMU to think that the other one is also around, while it is not.
> This is exactly what happens with ic-mode=dual at machine init when
> claiming IRQ numbers, which must be done on all possible IRQ backends,
> eg. RTAS event sources or the PHB0 LSI table : only the KVM XICS device
> is active but we end up calling kvmppc_xive_source_reset_one() anyway,
> which fails. This doesn't cause any trouble because of another bug :
> kvmppc_xive_source_reset_one() lacks an error_setg() and callers don't
> see the failure.
> 
> Most of the other kvmppc_xive_* functions have similar xive->fd
> checks to filter out the case when KVM XIVE isn't active. It
> might look safer to have idempotent functions but it doesn't
> really help to understand what's going on when debugging.
> 
> Since we already have all the kvm_irqchip_in_kernel() in place,
> also have the callers to check xive->fd as well before calling
> KVM XIVE specific code. This is straight-forward for the spapr
> specific XIVE code. Some more care is needed for the platform
> agnostic XIVE code since it cannot access xive->fd directly.
> Introduce new in_kernel() methods in some base XIVE classes
> for this purpose and implement them only in spapr.
> 
> In all cases, we still need to call kvm_irqchip_in_kernel() so that
> compilers can optimize the kvmppc_xive_* calls away when CONFIG_KVM
> isn't defined, thus avoiding the need for stubs.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: Introduce in_kernel() abstract methods in the base XIVE classes
> ---
>  hw/intc/spapr_xive.c  |   53 ++++++++++++++++++++++++++++++++++++-------------
>  hw/intc/xive.c        |   28 +++++++++++++++++++-------
>  include/hw/ppc/xive.h |    2 ++
>  3 files changed, 62 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 89c8cd96670b..cd001c580e89 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -148,12 +148,19 @@ static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
>      xive_end_queue_pic_print_info(end, 6, mon);
>  }
>  
> +/*
> + * kvm_irqchip_in_kernel() will cause the compiler to turn this
> + * info a nop if CONFIG_KVM isn't defined.
> + */
> +#define spapr_xive_in_kernel(xive) \
> +    (kvm_irqchip_in_kernel() && (xive)->fd != -1)
> +

This looks ok. SpaprXive is the userspace frontend device of 
the KVM XIVE native device in the hypervisor.

>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
>  {
>      XiveSource *xsrc = &xive->source;
>      int i;
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_synchronize_state(xive, &local_err);
> @@ -507,8 +514,10 @@ static const VMStateDescription vmstate_spapr_xive_eas = {
>  
>  static int vmstate_spapr_xive_pre_save(void *opaque)
>  {
> -    if (kvm_irqchip_in_kernel()) {
> -        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
> +    SpaprXive *xive = SPAPR_XIVE(opaque);
> +
> +    if (spapr_xive_in_kernel(xive)) {
> +        return kvmppc_xive_pre_save(xive);
>      }
>  
>      return 0;
> @@ -520,8 +529,10 @@ static int vmstate_spapr_xive_pre_save(void *opaque)
>   */
>  static int spapr_xive_post_load(SpaprInterruptController *intc, int version_id)
>  {
> -    if (kvm_irqchip_in_kernel()) {
> -        return kvmppc_xive_post_load(SPAPR_XIVE(intc), version_id);
> +    SpaprXive *xive = SPAPR_XIVE(intc);
> +
> +    if (spapr_xive_in_kernel(xive)) {
> +        return kvmppc_xive_post_load(xive, version_id);
>      }
>  
>      return 0;
> @@ -564,7 +575,7 @@ static int spapr_xive_claim_irq(SpaprInterruptController *intc, int lisn,
>          xive_source_irq_set_lsi(xsrc, lisn);
>      }
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
>      }
>  
> @@ -641,7 +652,7 @@ static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
>  {
>      SpaprXive *xive = SPAPR_XIVE(intc);
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          kvmppc_xive_source_set_irq(&xive->source, irq, val);
>      } else {
>          xive_source_set_irq(&xive->source, irq, val);
> @@ -749,11 +760,21 @@ static void spapr_xive_deactivate(SpaprInterruptController *intc)
>  
>      spapr_xive_mmio_set_enabled(xive, false);
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          kvmppc_xive_disconnect(intc);
>      }
>  }
>  
> +static bool spapr_xive_in_kernel_xptr(const XivePresenter *xptr)
> +{
> +    return spapr_xive_in_kernel(SPAPR_XIVE(xptr));
> +}

This is mostly OK, a XivePresenter is a part of the XiveRouter.

> +static bool spapr_xive_in_kernel_xn(const XiveNotifier *xn)
> +{
> +    return spapr_xive_in_kernel(SPAPR_XIVE(xn));
> +}


This is weird. we have other XiveNotifiers which have no relation
with a kernel backend.

>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -761,6 +782,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      SpaprInterruptControllerClass *sicc = SPAPR_INTC_CLASS(klass);
>      XivePresenterClass *xpc = XIVE_PRESENTER_CLASS(klass);
>      SpaprXiveClass *sxc = SPAPR_XIVE_CLASS(klass);
> +    XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
>  
>      dc->desc    = "sPAPR XIVE Interrupt Controller";
>      device_class_set_props(dc, spapr_xive_properties);
> @@ -788,6 +810,9 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      sicc->post_load = spapr_xive_post_load;
>  
>      xpc->match_nvt  = spapr_xive_match_nvt;
> +    xpc->in_kernel  = spapr_xive_in_kernel_xptr;
> +
> +    xnc->in_kernel  = spapr_xive_in_kernel_xn;
>  }
>  
>  static const TypeInfo spapr_xive_info = {
> @@ -1058,7 +1083,7 @@ static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
>          new_eas.w = xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
>      }
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err);
> @@ -1379,7 +1404,7 @@ static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
>       */
>  
>  out:
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &local_err);
> @@ -1480,7 +1505,7 @@ static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
>          args[2] = 0;
>      }
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &local_err);
> @@ -1642,7 +1667,7 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
>          return H_P3;
>      }
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          args[0] = kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
>                                       flags & SPAPR_XIVE_ESB_STORE);
>      } else {
> @@ -1717,7 +1742,7 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
>       * under KVM
>       */
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_sync_source(xive, lisn, &local_err);
> @@ -1761,7 +1786,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
>  
>      device_legacy_reset(DEVICE(xive));
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (spapr_xive_in_kernel(xive)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_reset(xive, &local_err);
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9b55e0356c62..27d27fdc9ee4 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -592,6 +592,17 @@ static const char * const xive_tctx_ring_names[] = {
>      "USER", "OS", "POOL", "PHYS",
>  };
>  
> +/*
> + * kvm_irqchip_in_kernel() will cause the compiler to turn this
> + * info a nop if CONFIG_KVM isn't defined.
> + */
> +#define xive_in_kernel(xptr)                                  \
> +    (kvm_irqchip_in_kernel() &&                                         \
> +     ({                                                                 \
> +         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);      \
> +         xpc->in_kernel ? xpc->in_kernel(xptr) : false;                 \
> +     }))
> +
>
>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
>  {
>      int cpu_index;
> @@ -606,7 +617,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
>  
>      cpu_index = tctx->cs ? tctx->cs->cpu_index : -1;
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (xive_in_kernel(tctx->xptr)) {
>          Error *local_err = NULL;
>  
>          kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
> @@ -671,7 +682,7 @@ static void xive_tctx_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* Connect the presenter to the VCPU (required for CPU hotplug) */
> -    if (kvm_irqchip_in_kernel()) {
> +    if (xive_in_kernel(tctx->xptr)) {
>          kvmppc_xive_cpu_connect(tctx, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> @@ -682,10 +693,11 @@ static void xive_tctx_realize(DeviceState *dev, Error **errp)
>  
>  static int vmstate_xive_tctx_pre_save(void *opaque)
>  {
> +    XiveTCTX *tctx = XIVE_TCTX(opaque);
>      Error *local_err = NULL;
>  
> -    if (kvm_irqchip_in_kernel()) {
> -        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
> +    if (xive_in_kernel(tctx->xptr)) {
> +        kvmppc_xive_cpu_get_state(tctx, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              return -1;
> @@ -697,14 +709,15 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
>  
>  static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
>  {
> +    XiveTCTX *tctx = XIVE_TCTX(opaque);
>      Error *local_err = NULL;
>  
> -    if (kvm_irqchip_in_kernel()) {
> +    if (xive_in_kernel(tctx->xptr)) {
>          /*
>           * Required for hotplugged CPU, for which the state comes
>           * after all states of the machine.
>           */
> -        kvmppc_xive_cpu_set_state(XIVE_TCTX(opaque), &local_err);
> +        kvmppc_xive_cpu_set_state(tctx, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              return -1;
> @@ -1128,6 +1141,7 @@ static void xive_source_reset(void *dev)
>  static void xive_source_realize(DeviceState *dev, Error **errp)
>  {
>      XiveSource *xsrc = XIVE_SOURCE(dev);
> +    XiveNotifierClass *xnc = XIVE_NOTIFIER_GET_CLASS(xsrc->xive);
>  
>      assert(xsrc->xive);
>  
> @@ -1147,7 +1161,7 @@ static void xive_source_realize(DeviceState *dev, Error **errp)
>      xsrc->status = g_malloc0(xsrc->nr_irqs);
>      xsrc->lsi_map = bitmap_new(xsrc->nr_irqs);
>  
> -    if (!kvm_irqchip_in_kernel()) {
> +    if (!xnc->in_kernel || !xnc->in_kernel(xsrc->xive)) {
>          memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
>                                &xive_source_esb_ops, xsrc, "xive.esb",
>                                (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 705cf48176fc..aa46e3fcf512 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -161,6 +161,7 @@ typedef struct XiveNotifier XiveNotifier;
>  typedef struct XiveNotifierClass {
>      InterfaceClass parent;
>      void (*notify)(XiveNotifier *xn, uint32_t lisn);
> +    bool (*in_kernel)(const XiveNotifier *xn);
>  } XiveNotifierClass;
>  
>  /*
> @@ -396,6 +397,7 @@ typedef struct XivePresenterClass {
>                       uint8_t nvt_blk, uint32_t nvt_idx,
>                       bool cam_ignore, uint8_t priority,
>                       uint32_t logic_serv, XiveTCTXMatch *match);
> +    bool (*in_kernel)(const XivePresenter *xptr);
>  } XivePresenterClass;
>  
>  int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> 
> 

It seems redundant. Can we introduce a new XiveBackend QOM interface 
which would implement an in_kernel() handler ? and XiveRouter would 
inherit from it. 

C.






