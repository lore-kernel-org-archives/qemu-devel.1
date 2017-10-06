Received: from eggs.gnu.org ([2001:4830:134:3::10]:45162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OeB-0003w7-NB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Oe8-000536-El
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:10:19 -0400
Date: Fri, 6 Oct 2017 20:09:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006090926.GF10961@umbus.fritz.box>
References: <20171005164959.26024-1-clg@kaod.org>
	<87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 0/2] disable the decrementer interrupt when
 a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:40:02AM +0530, Nikunj A Dadhania wrote:
> C=E9dric Le Goater <clg@kaod.org> writes:
>=20
> > Hello,
> >
> > When a CPU is stopped with the 'stop-self' RTAS call, its state
> > 'halted' is switched to 1 and, in this case, the MSR is not taken into
> > account anymore in the cpu_has_work() routine. Only the pending
> > hardware interrupts are checked with their LPCR:PECE* enablement bit.
> >
> > If the DECR timer fires after 'stop-self' is called and before the CPU
> > 'stop' state is reached, the nearly-dead CPU will have some work to do
> > and the guest will crash. This case happens very frequently with the
> > not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
> > occasionally fired but after 'stop' state, so no work is to be done
> > and the guest survives.
> >
> > I suspect there is a race between the QEMU mainloop triggering the
> > timers and the TCG CPU thread but I could not quite identify the root
> > cause. To be safe, let's disable the decrementer interrupt in the LPCR
> > when the CPU is halted and reenable it when the CPU is restarted.
>=20
> Moreover, disabling the DECR in the reset path solves the TCG multi cpu
> reboot case, as reboot path does not call stop-cpu rtas call.
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3e20b1d886..c5150ee590 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -86,6 +86,15 @@ static void spapr_cpu_reset(void *opaque)
>      cs->halted =3D 1;
> =20
>      env->spr[SPR_HIOR] =3D 0;
> +    /* Disable DECR for secondary cpus */
> +    if (cs !=3D first_cpu) {
> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +            env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
> +        }
> +    }
>  }

This seems reasonable.

> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
>=20
>=20
> Regards
> Nikunj
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXSEYACgkQbDjKyiDZ
s5Km0xAA2r/gtfK3UYXnTaz/ZGx+TGs+ZLoDb3Y66ihxl7Y5+qf1YR6a45yvqpUV
V9fIHU+Pn60mA9qJ+RfJR/kQnqk/PqJvZKqFrbJg2m6qUj0R9QehuWy/DmVAqFG+
cXGZqWM8jF5a1noAXEZpXENAlDXntFXVDyW9IKWsy0L5xN45lVvOu4+gKEcfgJNj
ClbHKYcGV51cnJjfJ55aPHXP5aXgMzfj6NTcJUEaOH4jPoeCz7sbGhBXl6q5BzRX
kCZd/CA/LOhGWsCikatx6XNX3Gxd2bV9w/z7opd/pNQmq9Jc3soX5MfZ8nP0xddX
4dwqNJfDdpSjTcDhonpDTvl/1xdWJPaoLhphQdVbh+vFcoCUxqqfZLXcbqR8jIoJ
dOBrsxr3xsHQO5rJxvIBRFe3gZ67e9g3e+3uRcXV28MxEgh6UYH6Bl0dC7JcYgd5
WPkSP0WCO6GG8DggVv4+EaZaJ5KeNYAGCeX7IwUx0UGsbyn9IECE5Djr4HJpYUOU
Iwqqo4zJpFAA42XScZhOUrl5t42T1cjZfsJT8cS/0AqGlV2lqs/686qWmzsZ6wDx
cjaFiSxnQpfWaOQ8tGc5+UFdlfvdSFg2PJ5nXiuKE3dduM9tAnXUiuI0q2pBKyjg
MB6AXYedEjDZEFKFfsIwDYMDQdgH8Ao94GL0fk2huP0fqijCLMU=
=OxNE
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
