Received: from eggs.gnu.org ([2001:4830:134:3::10]:56090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVtFN-0002QQ-LV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVtFK-0000ci-H6
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:39:09 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:51172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVtFK-0000bj-Ai
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:39:06 -0400
Received: from player735.ha.ovh.net (unknown [10.109.108.76])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id D2387E7AB1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:39:04 +0200 (CEST)
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e06bdae5-68a9-add4-e731-de895c1624db@kaod.org>
Date: Thu, 21 Jun 2018 08:38:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180618063606.2513-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/9] target/ppc: Add
 ppc_hash64_filter_pagesizes()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, abologna@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On 06/18/2018 08:36 AM, David Gibson wrote:
> The paravirtualized PAPR platform sometimes needs to restrict the guest=
 to
> using only some of the page sizes actually supported by the host's MMU.
> At the moment this is handled in KVM specific code, but for consistency=
 we
> want to apply the same limitations to all accelerators.
>=20
> This makes a start on this by providing a helper function in the cpu co=
de
> to allow platform code to remove some of the cpu's page size definition=
s
> via a caller supplied callback.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

it looks correct.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  target/ppc/mmu-hash64.c | 59 +++++++++++++++++++++++++++++++++++++++++
>  target/ppc/mmu-hash64.h |  3 +++
>  2 files changed, 62 insertions(+)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index aa200cba4c..276d9015e7 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1166,3 +1166,62 @@ const PPCHash64Options ppc_hash64_opts_POWER7 =3D=
 {
>          },
>      }
>  };
> +
> +void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
> +                                 bool (*cb)(void *, uint32_t, uint32_t=
),
> +                                 void *opaque)
> +{
> +    PPCHash64Options *opts =3D cpu->hash64_opts;
> +    int i;
> +    int n =3D 0;
> +    bool ci_largepage =3D false;
> +
> +    assert(opts);
> +
> +    n =3D 0;
> +    for (i =3D 0; i < ARRAY_SIZE(opts->sps); i++) {
> +        PPCHash64SegmentPageSizes *sps =3D &opts->sps[i];
> +        int j;
> +        int m =3D 0;
> +
> +        assert(n <=3D i);
> +
> +        if (!sps->page_shift) {
> +            break;
> +        }
> +
> +        for (j =3D 0; j < ARRAY_SIZE(sps->enc); j++) {
> +            PPCHash64PageSize *ps =3D &sps->enc[j];
> +
> +            assert(m <=3D j);
> +            if (!ps->page_shift) {
> +                break;
> +            }
> +
> +            if (cb(opaque, sps->page_shift, ps->page_shift)) {
> +                if (ps->page_shift >=3D 16) {
> +                    ci_largepage =3D true;
> +                }
> +                sps->enc[m++] =3D *ps;
> +            }
> +        }
> +
> +        /* Clear rest of the row */
> +        for (j =3D m; j < ARRAY_SIZE(sps->enc); j++) {
> +            memset(&sps->enc[j], 0, sizeof(sps->enc[j]));
> +        }
> +
> +        if (m) {
> +            n++;
> +        }
> +    }
> +
> +    /* Clear the rest of the table */
> +    for (i =3D n; i < ARRAY_SIZE(opts->sps); i++) {
> +        memset(&opts->sps[i], 0, sizeof(opts->sps[i]));
> +    }
> +
> +    if (!ci_largepage) {
> +        opts->flags &=3D ~PPC_HASH64_CI_LARGEPAGE;
> +    }
> +}
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 53dcec5b93..f11efc9cbc 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -20,6 +20,9 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU =
*cpu,
>  void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
>  void ppc_hash64_init(PowerPCCPU *cpu);
>  void ppc_hash64_finalize(PowerPCCPU *cpu);
> +void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
> +                                 bool (*cb)(void *, uint32_t, uint32_t=
),
> +                                 void *opaque);
>  #endif
> =20
>  /*
>=20
