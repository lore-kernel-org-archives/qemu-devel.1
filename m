Received: from eggs.gnu.org ([209.51.188.92]:58432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpa-0005ZM-9P
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpZ-0003Sb-Ek
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:50 -0500
Date: Fri, 11 Jan 2019 11:27:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111002747.GN6682@umbus.fritz.box>
References: <1547042603-21147-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
In-Reply-To: <1547042603-21147-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Encode the SCSI channel
 (bus) in the SRP LUNs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 03:03:23PM +0100, Thomas Huth wrote:
> In hw/scsi/spapr_vio.c we declare that the controller supports multiple
> buses by specifying "max_channel =3D 7" there. So in the code that fixes
> up the device tree nodes, we must encode the channel number (a.k.a. bus
> number in the "Logical unit addressing format" table of SAM5) into the
> 64-bit LUN, too.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1663160
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  hw/ppc/spapr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5671608..1f49489 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2905,10 +2905,11 @@ static char *spapr_get_fw_dev_path(FWPathProvider=
 *p, BusState *bus,
>          if (spapr) {
>              /*
>               * Replace "channel@0/disk@0,0" with "disk@8000000000000000":
> -             * We use SRP luns of the form 8000 | (bus << 8) | (id << 5)=
 | lun
> -             * in the top 16 bits of the 64-bit LUN
> +             * In the top 16 bits of the 64-bit LUN, we use SRP luns of =
the form
> +             * 0x8000 | (target << 8) | (bus << 5) | lun
> +             * (see the "Logical unit addressing format" table in SAM5)
>               */
> -            unsigned id =3D 0x8000 | (d->id << 8) | d->lun;
> +            unsigned id =3D 0x8000 | (d->id << 8) | (d->channel << 5) | =
d->lun;
>              return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
>                                     (uint64_t)id << 48);
>          } else if (virtio) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw34wIACgkQbDjKyiDZ
s5IvVg/9HgiiEH4Q63io2iZCsOjF7ZKYWfeUC2L7QX5+2NW/Jo6EiGKsvImCwdEc
OVkRfVDkgymvvPgfGQpLzwgb6OX19WKuovPJYNHxZ728CR7PlyM8yMVKfiBkP6sZ
RSmW/xcI8CrKgdXWOGjVWPkRn3IH5XSrEMrDJsK3rkDJ9SPofjlEJs30NNQtL5m8
pUeoEQQkoYdW06EL/iAFu+GR1dlprNIT3QEqCJlJKryQkIk4ufyAh8dbPS5BiNAZ
/feDWBy7OzL2mTnj1250ZatTb1X7mrjo52oJIWVXGYIatLwd5GWRl8QtJ6j3i0Kd
adVsgjsSYQSBqqFGnTbMAfJZEtcDHe6HMYxziWwZEBUfczFZj6oVpi65Ix0SvprZ
opz1wRzeqLwEdEQEtns5MIBWRcCh1ydv+dQkUjIEKGdgpzjUKfwOc4YAROdD0Un2
rgD8efRgYA9Ri5rKBJVba0m8MQqHOg8dsKPqzrt1Ag13SyT32pqn3XzWHIhfJLVY
P6WCth5NJg/NC9Jv0ie0XXI+8HQaftjeR0lUEIcqSyLtI00caIai4koYcq/4Ir6D
3gCk5/Q2U0CDgWu4vUdEToAhcxy3fQFF1nDqQILXBr4xuPajci4yMsZ3ZYSt0fWP
4mTx0qqPcvcZTcVUOR6lK+TvSwi5u7tR+ozK+ONPW6VPQ0nIftc=
=Dv8V
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--
