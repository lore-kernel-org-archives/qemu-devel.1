Received: from eggs.gnu.org ([2001:4830:134:3::10]:46689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpEmO-0000eE-9x
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpEmJ-0002Nv-8I
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:24:40 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:52913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpEmJ-0002Lj-1o
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:24:35 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0A282AAEB2
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 16:24:32 +0200 (CEST)
Date: Tue, 5 Sep 2017 16:24:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905162425.3a202a87@bahia>
In-Reply-To: <1d5efdef-21b8-9b7b-6939-339b97fd9bce@redhat.com>
References: <150451194093.7046.18254446012958612468.stgit@bahia>
	<1d5efdef-21b8-9b7b-6939-339b97fd9bce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/9glOxOmFT1hlWQgHCaHOX1G";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] virtfs: error out gracefully when
 mandatory suboptions are missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com

--Sig_/9glOxOmFT1hlWQgHCaHOX1G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Sep 2017 15:35:34 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 04.09.2017 09:59, Greg Kurz wrote:
> > We internally convert -virtfs to -fsdev/-device. If the user doesn't
> > provide the path or security_model suboptions, and the fsdev backend
> > requires them, we hit an assertion when populating the internal -fsdev
> > option:
> >=20
> > util/qemu-option.c:547: opt_set: Assertion `opt->str' failed.
> > Aborted (core dumped)
> >=20
> > Let's test the suboption presence on the command line before trying
> > to set it in the internal -fsdev option, and let the backend code
> > error out gracefully (ie, like it already does when the user passes
> > -fsdev on the command line).
> >=20
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  vl.c |   16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/vl.c b/vl.c
> > index 8e247cc2a239..d63269332fed 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3557,7 +3557,7 @@ int main(int argc, char **argv, char **envp)
> >              case QEMU_OPTION_virtfs: {
> >                  QemuOpts *fsdev;
> >                  QemuOpts *device;
> > -                const char *writeout, *sock_fd, *socket;
> > +                const char *writeout, *sock_fd, *socket, *path, *secur=
ity_model;
> > =20
> >                  olist =3D qemu_find_opts("virtfs");
> >                  if (!olist) {
> > @@ -3596,11 +3596,15 @@ int main(int argc, char **argv, char **envp)
> >                  }
> >                  qemu_opt_set(fsdev, "fsdriver",
> >                               qemu_opt_get(opts, "fsdriver"), &error_ab=
ort);
> > -                qemu_opt_set(fsdev, "path", qemu_opt_get(opts, "path"),
> > -                             &error_abort);
> > -                qemu_opt_set(fsdev, "security_model",
> > -                             qemu_opt_get(opts, "security_model"),
> > -                             &error_abort);
> > +                path =3D qemu_opt_get(opts, "path");
> > +                if (path) {
> > +                    qemu_opt_set(fsdev, "path", path, &error_abort);
> > +                }
> > +                security_model =3D qemu_opt_get(opts, "security_model"=
);
> > +                if (security_model) {
> > +                    qemu_opt_set(fsdev, "security_model", security_mod=
el,
> > +                                 &error_abort);
> > +                }
> >                  socket =3D qemu_opt_get(opts, "socket");
> >                  if (socket) {
> >                      qemu_opt_set(fsdev, "socket", socket, &error_abort=
); =20
>=20
> By the way, I think this should be CC:-ed to stable, too.
>=20

Well, it's been there forever and it isn't a critical fix... but the
thread on qemu-discuss the other day showed that it was confusing
people, and the fix is trivial. So I guess it doesn't hurt to have
this in stable. :)

Michael,

I'll send a pull req later today. If it's not too late, maybe you can add
this patch to 2.9.1 when it's merged in master?

Cheers,

--
Greg

>  Thomas

--Sig_/9glOxOmFT1hlWQgHCaHOX1G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa6zmQAKCRAC/DrrAQHb
wj6IAJ0dn+60IMF0sJixH+rJ1JBJOvef7wCeOSNV7wj9EzEygJ10yQct9gJ/qsA=
=TnFN
-----END PGP SIGNATURE-----

--Sig_/9glOxOmFT1hlWQgHCaHOX1G--
