Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AF6C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46412083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46412083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk7r-0006qu-Vq
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jWk76-00062d-PU
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:15:12 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:58708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jWk75-0002x2-Gh
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:15:12 -0400
Received: from player735.ha.ovh.net (unknown [10.108.57.95])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5411416528F
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 19:15:02 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id A213211E93710;
 Thu,  7 May 2020 17:14:57 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200507114824.788942-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <55ff4f45-4e1f-e0af-7b25-0c197dd41e19@kaod.org>
Date: Thu, 7 May 2020 19:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507114824.788942-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4761712181045988326
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkedtgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.59.63; envelope-from=clg@kaod.org;
 helo=4.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 13:15:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 1:48 PM, Nicholas Piggin wrote:
> Commit a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
> SRR1 setting wrong for sresets that hit outside of power-save states.
> 
> Fix this, better documenting the source for the bit definitions.
> 
> Fixes: a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

We should introduce some defines like the SRR1_WAKE ones in Linux and 
cleanup powerpc_reset_wakeup(). This function uses cryptic values. 
That can be done later on as a followup.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
> 
> Thanks to Cedric for pointing out concerns with a previous MCE patch
> that unearthed this as well. Linux does not actually care what these
> SRR1[42:45] bits look like for non-powersave sresets, but we should
> follow documented behaviour as far as possible.

We should introduce some defines like the SRR1_WAKE ones in Linux and 
cleanup powerpc_reset_wakeup(). This function uses cryptic values. 
That can be done later on as a followup.


I am currently after a bug which results in a CPU hard lockup because 
of a pending interrupt. It occurs on a SMP PowerNV machine when it is 
stressed with IO, such as scp of a big file. 

I am suspecting more and more an issue with an interrupt being handled 
when the CPU is coming out of idle. I haven't seen anything wrong in
the models. Unless this maybe :

    /* Pretend to be returning from doze always as we don't lose state */
    *msr |= (0x1ull << (63 - 47));

I am not sure how in sync it is with PSSCR.


Thanks, 

C.

>  hw/ppc/pnv.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a3b7a8d0ff..1b4748ce6d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1986,12 +1986,26 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>  
>      cpu_synchronize_state(cs);
>      ppc_cpu_do_system_reset(cs);
> -    /*
> -     * SRR1[42:45] is set to 0100 which the ISA defines as implementation
> -     * dependent. POWER processors use this for xscom triggered interrupts,
> -     * which come from the BMC or NMI IPIs.
> -     */
> -    env->spr[SPR_SRR1] |= PPC_BIT(43);
> +    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
> +        /*
> +	 * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
> +	 * wakeup reason in SRR1[42:45], system reset is indicated with 0b0100
> +	 * (PPC_BIT(43)).
> +	 */
> +        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
> +            warn_report("ppc_cpu_do_system_reset does not set system reset wakeup reason");
> +            env->spr[SPR_SRR1] |= PPC_BIT(43);
> +        }
> +    } else {
> +        /*
> +	 * For non-powersave system resets, SRR1[42:45] are defined to be
> +	 * implementation-dependent. The POWER9 User Manual specifies that
> +	 * an external (SCOM driven, which may come from a BMC nmi command or
> +	 * another CPU requesting a NMI IPI) system reset exception should be
> +	 * 0b0010 (PPC_BIT(44)).
> +         */
> +        env->spr[SPR_SRR1] |= PPC_BIT(44);
> +    }
>  }
>  
>  static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
> 


