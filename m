Received: from eggs.gnu.org ([2001:4830:134:3::10]:50965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAyeV-0003Um-Jb
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAyeS-0001qw-Ev
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:06:07 -0400
Date: Wed, 17 May 2017 14:06:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170517130600.GI8260@stefanha-x1.localdomain>
References: <149500797926.28874.3877030098009500731.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
In-Reply-To: <149500797926.28874.3877030098009500731.stgit@bahia>
Subject: Re: [Qemu-devel] [RESEND PATCH] virtio: allow broken device to
 notify guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 10:17:51AM +0200, Greg Kurz wrote:
> According to section 2.1.2 of the virtio-1 specification:
>=20
> "The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state t=
hat
> a reset is needed. If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET,
> the device MUST send a device configuration change notification to the
> driver."
>=20
> Commit "f5ed36635d8f virtio: stop virtqueue processing if device is broke=
n"
> introduced a virtio_error() call that just does that:
>=20
> - internally mark the device as broken
> - set the DEVICE_NEEDS_RESET bit in the status
> - send a configuration change notification
>=20
> Unfortunately, virtio_notify_vector(), called by virtio_notify_config(),
> returns right away when the device is marked as broken and the notificati=
on
> isn't sent in this case.
>=20
> The spec doesn't say whether a broken device can send notifications
> in other situations or not. But since the driver isn't supposed to do
> anything but to reset the device, it makes sense to keep the check in
> virtio_notify_config().
>=20
> Marking the device as broken AFTER the configuration change notification =
was
> sent is enough to fix the issue.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/virtio/virtio.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Re-sending this patch with Cornelia's Reviewed-by and Cc'ing qemu-stable
> since this is a spec violation, as suggested in:
>=20
> Message-ID: <20170427183237-mutt-send-email-mst@kernel.org>
>=20
> Cheers,
>=20
> --
> Greg

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHEq4AAoJEJykq7OBq3PINTIH/2cakWNMJ2n1QiLjefTmUMQV
hJ6zjiRnJiwPQJawKo6ATvMDsEHkfrgM2UZagJ9x/u83IpZ+Mfc+18IjhbPg749m
BcIfzXERzq+F492hdV0yTc17BOBFuJpCG0vcrMXTwm8YDZjBl9vws5Hy7xg28sNi
Oae8Kz1oRhFW4d47jOiOsSWHisP9Ci36I2eH2XIj/j2wbMfXA626OkDnPjL3Rn7Y
seeowOsTTVppJ0mYcENxtfaDnX7Bxp3YOqs7oatQUTpS17UloDcm8SB/7wYfjfEM
9N6oaucHDBVbwdpdfuWmCk8CNDIi4SR0bAHkHWAXWzo8GxYi6cK1r2O4fj9nJVY=
=5fiu
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--
