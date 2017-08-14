Received: from eggs.gnu.org ([2001:4830:134:3::10]:56203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8ff-0000dI-EG
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8fd-0005c6-Cj
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:14 -0400
Date: Mon, 14 Aug 2017 14:40:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814044045.GD3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<49e4b95ddbb40575bfb4db2e7c43b0b0801ce399.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <49e4b95ddbb40575bfb4db2e7c43b0b0801ce399.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 10/12] ppc: Add 460EX embedded CPU
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


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> Despite its name it is a 440 core CPU
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRKcwACgkQbDjKyiDZ
s5IDRw//XO2f+GMMxpbAI+4BdHTBLncOps/R/LBiEqQ7krOSOoHXv6PYtq/D1RBk
eE7scTOyAwxkrDgt1ZfmtnJCBJwx3bxNiQO74eZZWjg/VYA5VWG5tyVMYPzOV51X
TRzmu1USVKq1WeqoC13/Q+82IqbjutTO0UnWcwGq4PDVVY7xmulqKUACDXGieAtu
xIV2hYD1j/mFv79Lt4+s6KleFbG93IzZywQ3MLnV7iROUAtM57DHt0sdayQarTu0
CuRoAEmFH7PInAEwRUfTrX+NtyxMe4LYViF8Z2Kb/gwih8FHZ4nA5A87z5drLVYi
/Z+DPrsqwQV+jXL53R35JRZwVtJRH38MLkvJxwgIH2++hHM/fLIbyTwDmpWYDdZw
sMqUcGI+rF4m6OZFDyK7fRj4QY5XhL+TM09I+Hj0GnUobGae9tj263f2DxmCVwTA
cqfvnKI/h7Iz5dtiRPnRlS0Gk2yA6fps8o6KwfI21pFwboPI9G37errcgkWdO0Co
eor3saeXtdMr5MCE102SGIF76LVJHtdONe6ml4gQP+UOel3+HfkKFuGzyubCqjdH
DI/M7PteVKiCqqjleoDCL0TcUjOfLhRJBdyH7xWZoqLnrLIdET3a4mlv2g5JYolR
2uQFL4EntA9c1H8JIUsRavYcez8tg/NBCvQKelFCN2Ebvr5oc6g=
=BasF
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
