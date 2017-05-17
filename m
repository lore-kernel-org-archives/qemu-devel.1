Received: from eggs.gnu.org ([2001:4830:134:3::10]:55721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB5Mu-0007sS-D0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB5Ms-0005wb-TC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:16:24 -0400
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
Date: Wed, 17 May 2017 15:16:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170517170941.25850-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6QA4EoORie5QUW2POQtjVinsJ6I5jC81J"
Subject: Re: [Qemu-devel] [PATCH 2/3] block: use BDRV_POLL_WHILE() in
 bdrv_rw_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6QA4EoORie5QUW2POQtjVinsJ6I5jC81J
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org
Message-ID: <e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] block: use BDRV_POLL_WHILE() in
 bdrv_rw_vmstate()
References: <20170517170941.25850-1-stefanha@redhat.com>
 <20170517170941.25850-3-stefanha@redhat.com>
In-Reply-To: <20170517170941.25850-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 12:09 PM, Stefan Hajnoczi wrote:
> Calling aio_poll() directly may have been fine previously, but this is
> the future, man!

lol

>  The difference between an aio_poll() loop and
> BDRV_POLL_WHILE() is that BDRV_POLL_WHILE() releases the AioContext
> around aio_poll().
>=20
> This allows the IOThread to run fd handlers or BHs to complete the
> request.  Failure to release the AioContext causes deadlocks.
>=20
> Using BDRV_POLL_WHILE() partially fixes a 'savevm' hang with -object
> iothread.

I'm surprised at how many separate hangs we actually had!

>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/io.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/io.c b/block/io.c
> index cc56e90..f0041cd 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2031,9 +2031,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVecto=
r *qiov, int64_t pos,
>          Coroutine *co =3D qemu_coroutine_create(bdrv_co_rw_vmstate_ent=
ry, &data);
> =20
>          bdrv_coroutine_enter(bs, co);
> -        while (data.ret =3D=3D -EINPROGRESS) {
> -            aio_poll(bdrv_get_aio_context(bs), true);
> -        }
> +        BDRV_POLL_WHILE(bs, data.ret =3D=3D -EINPROGRESS);
>          return data.ret;
>      }

Do we have other culprits (not necessarily for vmsave, but for other
situations), where we should be using BDRV_POLL_WHILE in separate
patches? For example, a quick grep show that at least hw/9pfs/9p.c makes
a direct call to aio_poll(,true) in a while loop.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6QA4EoORie5QUW2POQtjVinsJ6I5jC81J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHK+IAAoJEKeha0olJ0NqDyEIAIAedoCQh6mMAjEZAIz4Zs2I
1/IRb0JopYhXlYYWd1byYs+26IE4lSRoNLSMKwGnQFS9HaQaNYMt2LFLCijl5f3z
b6ZPS7c/3YbfDVNWQawiCmA+rfxVFv45MbcZslC8Yaj40y5z51GJE003jJDNBRGK
bYwNIfTF5RxIAKZVzXk2fhw8gNbKjhqJW7vHYbed5gR1+VYNHyJ4qFipA5Y9wXfS
CGYhaZd7AkL01nVt2znSBmnM3EWRrWnk1mw1RlvQlzmQbO32nyRqZm8SrPYNVSBS
GHj6oXPe8FjgJ0xXzGCAcwdJhrhaeYxMN99i07pXY1o2Kk2uu9kevd4AnFHaJOc=
=5Nz3
-----END PGP SIGNATURE-----

--6QA4EoORie5QUW2POQtjVinsJ6I5jC81J--
