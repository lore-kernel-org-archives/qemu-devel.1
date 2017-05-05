Received: from eggs.gnu.org ([2001:4830:134:3::10]:44177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6h4C-0007KL-Sl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6h49-0003OZ-Pt
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:30:56 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:40484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6h49-0003OD-Id
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:30:53 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C7284E11F2
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 19:30:50 +0200 (CEST)
Date: Fri, 5 May 2017 19:30:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170505193046.6c9bf2c1@bahia>
In-Reply-To: <e1843524-9ec7-2aea-4138-f3ce246f0929@redhat.com>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399502436.29022.4452572475773635974.stgit@bahia.lan>
	<e1843524-9ec7-2aea-4138-f3ce246f0929@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Yukj13YSpS/qhl9vtoWqEiO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/5] 9pfs: check return value of
 v9fs_co_name_to_path()
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

--Sig_/Yukj13YSpS/qhl9vtoWqEiO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 5 May 2017 11:55:43 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/05/2017 09:37 AM, Greg Kurz wrote:
> > These v9fs_co_name_to_path() call sites have always been around. I guess
> > no care was taken to check the return value because the name_to_path
> > operation could never fail at the time. This is no longer true: the
> > handle and synth backends can already fail this operation, and so will =
the
> > local backend soon.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p.c |   36 +++++++++++++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 11 deletions(-)
> >  =20
>=20
> > @@ -2588,8 +2591,11 @@ static int coroutine_fn v9fs_complete_rename(V9f=
sPDU *pdu, V9fsFidState *fidp,
> >          new_name =3D g_malloc0(end - old_name + name->size + 1);
> >          strncat(new_name, old_name, end - old_name);
> >          strncat(new_name + (end - old_name), name->data, name->size); =
=20
>=20
> Ad long as you're here, you could replace this strncat mess with the
> shorter:
>=20
> new_name =3D g_strdup_printf("%.*s%.*s", end - old_name, old_name,
>                            name->size, name->data);
>=20
> (or with further simplifications if you have NUL-terminated data).  But
> that can be a separate cleanup.
>=20

Yes you're right, this definitely looks better than the strncat() logic.
I guess I'll do this in a separate patch.

Thanks for the suggestion.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--Sig_/Yukj13YSpS/qhl9vtoWqEiO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkMtscACgkQAvw66wEB28KUuwCfZbssU+xUGb4q013NMtizPba6
sawAn1Ck3vus+XCVm8Tx9j/lyAWbOGCw
=G16v
-----END PGP SIGNATURE-----

--Sig_/Yukj13YSpS/qhl9vtoWqEiO--
