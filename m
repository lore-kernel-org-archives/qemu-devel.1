Received: from eggs.gnu.org ([209.51.188.92]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gj0uY-0000vf-6i
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gj0uW-0007up-9N
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:00:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gj0uW-0007sp-0M
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:00:08 -0500
Date: Mon, 14 Jan 2019 12:54:20 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190114115420.GR23773@natto.ory.fergeau.eu>
References: <20181214105642.673-1-cfergeau@redhat.com>
	<20190103105425.GF7733@stefanha-x1.localdomain>
	<20190103141455.GP20900@natto.ory.fergeau.eu>
	<20190104154034.GK30381@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XiEhargoktrmcCDa"
Content-Disposition: inline
In-Reply-To: <20190104154034.GK30381@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org


--XiEhargoktrmcCDa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 03:40:34PM +0000, Stefan Hajnoczi wrote:
> On Thu, Jan 03, 2019 at 03:14:55PM +0100, Christophe Fergeau wrote:
> > Hey,
> >=20
> > On Thu, Jan 03, 2019 at 10:54:25AM +0000, Stefan Hajnoczi wrote:
> > > On Fri, Dec 14, 2018 at 11:56:42AM +0100, Christophe Fergeau wrote:
> > > > +static void qemu_log_func(const gchar *log_domain,
> > > > +                          GLogLevelFlags log_level,
> > > > +                          const gchar *message,
> > > > +                          gpointer user_data)
> > > > +{
> > > > +    switch (log_level & G_LOG_LEVEL_MASK) {
> > > > +    case G_LOG_LEVEL_DEBUG:
> > > > +        /* Use same G_MESSAGES_DEBUG logic as glib to enable/disab=
le debug
> > > > +         * messages
> > > > +         */
> > > > +        if (qemu_glog_domains =3D=3D NULL) {
> > > > +            break;
> > > > +        }
> > > > +        if (strcmp(qemu_glog_domains, "all") !=3D 0 &&
> > > > +          (log_domain =3D=3D NULL || !strstr(qemu_glog_domains, lo=
g_domain))) {
> > > > +            break;
> > > > +        }
> > > > +        /* Fall through */
> > > > +    case G_LOG_LEVEL_INFO:
> > > > +        /* Fall through */
> > > > +    case G_LOG_LEVEL_MESSAGE:
> > > > +        info_report("%s: %s", log_domain, message);
> > >=20
> > > QEMU itself uses glib, so what happens if *_report() emit more log
> > > messages?  Can this result in an infinite loop?
> >=20
> > If *_report try to output messages through the g_log API, glib will
> > catch it and will abort, so not an infinite loop, but not a
> > desirable outcome either.
> >=20
> > Some low-level logging functions which are going to dump the message
> > without glib (or using g_log_default_handler()) are needed.
> > The timestamping/prepending of 'error:', 'warning:' to the error message
> > is done right below *_report (in vreport) so this looked like a good
> > place for that.
>=20
> If you're confident that QEMU will never (indirectly) emit a glib log
> message from the *_report() code path, then I'm happy.

In these codepaths, I'm confident up to
void monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
{
    if (cur_mon && !monitor_cur_is_qmp()) {
        monitor_vprintf(cur_mon, fmt, ap);
    } else {
        vfprintf(stream, fmt, ap);
    }
}

=46rom there, it was not obvious to me whether the monitor_vprintf
codepath can be triggered from info/warn/error_report or not. If they
can, I'd feel less confident that monitor_vprintf will never indirectly
call glib log functions.

Christophe


>=20
> Stefan



--XiEhargoktrmcCDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlw8eGgACgkQqdjCFCms
bII+sBAAjroxu5yB0n7A69XIMZBH+t8jZYWIVZNrOuq574iLe5Y0ljXcHxvc1zMa
9yyx9ZTrhTK4kBRsiDMQPs9aJfDUPBlwSHGjoufrDQr+gHu5eNr1NTpAdK1AU4V0
4QNtSMOYn7OEXtFvkmac9gU5Bt80JGSDQ60cUohFehAXGiv5j7tQpALOX1CABlZB
bwFQHIf2pKF8cro6kNgZ52SzYzEuuNz2rnK2IHaFDRX06LjXnGtSv/QN8p3F6rUV
NabZ5S2qRgROZn4QGQvraH9xuk5sSMc4Kpm1b0cizeRCK5cbvs7w9VwT63dyPI7W
wxzWJD0+w4518xxyWk4UIhyAlRbAGoOdgbC/JOsrIaQKh8q73oWayZ1Qh5s7/q1C
QE3ExvlcTVry7e+uZbB2QIJaukEg/KTKZDT/SKBHffI0d4zV90lGtoh3nUkskrTJ
aSDgks676mCbrOuP0ABM+rLWgg5PsXEOuerL8AUUIJxQXkpIuyAOJGWKvUVY+lAx
vpPNmXl6hH4P5LP9zD4dakhMJIwn+jrvKUU+0SWoaCLowZ7OGlxcEvLrTdiSAt2T
k2zKerjHeBXewZysH7mjmdBAktbni5QVbYa6dCaG9F8LbgNUZb6vhjSfhtaLFOxH
CSepCP6S+sxYyOjnsDIUOAdYB3caHBtrl1uXxcUMmHGk0yE0jRQ=
=E9To
-----END PGP SIGNATURE-----

--XiEhargoktrmcCDa--
