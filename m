Received: from eggs.gnu.org ([2001:4830:134:3::10]:54480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBNii-0001kw-C7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBNif-00067p-9v
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:52:08 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:48538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBNif-00067S-3h
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:52:05 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 66D8AF0948
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:52:01 +0200 (CEST)
Date: Thu, 18 May 2017 17:51:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170518175155.67aeff06@bahia.lan>
In-Reply-To: <7698aca3-0ba9-9a7a-f2c5-8e459384842d@redhat.com>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399504137.29022.4985100698645275511.stgit@bahia.lan>
	<3c8abd95-b490-1b71-b467-4f00d6ce121d@redhat.com>
	<20170509112305.439c4d85@bahia>
	<7698aca3-0ba9-9a7a-f2c5-8e459384842d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/E9O=t8BnJ=AUnjCrMjI4cmD";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/5] 9pfs: local: simplify file opening
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

--Sig_/E9O=t8BnJ=AUnjCrMjI4cmD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 May 2017 09:23:07 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/09/2017 04:23 AM, Greg Kurz wrote:
> > On Fri, 5 May 2017 12:01:55 -0500
> > Eric Blake <eblake@redhat.com> wrote:
> >  =20
> >> On 05/05/2017 09:37 AM, Greg Kurz wrote: =20
> >>> All paths in the virtfs directory now start with "./" (except the vir=
tfs
> >>> root itself which is exactly ".").
> >>>
> >>> We hence don't need to skip leading '/' characters anymore, nor to ha=
ndle
> >>> the empty path case. Also, since virtfs will only ever be supported on
> >>> linux+glibc hosts, we can use strchrnul() and come up with a much sim=
plier
> >>> code to walk through the path elements. And we don't need to dup() the
> >>> passed directory fd.
> >>>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>> ---
> >>>  hw/9pfs/9p-local.c |    5 -----
> >>>  hw/9pfs/9p-util.c  |   26 ++++++++++----------------
> >>>  2 files changed, 10 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> >>> index 92262f3c3e37..bb6e296df317 100644
> >>> --- a/hw/9pfs/9p-local.c
> >>> +++ b/hw/9pfs/9p-local.c
> >>> @@ -54,11 +54,6 @@ int local_open_nofollow(FsContext *fs_ctx, const c=
har *path, int flags,
> >>>  {
> >>>      LocalData *data =3D fs_ctx->private;
> >>> =20
> >>> -    /* All paths are relative to the path data->mountfd points to */
> >>> -    while (*path =3D=3D '/') {
> >>> -        path++;
> >>> -    }   =20
> >>
> >> Is it worth adding any assert()s in place of the deleted code?
> >> =20
> >=20
> > The assert() added by this patch ensures that we never pass an empty
> > string to relative_openat_nofollow(), which isn't related to this
> > hunk of deleted code... so I'm not sure I understand the question :-\ =
=20
>=20
> I was thinking if it is worth replacing the deleted while() loop with an
>=20
> assert(*path !=3D '/');
>=20
> to prove that we have already taken care of ensuring a relative path.

If you're talking about this one in relative_openat_nofollow():

        assert(path[0] !=3D '/');

well, it was there before and it was supposed to handle two things that
should never happen:
1) passing an absolute path, which would cause openat() to ignore dirfd
   and access the absolute path in the host
2) having consecutive slashes in the path, which would cause "" to
   be passed to openat() and get ENOENT

Maybe it would make more sense to handle 1) by moving the assert() to
local_open_nofollow(), in place of the deleted loop.

2) is more a question of laziness... since all the paths that ever
get there come from the backend code, I just assume that it is up
to the backend to provide paths without consecutive slahes. But I
guess, it shouldn't be hard to change the logic to deal with that
gracefully.

> You're right that you added another assert(*path) elsewhere in the
> patch, and that one looked fine.
>=20

--Sig_/E9O=t8BnJ=AUnjCrMjI4cmD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkdwxsACgkQAvw66wEB28IFkwCghURMS6+ra5gjyYzmpjhhjK4E
S64An1OrsHEWUdUSxNUGDx+saK9JHa2x
=rXC/
-----END PGP SIGNATURE-----

--Sig_/E9O=t8BnJ=AUnjCrMjI4cmD--
