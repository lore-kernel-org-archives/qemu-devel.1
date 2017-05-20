Received: from eggs.gnu.org ([2001:4830:134:3::10]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBypW-0003Hu-Bm
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBypS-0002sR-E3
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:29:38 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:45472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBypS-0002sD-7B
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:29:34 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5F3143CAD9
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 09:29:31 +0200 (CEST)
Date: Sat, 20 May 2017 09:29:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170520092928.692d8815@bahia.lan>
In-Reply-To: <ea69f777-6b99-1e39-7e5b-4decde958769@redhat.com>
References: <149520423435.7495.2756710723268429379.stgit@bahia.lan>
	<ea69f777-6b99-1e39-7e5b-4decde958769@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/p7/unyrwUwGaOXJeCHsHE+p";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] fsdev: fix virtfs-proxy-helper cwd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

--Sig_/p7/unyrwUwGaOXJeCHsHE+p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 19 May 2017 17:19:10 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/19/2017 09:30 AM, Greg Kurz wrote:
> > Since chroot() doesn't change the current directory, it is indeed a good
> > practice to chdir() to the target directory and then then chroot(), or
> > to chroot() to the target directory and then chdir("/").
> >=20
> > The current code does neither of them actually. Let's go for the latter.
> >=20
> > This doesn't fix any security issue since all of this takes place before
> > the helper begins to process requests.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  fsdev/virtfs-proxy-helper.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-) =20
>=20
> You are correct that failing to sanitize the current working directory
> alongside a chroot() can lead to escaped access outside of the new
> smaller root.
>=20

The funny thing is that the author seemed to care about calling chdir("/")
at some point but it doesn't really make sense to do this before chroot().

Passing the special fd value AT_FDCWD and a relative path to an "*at()"
syscall would allow to access to the entire filesystem.

> Aside: chdir() is annoying in multi-threaded apps - it is global state,
> rather than thread-local.  A multi-threaded app should therefore either
> never change the current working directory, or else never rely on the
> current working directory.
>  But if I'm not mistaken, virtfs-proxy-helper
> is an independent helper app, not qemu proper, so the use of
> chdir/chroot is not affecting other threads.
>=20

Yes, this is correct, we're ok with this helper.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--Sig_/p7/unyrwUwGaOXJeCHsHE+p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkf8FgACgkQAvw66wEB28IQ+gCfYe2RcthwDdo3kM3Xv2QxYH7q
YakAnRIF8gO2qCj/iYHn5HNh8cxby8r6
=tius
-----END PGP SIGNATURE-----

--Sig_/p7/unyrwUwGaOXJeCHsHE+p--
