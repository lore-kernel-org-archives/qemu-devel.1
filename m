Received: from eggs.gnu.org ([2001:4830:134:3::10]:47915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMst8-0008Oh-HJ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMst4-0007fv-Bf
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:22:26 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:48830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dMst4-0007ea-0t
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:22:22 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id BB7524D64F
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:22:18 +0200 (CEST)
Date: Mon, 19 Jun 2017 11:22:14 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170619112214.1136446e@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170618161727.18404-2-tobleminer@gmail.com>
References: <20170618161727.18404-1-tobleminer@gmail.com>
	<20170618161727.18404-2-tobleminer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/=bWTddS.OgIaGcBwwolH/ej";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 1/1] Add support for custom
 fmasks/dmasks in 9ps mapped mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tobias Schramm <tobleminer@gmail.com>
Cc: qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, el13635@mail.ntua.gr

--Sig_/=bWTddS.OgIaGcBwwolH/ej
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Jun 2017 18:17:27 +0200
Tobias Schramm <tobleminer@gmail.com> wrote:

Hi,

The patch titles are usually prefixed by the component name. Something like:

9pfs: local: add support for custom fmask/dmask in mapped security modes

Also, it is always nice to write a changelog, even if the feature looks sim=
ple.
At least, explain why we need that.

> Signed-off-by: Tobias Schramm <tobleminer@gmail.com>
> ---
>  v3: Use unsigned types for umask
>  v2: Adjust patch to QEMU code style
>=20
>  fsdev/file-op-9p.h      |  4 ++++
>  fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
>  hw/9pfs/9p-local.c      | 29 +++++++++++++++++++++++++----
>  hw/9pfs/9p.c            |  3 +++

This patch changes the command line. Please update the documentation
accordingly (qemu-options.hx).

>  4 files changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 0844a403dc..0ecb1d392b 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -76,6 +76,8 @@ typedef struct FsDriverEntry {
>      int export_flags;
>      FileOperations *ops;
>      FsThrottle fst;
> +    mode_t fmask;
> +    mode_t dmask;
>  } FsDriverEntry;
> =20
>  typedef struct FsContext
> @@ -88,6 +90,8 @@ typedef struct FsContext
>      FsThrottle *fst;
>      /* fs driver specific data */
>      void *private;
> +    mode_t fmask;
> +    mode_t dmask;
>  } FsContext;
> =20
>  typedef struct V9fsPath {
> diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> index bf5713008a..dd6391edb0 100644
> --- a/fsdev/qemu-fsdev-opts.c
> +++ b/fsdev/qemu-fsdev-opts.c
> @@ -38,6 +38,12 @@ static QemuOptsList qemu_fsdev_opts =3D {
>          }, {
>              .name =3D "sock_fd",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "fmask",
> +            .type =3D QEMU_OPT_STRING,

Why not using QEMU_OPT_NUMBER ?

> +        }, {
> +            .name =3D "dmask",
> +            .type =3D QEMU_OPT_STRING,
>          },
> =20
>          THROTTLE_OPTS,
> @@ -75,6 +81,12 @@ static QemuOptsList qemu_virtfs_opts =3D {
>          }, {
>              .name =3D "sock_fd",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "fmask",
> +            .type =3D QEMU_OPT_STRING,
> +        }, {
> +            .name =3D "dmask",
> +            .type =3D QEMU_OPT_STRING,
>          },
> =20
>          { /*End of list */ }
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 1e78b7c9e9..ef7282e294 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -633,7 +633,7 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *d=
ir_path,
> =20
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
>          fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> -        err =3D mknodat(dirfd, name, SM_LOCAL_MODE_BITS | S_IFREG, 0);
> +        err =3D mknodat(dirfd, name, fs_ctx->fmask | S_IFREG, 0);
>          if (err =3D=3D -1) {
>              goto out;
>          }
> @@ -685,7 +685,7 @@ static int local_mkdir(FsContext *fs_ctx, V9fsPath *d=
ir_path,
> =20
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
>          fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> -        err =3D mkdirat(dirfd, name, SM_LOCAL_DIR_MODE_BITS);
> +        err =3D mkdirat(dirfd, name, fs_ctx->dmask);
>          if (err =3D=3D -1) {
>              goto out;
>          }
> @@ -786,7 +786,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *d=
ir_path, const char *name,
>      /* Determine the security model */
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
>          fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> -        fd =3D openat_file(dirfd, name, flags, SM_LOCAL_MODE_BITS);
> +        fd =3D openat_file(dirfd, name, flags, fs_ctx->fmask);
>          if (fd =3D=3D -1) {
>              goto out;
>          }
> @@ -849,7 +849,7 @@ static int local_symlink(FsContext *fs_ctx, const cha=
r *oldpath,
>          ssize_t oldpath_size, write_size;
> =20
>          fd =3D openat_file(dirfd, name, O_CREAT | O_EXCL | O_RDWR,
> -                         SM_LOCAL_MODE_BITS);
> +                         fs_ctx->fmask);
>          if (fd =3D=3D -1) {
>              goto out;
>          }
> @@ -1431,6 +1431,9 @@ static int local_parse_opts(QemuOpts *opts, struct =
FsDriverEntry *fse)
>  {
>      const char *sec_model =3D qemu_opt_get(opts, "security_model");
>      const char *path =3D qemu_opt_get(opts, "path");
> +    const char *fmask =3D qemu_opt_get(opts, "fmask");
> +    const char *dmask =3D qemu_opt_get(opts, "dmask");
> +    unsigned long mask;
>      Error *err =3D NULL;
> =20
>      if (!sec_model) {
> @@ -1469,6 +1472,24 @@ static int local_parse_opts(QemuOpts *opts, struct=
 FsDriverEntry *fse)
> =20
>      fse->path =3D g_strdup(path);
> =20
> +    fse->fmask =3D SM_LOCAL_MODE_BITS;
> +    if (fmask) {
> +        if (qemu_strtoul(fmask, NULL, 0, &mask)) {
> +            error_report("Invalid fmask %s specified", fmask);
> +            return -1;

If the user passes an invalid fmask, then fse->path is leaked.

Sanity checks should happen before, or you have to free allocated resources.

In the present case, I guess the g_strdup() line should be the last thing t=
his
function does.

> +        }
> +        fse->fmask =3D ((mode_t)mask) & 0777;
> +    }
> +
> +    fse->dmask =3D SM_LOCAL_DIR_MODE_BITS;
> +    if (dmask) {
> +        if (qemu_strtoul(dmask, NULL, 0, &mask)) {
> +            error_report("Invalid dmask %s specified", dmask);
> +            return -1;
> +        }
> +        fse->dmask =3D ((mode_t)mask) & 0777;
> +    }
> +

All of this is for mapped modes only. It should fail and print an error when
used with other modes.

>      return 0;
>  }
> =20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 96d2683348..40290dbade 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3533,6 +3533,9 @@ int v9fs_device_realize_common(V9fsState *s, Error =
**errp)
> =20
>      s->ops =3D fse->ops;
> =20
> +    s->ctx.fmask =3D fse->fmask;
> +    s->ctx.dmask =3D fse->dmask;
> +
>      s->fid_list =3D NULL;
>      qemu_co_rwlock_init(&s->rename_lock);
> =20


--Sig_/=bWTddS.OgIaGcBwwolH/ej
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllHl8YACgkQAvw66wEB28IwTACeN8N8hmHVH50+RLO2PZTuz+Vl
/24AoKg0jsdW/kC33OUwNpNsp3fSMJw5
=WI64
-----END PGP SIGNATURE-----

--Sig_/=bWTddS.OgIaGcBwwolH/ej--
