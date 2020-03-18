Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4983EC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F2E20724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F2E20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEbwq-0001rh-OH
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 12:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jEbw7-0001KH-QX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jEbw6-0001aU-Fr
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:52:55 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:42076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jEbw6-0000rS-8C
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:52:54 -0400
Received: from player728.ha.ovh.net (unknown [10.108.35.103])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1244C1CE84D
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 17:52:43 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id D6A0B107A6B1F;
 Wed, 18 Mar 2020 16:52:37 +0000 (UTC)
Date: Wed, 18 Mar 2020 17:52:32 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] target/ppc: Fix slbia TLB invalidation gap
Message-ID: <20200318175232.37db1fd1@bahia.lan>
In-Reply-To: <20200318044135.851716-1-npiggin@gmail.com>
References: <20200318044135.851716-1-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5898308139141470659
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefjedgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.181.248
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
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 14:41:34 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> slbia must invalidate TLBs even if it does not remove a valid SLB
> entry, because slbmte can overwrite valid entries without removing
> their TLBs.
> 
> As the architecture says, slbia invalidates all lookaside information,
> not conditionally based on if it removed valid entries.
> 
> It does not seem possible for POWER8 or earlier Linux kernels to hit
> this bug because it never changes its kernel SLB translations, and it
> should always have valid entries if any accesses are made to usespace

s/usespace/userspace

> regions. However other operating systems which may modify SLB entry 0
> or do more fancy things with segments might be affected.
> 
> When POWER9 slbia support is added in the next patch, this becomes a
> real problem because some new slbia variants don't invalidate all
> non-zero entries.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/mmu-hash64.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 34f6009b1e..373d44de74 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -100,20 +100,29 @@ void helper_slbia(CPUPPCState *env)
>      PowerPCCPU *cpu = env_archcpu(env);
>      int n;
>  
> +    /*
> +     * slbia must always flush all TLB (which is equivalent to ERAT in ppc
> +     * architecture). Matching on SLB_ESID_V is not good enough, because slbmte
> +     * can overwrite a valid SLB without flushing its lookaside information.
> +     *
> +     * It would be possible to keep the TLB in synch with the SLB by flushing
> +     * when a valid entry is overwritten by slbmte, and therefore slbia would
> +     * not have to flush unless it evicts a valid SLB entry. However it is
> +     * expected that slbmte is more common than slbia, and slbia is usually
> +     * going to evict valid SLB entries, so that tradeoff is unlikely to be a
> +     * good one.
> +     */
> +
>      /* XXX: Warning: slbia never invalidates the first segment */
>      for (n = 1; n < cpu->hash64_opts->slb_size; n++) {
>          ppc_slb_t *slb = &env->slb[n];
>  
>          if (slb->esid & SLB_ESID_V) {
>              slb->esid &= ~SLB_ESID_V;
> -            /*
> -             * XXX: given the fact that segment size is 256 MB or 1TB,
> -             *      and we still don't have a tlb_flush_mask(env, n, mask)
> -             *      in QEMU, we just invalidate all TLBs
> -             */
> -            env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
>          }
>      }
> +
> +    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
>  }
>  
>  static void __helper_slbie(CPUPPCState *env, target_ulong addr,


