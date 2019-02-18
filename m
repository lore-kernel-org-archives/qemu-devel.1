Received: from eggs.gnu.org ([209.51.188.92]:46248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvsTB-0007pE-3L
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvsTA-0005pV-6X
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:37:05 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bb6ada92-7cb5-7171-2424-e048f954a878@redhat.com>
Date: Tue, 19 Feb 2019 00:36:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t1cAeK5PRj8gCsrXNzQwpG6IX6xmSEE2x"
Subject: Re: [Qemu-devel] [RFC PATCH 07/11] qcow2: External file I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t1cAeK5PRj8gCsrXNzQwpG6IX6xmSEE2x
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <bb6ada92-7cb5-7171-2424-e048f954a878@redhat.com>
Subject: Re: [RFC PATCH 07/11] qcow2: External file I/O
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-8-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 18:55, Kevin Wolf wrote:
> This changes the qcow2 implementation to direct all guest data I/O to
> s->data_file rather than bs->file, while metadata I/O still uses
> bs->file. At the moment, this is still always the same, but soon we'll
> add options to set s->data_file to an external data file.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.h          |  2 +-
>  block/qcow2-bitmap.c   |  7 ++++---
>  block/qcow2-cache.c    |  6 +++---
>  block/qcow2-cluster.c  | 46 +++++++++++++++++++++++++++++++++++-------=

>  block/qcow2-refcount.c | 30 +++++++++++++++++++--------
>  block/qcow2-snapshot.c |  7 ++++---
>  block/qcow2.c          | 39 +++++++++++++++++++++++++----------
>  7 files changed, 101 insertions(+), 36 deletions(-)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2b81cf839d..ac9934b3ed 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -3598,6 +3598,16 @@ static int coroutine_fn qcow2_co_truncate(BlockD=
riverState *bs, int64_t offset,
>          int64_t old_file_size, new_file_size;
>          uint64_t nb_new_data_clusters, nb_new_l2_tables;
> =20
> +        /* With a data file, preallocation means just allocating the m=
etadata
> +         * and forwarding the truncate request to the data file */

That's true, but...

> +        if (has_data_file(bs)) {
> +            ret =3D preallocate_co(bs, old_length, offset);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "Preallocation failed");
> +                goto fail;
> +            }

=2E..without a break here we're still going to preallocate bs->file as be=
fore.

Max

> +        }
> +
>          old_file_size =3D bdrv_getlength(bs->file->bs);
>          if (old_file_size < 0) {
>              error_setg_errno(errp, -old_file_size,


--t1cAeK5PRj8gCsrXNzQwpG6IX6xmSEE2x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxrQZgACgkQ9AfbAGHV
z0CEWwf/UA230ZIfo1DW34++iQKJFsUeHYCDtZvyBKv0fzO8ZXUuyr6Ke5m/NjB2
yDMwW323CcK3dfvgB83yMBrHGtPmtZRXfyin52XDVbPFK/KPY6TKkqKLs+Hw/tTy
UIpUxmve1XARZXf7VIqGaEqdavPbC7Lq3ITs9yms2eaopu3+H7NekUA7bQYTUzha
lelTI+I5lbeMd5wDfc2WWQuihH8t7GCN54JB9sappCQVU2iWgBg9DpveBWpYZ/XO
p6PE5hKZh9qX26+ZTWhRQx3tdSbQjU/DnVv7aScjW/8H+DGVMGqsQE2RAFDyrQ3y
ecK7DUysayNsyFX9L9D82gX9yf5aqg==
=oPnQ
-----END PGP SIGNATURE-----

--t1cAeK5PRj8gCsrXNzQwpG6IX6xmSEE2x--
