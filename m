Received: from eggs.gnu.org ([2001:4830:134:3::10]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYKR-00045u-8H
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYKQ-0000vW-Ev
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:36:35 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-11-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bec0207c-4c0a-5881-b5f3-f05e0b41bc50@redhat.com>
Date: Wed, 7 Feb 2018 23:36:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-11-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="97pmrtqtEUyuM82WD6F1p5XSxqQ1epilk"
Subject: Re: [Qemu-devel] [PATCH v2 10/13] block/mirror: condense
 cancellation and relax calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--97pmrtqtEUyuM82WD6F1p5XSxqQ1epilk
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <bec0207c-4c0a-5881-b5f3-f05e0b41bc50@redhat.com>
Subject: Re: [PATCH v2 10/13] block/mirror: condense cancellation and relax
 calls
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-11-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-11-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> We can count on the relax call to check cancellation for us, so
> condense these concurrent calls.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 3c73caed5e..a0e0044de2 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -610,9 +610,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlo=
ckJob *s)
>              int bytes =3D MIN(s->bdev_length - offset,
>                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));=

> =20
> -            block_job_relax(&s->common, 0);
> -
> -            if (block_job_is_cancelled(&s->common)) {
> +            if (block_job_relax(&s->common, 0)) {
>                  s->initial_zeroing_ongoing =3D false;
>                  return 0;
>              }
> @@ -638,9 +636,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlo=
ckJob *s)
>          int bytes =3D MIN(s->bdev_length - offset,
>                          QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
> =20
> -        block_job_relax(&s->common, 0);
> -
> -        if (block_job_is_cancelled(&s->common)) {
> +        if (block_job_relax(&s->common, 0)) {
>              return 0;
>          }

=E2=80=9CSee <a href=3D"HEAD^">last patch</a>.=E2=80=9D


--97pmrtqtEUyuM82WD6F1p5XSxqQ1epilk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7f2cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Al4sH/jb01bqSupkhP5fiWsvmtJZrQmHkw6Ok
EbYDrF4YXCGjUrltXttOg+AAXYvQcYg38e7CjX8afBobTPif/jtKtFwpLFfOjjar
k+XV2IeAkwkPl67adrSbh/cVZFSpWlU/hHCTtF0oarcrYCyr6Ed0jDMZ6sSQhzVk
rk5dxZ4Gwxcc7rI5SHhqGA/VThxvE4B7P9ASIdTzgV7zi6BDeFXCbTUirgaz4t+4
f5WCIKS1QQIDGBpz99Xtfm6oROkmvQ0dWlmPBpt857rcr/djHRaPyKXjLJBg95Id
PmDDcUkLZj145w9FzYAshE3npj/PcIoz2eKkNrD9EjpynNYgebB8P54=
=4sk7
-----END PGP SIGNATURE-----

--97pmrtqtEUyuM82WD6F1p5XSxqQ1epilk--
