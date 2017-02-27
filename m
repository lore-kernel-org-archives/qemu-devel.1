Received: from eggs.gnu.org ([2001:4830:134:3::10]:39112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciMM8-00038n-2X
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciMM4-0008N7-3Z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:52 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:38521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciMM3-0008Mi-TY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:48 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 276B9B2F11
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:32:46 +0100 (CET)
Date: Mon, 27 Feb 2017 15:31:47 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170227153147.7875ca9c@bahia.lan>
In-Reply-To: <20170227124430.GG28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814892313.28146.906456388544163572.stgit@bahia>
	<20170227124430.GG28403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/kEw7IspRX2rZmyTnmiHex21";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 04/28] 9pfs: introduce openat_nofollow()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/kEw7IspRX2rZmyTnmiHex21
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 12:44:30 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Sun, Feb 26, 2017 at 11:42:03PM +0100, Greg Kurz wrote:
> > +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mod=
e)
> > +{
> > +    int fd;
> > +
> > +    fd =3D dup(dirfd);
> > +    if (fd =3D=3D -1) {
> > +        return -1;
> > +    }
> > +
> > +    while (*path) {
> > +        const char *c;
> > +        int next_fd;
> > +        char *head;
> > +
> > +        head =3D g_strdup(path);
> > +        c =3D strchr(path, '/');
> > +        if (c) {
> > +            head[c - path] =3D 0;
> > +            next_fd =3D openat_dir(fd, head);
> > +        } else {
> > +            next_fd =3D openat_file(fd, head, flags, mode);
> > +        }
> > +        g_free(head);
> > +        if (next_fd =3D=3D -1) {
> > +            close_preserve_errno(fd);
> > +            return -1;
> > +        }
> > +        close(fd);
> > +        fd =3D next_fd;
> > +
> > +        if (!c) {
> > +            break;
> > +        }
> > +        path =3D c + 1;
> > +    }
> > +
> > +    return fd;
> > +} =20
>=20
> If I understand the Linux openat(2) implementation correctly this
> function fails with ENOENT if:
>=20
> 1. An absolute path is given
> 2. A path contains consecutive slashes ("a///b")
>=20
> Both of these behaviors are problematic.  If the function doesn't
> support absolute paths it should be called relative_openat_nofollow()
> and have an error if path[0] =3D=3D '/'.
>=20

I agree with the name change since we don't want this function to deal
with absolute names, per-design. It shouldn't even return an error but
rather assert (see below for more details).

> I believe guests can pass in paths with consecutive slashes, so the
> function must cope with them.

Actually no. The 9P protocol implements paths as an array of path
elements, and the frontend prohibits '/' characters in individual
path elements (look for name_is_illegal in hw/9pfs/9p.c).

We cannot have consecutive '/' characters in the intermediate part or at
the end of the path.  But we do have '//' at the beginning.

This lies lies in the way the frontend internally forges paths to access
files.

A typical path is in the form:

${root}/${elem1}/${elem2}/${elem3}/ ... etc... /${elemN}

where ${root} is set to '/' when the client mounts the 9pfs share (see
v9fs_attach() in hw/9pfs/9p.c). Since all paths are supposed to be
relative to the path of shared directory on the host, I believe ${root}
should rather be '.' than '/'. Unfortunately, this contradicts this
snippet of code in the handle backend code (hw/9pfs/9p-handle.c):

static int handle_name_to_path(FsContext *ctx, V9fsPath *dir_path,
                              const char *name, V9fsPath *target)
{
[...]
    /* "." and ".." are not allowed */
    if (!strcmp(name, ".") || !strcmp(name, "..")) {
        errno =3D EINVAL;
        return -1;

    }

I should probably dig some more to see why it is coded that way. But since
I couldn't reproduce the vulnerability with the handle backend and this ser=
ies
is already huge, I've opted to keep the hardcoded '/' in v9fs_attach().

The consequence is that I have to strip these leading '/' when calling open=
at().

But then the code can safely assume that paths don't have consecutive '/'.

--Sig_/kEw7IspRX2rZmyTnmiHex21
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0OFMACgkQAvw66wEB28JNogCfQXfXx8i1Ma0oNX9Xh9K72cUN
U5UAnRcp+D3+UpPvZk6d0GYpmBkyQkt2
=PT9n
-----END PGP SIGNATURE-----

--Sig_/kEw7IspRX2rZmyTnmiHex21--
