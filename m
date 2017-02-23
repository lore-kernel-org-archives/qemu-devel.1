Received: from eggs.gnu.org ([2001:4830:134:3::10]:33358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguIk-0001JH-Dj
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguIg-0005bb-FZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:23:22 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cguIg-0005bJ-7S
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:23:18 -0500
Received: by mail-wm0-x241.google.com with SMTP id r18so84696wmd.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:23:18 -0800 (PST)
Date: Thu, 23 Feb 2017 14:23:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223142315.GM30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760166051.31154.9036980312875397552.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/t6ASE28jIy1gGy9"
Content-Disposition: inline
In-Reply-To: <148760166051.31154.9036980312875397552.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 13/29] 9pfs: local: remove: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--/t6ASE28jIy1gGy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:00PM +0100, Greg Kurz wrote:
> +    dirfd =3D local_opendir_nofollow(ctx, dirpath);
> +    if (dirfd) {
> +        goto out;
>      }
> =20
> -    buffer =3D rpath(ctx, path);
> -    err =3D remove(buffer);
> -    g_free(buffer);
> +    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
> +        goto err_out;
> +    }
> +
> +    if (S_ISDIR(stbuf.st_mode)) {
> +        flags |=3D AT_REMOVEDIR;
> +    }
> +
> +    err =3D local_unlinkat_common(ctx, dirfd, name, flags);

The alternative is optimistically skip fstat but then do:

  if (err =3D=3D EISDIR) {
      err =3D local_unlinkat_common(ctx, dirfd, name, flags | AT_REMOVEDIR);
  }

It might be faster.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/t6ASE28jIy1gGy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvBTAAoJEJykq7OBq3PIORUIAKjl2XLioaPRGLSyBsrz3T0M
EY74nelYHZ+eOjuGdZ+VwKAc8KZZWN/NZmDAIQc5yayNuBpoOBEo0KAbfEYOvXJ6
GnQAu1L9xzdOJAVGN2gaA4tQBVJT/mrCgWoGV8LdzfbONJg+YD9yuJ+MW2LMv12i
nOdEP9JZ77Jj5+O8G6IS8VmBHrw8ICKfT5fShLSH9lJASv7I9OBVRisvnKLKzyml
sJtemdlBkv4Zncux0qJIGwcVFoRknpJDZ8Venf1lScTjdmlkF7cPADfS0c2ReBpA
NrGMZUJxKkplu7kR2OL4LbHtKdKp0F+pUCAENjSVSIET7oO8x1VmjJ6bF9PimKI=
=IjNU
-----END PGP SIGNATURE-----

--/t6ASE28jIy1gGy9--
