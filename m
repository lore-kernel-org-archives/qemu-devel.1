Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD1C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED1B20776
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED1B20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxok-0003Dt-23
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jIxmb-0000QD-3K
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jIxmZ-0004H9-3t
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:01:04 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:57587)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jIxmY-0004Et-QH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:01:03 -0400
Received: from player737.ha.ovh.net (unknown [10.110.171.31])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id C21F624A967
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 19:00:59 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id F1E1877AD761;
 Mon, 30 Mar 2020 17:00:52 +0000 (UTC)
Date: Mon, 30 Mar 2020 19:00:52 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 5/7] target/ppc: Rework ppc_radix64_walk_tree() for
 partition-scoped translation
Message-ID: <20200330170610.38a5ce61@bahia.lan>
In-Reply-To: <20200330094946.24678-6-clg@kaod.org>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-6-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2723270401250859403
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.46.10
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 11:49:44 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The ppc_radix64_walk_tree() routine walks through the nested radix
> tables to look for a PTE.
>=20
> Split it two and introduce a new routine ppc_radix64_next_level()

Split it in two...

> which we will use for partition-scoped Radix translation when
> translating the process tree addresses.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/mmu-radix64.c | 50 ++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index b4e6abcd2d35..136498111f60 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -162,44 +162,60 @@ static void ppc_radix64_set_rc(PowerPCCPU *cpu, int=
 rwx, uint64_t pte,
>      }
>  }
> =20
> -static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
> -                                      uint64_t base_addr, uint64_t nls,
> -                                      hwaddr *raddr, int *psize,
> -                                      int *fault_cause, hwaddr *pte_addr)
> +static uint64_t ppc_radix64_next_level(PowerPCCPU *cpu, vaddr eaddr,
> +                                       uint64_t *pte_addr, uint64_t *nls,
> +                                       int *psize, int *fault_cause)
>  {
>      CPUState *cs =3D CPU(cpu);
>      uint64_t index, pde;
> =20
> -    if (nls < 5) { /* Directory maps less than 2**5 entries */
> +    if (*nls < 5) { /* Directory maps less than 2**5 entries */
>          *fault_cause |=3D DSISR_R_BADCONFIG;
>          return 0;
>      }
> =20

I think this should stay in the caller...

>      /* Read page <directory/table> entry from guest address space */
> -    index =3D eaddr >> (*psize - nls); /* Shift */
> -    index &=3D ((1UL << nls) - 1); /* Mask */
> -    pde =3D ldq_phys(cs->as, base_addr + (index * sizeof(pde)));
> -    if (!(pde & R_PTE_VALID)) { /* Invalid Entry */
> +    pde =3D ldq_phys(cs->as, *pte_addr);
> +    if (!(pde & R_PTE_VALID)) {         /* Invalid Entry */
>          *fault_cause |=3D DSISR_NOPTE;
>          return 0;
>      }
> =20
> -    *psize -=3D nls;
> +    *psize -=3D *nls;
> +    if (!(pde & R_PTE_LEAF)) { /* Prepare for next iteration */
> +        *nls =3D pde & R_PDE_NLS;
> +        index =3D eaddr >> (*psize - *nls);       /* Shift */
> +        index &=3D ((1UL << *nls) - 1);           /* Mask */
> +        *pte_addr =3D (pde & R_PDE_NLB) + (index * sizeof(pde));
> +    }
> +    return pde;
> +}
> +
> +static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
> +                                      uint64_t base_addr, uint64_t nls,
> +                                      hwaddr *raddr, int *psize,
> +                                      int *fault_cause, hwaddr *pte_addr)
> +{
> +    uint64_t index, pde;
> +
> +    index =3D eaddr >> (*psize - nls);    /* Shift */
> +    index &=3D ((1UL << nls) - 1);       /* Mask */
> +    *pte_addr =3D base_addr + (index * sizeof(pde));
> +    do {

... here. So that we have a well established "bad config" path at
the root level, just like the current code has.

Since the ppc_radix64_walk_tree() now calls ppc_radix64_next_level()
in a loop instead of recursing, and since ppc_radix64_next_level()
returns the nls value for the next level, it really makes sense to
have this check in ppc_radix64_walk_tree() and maybe put an assert
in ppc_radix64_next_level().

> +        pde =3D ppc_radix64_next_level(cpu, eaddr, pte_addr, &nls, psize,
> +                                     fault_cause);
> +    } while ((pde & R_PTE_VALID) && !(pde & R_PTE_LEAF));
> =20
> -    /* Check if Leaf Entry -> Page Table Entry -> Stop the Search */
> -    if (pde & R_PTE_LEAF) {
> +    /* Did we find a valid leaf? */
> +    if ((pde & R_PTE_VALID) && (pde & R_PTE_LEAF)) {
>          uint64_t rpn =3D pde & R_PTE_RPN;
>          uint64_t mask =3D (1UL << *psize) - 1;
> =20
>          /* Or high bits of rpn and low bits to ea to form whole real add=
r */
>          *raddr =3D (rpn & ~mask) | (eaddr & mask);
> -        *pte_addr =3D base_addr + (index * sizeof(pde));
> -        return pde;
>      }
> =20
> -    /* Next Level of Radix Tree */
> -    return ppc_radix64_walk_tree(cpu, eaddr, pde & R_PDE_NLB, pde & R_PD=
E_NLS,
> -                                 raddr, psize, fault_cause, pte_addr);
> +    return pde;
>  }
> =20
>  static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t =
*pate)


