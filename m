Received: from eggs.gnu.org ([2001:4830:134:3::10]:40741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degaX-0003rD-Pd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degaS-0008M5-Tu
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:52:49 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
Date: Mon, 7 Aug 2017 06:52:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PR8CJqMS7R3vp0UgXQBsn3huAmJgffWHD"
Subject: Re: [Qemu-devel] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PR8CJqMS7R3vp0UgXQBsn3huAmJgffWHD
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
Subject: Re: [PATCH 06/17] block/nbd-client: fix nbd_read_reply_entry
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Set reply.handle to 0 on error path to prevent normal path of
> nbd_co_receive_reply.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 1 +
>  1 file changed, 1 insertion(+)

Can you document a case where not fixing this would be an observable bug
(even if it requires using gdb and single-stepping between client and
server to make what is otherwise a racy situation easy to see)?  I'm
trying to figure out if this is 2.10 material.

>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index dc19894a7c..0c88d84de6 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -107,6 +107,7 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>          qemu_coroutine_yield();
>      }
> =20
> +    s->reply.handle =3D 0;
>      nbd_recv_coroutines_enter_all(s);
>      s->read_reply_co =3D NULL;
>  }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PR8CJqMS7R3vp0UgXQBsn3huAmJgffWHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIVH4ACgkQp6FrSiUn
Q2p1Kgf/TjCqZZJ4QSSpNWfyS0id/GB/khoztQglP3aO07Rk3sM+4qPyJq39o7Pf
KB79u5qsxJ4I5dkVijA5qtBf2Hg+tAHNm6AQNuVrwt+g53G1Zxui//TdNUEtRjf8
8xgQrCSeJS+B4mWBlUt6EPgFZZc9hY60IOTLDjdS3HjdS+cq5WXYsYvRNRK56tH7
Dq773GSWxC3qZ1O9JnPfvOUBKP8pKlUcee+Ml3tQuMaQ4K2XxNH8Ucd+kEwLpo3v
X8/j4jbIs9zPCfOtdpVnUWaRHOaP7OxapiY91u5g8QXVKVnfy7KOZv6DITh+LVd0
bufj0oU+jJ0Jy1g7zHPWUyHj6+rN4g==
=yfNa
-----END PGP SIGNATURE-----

--PR8CJqMS7R3vp0UgXQBsn3huAmJgffWHD--
