Received: from eggs.gnu.org ([2001:4830:134:3::10]:33726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPU78-0002pp-UN
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPU75-0003zb-RP
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:59:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cPU75-0003yY-Id
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:59:19 -0500
Date: Fri, 6 Jan 2017 12:59:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170106125915.GA17294@stefanha-x1.localdomain>
References: <20170105173107.5426-1-stefanha@redhat.com>
	<20170105173107.5426-2-stefanha@redhat.com>
	<20170105174550.GW3292@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20170105174550.GW3292@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] configure: add libsystemd check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 05:45:50PM +0000, Daniel P. Berrange wrote:
> On Thu, Jan 05, 2017 at 05:31:06PM +0000, Stefan Hajnoczi wrote:
> > libsystemd provides APIs for daemons that wish to integrate socket
> > activation and other systemd-related functionality.  This will be used
> > as an optional dependency by qemu-guest-agent.
> >=20
> > In the future it could also be used for systemd logging or sd_notify(3)
> > service startup notification.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  configure | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >=20
> > diff --git a/configure b/configure
> > index 218df87..c353ff7 100755
> > --- a/configure
> > +++ b/configure
> > @@ -321,6 +321,7 @@ numa=3D""
> >  tcmalloc=3D"no"
> >  jemalloc=3D"no"
> >  replication=3D"yes"
> > +systemd=3D""
> > =20
> >  # parse CC options first
> >  for opt do
> > @@ -1168,6 +1169,10 @@ for opt do
> >    ;;
> >    --enable-replication) replication=3D"yes"
> >    ;;
> > +  --disable-systemd) systemd=3D"no"
> > +  ;;
> > +  --enable-systemd) systemd=3D"yes"
> > +  ;;
> >    *)
> >        echo "ERROR: unknown option $opt"
> >        echo "Try '$0 --help' for more information"
> > @@ -1401,6 +1406,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
> >    tcmalloc        tcmalloc support
> >    jemalloc        jemalloc support
> >    replication     replication support
> > +  systemd         systemd support
> > =20
> >  NOTE: The object files are built at the place where configure is launc=
hed
> >  EOF
> > @@ -4720,6 +4726,27 @@ if compile_prog "" "" ; then
> >      have_af_vsock=3Dyes
> >  fi
> > =20
> > +##########################################
> > +# check for libsystemd
> > +if test "$systemd" !=3D "no" ; then
> > +  cat > $TMPC << EOF
> > +#include <systemd/sd-daemon.h>
> > +int main(void) { (void)sd_listen_fds(1); return 0; }
> > +EOF
> > +  systemd_cflags=3D$($pkg_config --cflags libsystemd 2>/dev/null)
> > +  systemd_libs=3D$($pkg_config --libs libsystemd 2>/dev/null)
> > +  if $pkg_config libsystemd >/dev/null 2>&1 && \
> > +     compile_prog "$systemd_cflags" "$systemd_libs" ; then
>=20
> Any reason why you're going to the trouble of compiling a
> program here ? The key benefit of pkg-config is that you
> don't need to do things like that to test for existance
> of the library - just trust the result of pkg-config check.
>=20
> FWIW, it is easy to support socket activation without even
> using libsystemd. The systemd activation "protocol" is
> trivial - it merely sets "LISTEN_FDS" env variable to the
> number of FDs it has been passed down, and they are numbered
> from stderr fileno + 1.

After looking into it I found that LISTEN_FDS is considered stable and
"reimplementable independently":
https://www.freedesktop.org/wiki/Software/systemd/InterfacePortabilityAndSt=
abilityChart/

I'll resend this patch without the libsystemd dependency.

I guess that will make packagers happy who wish to provide packages that
work both with and without systemd installed.

Stefan

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYb5SjAAoJEJykq7OBq3PI1AkH/i8QFDn1Fe44kF5o5ewN4Gzs
3OyV+oKAkTUjiv29DsFTsc6TG8ciQzOewzk13xGkwDc9oklgkWD03GrpVnwCeHJS
I+ToPr0iwczgW1rG0pAC1y7XVmGHmRAwWjD/AnEVkFcbMiRn8YN6kau1kikPkqg4
vuDLG05d6YZWlH43YUpIUeLoNDMAzWaluyLWwK9t77gswxW1nOJYQrCiCvMBGN2V
F2NBpNajv1QGkmNQVBosn9njHro4hZhCSLCSuQonwo7ltYMfh4T9STx0bTwSwsmF
h84aSUjnCzJPNn94Sb7kCFRYGq5N/ZK9BHthaiYhJDzRF3QORyS7N6K8FFplDO8=
=jEe8
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
