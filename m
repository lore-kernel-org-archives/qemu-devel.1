Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciKjk-0007Ip-Sm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciKjh-0001Or-K3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:49:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciKjh-0001Ol-C4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:49:05 -0500
Received: by mail-wm0-x241.google.com with SMTP id v77so13283569wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 04:49:05 -0800 (PST)
Date: Mon, 27 Feb 2017 12:49:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227124901.GH28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814893846.28146.10539730675852394601.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <148814893846.28146.10539730675852394601.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 06/28] 9pfs: local: open/opendir: don't
 follow symlinks
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


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:42:18PM +0100, Greg Kurz wrote:
> @@ -48,6 +49,24 @@ typedef struct {
>      int mountfd;
>  } LocalData;
> =20
> +int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
> +                        mode_t mode)
> +{
> +    LocalData *data =3D fs_ctx->private;
> +
> +    /* All paths are relative to the path data->mountfd points to */
> +    while (*path =3D=3D '/') {
> +        path++;
> +    }
> +
> +    return openat_nofollow(data->mountfd, path, flags, mode);

What about all the other openat_nofollow() users?  They don't explicitly
strip leading slashes.  Perhaps this should be part of a renamed
relative_openat_nofollow() function.

> +}
> +
> +int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
> +{
> +    return local_open_nofollow(fs_ctx, path, O_DIRECTORY | O_RDONLY, 0);

Why not strip slashes here?

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCA9AAoJEJykq7OBq3PIDbEH/ApuJrKUcV0xPFNw82c+fHfX
OD8s18OIBY3UA/YDpJgVuBFCxFw6onlns6bi3ple0ZIAdl5azB8SSpix5wDCVIAC
jF8gMzx19sDNPSR1AC7IybLA8mYpX8SzCV3cm1Dlue6AOfLjQAJDZ2HkYAhBVQr5
D4OKQQpuffbtxP/Qk0mHm0kuTbJU3dW/5uku9/4qaFFdZEWglUtqADeiw9aZJaYr
agXw0prVUkFQmC9hW54SJU6sv+pvLFAOjc4hFReVFeiNBICRixcR7h+S5ZjEXAfG
9Uo2gfbO0sMbPzW5/Zyb+uEn5A23asDvcSqoFOpe7GVK/Emqmia3w2hF9+80Qis=
=wATj
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--
