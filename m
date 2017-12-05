Received: from eggs.gnu.org ([2001:4830:134:3::10]:36985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEL3-0000vo-0h
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEL2-0005rF-5n
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:36:49 -0500
References: <20171205104141.28882-1-stefanha@redhat.com>
	<20171205104141.28882-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f69659d6-0bae-b510-3cd5-435e8fd4838a@redhat.com>
Date: Tue, 5 Dec 2017 08:36:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171205104141.28882-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LAKmJuQltWGTQUnK4gbAiKBT8cOBjtOT2"
Subject: Re: [Qemu-devel] [PATCH 1/9] blockdev: hold AioContext for
 bdrv_unref() in external_snapshot_clean()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LAKmJuQltWGTQUnK4gbAiKBT8cOBjtOT2
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <f69659d6-0bae-b510-3cd5-435e8fd4838a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] blockdev: hold AioContext for
 bdrv_unref() in external_snapshot_clean()
References: <20171205104141.28882-1-stefanha@redhat.com>
 <20171205104141.28882-2-stefanha@redhat.com>
In-Reply-To: <20171205104141.28882-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 04:41 AM, Stefan Hajnoczi wrote:
> bdrv_unref() requires the AioContext lock because bdrv_flush() uses
> BDRV_POLL_WHILE(), which assumes the AioContext is currently held.  If
> BDRV_POLL_WHILE() runs without AioContext held the
> pthread_mutex_unlock() call in aio_context_release() fails.
>=20
> This patch moves bdrv_unref() into the AioContext locked region to solv=
e
> the following pthread_mutex_unlock() failure:
>=20
>   #0  0x00007f566181969b in raise () at /lib64/libc.so.6
>   #1  0x00007f566181b3b1 in abort () at /lib64/libc.so.6
>   #2  0x00005592cd590458 in error_exit (err=3D<optimized out>, msg=3Dms=
g@entry=3D0x5592cdaf6d60 <__func__.23977> "qemu_mutex_unlock") at util/qe=
mu-thread-posix.c:36
>   #3  0x00005592cd96e738 in qemu_mutex_unlock (mutex=3Dmutex@entry=3D0x=
5592ce9505e0) at util/qemu-thread-posix.c:96
>   #4  0x00005592cd969b69 in aio_context_release (ctx=3Dctx@entry=3D0x55=
92ce950580) at util/async.c:507
>   #5  0x00005592cd8ead78 in bdrv_flush (bs=3Dbs@entry=3D0x5592cfa87210)=
 at block/io.c:2478
>   #6  0x00005592cd89df30 in bdrv_close (bs=3D0x5592cfa87210) at block.c=
:3207
>   #7  0x00005592cd89df30 in bdrv_delete (bs=3D0x5592cfa87210) at block.=
c:3395
>   #8  0x00005592cd89df30 in bdrv_unref (bs=3D0x5592cfa87210) at block.c=
:4418
>   #9  0x00005592cd6b7f86 in qmp_transaction (dev_list=3D<optimized out>=
, has_props=3D<optimized out>, props=3D<optimized out>, errp=3Derrp@entry=
=3D0x7ffe4a1fc9d8) at blockdev.c:2308
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  blockdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I know the series is too big/late for 2.11, but is this one patch worth
having?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LAKmJuQltWGTQUnK4gbAiKBT8cOBjtOT2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomrvAACgkQp6FrSiUn
Q2r/MQf+LEyXKKksyQokvnVHBl3LHqbMixu3M2CqrxfoAoJZndj/z9rg0HHDkvkI
HSoVvEkFehpvOYtDQpH62B5U2YnJoQwwMhRc1aAbJHcAZSgy5EWXztJqaz+EdAAU
JuDUHzsv6Waig0uFQieo9JeSp9t/2GzTSHz6i9VSTKslpifHsmypvZM23NLGkTif
WveDyck2JiAqnd1e/ovG/tLYO+4aRFnt7Vq3k5eXmAaYn0hPhr5mz1a2XZrdXJB7
hdJPOgF8K5gZx7oFYFQabLOjW2xHlH7DCjEoYchVRMizG8bdD7ETc0nd/SBDES6P
veKmK6cGTHJmvEHAAJ1HtVBBECGKYA==
=g+3O
-----END PGP SIGNATURE-----

--LAKmJuQltWGTQUnK4gbAiKBT8cOBjtOT2--
