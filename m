Received: from eggs.gnu.org ([2001:4830:134:3::10]:58196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chNsd-0007tQ-5c
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chNsa-00058w-3b
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:58:23 -0500
Received: from mo6.mail-out.ovh.net ([178.32.228.6]:33177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1chNsZ-00057j-Sz
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:58:20 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6AFB1B14EF
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 22:58:17 +0100 (CET)
Date: Fri, 24 Feb 2017 22:58:11 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170224225811.79f3f3c9@bahia.lan>
In-Reply-To: <148760164565.31154.18106542980362196249.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760164565.31154.18106542980362196249.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/gKMkYw_gZ3sGQNTO9614PUi";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 11/29] 9pfs: local: lremovexattr: don't
 follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/gKMkYw_gZ3sGQNTO9614PUi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Feb 2017 15:40:45 +0100
Greg Kurz <groug@kaod.org> wrote:

> The local_lremovexattr() callback is vulnerable to symlink attacks because
> it calls lremovexattr() which follows symbolic links in all path elements=
 but
> the rightmost one.
>=20
> This patch converts local_lremovexattr() to rely on opendir_nofollow() and
> fremovexattrat_nofollow() instead.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-posix-acl.c  |   10 ++--------
>  hw/9pfs/9p-xattr-user.c |    8 +-------
>  hw/9pfs/9p-xattr.c      |    8 +-------
>  3 files changed, 4 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-posix-acl.c b/hw/9pfs/9p-posix-acl.c
> index 0154e2a7605f..c20409104135 100644
> --- a/hw/9pfs/9p-posix-acl.c
> +++ b/hw/9pfs/9p-posix-acl.c
> @@ -58,10 +58,8 @@ static int mp_pacl_removexattr(FsContext *ctx,
>                                 const char *path, const char *name)
>  {
>      int ret;
> -    char *buffer;
> =20
> -    buffer =3D rpath(ctx, path);
> -    ret  =3D lremovexattr(buffer, MAP_ACL_ACCESS);
> +    ret =3D local_removexattr_nofollow(ctx, MAP_ACL_ACCESS, name);

While reworking on a new implementation fremovexattrat(), I realized the
above should be:

    ret =3D local_removexattr_nofollow(ctx, path, MAP_ACL_ACCESS);

>      if (ret =3D=3D -1 && errno =3D=3D ENODATA) {
>          /*
>           * We don't get ENODATA error when trying to remove a
> @@ -71,7 +69,6 @@ static int mp_pacl_removexattr(FsContext *ctx,
>          errno =3D 0;
>          ret =3D 0;
>      }
> -    g_free(buffer);
>      return ret;
>  }
> =20
> @@ -111,10 +108,8 @@ static int mp_dacl_removexattr(FsContext *ctx,
>                                 const char *path, const char *name)
>  {
>      int ret;
> -    char *buffer;
> =20
> -    buffer =3D rpath(ctx, path);
> -    ret  =3D lremovexattr(buffer, MAP_ACL_DEFAULT);
> +    ret =3D local_removexattr_nofollow(ctx, MAP_ACL_DEFAULT, name);

Same error here.

>      if (ret =3D=3D -1 && errno =3D=3D ENODATA) {
>          /*
>           * We don't get ENODATA error when trying to remove a
> @@ -124,7 +119,6 @@ static int mp_dacl_removexattr(FsContext *ctx,
>          errno =3D 0;
>          ret =3D 0;
>      }
> -    g_free(buffer);
>      return ret;
>  }
> =20
> diff --git a/hw/9pfs/9p-xattr-user.c b/hw/9pfs/9p-xattr-user.c
> index 1840a5db66f3..2c90817b75a6 100644
> --- a/hw/9pfs/9p-xattr-user.c
> +++ b/hw/9pfs/9p-xattr-user.c
> @@ -81,9 +81,6 @@ static int mp_user_setxattr(FsContext *ctx, const char =
*path, const char *name,
>  static int mp_user_removexattr(FsContext *ctx,
>                                 const char *path, const char *name)
>  {
> -    char *buffer;
> -    int ret;
> -
>      if (strncmp(name, "user.virtfs.", 12) =3D=3D 0) {
>          /*
>           * Don't allow fetch of user.virtfs namesapce
> @@ -92,10 +89,7 @@ static int mp_user_removexattr(FsContext *ctx,
>          errno =3D EACCES;
>          return -1;
>      }
> -    buffer =3D rpath(ctx, path);
> -    ret =3D lremovexattr(buffer, name);
> -    g_free(buffer);
> -    return ret;
> +    return local_removexattr_nofollow(ctx, path, name);
>  }
> =20
>  XattrOperations mapped_user_xattr =3D {
> diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
> index 72ef820f16d7..6fbfbca7e9a0 100644
> --- a/hw/9pfs/9p-xattr.c
> +++ b/hw/9pfs/9p-xattr.c
> @@ -333,13 +333,7 @@ int pt_setxattr(FsContext *ctx, const char *path, co=
nst char *name, void *value,
> =20
>  int pt_removexattr(FsContext *ctx, const char *path, const char *name)
>  {
> -    char *buffer;
> -    int ret;
> -
> -    buffer =3D rpath(ctx, path);
> -    ret =3D lremovexattr(path, name);
> -    g_free(buffer);
> -    return ret;
> +    return local_removexattr_nofollow(ctx, path, name);
>  }
> =20
>  ssize_t notsup_getxattr(FsContext *ctx, const char *path, const char *na=
me,
>=20


--Sig_/gKMkYw_gZ3sGQNTO9614PUi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliwrHMACgkQAvw66wEB28I4cACfZ5xQUKH1Gc9QJ5lzUo1QGNto
uZYAninS9oc+eGfbGR1cq8274760WGec
=DjDL
-----END PGP SIGNATURE-----

--Sig_/gKMkYw_gZ3sGQNTO9614PUi--
