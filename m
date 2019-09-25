Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F40C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78C92082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78C92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1iY-0004n0-Ct
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1G7-0003bp-R1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1G5-00025Q-Lh
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:58:43 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:33927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1G5-00024Q-G7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:58:41 -0400
Received: from player750.ha.ovh.net (unknown [10.108.57.211])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5647E666E2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:58:38 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 53258A487BCF;
 Wed, 25 Sep 2019 06:58:27 +0000 (UTC)
Subject: Re: [PATCH 07/20] spapr: Fold spapr_phb_lsi_qirq() into its single
 caller
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a184f1aa-0347-7f07-dbc4-8f9e4f7a901c@kaod.org>
Date: Wed, 25 Sep 2019 08:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1161084281337580504
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.78
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
> No point having a two-line helper that's used exactly once, and not lik=
ely
> to be used anywhere else in future.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_pci.c          | 3 ++-
>  include/hw/pci-host/spapr.h | 7 -------
>  2 files changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 7b71ad7c74..6934d506a7 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -721,9 +721,10 @@ static void pci_spapr_set_irq(void *opaque, int ir=
q_num, int level)
>       * corresponding qemu_irq.
>       */
>      SpaprPhbState *phb =3D opaque;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
>      trace_spapr_pci_lsi_set(phb->dtbusname, irq_num, phb->lsi_table[ir=
q_num].irq);
> -    qemu_set_irq(spapr_phb_lsi_qirq(phb, irq_num), level);
> +    qemu_set_irq(spapr_qirq(spapr, phb->lsi_table[irq_num].irq), level=
);
>  }
> =20
>  static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index abd87605b2..23506f05d9 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -128,13 +128,6 @@ struct SpaprPhbState {
>  #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS =
* \
>                                        64 * KiB)
> =20
> -static inline qemu_irq spapr_phb_lsi_qirq(struct SpaprPhbState *phb, i=
nt pin)
> -{
> -    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> -
> -    return spapr_qirq(spapr, phb->lsi_table[pin].irq);
> -}
> -
>  int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>                   uint32_t nr_msis, int *node_offset);
> =20
>=20


