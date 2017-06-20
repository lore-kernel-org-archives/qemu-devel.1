Received: from eggs.gnu.org ([2001:4830:134:3::10]:60023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNL1p-0002NE-Pt
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNL1l-0000m9-Od
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:25:17 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:56213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNL1l-0000kx-E3
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:25:13 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5647A5EE8A
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 17:25:11 +0200 (CEST)
Date: Tue, 20 Jun 2017 17:25:06 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620172506.3291a8ce@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170619233718.24959-2-tobleminer@gmail.com>
References: <20170619233718.24959-1-tobleminer@gmail.com>
	<20170619233718.24959-2-tobleminer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/azoOdqSXzH3H49rrVkk5cwK";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 1/1] 9pfs: local: Add support for custom
 fmode/dmode in 9ps mapped security modes
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

--Sig_/azoOdqSXzH3H49rrVkk5cwK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 01:37:18 +0200
Tobias Schramm <tobleminer@gmail.com> wrote:

> In mapped security modes, files are created with very restrictive
> permissions (600 for files and 700 for directories). This makes
> file sharing between virtual machines and users on the host rather
> complicated. Imagine eg. a group of users that need to access data
> produced by processes on a virtual machine. Giving those users access
> to the data will be difficult since the group access mode is always 0.
>=20
> This patch makes the default mode for both files and directories
> configurable. Existing setups that don't know about the new parameters
> keep using the current secure behavior.
>=20
> Signed-off-by: Tobias Schramm <tobleminer@gmail.com>
> ---

Thanks.

Pushed to https://github.com/gkurz/qemu/commits/9p-next


>  v5: Eliminate expandable variables, check mandatory commandline options
>      first
>  v4: Use OPT_NUMBER for file mode arguments, fix back to front naming,
>      fix resource leak and add sanity checking for fmode/dmode arguments
>  v3: Use unsigned types for umask
>  v2: Adjust patch to QEMU code style
>=20
>  fsdev/file-op-9p.h      |  4 ++++
>  fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
>  hw/9pfs/9p-local.c      | 25 +++++++++++++++++++++----
>  hw/9pfs/9p.c            |  3 +++
>  qemu-options.hx         | 20 ++++++++++++++++----
>  5 files changed, 56 insertions(+), 8 deletions(-)
>=20
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 0844a403dc..474c79d003 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -76,6 +76,8 @@ typedef struct FsDriverEntry {
>      int export_flags;
>      FileOperations *ops;
>      FsThrottle fst;
> +    mode_t fmode;
> +    mode_t dmode;
>  } FsDriverEntry;
> =20
>  typedef struct FsContext
> @@ -88,6 +90,8 @@ typedef struct FsContext
>      FsThrottle *fst;
>      /* fs driver specific data */
>      void *private;
> +    mode_t fmode;
> +    mode_t dmode;
>  } FsContext;
> =20
>  typedef struct V9fsPath {
> diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> index bf5713008a..7c31ffffaf 100644
> --- a/fsdev/qemu-fsdev-opts.c
> +++ b/fsdev/qemu-fsdev-opts.c
> @@ -38,6 +38,12 @@ static QemuOptsList qemu_fsdev_opts =3D {
>          }, {
>              .name =3D "sock_fd",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "fmode",
> +            .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "dmode",
> +            .type =3D QEMU_OPT_NUMBER,
>          },
> =20
>          THROTTLE_OPTS,
> @@ -75,6 +81,12 @@ static QemuOptsList qemu_virtfs_opts =3D {
>          }, {
>              .name =3D "sock_fd",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "fmode",
> +            .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "dmode",
> +            .type =3D QEMU_OPT_NUMBER,
>          },
> =20
>          { /*End of list */ }
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 1e78b7c9e9..f1ce03b06a 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -633,7 +633,7 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *d=
ir_path,
> =20
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
>          fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> -        err =3D mknodat(dirfd, name, SM_LOCAL_MODE_BITS | S_IFREG, 0);
> +        err =3D mknodat(dirfd, name, fs_ctx->fmode | S_IFREG, 0);
>          if (err =3D=3D -1) {
>              goto out;
>          }
> @@ -685,7 +685,7 @@ static int local_mkdir(FsContext *fs_ctx, V9fsPath *d=
ir_path,
> =20
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
>          fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> -        err =3D mkdirat(dirfd, name, SM_LOCAL_DIR_MODE_BITS);
> +        err =3D mkdirat(dirfd, name, fs_ctx->dmode);
>          if (err =3D=3D -1) {
>              goto out;
>          }
> @@ -786,7 +786,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *d=
ir_path, const char *name,
>      /* Determine the security model */
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
>          fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> -        fd =3D openat_file(dirfd, name, flags, SM_LOCAL_MODE_BITS);
> +        fd =3D openat_file(dirfd, name, flags, fs_ctx->fmode);
>          if (fd =3D=3D -1) {
>              goto out;
>          }
> @@ -849,7 +849,7 @@ static int local_symlink(FsContext *fs_ctx, const cha=
r *oldpath,
>          ssize_t oldpath_size, write_size;
> =20
>          fd =3D openat_file(dirfd, name, O_CREAT | O_EXCL | O_RDWR,
> -                         SM_LOCAL_MODE_BITS);
> +                         fs_ctx->fmode);
>          if (fd =3D=3D -1) {
>              goto out;
>          }
> @@ -1467,6 +1467,23 @@ static int local_parse_opts(QemuOpts *opts, struct=
 FsDriverEntry *fse)
>          return -1;
>      }
> =20
> +    if (fse->export_flags & V9FS_SM_MAPPED ||
> +        fse->export_flags & V9FS_SM_MAPPED_FILE) {
> +        fse->fmode =3D
> +            qemu_opt_get_number(opts, "fmode", SM_LOCAL_MODE_BITS) & 077=
7;
> +        fse->dmode =3D
> +            qemu_opt_get_number(opts, "dmode", SM_LOCAL_DIR_MODE_BITS) &=
 0777;
> +    } else {
> +        if (qemu_opt_find(opts, "fmode")) {
> +            error_report("fmode is only valid for mapped 9p modes");
> +            return -1;
> +        }
> +        if (qemu_opt_find(opts, "dmode")) {
> +            error_report("dmode is only valid for mapped 9p modes");
> +            return -1;
> +        }
> +    }
> +
>      fse->path =3D g_strdup(path);
> =20
>      return 0;
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 96d2683348..a0ae98f7ca 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3533,6 +3533,9 @@ int v9fs_device_realize_common(V9fsState *s, Error =
**errp)
> =20
>      s->ops =3D fse->ops;
> =20
> +    s->ctx.fmode =3D fse->fmode;
> +    s->ctx.dmode =3D fse->dmode;
> +
>      s->fid_list =3D NULL;
>      qemu_co_rwlock_init(&s->rename_lock);
> =20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 30c4f9850f..5999719720 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -847,7 +847,7 @@ ETEXI
> =20
>  DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
>      "-fsdev fsdriver,id=3Did[,path=3Dpath,][security_model=3D{mapped-xat=
tr|mapped-file|passthrough|none}]\n"
> -    " [,writeout=3Dimmediate][,readonly][,socket=3Dsocket|sock_fd=3Dsock=
_fd]\n"
> +    " [,writeout=3Dimmediate][,readonly][,socket=3Dsocket|sock_fd=3Dsock=
_fd][,fmode=3Dfmode][,dmode=3Ddmode]\n"
>      " [[,throttling.bps-total=3Db]|[[,throttling.bps-read=3Dr][,throttli=
ng.bps-write=3Dw]]]\n"
>      " [[,throttling.iops-total=3Di]|[[,throttling.iops-read=3Dr][,thrott=
ling.iops-write=3Dw]]]\n"
>      " [[,throttling.bps-total-max=3Dbm]|[[,throttling.bps-read-max=3Drm]=
[,throttling.bps-write-max=3Dwm]]]\n"
> @@ -857,7 +857,7 @@ DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
> =20
>  STEXI
> =20
> -@item -fsdev @var{fsdriver},id=3D@var{id},path=3D@var{path},[security_mo=
del=3D@var{security_model}][,writeout=3D@var{writeout}][,readonly][,socket=
=3D@var{socket}|sock_fd=3D@var{sock_fd}]
> +@item -fsdev @var{fsdriver},id=3D@var{id},path=3D@var{path},[security_mo=
del=3D@var{security_model}][,writeout=3D@var{writeout}][,readonly][,socket=
=3D@var{socket}|sock_fd=3D@var{sock_fd}][,fmode=3D@var{fmode}][,dmode=3D@va=
r{dmode}]
>  @findex -fsdev
>  Define a new file system device. Valid options are:
>  @table @option
> @@ -898,6 +898,12 @@ with virtfs-proxy-helper
>  Enables proxy filesystem driver to use passed socket descriptor for
>  communicating with virtfs-proxy-helper. Usually a helper like libvirt
>  will create socketpair and pass one of the fds as sock_fd
> +@item fmode=3D@var{fmode}
> +Specifies the default mode for newly created files on the host. Works on=
ly
> +with security models "mapped-xattr" and "mapped-file".
> +@item dmode=3D@var{dmode}
> +Specifies the default mode for newly created directories on the host. Wo=
rks
> +only with security models "mapped-xattr" and "mapped-file".
>  @end table
> =20
>  -fsdev option is used along with -device driver "virtio-9p-pci".
> @@ -914,12 +920,12 @@ ETEXI
> =20
>  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
>      "-virtfs local,path=3Dpath,mount_tag=3Dtag,security_model=3D[mapped-=
xattr|mapped-file|passthrough|none]\n"
> -    "        [,id=3Did][,writeout=3Dimmediate][,readonly][,socket=3Dsock=
et|sock_fd=3Dsock_fd]\n",
> +    "        [,id=3Did][,writeout=3Dimmediate][,readonly][,socket=3Dsock=
et|sock_fd=3Dsock_fd][,fmode=3Dfmode][,dmode=3Ddmode]\n",
>      QEMU_ARCH_ALL)
> =20
>  STEXI
> =20
> -@item -virtfs @var{fsdriver}[,path=3D@var{path}],mount_tag=3D@var{mount_=
tag}[,security_model=3D@var{security_model}][,writeout=3D@var{writeout}][,r=
eadonly][,socket=3D@var{socket}|sock_fd=3D@var{sock_fd}]
> +@item -virtfs @var{fsdriver}[,path=3D@var{path}],mount_tag=3D@var{mount_=
tag}[,security_model=3D@var{security_model}][,writeout=3D@var{writeout}][,r=
eadonly][,socket=3D@var{socket}|sock_fd=3D@var{sock_fd}][,fmode=3D@var{fmod=
e}][,dmode=3D@var{dmode}]
>  @findex -virtfs
> =20
>  The general form of a Virtual File system pass-through options are:
> @@ -961,6 +967,12 @@ will create socketpair and pass one of the fds as so=
ck_fd
>  @item sock_fd
>  Enables proxy filesystem driver to use passed 'sock_fd' as the socket
>  descriptor for interfacing with virtfs-proxy-helper
> +@item fmode=3D@var{fmode}
> +Specifies the default mode for newly created files on the host. Works on=
ly
> +with security models "mapped-xattr" and "mapped-file".
> +@item dmode=3D@var{dmode}
> +Specifies the default mode for newly created directories on the host. Wo=
rks
> +only with security models "mapped-xattr" and "mapped-file".
>  @end table
>  ETEXI
> =20


--Sig_/azoOdqSXzH3H49rrVkk5cwK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllJPlIACgkQAvw66wEB28KslQCfWsQ8BeNa6wScfkml22tZtJTu
sJcAmgNYE+yINcCRZ64CWeY8aNx9GCrp
=KwHw
-----END PGP SIGNATURE-----

--Sig_/azoOdqSXzH3H49rrVkk5cwK--
