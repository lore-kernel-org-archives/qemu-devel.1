Received: from eggs.gnu.org ([2001:4830:134:3::10]:51142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cRFbs-0008Em-5l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cRFbo-00035u-8D
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:54:24 -0500
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:53785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cRFbo-000358-1e
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:54:20 -0500
Received: from player726.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 145413736B
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 10:54:17 +0100 (CET)
Date: Wed, 11 Jan 2017 10:54:13 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170111105413.69f5d91d@bahia.lan>
In-Reply-To: <b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/uUC44znCJpjx7cEtdCWqciF";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/7] 9pfs: restrict open to regular files
 and directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/uUC44znCJpjx7cEtdCWqciF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jan 2017 08:38:27 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 01/10/2017 08:32 AM, Greg Kurz wrote:
> > It really does not make sense for the 9P server to open anything else b=
ut
> > a regular file or a directory.
> >=20
> > Malicious code in a guest could for example create a named pipe, associ=
ate
> > it to a valid fid and pass it to the server in a RLOPEN message. This w=
ould
> > cause QEMU to hang in open(), waiting for someone to open the other end=
 of
> > the pipe.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index fa58877570f6..edd7b97270e3 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1462,7 +1462,7 @@ static void coroutine_fn v9fs_open(void *opaque)
> >              goto out;
> >          }
> >          err +=3D offset;
> > -    } else {
> > +    } else if (S_ISREG(stbuf.st_mode)) {
> >          if (s->proto_version =3D=3D V9FS_PROTO_2000L) { =20
>=20
> TOCTTOU race.  You are checking the stat() results and only then calling
> open(), rather than calling open() first and validating fstat().  That
> means the guest can STILL cause you to open() a pipe by changing the
> file type in between the stat and the open.
>=20

You're right. And of course, this TOCTTOU race also affects the
file versus directory choice: we can end up with a fid with type
P9_FID_FILE whereas the underlying fd points to a directory... not
sure how the rest of the code copes with that. :-\

Side note: support for older versions of the protocol greatly
contribute to the overall obfuscation of the code... I wonder
if we have non-V9FS_PROTO_2000L users, and how I could deprecate
the damn thing...

> I think you need to rework this patch to open() first, then validate
> (closing the fd if necessary); the open can be done with O_NONBLOCK to
> avoid hanging on a pipe.  Yes, that's more annoying, but that's life
> with TOCTTOU races.
>=20

Yeah... and even if linux doesn't implement O_NONBLOCK behaviour for files,
for completeness we should revert this with fcntl(). The fix should hence
be done at the backend level.

Good news, at least: the directory branch will eventually call
opendir()->open(O_DIRECTORY) and thus doesn't need fixing.
Also the fixing of the regular file case will also take care of
the P9_FID_FILE/directory discrepancy mentioned above.

Thanks for the advice anyway. :)

--
Greg

--Sig_/uUC44znCJpjx7cEtdCWqciF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlh2AMUACgkQAvw66wEB28Iy1gCgnT2LEBhcnwtSdsmpHAWbPRsU
G70An0rQij1AaS+NEwFTvveO+ZHMLph8
=M1Y7
-----END PGP SIGNATURE-----

--Sig_/uUC44znCJpjx7cEtdCWqciF--
