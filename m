Received: from eggs.gnu.org ([2001:4830:134:3::10]:35692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chDCZ-0004KZ-D6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chDCW-0003gF-9C
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:34:15 -0500
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:39515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1chDCV-0003fn-W6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:34:12 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 21519ABA19
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:34:10 +0100 (CET)
Date: Fri, 24 Feb 2017 11:34:02 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170224113402.07a0fb44@bahia.lan>
In-Reply-To: <20170223151042.GW30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760173919.31154.7555675803159581620.stgit@bahia.lan>
	<20170223151042.GW30636@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/o16SVlsOnrK1ejNhe76404g";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 23/29] 9pfs: local: chmod: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

--Sig_/o16SVlsOnrK1ejNhe76404g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2017 15:10:42 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, Feb 20, 2017 at 03:42:19PM +0100, Greg Kurz wrote:
> > The local_chmod() callback is vulnerable to symlink attacks because it
> > calls:
> >=20
> > (1) chmod() which follows symbolic links for all path elements
> > (2) local_set_xattr()->setxattr() which follows symbolic links for all
> >     path elements
> > (3) local_set_mapped_file_attr() which calls in turn local_fopen() and
> >     mkdir(), both functions following symbolic links for all path
> >     elements but the rightmost one
> >=20
> > This patch converts local_chmod() to rely on open_nofollow() and
> > fchmod() to fix (1).
> >=20
> > It introduces a local_set_xattrat() replacement to local_set_xattr()
> > based on fsetxattrat() to fix (2), and a local_set_mapped_file_attrat()
> > replacement to local_set_mapped_file_attr() based on local_fopenat()
> > and mkdirat() to fix (3). No effort is made to factor out code because
> > both local_set_xattr() and local_set_mapped_file_attr() will be dropped
> > when all users have been converted to use the "at" versions.
> >=20
> > This partly fixes CVE-2016-9602.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-local.c |  163 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
> >  1 file changed, 150 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index fb536fdb3082..56d7731f7ce1 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -327,6 +327,87 @@ err_out:
> >      return ret;
> >  }
> > =20
> > +static int local_set_mapped_file_attrat(int dirfd, const char *name,
> > +                                        FsCred *credp)
> > +{
> > +    FILE *fp;
> > +    int ret;
> > +    char buf[ATTR_MAX];
> > +    int uid =3D -1, gid =3D -1, mode =3D -1, rdev =3D -1;
> > +    int map_dirfd;
> > +
> > +    ret =3D mkdirat(dirfd, VIRTFS_META_DIR, 0700);
> > +    if (ret < 0 && errno !=3D EEXIST) {
> > +        return -1;
> > +    }
> > +
> > +    map_dirfd =3D openat(dirfd, VIRTFS_META_DIR,
> > +                       O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
> > +    if (map_dirfd =3D=3D -1) {
> > +        return -1;
> > +    }
> > +
> > +    fp =3D local_fopenat(map_dirfd, name, "r");
> > +    if (!fp) {
> > +        if (errno =3D=3D ENOENT) {
> > +            goto update_map_file;
> > +        } else {
> > +            close_preserve_errno(map_dirfd);
> > +            return -1;
> > +        }
> > +    }
> > +    memset(buf, 0, ATTR_MAX);
> > +    while (fgets(buf, ATTR_MAX, fp)) {
> > +        if (!strncmp(buf, "virtfs.uid", 10)) {
> > +            uid =3D atoi(buf + 11);
> > +        } else if (!strncmp(buf, "virtfs.gid", 10)) {
> > +            gid =3D atoi(buf + 11);
> > +        } else if (!strncmp(buf, "virtfs.mode", 11)) {
> > +            mode =3D atoi(buf + 12);
> > +        } else if (!strncmp(buf, "virtfs.rdev", 11)) {
> > +            rdev =3D atoi(buf + 12);
> > +        }
> > +        memset(buf, 0, ATTR_MAX);
> > +    }
> > +    fclose(fp);
> > +
> > +update_map_file:
> > +    fp =3D local_fopenat(map_dirfd, name, "w");
> > +    close_preserve_errno(map_dirfd);
> > +    if (!fp) {
> > +        return -1;
> > +    }
> > +
> > +    if (credp->fc_uid !=3D -1) {
> > +        uid =3D credp->fc_uid;
> > +    }
> > +    if (credp->fc_gid !=3D -1) {
> > +        gid =3D credp->fc_gid;
> > +    }
> > +    if (credp->fc_mode !=3D -1) {
> > +        mode =3D credp->fc_mode;
> > +    }
> > +    if (credp->fc_rdev !=3D -1) {
> > +        rdev =3D credp->fc_rdev;
> > +    }
> > +
> > +    if (uid !=3D -1) {
> > +        fprintf(fp, "virtfs.uid=3D%d\n", uid);
> > +    }
> > +    if (gid !=3D -1) {
> > +        fprintf(fp, "virtfs.gid=3D%d\n", gid);
> > +    }
> > +    if (mode !=3D -1) {
> > +        fprintf(fp, "virtfs.mode=3D%d\n", mode);
> > +    }
> > +    if (rdev !=3D -1) {
> > +        fprintf(fp, "virtfs.rdev=3D%d\n", rdev);
> > +    }
> > +    fclose(fp);
> > +
> > +    return 0;
> > +}
> > +
> >  static int local_set_xattr(const char *path, FsCred *credp)
> >  {
> >      int err;
> > @@ -362,6 +443,45 @@ static int local_set_xattr(const char *path, FsCre=
d *credp)
> >      return 0;
> >  }
> > =20
> > +static int local_set_xattrat(int dirfd, const char *path, FsCred *cred=
p)
> > +{
> > +    int err;
> > +
> > +    if (credp->fc_uid !=3D -1) {
> > +        uint32_t tmp_uid =3D cpu_to_le32(credp->fc_uid);
> > +        err =3D fsetxattrat_nofollow(dirfd, path, "user.virtfs.uid", &=
tmp_uid,
> > +                                   sizeof(uid_t), 0);
> > +        if (err) {
> > +            return err;
> > +        }
> > +    }
> > +    if (credp->fc_gid !=3D -1) {
> > +        uint32_t tmp_gid =3D cpu_to_le32(credp->fc_gid);
> > +        err =3D fsetxattrat_nofollow(dirfd, path, "user.virtfs.gid", &=
tmp_gid,
> > +                                   sizeof(gid_t), 0);
> > +        if (err) {
> > +            return err;
> > +        }
> > +    }
> > +    if (credp->fc_mode !=3D -1) {
> > +        uint32_t tmp_mode =3D cpu_to_le32(credp->fc_mode);
> > +        err =3D fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", =
&tmp_mode,
> > +                                   sizeof(mode_t), 0);
> > +        if (err) {
> > +            return err;
> > +        }
> > +    }
> > +    if (credp->fc_rdev !=3D -1) {
> > +        uint64_t tmp_rdev =3D cpu_to_le64(credp->fc_rdev);
> > +        err =3D fsetxattrat_nofollow(dirfd, path, "user.virtfs.rdev", =
&tmp_rdev,
> > +                                   sizeof(dev_t), 0);
> > +        if (err) {
> > +            return err;
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> >  static int local_post_create_passthrough(FsContext *fs_ctx, const char=
 *path,
> >                                           FsCred *credp)
> >  {
> > @@ -553,21 +673,38 @@ static ssize_t local_pwritev(FsContext *ctx, V9fs=
FidOpenState *fs,
> > =20
> >  static int local_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *c=
redp)
> >  {
> > -    char *buffer;
> >      int ret =3D -1;
> > -    char *path =3D fs_path->data;
> > +    int dirfd;
> > =20
> > -    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
> > -        buffer =3D rpath(fs_ctx, path);
> > -        ret =3D local_set_xattr(buffer, credp);
> > -        g_free(buffer);
> > -    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> > -        return local_set_mapped_file_attr(fs_ctx, path, credp);
> > -    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
> > -               (fs_ctx->export_flags & V9FS_SM_NONE)) {
> > -        buffer =3D rpath(fs_ctx, path);
> > -        ret =3D chmod(buffer, credp->fc_mode);
> > -        g_free(buffer);
> > +    if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
> > +        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> > +        char *dirpath, *name;
> > +
> > +        dirpath =3D g_path_get_dirname(fs_path->data);
> > +        dirfd =3D local_opendir_nofollow(fs_ctx, dirpath);
> > +        g_free(dirpath);
> > +        if (dirfd =3D=3D -1) {
> > +            return -1;
> > +        }
> > +
> > +        name =3D g_path_get_basename(fs_path->data);
> > +        if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
> > +            ret =3D local_set_xattrat(dirfd, name, credp);
> > +        } else {
> > +            ret =3D local_set_mapped_file_attrat(dirfd, name, credp);
> > +        }
> > +        g_free(name);
> > +        close_preserve_errno(dirfd);
> > +    } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
> > +               fs_ctx->export_flags & V9FS_SM_NONE) {
> > +        int fd;
> > +
> > +        fd =3D local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
> > +        if (fd =3D=3D -1) {
> > +            return -1;
> > +        }
> > +        ret =3D fchmod(fd, credp->fc_mode);
> > +        close_preserve_errno(fd); =20
>=20
> As mentioned on IRC, not sure this is workable since chmod(2) must not
> require read permission on the file.  This patch introduces failures
> when the file isn't readable.
>=20

Yeah :-\ This one is the more painful issue to address. I need a
chmod() variant that would fail on symlinks instead of following
them... and I'm kinda suffering to implement this in a race-free
manner.

Cc'ing Eric for insights.

> Stefan


--Sig_/o16SVlsOnrK1ejNhe76404g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliwDBoACgkQAvw66wEB28LK3wCgj84S3fx9S44MOM1h7v5EXGFK
IO0AniqCavVpn3kjBVcGEq8J75jzZmr6
=QhSZ
-----END PGP SIGNATURE-----

--Sig_/o16SVlsOnrK1ejNhe76404g--
