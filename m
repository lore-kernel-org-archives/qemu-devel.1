Received: from eggs.gnu.org ([2001:4830:134:3::10]:52345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGkd-0000IK-2z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGkZ-0000zM-Vs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:47 -0500
Date: Tue, 17 Jan 2017 08:36:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170116213617.GF15853@umbus>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-5-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-5-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 04/17] target/ppc/POWER9: Add ISAv3.00
 MMU definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:10PM +1100, Suraj Jitindar Singh wrote:
> POWER9 processors implement the mmu as defined in version 3.00 of the ISA.
>=20
> Add a definition for this mmu model and set the POWER9 cpu model to use
> this mmu model.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/cpu-qom.h        | 5 ++++-
>  target/ppc/mmu_helper.c     | 2 ++
>  target/ppc/translate_init.c | 3 +--
>  3 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index d46c31a..1577cc8 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -86,10 +86,13 @@ enum powerpc_mmu_t {
>      POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
>                               | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | 0x00000004,
> -    /* FIXME Add POWERPC_MMU_3_OO defines */
>      /* Architecture 2.07 "degraded" (no 1T segments)           */
>      POWERPC_MMU_2_07a      =3D POWERPC_MMU_64 | POWERPC_MMU_AMR
>                               | 0x00000004,
> +    /* Architecture 3.00 variant                               */
> +    POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> +                             | POWERPC_MMU_64K
> +                             | POWERPC_MMU_AMR | 0x00000005,

Hmm.  I guess it works for now, but I'm not really sure that having
this include POWERPC_MMU_64 is a great idea.  The name is kind of
misleading, but I'm pretty sure a number of places assume that the
POWERPC_MMU_64 bitindicates a 64-bit *hash* MMU, which is no longer
really the case.

>  };
> =20
>  /***********************************************************************=
******/
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index d09fc0a..2ab4562 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1935,6 +1935,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
>      case POWERPC_MMU_2_06a:
>      case POWERPC_MMU_2_07:
>      case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_3_00:
>  #endif /* defined(TARGET_PPC64) */
>          env->tlb_need_flush =3D 0;
>          tlb_flush(CPU(cpu), 1);
> @@ -1974,6 +1975,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, targe=
t_ulong addr)
>      case POWERPC_MMU_2_06a:
>      case POWERPC_MMU_2_07:
>      case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_3_00:
>          /* tlbie invalidate TLBs for all segments */
>          /* XXX: given the fact that there are too many segments to inval=
idate,
>           *      and we still don't have a tlb_flush_mask(env, n, mask) i=
n QEMU,
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index bfc1f24..2402eef 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8838,8 +8838,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                      (1ull << MSR_PMM) |
>                      (1ull << MSR_RI) |
>                      (1ull << MSR_LE);
> -    /* Using 2.07 defines until new radix model is added. */
> -    pcc->mmu_model =3D POWERPC_MMU_2_07;
> +    pcc->mmu_model =3D POWERPC_MMU_3_00;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
>      /* segment page size remain the same */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfTzRAAoJEGw4ysog2bOS3Z4QANEVxviCdQhzkNfsLpH74Iog
Tjo1I8y84hkcvQTuLSeIyj8MUCqK0+NfAPBO8Sdxp5twxyHVkJlupY+Wnjd0EcuT
bIokOK7k0plGDDA+nCIkxYtSh5HGutJtLpa4t/2Zk+aKRdZdLSsMHvnDgkAZxtAM
ttCJidR2oVrYyw9z59+bDORO3D8RRg1b1BlX7zGQZ8+E0SK5T64nqdSyirsKV0XQ
4tnxqBsr+JpG+wYRfe7SwEcUHGP9QvM0abSF88Opoj9kaM9gPgSPN2w+VzsF0OlS
U6S5vYMunmJ5TbEGBwfOnlVGbxuHIQXe+ff+3+3HFO/qr/L51jyrKD89ftk/Tq2J
s7WHuCRAJ2D5HbU/NvTpJ6vAYmdUikSWuDn/bqa7Byl/bgfQR2FqpfpyDUuJFBOG
zBQy2YMWmJ8OqzIqnWRXNeVgTagq37Fosp5TW8lg4L8MAoIQBPDdAxgYkSO2DJ00
3okk5GEeSCPw3gZys+uOmNCTKOHyl0uctLMfBzZR+7JF+mzwot0tDfc5U8IT8mBY
QfEX7GcRxmQoyE4aPm7HDFmeKomIk121ec5g1BSps2xA65zxV7jMx8Xg56vVYyHC
B7o8z50qrzwElNGhoX6+ixQyI0D9pd3cl2Gf38l5ElaltxKhsZp82qsXyV0xTZjG
l/NvFBDuhTY8LbLkjaS/
=w9t+
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
