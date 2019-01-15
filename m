Received: from eggs.gnu.org ([209.51.188.92]:37384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPYe-0002rf-1u
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPP2-0000GZ-KF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:09:17 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjPP2-0000GA-E3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:09:16 -0500
Received: by mail-wm1-x341.google.com with SMTP id d15so3418190wmb.3
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:09:15 -0800 (PST)
Date: Tue, 15 Jan 2019 14:09:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190115140912.GA29056@stefanha-x1.localdomain>
References: <20181214105642.673-1-cfergeau@redhat.com>
	<20190103105425.GF7733@stefanha-x1.localdomain>
	<20190103141455.GP20900@natto.ory.fergeau.eu>
	<20190104154034.GK30381@stefanha-x1.localdomain>
	<20190114115420.GR23773@natto.ory.fergeau.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190114115420.GR23773@natto.ory.fergeau.eu>
Subject: Re: [Qemu-devel] [PATCH v4] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 12:54:20PM +0100, Christophe Fergeau wrote:
> On Fri, Jan 04, 2019 at 03:40:34PM +0000, Stefan Hajnoczi wrote:
> > On Thu, Jan 03, 2019 at 03:14:55PM +0100, Christophe Fergeau wrote:
> > > Hey,
> > >=20
> > > On Thu, Jan 03, 2019 at 10:54:25AM +0000, Stefan Hajnoczi wrote:
> > > > On Fri, Dec 14, 2018 at 11:56:42AM +0100, Christophe Fergeau wrote:
> > > > > +static void qemu_log_func(const gchar *log_domain,
> > > > > +                          GLogLevelFlags log_level,
> > > > > +                          const gchar *message,
> > > > > +                          gpointer user_data)
> > > > > +{
> > > > > +    switch (log_level & G_LOG_LEVEL_MASK) {
> > > > > +    case G_LOG_LEVEL_DEBUG:
> > > > > +        /* Use same G_MESSAGES_DEBUG logic as glib to enable/dis=
able debug
> > > > > +         * messages
> > > > > +         */
> > > > > +        if (qemu_glog_domains =3D=3D NULL) {
> > > > > +            break;
> > > > > +        }
> > > > > +        if (strcmp(qemu_glog_domains, "all") !=3D 0 &&
> > > > > +          (log_domain =3D=3D NULL || !strstr(qemu_glog_domains, =
log_domain))) {
> > > > > +            break;
> > > > > +        }
> > > > > +        /* Fall through */
> > > > > +    case G_LOG_LEVEL_INFO:
> > > > > +        /* Fall through */
> > > > > +    case G_LOG_LEVEL_MESSAGE:
> > > > > +        info_report("%s: %s", log_domain, message);
> > > >=20
> > > > QEMU itself uses glib, so what happens if *_report() emit more log
> > > > messages?  Can this result in an infinite loop?
> > >=20
> > > If *_report try to output messages through the g_log API, glib will
> > > catch it and will abort, so not an infinite loop, but not a
> > > desirable outcome either.
> > >=20
> > > Some low-level logging functions which are going to dump the message
> > > without glib (or using g_log_default_handler()) are needed.
> > > The timestamping/prepending of 'error:', 'warning:' to the error mess=
age
> > > is done right below *_report (in vreport) so this looked like a good
> > > place for that.
> >=20
> > If you're confident that QEMU will never (indirectly) emit a glib log
> > message from the *_report() code path, then I'm happy.
>=20
> In these codepaths, I'm confident up to
> void monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
> {
>     if (cur_mon && !monitor_cur_is_qmp()) {
>         monitor_vprintf(cur_mon, fmt, ap);
>     } else {
>         vfprintf(stream, fmt, ap);
>     }
> }
>=20
> From there, it was not obvious to me whether the monitor_vprintf
> codepath can be triggered from info/warn/error_report or not. If they
> can, I'd feel less confident that monitor_vprintf will never indirectly
> call glib log functions.

I think we're okay because otherwise monitor_vprintf() ->
info/warn/error_report() would already be an infinite loop today.

Stefan

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPemIAAoJEJykq7OBq3PI0uoH/jD7qyrl00s6PMiJeMyQ+EyC
dElvriNjz58+uw8t6rsnDlY3HjJVSk0o8frhraeW22hnBdkvG/H+OINr6Wezt8rq
C6F9hAzHE7/6fEuyt7Va+o7cUYwLIM3BfpFWF1wv8H8TNnNQ+OgNCRgCqcKrP4xn
j/okV6/JTQ7k+1pq5xf25VasmrmIOspcBD5gGngWZ7I1Wy9ud48IQVopkuhOPWz3
SqGcf8SGQR4gXlGZMtOTpcdl9vx7sJhQGL8aZw/oBl88tk95Ko6vSZ1/s+b5wjFz
3x2RL53aWBxbDr/hrOwO3yEshUaPL/pgmyecCt3mZY51WQDxFk/b+LJHDWsbFr8=
=FFBU
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
