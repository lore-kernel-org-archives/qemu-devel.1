Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B24C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5FC222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5FC222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDOqc-0003tV-Ut
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDOph-0002kZ-FX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDOpe-0007jU-2c
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:08:59 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:41596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDOpd-0007im-T7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:08:58 -0400
Received: from player796.ha.ovh.net (unknown [10.109.146.106])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 08E6367B45
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:08:53 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id C44F9A26949A;
 Thu, 26 Sep 2019 08:08:42 +0000 (UTC)
Date: Thu, 26 Sep 2019 10:08:41 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 16/20] spapr, xics, xive: Better use of assert()s on irq
 claim/free paths
Message-ID: <20190926100841.5c8b779b@bahia.lan>
In-Reply-To: <20190925064534.19155-17-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-17-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8220476696712092134
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.80
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

On Wed, 25 Sep 2019 16:45:30 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The irq claim and free paths for both XICS and XIVE check for some
> validity conditions.  Some of these represent genuine runtime failures,
> however others - particularly checking that the basic irq number is in a
> sane range - could only fail in the case of bugs in the callin code.
> Therefore use assert()s instead of runtime failures for those.
> 
> In addition the non backend-specific part of the claim/free paths should
> only be used for PAPR external irqs, that is in the range SPAPR_XIRQ_BASE
> to the maximum irq number.  Put assert()s for that into the top level
> dispatchers as well.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/spapr_xive.c |  8 ++------
>  hw/ppc/spapr_irq.c   | 18 ++++++++++--------
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index c1c97192a7..47b5ec0b56 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -532,9 +532,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi)
>  {
>      XiveSource *xsrc = &xive->source;
>  
> -    if (lisn >= xive->nr_irqs) {
> -        return false;
> -    }
> +    assert(lisn < xive->nr_irqs);
>  
>      /*
>       * Set default values when allocating an IRQ number
> @@ -559,9 +557,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi)
>  
>  bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
>  {
> -    if (lisn >= xive->nr_irqs) {
> -        return false;
> -    }
> +    assert(lisn < xive->nr_irqs);
>  
>      xive->eat[lisn].w &= cpu_to_be64(~EAS_VALID);
>      return true;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index c40357a985..261d66ba17 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -118,11 +118,7 @@ static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool lsi,
>      ICSState *ics = spapr->ics;
>  
>      assert(ics);
> -
> -    if (!ics_valid_irq(ics, irq)) {
> -        error_setg(errp, "IRQ %d is invalid", irq);
> -        return -1;
> -    }
> +    assert(ics_valid_irq(ics, irq));
>  
>      if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
> @@ -138,9 +134,9 @@ static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
>      ICSState *ics = spapr->ics;
>      uint32_t srcno = irq - ics->offset;
>  
> -    if (ics_valid_irq(ics, irq)) {
> -        memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> -    }
> +    assert(ics_valid_irq(ics, irq));
> +
> +    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
>  }
>  
>  static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor *mon)
> @@ -628,6 +624,9 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
>  {
> +    assert(irq >= SPAPR_XIRQ_BASE);
> +    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +
>      return spapr->irq->claim(spapr, irq, lsi, errp);
>  }
>  
> @@ -635,6 +634,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>  {
>      int i;
>  
> +    assert(irq >= SPAPR_XIRQ_BASE);
> +    assert((irq+num) <= (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));

Non surprisingly this makes checkpatch unhappy:

ERROR: spaces required around that '+' (ctx:VxV)
#91: FILE: hw/ppc/spapr_irq.c:638:
+    assert((irq+num) <= (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));

With that fixed,

Reviewed-by: Greg Kurz <groug@kaod.org>

> +
>      for (i = irq; i < (irq + num); i++) {
>          spapr->irq->free(spapr, irq);
>      }


