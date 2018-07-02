Received: from eggs.gnu.org ([2001:4830:134:3::10]:60707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrxW-0002Js-6L
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrxS-0003Di-2n
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:05:10 -0400
Date: Mon, 2 Jul 2018 16:04:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702060454.GB3422@umbus.fritz.box>
References: <153026568125.394407.16374811229961951138.stgit@bahia.lan>
	<153026572065.394407.16369067299697377597.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JoJCGVnM/36AiBh+"
Content-Disposition: inline
In-Reply-To: <153026572065.394407.16369067299697377597.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] spapr: compute default value of
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--JoJCGVnM/36AiBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 11:48:40AM +0200, Greg Kurz wrote:
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
> We fix this by moving the logic to a fixup helper to be called by
> spapr_caps_init(). Since the user cannot pass cap-hpt-max-page-size=3D0,
> we set the default to 0 in the pseries-2.12 class init function and use
> that as a flag to do the real work.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - moved logic under spapr_caps_init()

As discussed in another thread, it would actually be better to put
this logic into default_caps_with_cpu().  At the moment that just
deals with cpu-dependent defaults, but that's just because that was
the only thing that previously required "late" default calculation.
Now we have another thing, so it makes sense to put them together, and
avoids altering the class structure at runtime.

> ---
>  hw/ppc/spapr.c      |   13 ++++++-------
>  hw/ppc/spapr_caps.c |   20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8cc996d0b822..f6c60f2a1248 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4103,17 +4103,16 @@ static void spapr_machine_2_12_instance_options(M=
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
> +     * yet. Postpone this to spapr_caps_init().
> +     */
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 0;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 62663ebdf51a..e307161f6425 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -552,11 +552,31 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
>  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> =20
> +static void fixup_default_cap_hpt_maxpagesize_pre_3_0(sPAPRMachineState =
*spapr)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    uint8_t mps;
> +
> +    /* If it is already set, then this is a 3.0 or newer machine */
> +    if (smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE]) {
> +        return;
> +    }
> +
> +    if (kvmppc_hpt_needs_host_contiguous_pages()) {
> +        mps =3D ctz64(qemu_getrampagesize());
> +    } else {
> +        mps =3D 34; /* allow everything up to 16GiB, i.e. everything */
> +    }
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
> +}
> +
>  void spapr_caps_init(sPAPRMachineState *spapr)
>  {
>      sPAPRCapabilities default_caps;
>      int i;
> =20
> +    fixup_default_cap_hpt_maxpagesize_pre_3_0(spapr);
> +
>      /* Compute the actual set of caps we should run with */
>      default_caps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_ty=
pe);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JoJCGVnM/36AiBh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5wIYACgkQbDjKyiDZ
s5I4rw//XkZ+/ZcXOIgkWpHrM04Q6n++Al1B0KpJvkUtvmmlVP0Yx8mj2n1KEkll
A4qsDsQhGXWmeq+xQODygzp9kRctdu3fLeUK1SPNElJ49a+GMohdu9cZSU1sVVUC
V+xHC8PDAkTKG0RuPLNTD7G+Y1LoxchZoIIcYLP7IBna2x+zpvquQqIgABgzgvZW
Sp0+YvRquBYdEs3hq5975ZNO5sVDNAHss6KIiLu86/6oaYtBpnIJFhOmjQvJW7CO
I9NN23voqGsf02Ovh8Xmbby/oQEm4QhtxlofYYf/jlYms0k3BYV7jmNhElerLnnR
napeSTuYEm3Igz6CdQUzgZS+f7CWfzWS98o7BOVeCwW/WDLkHcC//U+V/iiVOxc8
Qe79GRKYYtQycEDIBfCPrXXW47BdPwyIqcXA8zYzqoKvI21Lh9Ozb+PKdStSfyhd
qd8HI3OQ6Ku+Cztr356XaaBnWq0YmSs7Laz66Zm8QxTubJH51gqa1+QxvXukGDxq
CUxzcdXfI4tRxiitopXYjlySqxAqE8k1Z9IF4Ts2Bb6niIyxznk6wzom5L2SHZdI
87bNTJfF8/JrQ1MAVSl1+pBHDkmu3QHTwpnhV3pDBmrDBlNY3XhJVDY6Ww/bdGoP
Z8ahUb378PTEOk794q1feTQEuPmgyTy2CFJmNO1E/quJZE8+nuE=
=oSxP
-----END PGP SIGNATURE-----

--JoJCGVnM/36AiBh+--
