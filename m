Received: from eggs.gnu.org ([2001:4830:134:3::10]:59066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d81Co-0004rN-RF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d81Cl-0003pb-Ma
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:13:18 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:50152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d81Cl-0003oo-FV
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:13:15 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 01485EE190
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:13:03 +0200 (CEST)
Date: Tue, 9 May 2017 11:12:58 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170509111258.4c4f3de9@bahia>
In-Reply-To: <093d42d3-a4a5-94bd-3a7a-b2a2f867ae89@redhat.com>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399503288.29022.13904385823492355197.stgit@bahia.lan>
	<093d42d3-a4a5-94bd-3a7a-b2a2f867ae89@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/M_f8ZNEpesn_D3a7Pap+CZ9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/5] 9pfs: local: resolve special
 directories in paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TMOpbw==?= Gaspard <leo@gaspard.io>

--Sig_/M_f8ZNEpesn_D3a7Pap+CZ9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 5 May 2017 11:59:15 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/05/2017 09:37 AM, Greg Kurz wrote:
> > When using the mapped-file security mode, the creds of a path /foo/bar
> > are stored in the /foo/.virtfs_metadata/bar file. This is okay for all
> > paths unless they end with '.' or '..', because we cannot create the
> > corresponding file in the metadata directory.
> >=20
> > This patch ensures that '.' and '..' are resolved in all paths.
> >=20
> > The core code only passes path elements (no '/') to the backend, with
> > the notable exception of the '/' path, which refers to the virtfs root.
> > This patch preserve the current behavior of converting it to '.' so =20
>=20
> s/preserve/preserves/
>=20

I'll fix this.

> > that it can be passed to "*at()" syscalls ('/' would mean the host root=
).
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-local.c |   30 +++++++++++++++++++++++-------
> >  1 file changed, 23 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index f3ebca4f7a56..92262f3c3e37 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -1097,14 +1097,30 @@ static int local_name_to_path(FsContext *ctx, V=
9fsPath *dir_path,
> >                                const char *name, V9fsPath *target)
> >  {
> >      if (dir_path) {
> > -        v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
> > -    } else if (strcmp(name, "/")) {
> > -        v9fs_path_sprintf(target, "%s", name);
> > +        if (!strcmp(name, ".")) {
> > +            /* "." relative to "foo/bar" is "foo/bar" */
> > +            v9fs_path_copy(target, dir_path);
> > +        } else if (!strcmp(name, "..")) {
> > +            if (!strcmp(dir_path->data, ".")) {
> > +                /* ".." relative to the root is "." */
> > +                v9fs_path_sprintf(target, ".");
> > +            } else {
> > +                char *tmp =3D g_path_get_dirname(dir_path->data);
> > +                /* ".." relative to "foo/bar" is equivalent to "foo" *=
/ =20
>=20
> True only if bar is not a symlink to some other directory.  What
> guarantees do you have that you are not going to be inadvertently
> skipping a traversal through symlinks and thereby picking the wrong
> location for '..'?
>=20

My understanding is that symlinks are supposed to be resolved by the client,
and we shouldn't follow them in the server.

> > +                v9fs_path_sprintf(target, "%s", tmp);
> > +                g_free(tmp);
> > +            }
> > +        } else {
> > +            assert(!strchr(name, '/'));
> > +            v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
> > +        }
> > +    } else if (!strcmp(name, "/") || !strcmp(name, ".") ||
> > +               !strcmp(name, "..")) {
> > +            /* This is the root fid */
> > +        v9fs_path_sprintf(target, ".");
> >      } else {
> > -        /* We want the path of the export root to be relative, otherwi=
se
> > -         * "*at()" syscalls would treat it as "/" in the host.
> > -         */
> > -        v9fs_path_sprintf(target, "%s", ".");
> > +        assert(!strchr(name, '/'));
> > +        v9fs_path_sprintf(target, "./%s", name);
> >      }
> >      return 0;
> >  }
> >=20
> >  =20
>=20


--Sig_/M_f8ZNEpesn_D3a7Pap+CZ9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkRiBoACgkQAvw66wEB28KMgACfQOEIOHyeBbj6/cRRKqQ6OHPf
hZMAnRFpLbWoDrS7P5Utzo0RkucnVJFy
=s162
-----END PGP SIGNATURE-----

--Sig_/M_f8ZNEpesn_D3a7Pap+CZ9--
