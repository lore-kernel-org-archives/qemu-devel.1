Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A72BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44036214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44036214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94nu-0000bl-G6
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j94e0-0001Ih-5p
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j94dy-0001c8-NL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:19:19 -0500
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:55735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j94dy-0001aM-A8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:19:18 -0500
Received: from player788.ha.ovh.net (unknown [10.110.103.112])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id ADD421B3D04
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 11:19:14 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id C385B1005FCB2;
 Tue,  3 Mar 2020 10:18:51 +0000 (UTC)
Date: Tue, 3 Mar 2020 11:18:49 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 16/17] spapr: Clean up RMA size calculation
Message-ID: <20200303111849.361b741a@bahia.home>
In-Reply-To: <20200303034351.333043-17-david@gibson.dropbear.id.au>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-17-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3396277069955373542
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedgudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.35.72
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, clg@kaod.org, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Mar 2020 14:43:50 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Move the calculation of the Real Mode Area (RMA) size into a helper
> function.  While we're there clean it up and correct it in a few ways:
>   * Add comments making it clearer where the various constraints come from
>   * Remove a pointless check that the RMA fits within Node 0 (we've just
>     clamped it so that it does)
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 60 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 95bda4a615..2eb0d8f70d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2648,6 +2648,41 @@ static PCIHostState *spapr_create_default_phb(void)
>      return PCI_HOST_BRIDGE(dev);
>  }
>  
> +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> +{
> +    MachineState *machine = MACHINE(spapr);
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +    hwaddr rma_size = machine->ram_size;
> +    hwaddr node0_size = spapr_node0_size(machine);
> +
> +    /* RMA has to fit in the first NUMA node */
> +    rma_size = MIN(rma_size, node0_size);
> +
> +    /*
> +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> +     * never exceed that
> +     */
> +    rma_size = MIN(rma_size, 1 * TiB);
> +
> +    /*
> +     * Clamp the RMA size based on machine type.  This is for
> +     * migration compatibility with older qemu versions, which limited
> +     * the RMA size for complicated and mostly bad reasons.
> +     */
> +    if (smc->rma_limit) {
> +        rma_size = MIN(rma_size, smc->rma_limit);
> +    }
> +
> +    if (rma_size < MIN_RMA_SLOF) {
> +        error_setg(errp,
> +"pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area memory)",
> +                   MIN_RMA_SLOF / MiB);
> +        return 0;
> +    }
> +
> +    return rma_size;
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void spapr_machine_init(MachineState *machine)
>  {
> @@ -2659,7 +2694,6 @@ static void spapr_machine_init(MachineState *machine)
>      PCIHostState *phb;
>      int i;
>      MemoryRegion *sysmem = get_system_memory();
> -    hwaddr node0_size = spapr_node0_size(machine);
>      long load_limit, fw_size;
>      char *filename;
>      Error *resize_hpt_err = NULL;
> @@ -2699,22 +2733,7 @@ static void spapr_machine_init(MachineState *machine)
>          exit(1);
>      }
>  
> -    spapr->rma_size = node0_size;
> -
> -    /*
> -     * Clamp the RMA size based on machine type.  This is for
> -     * migration compatibility with older qemu versions, which limited
> -     * the RMA size for complicated and mostly bad reasons.
> -     */
> -    if (smc->rma_limit) {
> -        spapr->rma_size = MIN(spapr->rma_size, smc->rma_limit);
> -    }
> -
> -    if (spapr->rma_size > node0_size) {
> -        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx")",
> -                     spapr->rma_size);
> -        exit(1);
> -    }
> +    spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
>  
>      /* Setup a load limit for the ramdisk leaving room for SLOF and FDT */
>      load_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> @@ -2951,13 +2970,6 @@ static void spapr_machine_init(MachineState *machine)
>          }
>      }
>  
> -    if (spapr->rma_size < MIN_RMA_SLOF) {
> -        error_report(
> -            "pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area memory)",
> -            MIN_RMA_SLOF / MiB);
> -        exit(1);
> -    }
> -
>      if (kernel_filename) {
>          uint64_t lowaddr = 0;
>  


