Received: from eggs.gnu.org ([2001:4830:134:3::10]:58463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGwPf-0003Ep-Vl
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGwPe-0003qj-Tc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:27:43 -0500
Date: Tue, 21 Nov 2017 11:12:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171121001226.GN19214@umbus.fritz.box>
References: <1511163878-11977-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRo3kt64Wi40AlcO"
Content-Disposition: inline
In-Reply-To: <1511163878-11977-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/ppc/spapr: Fix virtio-scsi
 bootindex handling for LUNs >= 256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--QRo3kt64Wi40AlcO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 08:44:38AM +0100, Thomas Huth wrote:
> LUNs >=3D 256 have to be encoded with the so-called "flat space
> addressing method" for virtio-scsi, where an additional bit has to
> be set. SLOF already took care of this with the following commit:
>=20
>  https://git.qemu.org/?p=3DSLOF.git;a=3Dcommitdiff;h=3Df72a37713fea47da
>  (see https://bugzilla.redhat.com/show_bug.cgi?id=3D1431584 for details)
>=20
> But QEMU does not use this encoding yet for device tree paths
> that have to be handed over to SLOF to deal with the "bootindex"
> property, so SLOF currently fails to boot from virtio-scsi devices
> with LUNs >=3D 256 in the right boot order. Fix it by using the bit
> to indicate the "flat space addressing method" for LUNs >=3D 256.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.11, thanks.

> ---
>  hw/ppc/spapr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d682f01..ff2eec4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2643,6 +2643,10 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>               * swap 0100 or 10 << or 20 << ( target lun-id -- srplun )
>               */
>              unsigned id =3D 0x1000000 | (d->id << 16) | d->lun;
> +            if (d->lun >=3D 256) {
> +                /* Use the LUN "flat space addressing method" */
> +                id |=3D 0x4000;
> +            }
>              return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
>                                     (uint64_t)id << 32);
>          } else if (usb) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QRo3kt64Wi40AlcO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloTb2cACgkQbDjKyiDZ
s5KvYQ/+Kz/D9tc7zO8Me9qudhc2TYgYfaR7ijunGwh0vlQPLx/MU0nEJeqb4tKU
B2S8D8qIk+xsujx+tgaxCIEvJyUPPxjeNSx6kqNakEx9qWh/dhlSvRunQwmVs8Sb
i8kZTn0QXfX1sr48jvgOChZZub2zWbiRuVGCRK62x95aH4wpV0WGaAkHedbdQ1ro
fV292eGicDr3H/O76ydjyaT7MRlqaAxBUVuIEqRAdYXoDL5YV63iFzkIl2wFancp
IQaCLPQAP3YZjp36R0M35xMp2sg008BEuqLiDaNPmqqvui0ym2re/6RfgSMDVlFM
yYlXks4Whz/ctIRq1G4oPtV5p/l3tEWGpKbSpyIm9PtRIlwF1r7O0/cfpUuYrR8C
eVkDKEY1haJZFtvbco+4CGPnYOWB/Ew96i2blR02JKsQPuZPhGbmxHObY2fQmUVS
Qfrtdx6UITiaLjlPTy2NPvSQsLUMGN1oc+w3IZAm8EeWiS4YwwSXTYpeIzcw3bCE
Q3/fpngio3vs24PeIhfqMnxiUBbnxIZp9rzacqOC1h/8peLtyHzwEbnYrNBdRNl+
xuEE5gLvJ2xlNqolE+upLmuqnO8cWJ5xMo4u4y6tTaKHL7q0W0It9aYsP6TYouDA
auHiHSPv893cGag0txgEwI4uztqde1RqkdS93jyGQFI449NA4fA=
=AYS1
-----END PGP SIGNATURE-----

--QRo3kt64Wi40AlcO--
