Received: from eggs.gnu.org ([2001:4830:134:3::10]:47701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cir4y-0008C5-VF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cir4u-0007o3-3O
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:21:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cir4t-0007nR-Qy
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:21:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1EFB81F01
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 23:21:07 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-29-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <304c6066-fea0-f5e4-9c6f-384afa9ff5f2@redhat.com>
Date: Tue, 28 Feb 2017 17:21:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-29-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xE9x7Jw92bnoigwb5bXu5dairOivw2RgI"
Subject: Re: [Qemu-devel] [PATCH v2 28/30] tests: add specialized
 device_find function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xE9x7Jw92bnoigwb5bXu5dairOivw2RgI
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <304c6066-fea0-f5e4-9c6f-384afa9ff5f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 28/30] tests: add specialized device_find
 function
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
 <20170221141451.28305-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> Allows to specify which slot to look for the device.

"Allow[s] to ${verb}" is not idiomatic; it's missing a subject.  But
"Allows $subject to" (as in "allows someone to" or "allows me to") is
wordy, compared to just saying "Allows ${verb}ing".  I'd suggest:

Allow specifying which slot to favor when looking for the device.

>=20
> This will be used in the following patch to avoid leaking when multiple=

> devices exists and we want to lookup the hotplug one.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/libqos/virtio-pci.h |  4 ++--
>  tests/libqos/virtio-pci.c | 31 ++++++++++++++++++++++++++-----
>  2 files changed, 28 insertions(+), 7 deletions(-)
>=20

> @@ -55,10 +57,11 @@ static void qvirtio_pci_foreach_callback(
>      QVirtioPCIForeachData *d =3D data;
>      QVirtioPCIDevice *vpcidev =3D qpcidevice_to_qvirtiodevice(dev);
> =20
> -    if (vpcidev->vdev.device_type =3D=3D d->device_type) {
> +    if (vpcidev->vdev.device_type =3D=3D d->device_type &&
> +        (!d->has_slot || vpcidev->pdev->devfn =3D=3D d->slot << 3)) {
>          d->func(&vpcidev->vdev, d->user_data);
>      } else {
> -        g_free(vpcidev);
> +        qvirtio_pci_device_free(vpcidev);

Is this an unmentioned leak plug?  Either it should be mentioned, or
squashed into the leak fix of 29.

With those cleanups,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xE9x7Jw92bnoigwb5bXu5dairOivw2RgI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgXhAAoJEKeha0olJ0Nq+gQH/jc6iX5Zrv96qDyXFg4+ODCD
+Qu7xTv53goc1NioGLVcHqbQ0QEXjpH2MwuhhlpXpuPrOJSAY4ESiKJJmBRtipsA
xouy7sHf9TaJp7dERQ6RoddMS005izigb3oQBNkDIEXrVDHVJw836xLIeWjVVWdR
Z4JASf3gAWV71Vhvy/eXQfHa8bZn/PtYRbNxNJGGxqBt8NcPM6AMnlotWfV8kgIc
UdVyNvxmQBxMoCfz3TgmWJE1T+B/CJIRRrn/Kv0y0+3ernjvhC9Z3binpMZsemqW
Iha/3vEW4JR9ojyWoHvb7mTbhZUcPYrLOmZRieo5Ph2PZVP4h8threfOhq74GXs=
=N8nw
-----END PGP SIGNATURE-----

--xE9x7Jw92bnoigwb5bXu5dairOivw2RgI--
