Received: from eggs.gnu.org ([2001:4830:134:3::10]:43625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpYS-0006Ly-3A
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpYO-0006yr-5Z
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFpYN-0006yl-SI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:23:52 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-11-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <762999b6-71cb-f32a-c67a-71f5309d6ac9@redhat.com>
Date: Tue, 30 May 2017 17:23:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0SV7oabQGnupX5jVr9V0GfuW2LD4bXhHQ"
Subject: Re: [Qemu-devel] [PATCH 10/19] nbd/server: refactor nbd_trip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0SV7oabQGnupX5jVr9V0GfuW2LD4bXhHQ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <762999b6-71cb-f32a-c67a-71f5309d6ac9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/19] nbd/server: refactor nbd_trip
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> - do not goto into switch block from outer block

This sentence didn't quite make sense.  Better might be:

- do not use 'goto error_reply' outside a switch to jump into the middle
of the switch's default case label

> - reduce code duplications

s/duplications/duplication/

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 53 ++++++++++++++++++++--------------------------------=
-
>  1 file changed, 20 insertions(+), 33 deletions(-)
>=20

> @@ -1098,7 +1099,7 @@ static coroutine_fn void nbd_trip(void *opaque)
> =20
>      if (ret < 0) {
>          reply.error =3D -ret;
> -        goto error_reply;
> +        goto reply;
>      }

But this was indeed a case of jumping from before the switch()...

>      default:
>          LOG("invalid request type (%" PRIu32 ") received", request.typ=
e);
>          reply.error =3D EINVAL;
> -    error_reply:
> -        /* We must disconnect after NBD_CMD_WRITE if we did not
> -         * read the payload.
> -         */

=2E..into the middle, which, although valid C, is indeed unusual.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0SV7oabQGnupX5jVr9V0GfuW2LD4bXhHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLfD1AAoJEKeha0olJ0Nq7tgH/1c3xit6ywMIZzxjAi+Dilyx
ZZZ3eQ6QNr8g9GBNtEqOdjyuKT9iCx/2k1Iin+nzk6RHqz5Rsa8Rsm91hGcrcHrE
NhfQWYPg7EPR0sn8UaqEKUb8HJr+Quzq/o9ElVg0D6tlxh+VNz13p7ZwSG/h9Xe4
QDoZVQfbe9G+eI/Iym27MDb4XvkYaq+pk1uFtOF2Dz2NVUVIXkKIsC6IbIvXfnHO
UV/DRBfVh5SxPQKF3ffFjB0JYP/PCh/9k7+h4sPH5WtylbCXcVKqGkJv+bnGRq7s
h+3Z1NW8iqZQPXdk/yAMzos6ki5Evnjy7Sv5kOLJ+sN0mApZhzAPzOwIZDwpvms=
=BrhK
-----END PGP SIGNATURE-----

--0SV7oabQGnupX5jVr9V0GfuW2LD4bXhHQ--
