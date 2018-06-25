Received: from eggs.gnu.org ([2001:4830:134:3::10]:54881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXSQN-00009G-M1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXSQM-00018B-P6
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:24:59 -0400
References: <20180621170657.27542-1-kwolf@redhat.com>
	<20180621170657.27542-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c206c1db-0fb4-0297-8b41-51d89235d8d0@redhat.com>
Date: Mon, 25 Jun 2018 16:24:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180621170657.27542-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nbdvQiSi4AOm7koq9xNy2wTGR14EJtt43"
Subject: Re: [Qemu-devel] [PATCH 2/2] file-posix: Make .bdrv_co_truncate
 asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nbdvQiSi4AOm7koq9xNy2wTGR14EJtt43
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, qemu-devel@nongnu.org
Message-ID: <c206c1db-0fb4-0297-8b41-51d89235d8d0@redhat.com>
Subject: Re: [PATCH 2/2] file-posix: Make .bdrv_co_truncate asynchronous
References: <20180621170657.27542-1-kwolf@redhat.com>
 <20180621170657.27542-3-kwolf@redhat.com>
In-Reply-To: <20180621170657.27542-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-21 19:06, Kevin Wolf wrote:
> This moves the code to resize an image file to the thread pool to avoid=

> blocking.
>=20
> Creating large images with preallocation with blockdev-create is now
> actually a background job instead of blocking the monitor (and most
> other things) until the preallocation has completed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/raw-aio.h |   4 +-
>  block/file-posix.c      | 265 +++++++++++++++++++++++++++-------------=
--------
>  2 files changed, 153 insertions(+), 116 deletions(-)

[...]

> diff --git a/block/file-posix.c b/block/file-posix.c
> index 6223a8bccc..fa918f2bdb 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -188,8 +188,16 @@ typedef struct RawPosixAIOData {
>  #define aio_ioctl_cmd   aio_nbytes /* for QEMU_AIO_IOCTL */
>      off_t aio_offset;
>      int aio_type;
> -    int aio_fd2;
> -    off_t aio_offset2;
> +    union {
> +        struct {
> +            int aio_fd2;
> +            off_t aio_offset2;
> +        };
> +        struct {
> +            PreallocMode prealloc;
> +            Error **errp;
> +        };
> +    };

Comments might help (that the first struct is for *_COPY_RANGE and the
second one is for *_TRUNCATE).

But in general (without having actual knowledge of file-posix's AIO pool)=
:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>  } RawPosixAIOData;
> =20
>  #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)


--nbdvQiSi4AOm7koq9xNy2wTGR14EJtt43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsw+zEACgkQ9AfbAGHV
z0Cr9QgArATJ3cC5ViyOOjrHJ4Ee5drZ3vND1h7pZ39PwXLs/z5tCRh4iNaJCMlO
r6aepAvKCKBfMCxNAn1aNepPTs4+qabSCfqWJWr2CZamwOoc/khsyP2Ko5lbbrAD
njik1zoPBdLC8kn73wqc+eTCdLJDEe4YaTI0YsTBj2mDZyya8yLERJLxt1uOtdy9
GAVNKMgteM2bmpq7tbQK0iGfbunPrrARbGcEdZ6gT7Fvs8ib1togqQN6hrnN7dSj
k8T0rdlWqm4BFCxjHgxwxUIJRS3T63xJfecG2Azn7S34QVkgUTvhEEri6XXvqGVO
6yuIHn6ZG8UuAsNzEC2hMnHQbe2WoQ==
=OHhR
-----END PGP SIGNATURE-----

--nbdvQiSi4AOm7koq9xNy2wTGR14EJtt43--
