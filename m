Received: from eggs.gnu.org ([2001:4830:134:3::10]:40632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDEqS-00071F-PF
	for qemu-devel@nongnu.org; Tue, 23 May 2017 14:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDEqP-0005SK-Mz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 14:47:48 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:37220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDEqP-0005S7-Gj
	for qemu-devel@nongnu.org; Tue, 23 May 2017 14:47:45 -0400
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A2BB488693
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 20:47:42 +0200 (CEST)
Date: Tue, 23 May 2017 20:47:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170523204738.62c5e73b@bahia.ttt.fr.ibm.com>
In-Reply-To: <5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/CjGXDp0OwzKfiDtNWXomj4=";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] 9pfs: local: metadata file for the
 VirtFS root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Leo Gaspard <leo@gaspard.io>

--Sig_/CjGXDp0OwzKfiDtNWXomj4=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017 12:13:17 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/23/2017 09:32 AM, Greg Kurz wrote:
> > When using the mapped-file security, credentials are stored in a metada=
ta
> > directory located in the parent directory. This is okay for all paths w=
ith
> > the notable exception of the root path, since we don't want and probably
> > can't create a metadata directory above the virtfs directory on the hos=
t.
> >=20
> > This patch introduces a dedicated metadata file, sitting in the virtfs =
root
> > for this purpose. It relies on the fact that the "." name necessarily r=
efers
> > to the virtfs root.
> >=20
> > As for the metadata directory, we don't want the client to see this fil=
e.
> > The current code only cares for readdir() but there are many other plac=
es
> > to fix actually. The filtering logic is hence put in a separate functio=
n.
> >=20
> > @@ -478,7 +504,8 @@ static off_t local_telldir(FsContext *ctx, V9fsFidO=
penState *fs)
> > =20
> >  static bool local_is_mapped_file_metadata(FsContext *fs_ctx, const cha=
r *name)
> >  {
> > -    return !strcmp(name, VIRTFS_META_DIR);
> > +    return
> > +        !strcmp(name, VIRTFS_META_DIR) || !strcmp(name, VIRTFS_META_RO=
OT_FILE); =20
>=20
> We have to block VIRTFS_META_DIR at any depth in the hierarchy, but
> can/should we change the blocking of VIRTFS_META_ROOT_FILE to only
> happen at the root directory, rather than at all directories?  On the
> other hand, if you can simultaneously map /path/to/a for one mount
> point, and /path/to/a/b for another, then the root file for B is visible
> at a lower depth than the root file for A, and blocking the metafile
> name everywhere means that the mount A can't influence the behavior on
> the mount for B.
>=20

I must confess I hadn't this scenario in mind but it's safer from a
security standpoint indeed.

> Not tested, but looks sane, so:
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks again for the review, Eric.

Cheers,

--
Greg

--Sig_/CjGXDp0OwzKfiDtNWXomj4=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkkg8oACgkQAvw66wEB28KR2gCfeTWSXKuyKMJyAclIGz+rrHTF
06AAoKMZo5h9z51WXMV/lnjjcJwZZlGY
=p8Kw
-----END PGP SIGNATURE-----

--Sig_/CjGXDp0OwzKfiDtNWXomj4=--
