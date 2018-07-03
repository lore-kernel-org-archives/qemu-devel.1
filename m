Received: from eggs.gnu.org ([2001:4830:134:3::10]:56395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9BJ-000860-SE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9BG-0001wD-ND
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:28:33 -0400
Date: Tue, 3 Jul 2018 10:20:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703002037.GE3422@umbus.fritz.box>
References: <153052169663.619548.17452930454532662595.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SqEuGDw53xMPnx3c"
Content-Disposition: inline
In-Reply-To: <153052169663.619548.17452930454532662595.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: compute default value of
 "hpt-max-page-size" later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--SqEuGDw53xMPnx3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 10:54:56AM +0200, Greg Kurz wrote:
> It is currently not possible to run a pseries-2.12 or older machine
> with HV KVM. QEMU prints the following and exits right away.
>=20
> qemu-system-ppc64: KVM doesn't support for base page shift 34
>=20
> The "hpt-max-page-size" capability was recently added to spapr to hide
> host configuration details from HPT mode guests. Its default value for
> newer machine types is 64k.
>=20
> For backwards compatibility, pseries-2.12 and older machine types need
> a different value. This is handled as usual in a class init function.
> The default value is 16G, ie, all page sizes supported by POWER7 and
> newer CPUs, but HV KVM requires guest pages to be hpa contiguous as
> well as gpa contiguous. The default value is the page size used to
> back the guest RAM in this case.
>=20
> Unfortunately kvmppc_hpt_needs_host_contiguous_pages()->kvm_enabled() is
> called way before KVM init and returns false, even if the user requested
> KVM. We thus end up selecting 16G, which isn't supported by HV KVM. The
> default value must be set during machine init, because we can safely
> assume that KVM is initialized at this point.
>=20
> We fix this by moving the logic to default_caps_with_cpu(). Since the
> user cannot pass cap-hpt-max-page-size=3D0, we set the default to 0 in
> the pseries-2.12 class init function and use that as a flag to do the
> real work.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
> v3: - moved logic to default_caps_with_cpu()
>=20
> v2: - moved logic under spapr_caps_init()
> ---
>  hw/ppc/spapr.c      |   13 ++++++-------
>  hw/ppc/spapr_caps.c |   13 +++++++++++++
>  2 files changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b2baec026ff4..062d9dc346d4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4095,17 +4095,16 @@ static void spapr_machine_2_12_instance_options(M=
achineState *machine)
>  static void spapr_machine_2_12_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> -    uint8_t mps;
> =20
>      spapr_machine_3_0_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
> =20
> -    if (kvmppc_hpt_needs_host_contiguous_pages()) {
> -        mps =3D ctz64(qemu_getrampagesize());
> -    } else {
> -        mps =3D 34; /* allow everything up to 16GiB, i.e. everything */
> -    }
> -    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
> +    /* We depend on kvm_enabled() to choose a default value for the
> +     * hpt-max-page-size capability. Of course we can't do it here
> +     * because this is too early and the HW accelerator isn't initialzed
> +     * yet. Postpone this to machine init (see default_caps_with_cpu()).
> +     */
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 0;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 62663ebdf51a..aa605cea9108 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -465,6 +465,19 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPR=
MachineState *spapr,
>          caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      }
> =20
> +    /* This is for pseries-2.12 and older */
> +    if (smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D=3D 0) {
> +        uint8_t mps;
> +
> +        if (kvmppc_hpt_needs_host_contiguous_pages()) {
> +            mps =3D ctz64(qemu_getrampagesize());
> +        } else {
> +            mps =3D 34; /* allow everything up to 16GiB, i.e. everything=
 */
> +        }
> +
> +        caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
> +    }
> +
>      return caps;
>  }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SqEuGDw53xMPnx3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls6wVUACgkQbDjKyiDZ
s5LGeQ/6Ajtspc7QmvaBKgIMIUFbrUG+5Gqx25t4AxRpnyVUG0FrZul49cx18kAI
BBqGS8b6sb/5l2+yxjai73LN+VB+T1VROkuiALR9egp/Dg0vXxP6WyBhix770iab
rxw4SMAviofwvdCXZhsW2A44kktSEXHe3fxDWAkyXW0gf4daIs2wGadaxcfHRAau
8kPY1aA9/eAUuhFcyR7qRMt4yzqTRd6NM30QXF5cnK2jfYnefmnPIDc6FnA+9rem
u3tbloyDqolwBsOftbEqJ4ufVBLc2GBbzxpf0nB52OABrikZLE3sC4cvx6fXSOIO
oe+HAEQJZbZrVdrCrmGRm4l/VMesjhkkLK5X8YptvJJ4mIytN0V6j4XcVriQNQyI
ybnyuFGpU0kfwqMgrzA1O59QBqcxbJI15oYcVaq0EkxE7M6+fDpF7UnpCK+QqxKE
GdY8MpLkqpTTrjKpaQj0Ls7BWeA1GgGXvuhJ0AwFQya7YedHYpMkQh5d/z1eShN2
JOy0cInDW/pJKpicuLFw8OTIVRMu5D927L9z581bfQC6wcyaqnp+j+YGMX0WyKoF
as4eVXmAjHt2TxJi3ZzjdjVjMkm9EmI4uIHTU6SJ1tN7DgteK2C39Aa6OE3XnxMq
Xwp1XrlE53qWaWVWrkhLbJ0XLI3pddy/WL+yTl9KRBthURgRFrI=
=tYXM
-----END PGP SIGNATURE-----

--SqEuGDw53xMPnx3c--
