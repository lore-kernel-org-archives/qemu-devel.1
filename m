Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15855C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0DB21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0DB21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDDlF-0007Ea-3y
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 16:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDDji-0006bU-Ah
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDDjf-0004Jw-2m
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:18:06 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:43602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDDje-0004Hx-RO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:18:03 -0400
Received: from player691.ha.ovh.net (unknown [10.108.57.153])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D8B186A1E5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:17:58 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 04037A534EF3;
 Wed, 25 Sep 2019 20:17:47 +0000 (UTC)
Date: Wed, 25 Sep 2019 22:17:46 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 11/20] spapr: Fix indexing of XICS irqs
Message-ID: <20190925221746.7b497c8c@bahia.lan>
In-Reply-To: <20190925064534.19155-12-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-12-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14660905640783354342
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgddugeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.42.102
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

On Wed, 25 Sep 2019 16:45:25 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr global irq numbers are different from the source numbers on the ICS
> when using XICS - they're offset by XICS_IRQ_BASE (0x1000).  But
> spapr_irq_set_irq_xics() was passing through the global irq number to
> the ICS code unmodified.
> 
> We only got away with this because of a counteracting bug - we were
> incorrectly adjusting the qemu_irq we returned for a requested global irq
> number.
> 
> That approach mostly worked but is very confusing, incorrectly relies on
> the way the qemu_irq array is allocated, and undermines the intention of
> having the global array of qemu_irqs for spapr have a consistent meaning
> regardless of irq backend.
> 
> So, fix both set_irq and qemu_irq indexing.  We rename some parameters at
> the same time to make it clear that they are referring to spapr global
> irq numbers.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

Further cleanup could be to have the XICS backend to only take global
irq numbers and to convert them to ICS source numbers internally. This
would put an end to the confusion between srcno/irq in the frontend
code.

>  hw/ppc/spapr_irq.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 300c65be3a..9a9e486eb5 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -153,10 +153,9 @@ static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq, int num)
>  static qemu_irq spapr_qirq_xics(SpaprMachineState *spapr, int irq)
>  {
>      ICSState *ics = spapr->ics;
> -    uint32_t srcno = irq - ics->offset;
>  
>      if (ics_valid_irq(ics, irq)) {
> -        return spapr->qirqs[srcno];
> +        return spapr->qirqs[irq];
>      }
>  
>      return NULL;
> @@ -204,9 +203,10 @@ static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
>      return 0;
>  }
>  
> -static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
> +static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
>  {
>      SpaprMachineState *spapr = opaque;
> +    uint32_t srcno = irq - spapr->ics->offset;
>  
>      ics_set_irq(spapr->ics, srcno, val);
>  }
> @@ -377,14 +377,14 @@ static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
>      spapr_xive_mmio_set_enabled(spapr->xive, true);
>  }
>  
> -static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
> +static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
>  {
>      SpaprMachineState *spapr = opaque;
>  
>      if (kvm_irqchip_in_kernel()) {
> -        kvmppc_xive_source_set_irq(&spapr->xive->source, srcno, val);
> +        kvmppc_xive_source_set_irq(&spapr->xive->source, irq, val);
>      } else {
> -        xive_source_set_irq(&spapr->xive->source, srcno, val);
> +        xive_source_set_irq(&spapr->xive->source, irq, val);
>      }
>  }
>  
> @@ -563,11 +563,11 @@ static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
>      spapr_irq_current(spapr)->reset(spapr, errp);
>  }
>  
> -static void spapr_irq_set_irq_dual(void *opaque, int srcno, int val)
> +static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
>  {
>      SpaprMachineState *spapr = opaque;
>  
> -    spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
> +    spapr_irq_current(spapr)->set_irq(spapr, irq, val);
>  }
>  
>  static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spapr)


