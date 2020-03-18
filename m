Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5718BC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE9020714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE9020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEbqf-00067r-Ay
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jEbpg-0005BJ-1t
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jEbpe-0007FG-T9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:46:15 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:57229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jEbpe-0006tU-O7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:46:14 -0400
Received: from player732.ha.ovh.net (unknown [10.110.103.118])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7913815F17E
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 17:46:05 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id 2B4B3107277B1;
 Wed, 18 Mar 2020 16:45:52 +0000 (UTC)
Subject: Re: [EXTERNAL] [PATCH 1/2] target/ppc: Fix slbia TLB invalidation gap
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200318044135.851716-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b4a5674c-12b0-68c5-fc2b-94b8d5675ee3@kaod.org>
Date: Wed, 18 Mar 2020 17:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318044135.851716-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5786281097922644889
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefjedgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.250.45
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
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 5:41 AM, Nicholas Piggin wrote:
> slbia must invalidate TLBs even if it does not remove a valid SLB
> entry, because slbmte can overwrite valid entries without removing
> their TLBs.
>=20
> As the architecture says, slbia invalidates all lookaside information,
> not conditionally based on if it removed valid entries.
>=20
> It does not seem possible for POWER8 or earlier Linux kernels to hit
> this bug because it never changes its kernel SLB translations, and it
> should always have valid entries if any accesses are made to usespace
> regions. However other operating systems which may modify SLB entry 0
> or do more fancy things with segments might be affected.

Did you hit the bug on the other OS ?=20
=20
> When POWER9 slbia support is added in the next patch, this becomes a
> real problem because some new slbia variants don't invalidate all
> non-zero entries.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks correct.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> ---
>  target/ppc/mmu-hash64.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 34f6009b1e..373d44de74 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -100,20 +100,29 @@ void helper_slbia(CPUPPCState *env)
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      int n;
>=20
> +    /*
> +     * slbia must always flush all TLB (which is equivalent to ERAT in=
 ppc
> +     * architecture). Matching on SLB_ESID_V is not good enough, becau=
se slbmte
> +     * can overwrite a valid SLB without flushing its lookaside inform=
ation.
> +     *
> +     * It would be possible to keep the TLB in synch with the SLB by f=
lushing
> +     * when a valid entry is overwritten by slbmte, and therefore slbi=
a would
> +     * not have to flush unless it evicts a valid SLB entry. However i=
t is
> +     * expected that slbmte is more common than slbia, and slbia is us=
ually
> +     * going to evict valid SLB entries, so that tradeoff is unlikely =
to be a
> +     * good one.
> +     */
> +
>      /* XXX: Warning: slbia never invalidates the first segment */
>      for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
>          ppc_slb_t *slb =3D &env->slb[n];
>=20
>          if (slb->esid & SLB_ESID_V) {
>              slb->esid &=3D ~SLB_ESID_V;
> -            /*
> -             * XXX: given the fact that segment size is 256 MB or 1TB,
> -             *      and we still don't have a tlb_flush_mask(env, n, m=
ask)
> -             *      in QEMU, we just invalidate all TLBs
> -             */
> -            env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
>          }
>      }
> +
> +    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
>  }
>=20
>  static void __helper_slbie(CPUPPCState *env, target_ulong addr,
>=20


