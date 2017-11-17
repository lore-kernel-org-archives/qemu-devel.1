Received: from eggs.gnu.org ([2001:4830:134:3::10]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhhG-0003U9-0K
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhhF-0006hE-0k
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:32:46 -0500
References: <20171117112913.21875-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f180831-1ecd-7326-7659-19f79170439e@redhat.com>
Date: Fri, 17 Nov 2017 08:32:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171117112913.21875-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lW3SGiTTOS9DXwd7lLVImqC84KrTMGtDp"
Subject: Re: [Qemu-devel] [PATCH v2 (for-2.11)] qcow2: fix image corruption
 after committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lW3SGiTTOS9DXwd7lLVImqC84KrTMGtDp
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9f180831-1ecd-7326-7659-19f79170439e@redhat.com>
Subject: Re: [PATCH v2 (for-2.11)] qcow2: fix image corruption after
 committing qcow2 image into base
References: <20171117112913.21875-1-berrange@redhat.com>
In-Reply-To: <20171117112913.21875-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 05:29 AM, Daniel P. Berrange wrote:
> After committing the qcow2 image contents into the base image, qemu-img=

> will call bdrv_make_empty to drop the payload in the layered image.
>=20
> When this is done for qcow2 images, it blows away the LUKS encryption
> header, making the resulting image unusable. There are two codepaths
> for emptying a qcow2 image, and the second (slower) codepath leaves
> the LUKS header intact, so force use of that codepath.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> =20
>      if (s->qcow_version >=3D 3 && !s->snapshots &&
> -        3 + l1_clusters <=3D s->refcount_block_size) {
> +        3 + l1_clusters <=3D s->refcount_block_size &&
> +        s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {

Missing the check for s->nb_bitmaps =3D=3D 0 that Vladimir mentioned on v=
1.
Either we can add that in this patch, or I can post the obvious followup
that also needs queuing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lW3SGiTTOS9DXwd7lLVImqC84KrTMGtDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloO8wAACgkQp6FrSiUn
Q2pJxAf/XNKCKk/0y6LmNMc5Wp+9TzX8ORxTdg7hZUNVn2YNQEGzMAI5+wdjaHT9
+/YmmTDb4cNZ8nX7GbHoTEVrC22T9dpaWd9oqvA09rC7Q0h4+oysxIkcuJPx66+Z
yqqliSgf8UDygYKVtHnIZvtCO581YxfeddCDAEE5S80XKtiXhjtkT8iOndL7pWKh
aQnq+Z9W8TOqp8lqNB0QNtsnJ8T455e/1wetKOvvh7po5cSof6qf08o/7bYXsEAe
+f6tHTx71e8Iz3QixDSkUt6FCAdOuHH49hW+22rLZO9N20aUunt21POq6lr6vO3G
YhqfPWzTl6nmXF05gVE/EjqIsoA9Gg==
=pTGi
-----END PGP SIGNATURE-----

--lW3SGiTTOS9DXwd7lLVImqC84KrTMGtDp--
