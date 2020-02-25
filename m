Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F5C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AA720732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AA720732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dhN-00089P-A3
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6dei-0005TB-Vh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6def-0006j4-4G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:06:00 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:49764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6dee-0006i4-UX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:05:57 -0500
Received: from player696.ha.ovh.net (unknown [10.110.208.220])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5DB1C130C21
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 18:05:54 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 69D75FCED3A6;
 Tue, 25 Feb 2020 17:05:36 +0000 (UTC)
Date: Tue, 25 Feb 2020 18:05:31 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 09/18] target/ppc: Streamline calculation of RMA
 limit from LPCR[RMLS]
Message-ID: <20200225180531.6551ce59@bahia.home>
In-Reply-To: <20200224233724.46415-10-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-10-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 6048897252239383014
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhnuhdrohhrghenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.148
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
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:15 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently we use a big switch statement in ppc_hash64_update_rmls() to wo=
rk
> out what the right RMA limit is based on the LPCR[RMLS] field.  There's no
> formula for this - it's just an arbitrary mapping defined by the existing
> CPU implementations - but we can make it a bit more readable by using a
> lookup table rather than a switch.  In addition we can use the MiB/GiB
> symbols to make it a bit clearer.
>=20
> While there we add a bit of clarity and rationale to the comment about
> what happens if the LPCR[RMLS] doesn't contain a valid value.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/mmu-hash64.c | 71 ++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 0ef330a614..4f082d775d 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -18,6 +18,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"This tool was originally developed to fix =
Linux CPU throttling issues affecting Lenovo T480 / T480s / X1C6 as describ=
ed here.
> @@ -757,6 +758,39 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr=
 ptex, uint64_t pte1)
>      stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
>  }
> =20
> +static target_ulong rmls_limit(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    /*
> +     * This is the full 4 bits encoding of POWER8. Previous
> +     * CPUs only support a subset of these but the filtering
> +     * is done when writing LPCR
> +     */
> +    const target_ulong rma_sizes[] =3D {
> +        [0] =3D 0,
> +        [1] =3D 16 * GiB,
> +        [2] =3D 1 * GiB,
> +        [3] =3D 64 * MiB,
> +        [4] =3D 256 * MiB,
> +        [5] =3D 0,
> +        [6] =3D 0,
> +        [7] =3D 128 * MiB,
> +        [8] =3D 32 * MiB,
> +    };
> +    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR_RMLS_=
SHIFT;
> +
> +    if (rmls < ARRAY_SIZE(rma_sizes)) {

This condition is always true since the RMLS field is 4-bit long... I guess
you want to check that RMLS encodes a valid RMA size instead.

    if (rma_sizes[rmls]) {

> +        return rma_sizes[rmls];
> +    } else {
> +        /*
> +         * Bad value, so the OS has shot itself in the foot.  Return a
> +         * 0-sized RMA which we expect to trigger an immediate DSI or
> +         * ISI
> +         */
> +        return 0;
> +    }
> +}
> +
>  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>                                  int rwx, int mmu_idx)
>  {
> @@ -1006,41 +1040,6 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, ta=
rget_ulong ptex,
>      cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_F=
LUSH;
>  }
> =20
> -static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -    uint64_t lpcr =3D env->spr[SPR_LPCR];
> -
> -    /*
> -     * This is the full 4 bits encoding of POWER8. Previous
> -     * CPUs only support a subset of these but the filtering
> -     * is done when writing LPCR
> -     */
> -    switch ((lpcr & LPCR_RMLS) >> LPCR_RMLS_SHIFT) {
> -    case 0x8: /* 32MB */
> -        env->rmls =3D 0x2000000ull;
> -        break;
> -    case 0x3: /* 64MB */
> -        env->rmls =3D 0x4000000ull;
> -        break;
> -    case 0x7: /* 128MB */
> -        env->rmls =3D 0x8000000ull;
> -        break;
> -    case 0x4: /* 256MB */
> -        env->rmls =3D 0x10000000ull;
> -        break;
> -    case 0x2: /* 1GB */
> -        env->rmls =3D 0x40000000ull;
> -        break;
> -    case 0x1: /* 16GB */
> -        env->rmls =3D 0x400000000ull;
> -        break;
> -    default:
> -        /* What to do here ??? */
> -        env->rmls =3D 0;
> -    }
> -}
> -
>  static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
> @@ -1099,7 +1098,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
al)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> -    ppc_hash64_update_rmls(cpu);
> +    env->rmls =3D rmls_limit(cpu);
>      ppc_hash64_update_vrma(cpu);
>  }
> =20


