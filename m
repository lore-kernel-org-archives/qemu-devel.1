Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d48y1-0007m0-UV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d48xy-0008IH-Qc
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:42:01 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:55396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d48xy-0008Hy-Jz
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:41:58 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E0282EA714
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 18:41:56 +0200 (CEST)
Date: Fri, 28 Apr 2017 18:41:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170428184151.611e47aa@bahia>
In-Reply-To: <f9833cd8-2f64-21d5-3bfc-9d91c178b8aa@redhat.com>
References: <149336968270.4566.7770744042249761246.stgit@bahia.lan>
	<f9833cd8-2f64-21d5-3bfc-9d91c178b8aa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WWCqWLm.wwT+vlQXj+vto4b";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: local: fix unlink of alien files in
 mapped-file mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

--Sig_/WWCqWLm.wwT+vlQXj+vto4b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Apr 2017 09:45:23 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 04/28/2017 03:54 AM, Greg Kurz wrote:
> > When trying to remove a file from a directory, both created in non-mapp=
ed
> > mode, the file remains and EBADF is returned to the guest.
> >=20
> > This is a regression introduced by commit "df4938a6651b 9pfs: local:
> > unlinkat: don't follow symlinks" when fixing CVE-2016-9602. It changed =
the
> > way we unlink the metadata file from
> >=20
> >     ret =3D remove("$dir/.virtfs_metadata/$name");
> >     if (ret < 0 && errno !=3D ENOENT) {
> >          /* Error out */
> >     }
> >     /* Ignore absence of metadata */
> >=20
> > to
> >=20
> >     fd =3D openat("$dir/.virtfs_metadata")
> >     unlinkat(fd, "$name") =20
>=20
> Yep, failure to check for errors. Is this something Coverity can flag?
>=20

I guess it should if it doesn't yet.

> >=20
> > We just need to check the return of openat() and ignore ENOENT, in order
> > to restore the behaviour we had with remove().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-local.c |   18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index f3ebca4f7a56..4e9823b08e74 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -983,12 +983,20 @@ static int local_unlinkat_common(FsContext *ctx, =
int dirfd, const char *name,
> >           * .virtfs_metadata directory.
> >           */
> >          map_dirfd =3D openat_dir(dirfd, VIRTFS_META_DIR);
> > -        ret =3D unlinkat(map_dirfd, name, 0);
> > -        close_preserve_errno(map_dirfd);
> > -        if (ret < 0 && errno !=3D ENOENT) {
> > +        if (map_dirfd !=3D -1) {
> > +            ret =3D unlinkat(map_dirfd, name, 0);
> > +            close_preserve_errno(map_dirfd);
> > +            if (ret < 0 && errno !=3D ENOENT) {
> > +                /*
> > +                 * We didn't had the .virtfs_metadata file. May be fil=
e created
> > +                 * in non-mapped mode ?. Ignore ENOENT. =20
>=20
> This is code motion (in fact, the second time you've moved this
> comment), but you might as well fix the poor grammar while you are here:
>=20
> We didn't have the .virtfs_metadata file. Maybe the file was created in
> non-mapped mode? Ignore ENOENT.
>=20
> > +                 */
> > +                goto err_out;
> > +            }
> > +        } else if (errno !=3D ENOENT) {
> >              /*
> > -             * We didn't had the .virtfs_metadata file. May be file cr=
eated
> > -             * in non-mapped mode ?. Ignore ENOENT.
> > +             * We didn't had the parent .virtfs_metadata directory. Ma=
y be
> > +             * file created in non-mapped mode ?. Ignore ENOENT. =20
>=20
> And certainly fix the grammar of your new comment (no need to
> copy-and-paste the poor wording):
>=20
> We didn't have the parent .virtfs_metadata directory. Maybe the file was
> created in non-mapped mode? Ignore ENOENT.
>=20

FYI, I've dropped the existing comments and added this instead:

@@ -957,6 +957,14 @@ static int local_unlinkat_common(FsContext *ctx, int d=
irfd,
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         int map_dirfd;
=20
+        /* We need to remove the metadata as well:
+         * - the metadata directory if we're removing a directory
+         * - the metadata file in the parent's metadata directory
+         *
+         * If any of these are missing (ie, ENOENT) then we're probably
+         * trying to remove something that wasn't created in mapped-file
+         * mode. We just ignore the error.
+         */
         if (flags =3D=3D AT_REMOVEDIR) {
             int fd;
=20
I'll push it to my 9p-next tree.

> But the code fix is correct, and a comment wording change is minor
> enough that you can add my:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--Sig_/WWCqWLm.wwT+vlQXj+vto4b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkDcM8ACgkQAvw66wEB28I1dgCfdwHGhEsZgPTGEEkpm/s1d9RC
qm8AnR0mI2DnMAnZC6pz7RxO4e+XPOFv
=uiyf
-----END PGP SIGNATURE-----

--Sig_/WWCqWLm.wwT+vlQXj+vto4b--
