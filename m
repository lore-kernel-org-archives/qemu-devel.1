Received: from eggs.gnu.org ([2001:4830:134:3::10]:38539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciViY-0001rc-QC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciViT-0003fp-Ux
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:32:38 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:49491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciViT-0003fh-OF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:32:33 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 21B36B2865
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 01:32:32 +0100 (CET)
Date: Tue, 28 Feb 2017 01:32:24 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170228013224.5d8fe797@bahia.lan>
In-Reply-To: <851bab51-f448-e21a-32df-c2b2e3b8dd8d@redhat.com>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814892313.28146.906456388544163572.stgit@bahia>
	<851bab51-f448-e21a-32df-c2b2e3b8dd8d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/wL4gHVHyiOUfmY+1JD=HR/L";
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/wL4gHVHyiOUfmY+1JD=HR/L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 17:28:33 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/26/2017 04:42 PM, Greg Kurz wrote:
> > When using the passthrough security mode, symbolic links created by the
> > guest are actual symbolic links on the host file system.
> >  =20
>=20
> >=20
> > diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> > new file mode 100644
> > index 000000000000..62fd7a76212a
> > --- /dev/null =20
>=20
> > +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mod=
e)
> > +{
> > +    int fd;
> > +
> > +    fd =3D dup(dirfd);
> > +    if (fd =3D=3D -1) {
> > +        return -1;
> > +    }
> > + =20
>=20
> Do you want to assert that the caller's path does not start with '/'?

Yes, I've added this for the pull request.

> This function ignores dirfd in that case, which may not be what you want.
>=20

Indeed, it really needs the path to be relative.

> > +    while (*path) {
> > +        const char *c;
> > +        int next_fd;
> > +        char *head;
> > +
> > +        head =3D g_strdup(path);
> > +        c =3D strchr(path, '/'); =20
>=20
> So if the caller passes path=3D"a//b", then the first iteration sets
> head=3D"a", but the second iteration sets head=3D"".
>=20

This doesn't happen with the current code, but you're right, we should
assert here also. We only wany a/b/c/d

>=20
> > +        if (c) {
> > +            head[c - path] =3D 0;
> > +            next_fd =3D openat_dir(fd, head); =20
>=20
> The second iteration will then fail (openat_dir on "" should fail with
> ENOENT, right?).  Oops.
>=20
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
> I think the fix is that you should skip past all consecutive '/' here,
> rather than assuming there is just one.  Or can you assert that all
> callers are well-behaved, and that *path is not '/' at this point?
>=20

Again you're right :-\

> > +    } =20
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
> Ouch - side effect inside an assertion.  We don't support use of NDEBUG,
> but this is poor practice.
>=20

And I now remember you already made a similar comment in the past... I hope
I will remember this time.

Thanks!

--Sig_/wL4gHVHyiOUfmY+1JD=HR/L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0xRkACgkQAvw66wEB28LdAQCeL9fIIKZkm/nzkoiYqmfeqvDy
Df4AnR0g2he3yxV3Xwfvef1aBOMvAN09
=L7qH
-----END PGP SIGNATURE-----

--Sig_/wL4gHVHyiOUfmY+1JD=HR/L--
