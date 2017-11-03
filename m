Received: from eggs.gnu.org ([2001:4830:134:3::10]:47958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgGi-0001vQ-Fc
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgGe-0007eq-MP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:00:36 -0400
References: <20171103144113.7188-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4296ded2-9c4e-4c21-202e-b28984e48566@redhat.com>
Date: Fri, 3 Nov 2017 13:00:22 -0500
MIME-Version: 1.0
In-Reply-To: <20171103144113.7188-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eCFlBawEi5qxIrnCGdQq5GqKClJWQsNk0"
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after
 committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eCFlBawEi5qxIrnCGdQq5GqKClJWQsNk0
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <4296ded2-9c4e-4c21-202e-b28984e48566@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after committing
 qcow2 image into base
References: <20171103144113.7188-1-berrange@redhat.com>
In-Reply-To: <20171103144113.7188-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 09:41 AM, Daniel P. Berrange wrote:
> After committing the qcow2 image contents into the base image, qemu-img=

> will call bdrv_make_empty to drop the payload in the layered image.
>=20
> When this is done for qcow2 images, it blows away the LUKS encryption
> header, making the resulting image unusable. There are two codepaths
> for emptying a qcow2 image, and the second (slower) codepaths leaves

s/codepaths/codepath/

> the LUKS header intact, so force use of that codepath.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> NB, ideally we would fix the faster codepath in make_completely_empty, =
but
> having looked at the code, I've really no idea how to even start on fix=
ing that
> to not kill the LUKS header clusters.
>=20

> +++ b/block/qcow2.c
> @@ -3594,7 +3594,8 @@ static int qcow2_make_empty(BlockDriverState *bs)=

>      l1_clusters =3D DIV_ROUND_UP(s->l1_size, s->cluster_size / sizeof(=
uint64_t));
> =20
>      if (s->qcow_version >=3D 3 && !s->snapshots &&
> -        3 + l1_clusters <=3D s->refcount_block_size) {
> +        3 + l1_clusters <=3D s->refcount_block_size &&
> +        s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
>          /* The following function only works for qcow2 v3 images (it r=
equires
>           * the dirty flag) and only as long as there are no snapshots =
(because
>           * it completely empties the image). Furthermore, the L1 table=
 and three

Worth updating the comment to explain why we can't use the fast path
with LUKS encryption?

But that's minor enough that with or without a comment tweak, I'm fine wi=
th:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eCFlBawEi5qxIrnCGdQq5GqKClJWQsNk0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8rrYACgkQp6FrSiUn
Q2prGgf/f3xOoJO+xag8MM0xHWcUtg3HredCTac8OLeHYgZjJVYwZpaWZvPtmDVm
YGeXblbnhsGEDSi/qNIoXtlQUfmxpRr8HoH/G3Hyudl79KDicannJigkAX3aw7ee
zVZwpRsjbxZzvxfK7Ltf0VC96ARoJ9bAS7knyW/AV38gv5tTnx7YEVUutIbjK9PR
OcezotONHl1qwMqjQrh3hQgKyzvs/DIlbnJlr/m9Lrw02g6YTnz7UIaBEm5cfBgb
Wb6ApXj8NY0fYKLbQ10VqBpbx359cFPuXTrGFENCeTGMYyTUOcrOtmWcX/5Oc6+n
Pd9dGCVeweVRgg4ErW8/PbycZDgMBA==
=z+PZ
-----END PGP SIGNATURE-----

--eCFlBawEi5qxIrnCGdQq5GqKClJWQsNk0--
