Received: from eggs.gnu.org ([209.51.188.92]:57456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gob8w-0007Kp-9S
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gob8v-00082l-Ex
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:42:06 -0500
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
	<20190129143800.88563-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63bef428-e6c8-1781-cf50-8659acf88e0b@redhat.com>
Date: Tue, 29 Jan 2019 15:41:58 -0600
MIME-Version: 1.0
In-Reply-To: <20190129143800.88563-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="568ro7bt0DUnLSn6i9PHfFikVfIt2CNYV"
Subject: Re: [Qemu-devel] [PATCH 2/2] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--568ro7bt0DUnLSn6i9PHfFikVfIt2CNYV
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com
Message-ID: <63bef428-e6c8-1781-cf50-8659acf88e0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/io: use qemu_iovec_init_buf
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
 <20190129143800.88563-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190129143800.88563-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 8:38 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 89 ++++++++++++------------------------------------------=

>  1 file changed, 20 insertions(+), 69 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index bd9d688f8b..80961910a6 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -842,17 +842,13 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t=
 offset,
>  static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *b=
uf,
>                        int nb_sectors, bool is_write, BdrvRequestFlags =
flags)
>  {
> -    QEMUIOVector qiov;
> -    struct iovec iov =3D {
> -        .iov_base =3D (void *)buf,
> -        .iov_len =3D nb_sectors * BDRV_SECTOR_SIZE,
> -    };
> +    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf,
> +                                            nb_sectors * BDRV_SECTOR_S=
IZE);

Okay, so you ARE using both the macro...

> @@ -977,17 +963,12 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset=
, QEMUIOVector *qiov)
> =20
>  int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int=
 bytes)
>  {
> -    QEMUIOVector qiov;
> -    struct iovec iov =3D {
> -        .iov_base   =3D (void *) buf,
> -        .iov_len    =3D bytes,
> -    };
> +    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);

Ouch - why are you passing NULL instead of buf?  But this answers why
the macro had to cast - it is indeed casting away const.

> @@ -1229,9 +1209,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(=
BdrvChild *child,
> =20
>          if (ret <=3D 0) {
>              /* Must copy-on-read; use the bounce buffer */
> -            iov.iov_base =3D bounce_buffer;
> -            iov.iov_len =3D pnum =3D MIN(pnum, MAX_BOUNCE_BUFFER);
> -            qemu_iovec_init_external(&local_qiov, &iov, 1);
> +            qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);

=2E..and the function.

Ouch - why did you lose the assignment of pnum =3D MIN() here?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--568ro7bt0DUnLSn6i9PHfFikVfIt2CNYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQyKYACgkQp6FrSiUn
Q2pV9Qf/VkYaYEm+VVh++dbrpDH3MzlwfFAZ9zrloT/cJoZhQcFzBdITFFsDW4or
acIklVhJG68bnBxv+cOuTggHuNoSMh69b6Z00eEMt3pGU/8+ZiPVF/IiM9wcR5LR
GnIQY+yP1UOPnClehswrEQB3Iylh6jsBoijWeu9YBiZZuAeunhr4ZjB7uT7jV7iO
BuoeGvtlAwTreq/lUc4Xs+IoihDoAgwf6/SEY+H2zzrQtWhI4+r2szGnPcWZ8drc
Y13C8QqIsU45ZSiDxOfwMFgLxKSUkNLn5M5FvJ+KgMBC1S+AIXgpxt+ajYBeRWOI
7Z8XiiABdweL5sJGAfD+Z961MMBrhQ==
=7oaX
-----END PGP SIGNATURE-----

--568ro7bt0DUnLSn6i9PHfFikVfIt2CNYV--
