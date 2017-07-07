Received: from eggs.gnu.org ([2001:4830:134:3::10]:46087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVUZ-0003ZM-KT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVUW-0002IY-HR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVUW-0002IK-94
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:48:24 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<20170707152918.23086-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb9ce7a0-7fa9-6638-5d38-908a1441e350@redhat.com>
Date: Fri, 7 Jul 2017 10:48:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L1KA2pFPt0qgnm6CAm6kuOGxXxFJMvAQK"
Subject: Re: [Qemu-devel] [PATCH v3 03/10] nbd/server: use errp instead of
 LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L1KA2pFPt0qgnm6CAm6kuOGxXxFJMvAQK
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 den@openvz.org
Message-ID: <bb9ce7a0-7fa9-6638-5d38-908a1441e350@redhat.com>
Subject: Re: [PATCH v3 03/10] nbd/server: use errp instead of LOG
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <20170707152918.23086-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move to modern errp scheme from just LOGging errors.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 266 +++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 160 insertions(+), 106 deletions(-)
>=20

> @@ -142,23 +142,26 @@ static int nbd_negotiate_send_rep_len(QIOChannel =
*ioc, uint32_t type,
>            type, opt, len);
> =20
>      magic =3D cpu_to_be64(NBD_REP_MAGIC);
> -    if (nbd_write(ioc, &magic, sizeof(magic), NULL) < 0) {
> -        LOG("write failed (rep magic)");
> +    if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
> +        error_prepend(errp, "write failed (rep magic): ");
>          return -EINVAL;

I wonder if we should try harder to preserve the errno returned by
nbd_write() instead of blindly slamming -EINVAL/-EIO everywhere.  But
I'm not going to let it hold up my review of this patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--L1KA2pFPt0qgnm6CAm6kuOGxXxFJMvAQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX61DAAoJEKeha0olJ0NqCXwH/338bnC+hbqLAhj/f0HDYkYE
vZc/wjBiSHrLXIarvA27dhV5OLwvRk5N7RRSfSMxIk89SgmOM+Q+NN4R4WgJnJf9
WrATn3BecoVqbxur1I426zh4NZva0kBGTsjavBjmaG55CVRLjq6NNyQCMw0xMPUN
o77zCTN+CHbxSoAtZa9RAOlXgyaZ69NvX+hLRY0Q/b3utaRYoVlR8L+PkKNVMWdB
CGZnqGhv2Xlv+/E+pKzA2uySNiCjZeJhv5pK8zGpzIxTx7gnoYWAF02YQjjFNQDM
y+qyB/ub/H5A6rwAWiaEuKt6bG/JYQGM1gB6zDNTS0OmLuOdl60reoION7eY6K8=
=gMfT
-----END PGP SIGNATURE-----

--L1KA2pFPt0qgnm6CAm6kuOGxXxFJMvAQK--
