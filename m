Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE04-0008Cn-ND
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE00-000059-Ng
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:44 -0500
Date: Mon, 27 Nov 2017 18:19:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127071917.GH11775@umbus.fritz.box>
References: <20171124070550.6433-1-clg@kaod.org>
	<20171124070550.6433-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <20171124070550.6433-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 2/3] spapr/rtas: fix reboot of a a SMP
 TCG guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 08:05:49AM +0100, C=E9dric Le Goater wrote:
> Just like for hot unplug CPUs, when a guest is rebooted, the secondary
> CPUs can be awaken by the decrementer and start entering SLOF at the
> same time the boot CPU is.
>=20
> To be safe, let's disable on the secondaries all the exceptions which
> can cause an exit while the CPU is in power-saving mode.
>=20
> Based on previous work from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-2.12.

> ---
>=20
> Changes in v4:
>=20
>  - used the 'lpcr_pm' field of PowerPCCPUClass
>=20
> Changes in v3:
>=20
>  - used the cpu_ppc_papr_pece_bits() helper=20
>=20
>  hw/ppc/spapr_cpu_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3a4c17401226..a2290528542d 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -26,6 +26,7 @@ static void spapr_cpu_reset(void *opaque)
>      PowerPCCPU *cpu =3D opaque;
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
>      cpu_reset(cs);
> =20
> @@ -35,6 +36,13 @@ static void spapr_cpu_reset(void *opaque)
>      cs->halted =3D 1;
> =20
>      env->spr[SPR_HIOR] =3D 0;
> +
> +    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> +     * This can cause issues when rebooting the guest if a secondary
> +     * is awaken */
> +    if (cs !=3D first_cpu) {
> +        env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
> +    }
>  }
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobvHUACgkQbDjKyiDZ
s5L3Mw/7BWKCfWktUBvzwc0IdPWX8AVuWN050uyRg3I7CcU1EuAszTkxPjblO5Br
yqnqDgEeYGMoXwnrQApe/pGwDmUv5wphLsrtOdYp72gswK2t6N62Ap/mcvyQzCcm
L7Pkj45u6LRY6uQoKzQhN7SFoRXAgp8b+O2HSga/dzdqS05kkMYVWz6wrF3tyk2P
2vHxRR6aoLLQ+nUzx6rn1PYwASfo3C5OeEVTVEV15aKXfn1X4kduTjCuv8DUbkHQ
mkThJJSclE30QnEkWgVVtVWn3ApxfzcOxjbFst7GxJBkdxe/G//99U4s4msU4GPC
ktBJTDgzS7ab2ob1EAUbO+/tNDlzDUrhCleR2Wrp0tknwsXHyf3BZtPf1+4Vew0M
iQUfKpX4TDhpTUq8Yd20AMtb4SAUG7Oy1Zk2PemMUUGc5YCdxX/eBwQKEs8/+PK+
goze/FBrKkC4c85RzJb1YtMzuX0CwYLvtnTgLE0JkaCx6bvFd8dhte1hZmrfisIP
kt8RtEdHpD0ZjWLuQYiNSar/s7YLpc4FL+wE5hnpYNp9JyXNIs8yun+i72K+/aVM
T0qwUlB2Pz9KRodk3fJDxpSOOlGDU8uTMVJcAQMy+ORI4cqdwyyxS590zMDXqJoR
EM3SBrl6Zb+MQvPbws2xGy4kDFddRgQqKoYaMAjYlmkrYZCnjP8=
=4Gqp
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
