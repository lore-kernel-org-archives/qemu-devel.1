Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36B5C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC34205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC34205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtZS-0006LN-TQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jDres-0006O1-A5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jDreq-0005JD-TS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:28:01 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:40759)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jDreq-00046X-JT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:28:00 -0400
Received: from player687.ha.ovh.net (unknown [10.110.171.50])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 66E9A86968
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 16:27:52 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id BC461106EF578;
 Mon, 16 Mar 2020 15:27:44 +0000 (UTC)
Date: Mon, 16 Mar 2020 16:27:37 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/8] ppc/spapr: Fix FWNMI machine check failure handling
Message-ID: <20200316162737.40a78537@bahia.lan>
In-Reply-To: <20200316142613.121089-2-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-2-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11166675278096013763
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.107
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 00:26:06 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> ppc_cpu_do_system_reset delivers a system rreset interrupt to the guest,
> which is certainly not what is intended here. Panic the guest like other
> failure cases here do.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Makes sense.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_events.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 2afd1844e4..11303258d4 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -785,7 +785,6 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
>  static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> -    CPUState *cs = CPU(cpu);
>      uint64_t rtas_addr;
>      CPUPPCState *env = &cpu->env;
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> @@ -823,8 +822,7 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr = spapr_get_rtas_addr();
>      if (!rtas_addr) {
> -        /* Unable to fetch rtas_addr. Hence reset the guest */
> -        ppc_cpu_do_system_reset(cs);
> +        qemu_system_guest_panicked(NULL);
>          g_free(ext_elog);
>          return;
>      }


