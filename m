Received: from eggs.gnu.org ([2001:4830:134:3::10]:49025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1zcM-00070h-Jb
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1zcL-0004kb-FU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:51:02 -0400
References: <20171010134205.6120-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00ece7c6-3c55-f84b-adcf-27869a596eb5@redhat.com>
Date: Tue, 10 Oct 2017 13:50:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171010134205.6120-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="unbhqtwGpHpVajqJ4C6gRpOB0tBArriqr"
Subject: Re: [Qemu-devel] [PATCH RFC] file-posix: make lock_fd read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--unbhqtwGpHpVajqJ4C6gRpOB0tBArriqr
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, berrange@redhat.com
Message-ID: <00ece7c6-3c55-f84b-adcf-27869a596eb5@redhat.com>
Subject: Re: [PATCH RFC] file-posix: make lock_fd read-only
References: <20171010134205.6120-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171010134205.6120-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 08:42 AM, Vladimir Sementsov-Ogievskiy wrote:
> We do not reopen lock_fd on bdrv_reopen which leads to problems on
> reopen image RO. So, lets make lock_fd be always RO.
> This is correct, because qemu_lock_fd always called with exclusive=3Dfa=
lse
> on lock_fd.

How is that correct?  file-posix.c calls:
            ret =3D qemu_lock_fd_test(s->lock_fd, off, 1, true);
where exclusive being true in turn sets:
        .l_type   =3D exclusive ? F_WRLCK : F_RDLCK,

and F_WRLCK requests fail on a RO fd with EBADF.

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> We've faced the following problem with our shared-storage migration
> scheme. We make an external snapshot and need base image to be reopened=

> RO. However, bdrv_reopen reopens only .fd of BDRVRawState but not
> .lock_fd. So, .lock_fd is left opened RW and this breaks the whole
> thing.

What exactly breaks?  Any specific error message, or a backtrace, or
something with more details?

>=20
> The simple fix is here: let's just open lock_fd as RO always. This
> looks fine for current code, as we never try to set write locks
> (qemu_lock_fd always called with exclusive=3Dfalse).

I just argued that we DO try to set write locks in file-posix, and
therefore, we need more details of what the real problem is, because
this does not feel like the right fix.

>=20
> However it will not work if we are going to use write locks.
>=20
>=20
>  block/file-posix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 36ee89e940..5c52df9174 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -514,7 +514,8 @@ static int raw_open_common(BlockDriverState *bs, QD=
ict *options,
> =20
>      s->lock_fd =3D -1;
>      if (s->use_lock) {
> -        fd =3D qemu_open(filename, s->open_flags);
> +        /* open it read-only, as we do not reopen it on bdrv_reopen */=

> +        fd =3D qemu_open(filename, (s->open_flags & ~BDRV_O_RDWR));
>          if (fd < 0) {
>              ret =3D -errno;
>              error_setg_errno(errp, errno, "Could not open '%s' for loc=
king",
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--unbhqtwGpHpVajqJ4C6gRpOB0tBArriqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndFosACgkQp6FrSiUn
Q2q8fAf/U7MxyLk4yKphRHI449+rJZeZlUvFYbaGaEqw+Gh1NyzqLz96jQ2xyhmj
wE4QsIjm3zZXmjHAXn6NU2RRufG42t05ZxnYbjRsPdVBFpNpvWpjou1bwCEjnTeH
FjgGDHmC4tUHVrwLU0XlOCWBzTKvuPQ+bGFr4VeWi7+dcUibpQ0qDxb3lmHt/ZhL
rbDzTB8bIYOdTVgr6u+4aOND/MIrglHZ3T5mH4JoMMVg3yn38FBZFmW8LMzAzFZp
iZBAFm0Joj7OfjSLk4PgD1/NFQNVADauzXAp4mAWwoUaXE/SwNzDfWbHMg0ASP3X
ttRRXBfMrHUQcMEuqyX5FYGjgruecw==
=zOd8
-----END PGP SIGNATURE-----

--unbhqtwGpHpVajqJ4C6gRpOB0tBArriqr--
