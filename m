Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD159C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9281D2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9281D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1rR-0004eY-Ov
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1ge-0003ML-DU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1ga-0000Zr-37
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:26:07 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:44022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1gY-0000Z5-JD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:26:03 -0400
Received: from player730.ha.ovh.net (unknown [10.108.54.119])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 83D891AE05E
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:25:59 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id C2A81A121495;
 Wed, 25 Sep 2019 07:25:48 +0000 (UTC)
Subject: Re: [PATCH 18/20] xive: Improve irq claim/free path
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-19-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3cdde622-4ca0-5edd-6bf7-ceb03895f1f2@kaod.org>
Date: Wed, 25 Sep 2019 09:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-19-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1623266193244523480
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.53.149
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
> spapr_xive_irq_claim() returns a bool to indicate if it succeeded.  But
> most of the callers and one callee use a richer Error * instead.  So us=
e
> that instead of a bool return so we can actually pass more informative
> errors up the stack.
>=20
> In addition it didn't actually check if the irq was already claimed, wh=
ich
> is one of the primary purposes of the claim path, so do that.
>=20
> spapr_xive_irq_free() also returned a bool... which no callers checked,=
 so
> just drop it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/spapr_xive.c        | 17 ++++++++++-------
>  hw/ppc/spapr_irq.c          | 12 ++++++++----
>  include/hw/ppc/spapr_xive.h |  5 +++--
>  3 files changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 47b5ec0b56..5a56a58299 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -528,12 +528,18 @@ static void spapr_xive_register_types(void)
> =20
>  type_init(spapr_xive_register_types)
> =20
> -bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi)
> +void spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi,
> +                          Error **errp)
>  {
>      XiveSource *xsrc =3D &xive->source;
> =20
>      assert(lisn < xive->nr_irqs);
> =20
> +    if (be64_to_cpu(xive->eat[lisn].w) & EAS_VALID) {

please use xive_eas_is_valid()

with that change,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


C.=20

> +        error_setg(errp, "IRQ %d is not free", lisn);
> +        return;
> +    }
> +
>      /*
>       * Set default values when allocating an IRQ number
>       */
> @@ -547,20 +553,17 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32=
_t lisn, bool lsi)
> =20
>          kvmppc_xive_source_reset_one(xsrc, lisn, &local_err);
>          if (local_err) {
> -            error_report_err(local_err);
> -            return false;
> +            error_propagate(errp, local_err);
> +            return;
>          }
>      }
> -
> -    return true;
>  }
> =20
> -bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
> +void spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
>  {
>      assert(lisn < xive->nr_irqs);
> =20
>      xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> -    return true;
>  }
> =20
>  /*
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2673a90604..f53544e45e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -245,7 +245,13 @@ static void spapr_irq_init_xive(SpaprMachineState =
*spapr, Error **errp)
> =20
>      /* Enable the CPU IPIs */
>      for (i =3D 0; i < nr_servers; ++i) {
> -        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false);
> +        Error *local_err =3D NULL;
> +
> +        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &l=
ocal_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>      }
> =20
>      spapr_xive_hcall_init(spapr);
> @@ -254,9 +260,7 @@ static void spapr_irq_init_xive(SpaprMachineState *=
spapr, Error **errp)
>  static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bo=
ol lsi,
>                                   Error **errp)
>  {
> -    if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
> -        error_setg(errp, "IRQ %d is invalid", irq);
> -    }
> +    spapr_xive_irq_claim(spapr->xive, irq, lsi, errp);
>  }
> =20
>  static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index bfd40f01d8..69df3793e1 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -54,8 +54,9 @@ typedef struct SpaprXive {
>   */
>  #define SPAPR_XIVE_BLOCK_ID 0x0
> =20
> -bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
> -bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
> +void spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi,
> +                          Error **errp);
> +void spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
>  int spapr_xive_post_load(SpaprXive *xive, int version_id);
> =20
>=20


