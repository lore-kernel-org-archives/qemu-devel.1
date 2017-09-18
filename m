Received: from eggs.gnu.org ([2001:4830:134:3::10]:37982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtyUq-0007oq-98
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtyUi-0008IG-DJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:08 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
Date: Mon, 18 Sep 2017 11:01:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wbh552j6MMcVJt4HMKsVC1rCtSj9IovGW"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] block/nbd-client:
 nbd_co_send_request: return -EIO if s->quit was set in parallel
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
--wbh552j6MMcVJt4HMKsVC1rCtSj9IovGW
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
Subject: Re: [PATCH v2 5/7] block/nbd-client: nbd_co_send_request: return -EIO
 if s->quit was set in parallel
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> It's incorrect to return success rc >=3D 0 if we skip qio_channel_write=
v_all()
> call due to s->quit.

Does this need to cc: qemu-stable for 2.10.1 (or put another way, can we
come up with some scenario of EAGAIN or other handling that would
actually set s->quit in a parallel coroutine when a client sends out
multiple requests at once)?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index f331f08a9a..280147e6a7 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -189,6 +189,9 @@ static int nbd_co_send_request(BlockDriverState *bs=
,
>      }
> =20
>  err:
> +    if (rc >=3D 0 && s->quit) {
> +        rc =3D -EIO;
> +    }

I'm still not convinced this is in the right place.  This fails the
send_request regardless of whether we skipped qio_channel_writev_all();
shouldn't the rc be set only in the case that we actually skipped
writing the full command because s->quit was detected at that point in ti=
me?

>      if (rc < 0) {
>          s->quit =3D true;
>          s->requests[i].coroutine =3D NULL;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wbh552j6MMcVJt4HMKsVC1rCtSj9IovGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/7ekACgkQp6FrSiUn
Q2oU/QgAgJ6nn8rD3nzOXhPX6kMmFYJd4zh/rXbLi1IPmRvL8HJSKcqcflL5kw+c
tfGaO5P3GS0uTKEAE6Hn+XscvObpANfjFyzWgqsodGcJxUH63dt2YdLX8/22mAuD
uAguSY475wf6FIPIXjwxNeAwvpbPnVa9SnhyY/SEQ2aFhfzQvsfcT0k0BVXV9+sJ
JAFhLYfTA1On7QFHe7C7k3hJ2UG7TbjMXSnjdA/XoRLLG+shN5uwpdyymPDReXPx
o3STF+HRA8ldYnKX8ILt2ZPFq9aTWkW3Y7UVeHg4tu4TBx893MjCIMmmjs5ZHRzE
02FixOYegE/1kHJPZQ6HK10PDWmr4Q==
=JYrv
-----END PGP SIGNATURE-----

--wbh552j6MMcVJt4HMKsVC1rCtSj9IovGW--
