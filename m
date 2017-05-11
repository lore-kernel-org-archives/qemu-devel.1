Received: from eggs.gnu.org ([2001:4830:134:3::10]:56089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8ug1-0003xl-IJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8ufx-0004j5-KN
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:27:09 -0400
Date: Thu, 11 May 2017 16:27:02 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511202702.GM24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-11-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-11-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 10/16] mirror: Do initial
 aio context move of target via BB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:50PM +0800, Fam Zheng wrote:
> diff --git a/blockdev.c b/blockdev.c
> index dfd1385..53f9874 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3556,8 +3556,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
>          goto out;
>      }
> =20
> -    bdrv_set_aio_context(target_bs, aio_context);
> -
>      blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, tar=
get_bs,
>                             arg->has_replaces, arg->replaces, arg->sync,
>                             backing_mode, arg->has_speed, arg->speed,
> @@ -3608,8 +3606,6 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
>      aio_context =3D bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);
> =20
> -    bdrv_set_aio_context(target_bs, aio_context);
> -
>      blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
>                             has_replaces, replaces, sync, backing_mode,
>                             has_speed, speed,

This patch post-pones bdrv_set_aio_context() until later on.  We now
call bdrv_get_info() without holding target_bs's AioContext in
mirror_start_job().

Please acquire the AioContext around target_bs accesses until we move it
to our AioContext.

Stefan

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMkWAAoJEJykq7OBq3PISRwIAJNGbwAiixrGwHtaVDwoul4k
ZgqwpQL1PjiNG0J1I/gGcjRiBLYQYLOfbdBaPBnv1wbh2fCAzS/AKW6814GBCO3O
PrSdyElzBR8+1mp+40kO3QVfJLO+j9auc9UgLOBvj6ywK+Sysn+eBgIj7/cWX468
izcZJ1+vandcNTffZhRe8qFJRubuQbQ37x6vd3OAjIgtocJCeQ0/NaIfG0Bgbkgf
NxSckiFXKrIrjAO+QG9Cbkm5hf9yOUt0h8xK64FbJqQOeA8M7kaqvxWymrp7+Vpl
ZUjSH0/l11iwQQrXiJ1iWaSAkMZegtacAtN7kXcQZ/WyvdbD+hEZMRXvLgEfvGY=
=1k5x
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--
