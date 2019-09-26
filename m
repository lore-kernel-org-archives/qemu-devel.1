Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B96C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6CB2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6CB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDObu-00027z-4z
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDOa5-0000JT-2q
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDOa3-0007ob-O2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:52:53 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:39717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDOa3-0007nG-Ic
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:52:51 -0400
Received: from player787.ha.ovh.net (unknown [10.108.35.223])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id E120D2025D8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:52:47 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id C3D17A58BDDA;
 Thu, 26 Sep 2019 07:52:37 +0000 (UTC)
Date: Thu, 26 Sep 2019 09:52:35 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 15/20] spapr: Handle freeing of multiple irqs in
 frontend only
Message-ID: <20190926095235.221fcc2a@bahia.lan>
In-Reply-To: <20190925064534.19155-16-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-16-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7948571870367422950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeefgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.109
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

On Wed, 25 Sep 2019 16:45:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_irq_free() can be used to free multiple irqs at once. That's useful
> for its callers, but there's no need to make the individual backend hooks
> handle this.  We can loop across the irqs in spapr_irq_free() itself and
> have the hooks just do one at time.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c         | 27 ++++++++++++---------------
>  include/hw/ppc/spapr_irq.h |  2 +-
>  2 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index db6755f3ab..c40357a985 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -133,16 +133,13 @@ static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool lsi,
>      return 0;
>  }
>  
> -static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq, int num)
> +static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
>  {
>      ICSState *ics = spapr->ics;
>      uint32_t srcno = irq - ics->offset;
> -    int i;
>  
>      if (ics_valid_irq(ics, irq)) {
> -        for (i = srcno; i < srcno + num; ++i) {
> -            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> -        }
> +        memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
>      }
>  }
>  
> @@ -269,13 +266,9 @@ static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool lsi,
>      return 0;
>  }
>  
> -static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq, int num)
> +static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
>  {
> -    int i;
> -
> -    for (i = irq; i < irq + num; ++i) {
> -        spapr_xive_irq_free(spapr->xive, i);
> -    }
> +    spapr_xive_irq_free(spapr->xive, irq);
>  }
>  
>  static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
> @@ -438,10 +431,10 @@ static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool lsi,
>      return ret;
>  }
>  
> -static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq, int num)
> +static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
>  {
> -    spapr_irq_xics.free(spapr, irq, num);
> -    spapr_irq_xive.free(spapr, irq, num);
> +    spapr_irq_xics.free(spapr, irq);
> +    spapr_irq_xive.free(spapr, irq);
>  }
>  
>  static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor *mon)
> @@ -640,7 +633,11 @@ int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
>  
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>  {
> -    spapr->irq->free(spapr, irq, num);
> +    int i;
> +
> +    for (i = irq; i < (irq + num); i++) {
> +        spapr->irq->free(spapr, irq);
> +    }
>  }
>  
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 9b60378e28..ed88b4599a 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -43,7 +43,7 @@ typedef struct SpaprIrq {
>  
>      void (*init)(SpaprMachineState *spapr, Error **errp);
>      int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
> -    void (*free)(SpaprMachineState *spapr, int irq, int num);
> +    void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);


