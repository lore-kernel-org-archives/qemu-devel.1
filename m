Received: from eggs.gnu.org ([2001:4830:134:3::10]:57606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqn-0001I2-Vp
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqk-0001pP-Qk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:41 -0400
Date: Fri, 29 Jun 2018 15:16:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629051642.GL3422@umbus.fritz.box>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<153018091454.336571.7311461748726927045.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
In-Reply-To: <153018091454.336571.7311461748726927045.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: compute default value of
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 12:15:14PM +0200, Greg Kurz wrote:
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
> KVM. We thus end up selecting 16G, which isn't supported by HV KVM.
>=20
> We fix this by moving the logic to spapr_machine_init() because this
> is the earliest call where we're sure kvm_enabled() can be trusted.
> Since the user cannot pass cap-hpt-max-page-size=3D0, we set the default
> to 0 in the pseries-2.12 class init function and use that as a flag
> in spapr_machine_init() to do the real work.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c |   25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8cc996d0b822..1eb45cd8c424 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2527,6 +2527,18 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      QLIST_INIT(&spapr->phbs);
>      QTAILQ_INIT(&spapr->pending_dimm_unplugs);
> =20
> +    /* This is for pseries-2.12 and older machine types */
> +    if (!smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE]) {
> +        uint8_t mps;
> +
> +        if (kvmppc_hpt_needs_host_contiguous_pages()) {
> +            mps =3D ctz64(qemu_getrampagesize());
> +        } else {
> +            mps =3D 34; /* allow everything up to 16GiB, i.e. everything=
 */
> +        }
> +        smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
> +    }
> +

The logic above should be folded into spapr_caps_init().

>      /* Determine capabilities to run with */
>      spapr_caps_init(spapr);
> =20
> @@ -4103,17 +4115,16 @@ static void spapr_machine_2_12_instance_options(M=
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
> +     * yet. Postpone this to spapr_machine_init().
> +     */
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 0;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1wLoACgkQbDjKyiDZ
s5K2rxAAvaWJG9Vnkye2y5XWr/mPtZ9UXfxStr32pca0MiAwHvN3LtZ4SbvqyI2h
soMR2GXNgc7lYqp9O1FlUIG8RD+7VZsLW3dNfv8Hua1/nFLenEELiP7fvsDGuNNX
Rw+p5/GA61OhyACUHHZBngGeo3mkyxpExeNzVUyHtw7V98NL3smlW8KzbSh7TLr7
Np2OsrKOrwqU15rufj807FAiM7oaFs3lNUmSB6Wh9eibBOwDGIrOL/fx1eW3aW68
FC8QKN088dMgeb0V8m1yMBUbKGjGthCi25IlMJUEOayvNsurXlxJCQURtzZgs0s1
ADFlDN9r6S0+xc58PqHMYpMHTjZ+Qv/srmzivEDDiRnVDEi5qLlRfs2B8uMsm8SC
TWWv992PjaFbJ2FL8TRQXBbFs9GMcDsRiZ237UswIV30CspGoOBY/JeVU+9x/BPe
E+Y42UlbR1f30AMjbrRIdjBQ6IgexuOAYuFTA4M2MNPFQUaT3+E7ql6NHe9RyNL5
zOxiZwVqNNqgpLiwdHHcWhcuAoHx30p7vN902o+SGncz66P00qwjNTGcXq/Mpi8K
PI94RXqAh/KvnLyva64tMPwfX4c/M+I44juv/Pgg1kFJYV79GQDWtGYGEROXiBgi
FTVB69q91n6aTDvX5GScxi+CRJP70iJGd2bDxThNAwvDD6YWE5Y=
=pYkn
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
