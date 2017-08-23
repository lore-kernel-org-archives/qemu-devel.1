Received: from eggs.gnu.org ([2001:4830:134:3::10]:47605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLs0-0004Yb-AU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLrz-0001Qi-8e
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:16 -0400
Date: Wed, 23 Aug 2017 12:28:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823022833.GK5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<f34dbaefd1224bca33a9052107cd32b628400106.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBYU9MM4gf8jKg2V"
Content-Disposition: inline
In-Reply-To: <f34dbaefd1224bca33a9052107cd32b628400106.1503249785.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 11/15] ppc: Add 460EX embedded CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--gBYU9MM4gf8jKg2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> Despite its name it is a 440 core CPU

As I recall 460 was supposed to be a 440 with SMP support.  Except
they screwed up the cache coherence, so it's basically unusable for
SMP (at least with Linux).  They finally got 440 SMP right in 470
IIRC.

Or are you saying that the 460EX is more 440 like than other 460 cpus?
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/cpu-models.c     |  3 +++
>  target/ppc/cpu-models.h     |  1 +
>  target/ppc/translate_init.c | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>=20
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 4d3e635..7c368fc 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -348,6 +348,8 @@
>                  "PowerPC 440 EPb")
>      POWERPC_DEF("440EPX",        CPU_POWERPC_440EPX,                 440=
EP,
>                  "PowerPC 440 EPX")
> +    POWERPC_DEF("460EXb",        CPU_POWERPC_460EXb,                 460=
EX,
> +                "PowerPC 460 EXb")
>  #if defined(TODO_USER_ONLY)
>      POWERPC_DEF("440GPb",        CPU_POWERPC_440GPb,                 440=
GP,
>                  "PowerPC 440 GPb")
> @@ -1238,6 +1240,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "440GP", "440GPc" },
>      { "440GR", "440GRa" },
>      { "440GX", "440GXf" },
> +    { "460EX", "460EXb" },
> =20
>      { "RCPU", "MPC5xx" },
>      /* MPC5xx microcontrollers */
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index b563c45..92f99c0 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -241,6 +241,7 @@ enum {
>      CPU_POWERPC_440SP              =3D 0x53221850,
>      CPU_POWERPC_440SP2             =3D 0x53221891,
>      CPU_POWERPC_440SPE             =3D 0x53421890,
> +    CPU_POWERPC_460EXb             =3D 0x130218A4, /* called 460 but 440=
 core */
>      /* PowerPC 460 family */
>  #if 0
>      /* Generic PowerPC 464 */
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 8fb407e..1e0d566 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -3832,6 +3832,44 @@ POWERPC_FAMILY(440EP)(ObjectClass *oc, void *data)
>                   POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
>  }
> =20
> +POWERPC_FAMILY(460EX)(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> +
> +    dc->desc =3D "PowerPC 460 EX";
> +    pcc->init_proc =3D init_proc_440EP;
> +    pcc->check_pow =3D check_pow_nocheck;
> +    pcc->insns_flags =3D PPC_INSNS_BASE | PPC_STRING |
> +                       PPC_FLOAT | PPC_FLOAT_FRES | PPC_FLOAT_FSEL |
> +                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> +                       PPC_FLOAT_STFIWX |
> +                       PPC_DCR | PPC_DCRX | PPC_WRTEE | PPC_RFMCI |
> +                       PPC_CACHE | PPC_CACHE_ICBI |
> +                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
> +                       PPC_MEM_TLBSYNC | PPC_MFTB |
> +                       PPC_BOOKE | PPC_4xx_COMMON | PPC_405_MAC |
> +                       PPC_440_SPEC;
> +    pcc->msr_mask =3D (1ull << MSR_POW) |
> +                    (1ull << MSR_CE) |
> +                    (1ull << MSR_EE) |
> +                    (1ull << MSR_PR) |
> +                    (1ull << MSR_FP) |
> +                    (1ull << MSR_ME) |
> +                    (1ull << MSR_FE0) |
> +                    (1ull << MSR_DWE) |
> +                    (1ull << MSR_DE) |
> +                    (1ull << MSR_FE1) |
> +                    (1ull << MSR_IR) |
> +                    (1ull << MSR_DR);
> +    pcc->mmu_model =3D POWERPC_MMU_BOOKE;
> +    pcc->excp_model =3D POWERPC_EXCP_BOOKE;
> +    pcc->bus_model =3D PPC_FLAGS_INPUT_BookE;
> +    pcc->bfd_mach =3D bfd_mach_ppc_403;
> +    pcc->flags =3D POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
> +                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
> +}
> +
>  static void init_proc_440GP(CPUPPCState *env)
>  {
>      /* Time base */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gBYU9MM4gf8jKg2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmc6E8ACgkQbDjKyiDZ
s5L3dhAArNbuchE/pFC3195GJLK2+FF4t0DbaSEcH4dA02UwH3oBraYVRVzH/waA
wp+9oqKaM1EiyVS/JwhQT2jZMmkandRdiTKsWp7qXi6D/ZIPNRWQ3O/MKXXTwRby
O88GG4KNsLR7lPsr3yfob/e2Pq580p24QaKWhCBhGzE+gE4prUX2UFczV2MrPz1D
QQRI68dxBPT2ILr8Ih1xr815gRb/zq8R6NuiVKw+vOXmBnn4b8x/rx6q+iHgfLEH
o2Pn2iH0SoUiv7yNbeseLGvQWVLTP4+6vDGeSkK2m1GBdrdE7l5+jMFsF+Ht/6vj
pVjrOXJlhepfiDq39afYDXD+Pe2f+BrSpebO+sBDGEebvuL366owlRA+vmRj/Ns7
P9mVVKjbC0ta3bzXllPC4bhW/g3BdCeyY4kFJJ3zZokmcWSuOF0yiCke4pNkuIVl
dkZGiN4tCyHxUF/2wOrsr/DFTY4wWX9HoOnAx/7Hngf5IAZH6si5cVOYlhCp3ar2
B8IESaLWyxdwVmgi5xGgP3lahzsCTiDTaAeKVLljzPHFnWzaV/l9wVoTxUcuCHaJ
MCr7AAbQLUPhIbbo9YvvCbCG20OU9U/IAZHZ0NE6y5qQ0nhooNrmdr/D6+H11FQR
nJmRRyawRPHbWKdWjLBdd3m9y17CIP3n1FLERC2wY6hGlut1wKA=
=Taq7
-----END PGP SIGNATURE-----

--gBYU9MM4gf8jKg2V--
