Received: from eggs.gnu.org ([2001:4830:134:3::10]:38725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciVjy-0002wW-Ui
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciVju-00045Q-2j
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:34:06 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:41811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciVjt-00045F-SV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:34:02 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 09144AF0AC
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 01:34:00 +0100 (CET)
Date: Tue, 28 Feb 2017 01:33:55 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170228013355.17b38fd5@bahia.lan>
In-Reply-To: <0bbb5051-c3ad-bdbc-fb20-38f16de840da@redhat.com>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
	<1488236421-30983-8-git-send-email-groug@kaod.org>
	<0bbb5051-c3ad-bdbc-fb20-38f16de840da@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/SOjUWY1i9fwvg3xOk3/+dck";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 07/31] 9pfs: introduce
 relative_openat_nofollow() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Aneesh
	Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/SOjUWY1i9fwvg3xOk3/+dck
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 17:37:56 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/27/2017 04:59 PM, Greg Kurz wrote:
> > When using the passthrough security mode, symbolic links created by the
> > guest are actual symbolic links on the host file system.
> >  =20
>=20
> Hmm, I just barely started reviewing the series, and see a pull request.
> At this point, anything I point out can probably be done as followup
> patches rather than forcing a respin of the pull (and soft freeze is
> appropriate for that).
>=20

Yes but I now realize I have another nit... Patch 2/31 should have

From: Pradeep <pradeepkiruvale@gmail.com>

but for unknown reasons, it got dropped at some point, and cannot be
fixed in a followup patch.

For simplicity, I guess I'd rather fix all the issues and respin a new
pull tomorrow.

> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > (renamed openat_nofollow() to relative_openat_nofollow(),
> >  assert path is relative, Greg Kurz)
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > --- =20
>=20
> > +int relative_openat_nofollow(int dirfd, const char *path, int flags,
> > +                             mode_t mode)
> > +{
> > +    int fd;
> > +
> > +    assert(path[0] !=3D '/'); =20
>=20
> If you move this assert...
>=20
> > +
> > +    fd =3D dup(dirfd);
> > +    if (fd =3D=3D -1) {
> > +        return -1;
> > +    }
> > +
> > +    while (*path) {
> > +        const char *c;
> > +        int next_fd;
> > +        char *head; =20
>=20
> ...here, you can make sure there are no 'a//b' issues to worry about.
>=20
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
> > +        path =3D c + 1; =20
>=20
> or else add an assert here.
>=20
>=20
> > +static inline int openat_file(int dirfd, const char *name, int flags,
> > +                              mode_t mode)
> > +{
> > +    int fd, serrno;
> > +
> > +    fd =3D openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBL=
OCK,
> > +                mode);
> > +    if (fd =3D=3D -1) {
> > +        return -1;
> > +    }
> > +
> > +    serrno =3D errno;
> > +    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
> > +    assert(!fcntl(fd, F_SETFL, flags)); =20
>=20
> Ewww. Side effect inside an assert().  :(
>=20

--Sig_/SOjUWY1i9fwvg3xOk3/+dck
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0xXMACgkQAvw66wEB28KTKQCfWPiUs92NSS+AebYuYPgnYjSj
DB4An3hqtcPUJzVkPdto2sUS2c5ZQnVt
=AVJB
-----END PGP SIGNATURE-----

--Sig_/SOjUWY1i9fwvg3xOk3/+dck--
