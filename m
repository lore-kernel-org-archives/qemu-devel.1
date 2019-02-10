Received: from eggs.gnu.org ([209.51.188.92]:42863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gsyVV-0002pD-QR
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 18:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gsyVN-000358-4A
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 18:27:25 -0500
Date: Mon, 11 Feb 2019 10:23:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190210232353.GC7230@umbus.fritz.box>
References: <154964986747.291716.2679312373018476920.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <154964986747.291716.2679312373018476920.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: Disallow unsupported kernel-irqchip
 settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 07:17:47PM +0100, Greg Kurz wrote:
> Split mode doesn't make sense on pseries, neither with XICS nor XIVE. But
> passing kernel-irqchip=3Dsplit silently behaves like kernel-irqchip=3Don.
> Other architectures that support kernel-irqchip do terminate QEMU when
> split mode is requested but not available though. Do the same with pseries
> for consistency.
>=20
> Similarly, passing kernel-irqchip=3Don,accel=3Dtcg starts the machine wit=
h the
> emulated interrupt controller, ie, behaves like kernel-irqchip=3Doff. How=
ever,
> when passing  kernel-irqchip=3Don,accel=3Dkvm, if we can't initialize the=
 KVM
> XICS for some reason, ie, xics_kvm_init() fails, then QEMU is terminated.
> This is inconsistent. Terminate QEMU all the same when requesting the
> in-kernel interrupt controller without KVM.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> The odds for someone to have an existing pseries setup with split mode are
> very low since this is really an x86 thingy. And I guess we don't really
> care to break the silly kernel-irqchip=3Don,accel=3Dtcg case. But if we r=
eally
> need to stay bug compatible, the errors can be turned into warnings.

Applied, thanks.

> ---
>  hw/ppc/spapr_irq.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2d7a7c163876..80b0083b8e38 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -600,6 +600,19 @@ sPAPRIrq spapr_irq_dual =3D {
>   */
>  void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
> +
> +    if (machine_kernel_irqchip_split(machine)) {
> +        error_setg(errp, "kernel_irqchip split mode not supported on pse=
ries");
> +        return;
> +    }
> +
> +    if (!kvm_enabled() && machine_kernel_irqchip_required(machine)) {
> +        error_setg(errp,
> +                   "kernel_irqchip requested but only available with KVM=
");
> +        return;
> +    }
> +
>      /* Initialize the MSI IRQ allocator. */
>      if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxgsokACgkQbDjKyiDZ
s5I09xAAkex/q1Xit5WaAAROPAXEscdxm1Xc9vHttYtbyzEvl6AYycvF39fr96oG
kiAeQGL8NgXrSELAhs63C4cY+wwuuQasnfrZmS3TZjj6CRKnXk2FeU4/8ppK33gY
fIamflCLvLXIVQSY7qqy/Z9RSvrL22Wv+55MTGbGH6B3ll/9xwGPt/XUaFePNFCR
XWFuoLJ9nlclgzN/7lAH8039+5JN8XR6V/Y4eRFegBa4RuHT15hBfoAQG/Wa1UQJ
ivgxpY2dYvn1cidBreq40cJcDCVserRY6+FL4/lCPWYYKx5ZCghXy6bSovXudmUT
16pSo8QhZi1/Lb84VwwrEBp12BXaWJuapF35kqb80+TvOSin6kSTb1XNUN3pAow3
EDC8rAOLG45+V+VtNFfLI0BMfkVFI8TFACQ8b+FyXSZgA2d6hdjG3mKEZjFa4tW5
5MkNAkJpGX8jsL4NuuOkwvvpT4f7sKNWlEg3Tb3Vp4ZHFEwpXzyj5ga+T8xkbXs+
StK2RNV4hFOBCVq5GOEHsOzIxEPtJdoYhMexv+m932ONCKw4uOxX6g0ecXj2Fgj8
meR8GaG0Gqd+Nwof8ZHrWfLlEOFsBkRA+3hzv5ttBBtivMwzS+n9n8OvpGbE0X4a
JG1WORM7oANM2SPkaBkn44vcnAnOsu+Xt2u+OE1BxXgggNw9Q8c=
=4LSM
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
