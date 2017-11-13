Received: from eggs.gnu.org ([2001:4830:134:3::10]:42491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE6HU-0003vk-VL
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE6HT-0007yV-JQ
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:23:32 -0500
Date: Mon, 13 Nov 2017 15:23:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171113042311.GA1014@umbus.fritz.box>
References: <4d05be59374384a32c09437f5d0308bfafaf0128.1509937620.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <4d05be59374384a32c09437f5d0308bfafaf0128.1509937620.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] target/ppc: correct htab shift for
 hash on radix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 02:14:35PM +1100, Sam Bobroff wrote:
> KVM HV will soon support running a guest in hash mode on a POWER9 host
> running in radix mode (see [1]), however the guest currently fails to
> boot.
>=20
> This is because the "htab_shift" value (the size of the MMU's hash
> table) is added to the device tree before KVM has had a chance to
> change it. If the host is in hash mode, KVM does not need to change it
> and so the problem is not seen, but when the host is in radix mode a
> change is required and we see a problem.
>=20
> To fix this, move the call spapr_setup_hpt_and_vrma() (where
> htab_shift could be changed) up a little so that it's called before
> spapr_h_cas_compose_response() (where htab_shift is added to the
> device tree).
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Applied to ppc-for-2.11.

>=20
> [1] See http://www.spinics.net/lists/kvm-ppc/msg13057.html
> ---
> I tested this patch using a kernel based on Paul's kvm-ppc-next branch fr=
om his
> powerpc tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
>=20
>  hw/ppc/spapr_hcall.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0d59d1534d..be22a6b289 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1636,6 +1636,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
>                                                            OV1_PPC_3_00);
>      if (!spapr->cas_reboot) {
> +        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
> +         * (because the guest isn't going to use radix) then set it up h=
ere. */
> +        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
> +            /* legacy hash or new hash: */
> +            spapr_setup_hpt_and_vrma(spapr);
> +        }
>          spapr->cas_reboot =3D
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>                                            ov5_updates) !=3D 0);
> @@ -1644,13 +1650,6 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
> =20
>      if (spapr->cas_reboot) {
>          qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> -    } else {
> -        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
> -         * (because the guest isn't going to use radix) then set it up h=
ere. */
> -        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
> -            /* legacy hash or new hash: */
> -            spapr_setup_hpt_and_vrma(spapr);
> -        }
>      }
> =20
>      return H_SUCCESS;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloJHiwACgkQbDjKyiDZ
s5K8SRAA5h4zGTKXuFfmp9cA+/bk3klswnA5DLORvZyoZsdLyi8M1+Fx14OmU/kA
woxFOk4JyLvNzFYrW4DAY/fKQRQbJNflYgTD8VPtk5E5eurAEGlN4yXdNkpd04Eq
EKDVpyUjgLli7MSABaLKa40MfXzdDd9w90VqYTBSmtcknTiOeSXkEMilToAaV52s
D5ZNyArOaBMkpIWv8B7QWER357RGVXx+RbuEnAEt39owZTwFZVf3QyfaxsjuOsAh
4Y+pKRZ+GpXr8MU5xCRLcChop628uHldl04N4WUzj7nShDc70OL8ca+xujbMaZJT
PulqsuK0W1o2+IHcBfgroxrorMvKQtZLsseINN51g3K/pfRUzEaTItuGkz6c+88K
bQHDm9u/Jd3ABSlzHutNjgF2wMI1YAMdAKUu+JJ+WSYxOgbSL9zypkXoKLAsXSUV
u+nOv4iPg6f5k4wiDFHoTWMTTVuYYDxr2Q0N33/rdVGSGfTabRU8s+ki1WXc1bUk
awc45zb3LuZ5S7FOY882NiYBXflte/+SibhqCG4wPKfaxCTRIiHWXxGcEo5VUtJs
WmD3mxYIvGOpm1Y9sEhBu2TTU5A4YqY60lH+xj69dcPdxXugJAHpFI8o4eL+OThH
8GBFehm0NQ2sM99kTK/F+9lzv41SQAGoq6GjlUUnhQQ+Yx4Hv+Q=
=12tw
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
