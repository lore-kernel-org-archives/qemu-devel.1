Received: from eggs.gnu.org ([208.118.235.92]:36772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gfRaV-0004pI-1p
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gfRaQ-0003yd-5M
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:40:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gfRaP-0003yQ-VM
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:40:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so1583067wmd.2
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:40:37 -0800 (PST)
Date: Fri, 4 Jan 2019 15:40:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190104154034.GK30381@stefanha-x1.localdomain>
References: <20181214105642.673-1-cfergeau@redhat.com>
	<20190103105425.GF7733@stefanha-x1.localdomain>
	<20190103141455.GP20900@natto.ory.fergeau.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uuKVzAmB+c+zQlhu"
Content-Disposition: inline
In-Reply-To: <20190103141455.GP20900@natto.ory.fergeau.eu>
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


--uuKVzAmB+c+zQlhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 03:14:55PM +0100, Christophe Fergeau wrote:
> Hey,
>=20
> On Thu, Jan 03, 2019 at 10:54:25AM +0000, Stefan Hajnoczi wrote:
> > On Fri, Dec 14, 2018 at 11:56:42AM +0100, Christophe Fergeau wrote:
> > > +static void qemu_log_func(const gchar *log_domain,
> > > +                          GLogLevelFlags log_level,
> > > +                          const gchar *message,
> > > +                          gpointer user_data)
> > > +{
> > > +    switch (log_level & G_LOG_LEVEL_MASK) {
> > > +    case G_LOG_LEVEL_DEBUG:
> > > +        /* Use same G_MESSAGES_DEBUG logic as glib to enable/disable=
 debug
> > > +         * messages
> > > +         */
> > > +        if (qemu_glog_domains =3D=3D NULL) {
> > > +            break;
> > > +        }
> > > +        if (strcmp(qemu_glog_domains, "all") !=3D 0 &&
> > > +          (log_domain =3D=3D NULL || !strstr(qemu_glog_domains, log_=
domain))) {
> > > +            break;
> > > +        }
> > > +        /* Fall through */
> > > +    case G_LOG_LEVEL_INFO:
> > > +        /* Fall through */
> > > +    case G_LOG_LEVEL_MESSAGE:
> > > +        info_report("%s: %s", log_domain, message);
> >=20
> > QEMU itself uses glib, so what happens if *_report() emit more log
> > messages?  Can this result in an infinite loop?
>=20
> If *_report try to output messages through the g_log API, glib will
> catch it and will abort, so not an infinite loop, but not a
> desirable outcome either.
>=20
> Some low-level logging functions which are going to dump the message
> without glib (or using g_log_default_handler()) are needed.
> The timestamping/prepending of 'error:', 'warning:' to the error message
> is done right below *_report (in vreport) so this looked like a good
> place for that.

If you're confident that QEMU will never (indirectly) emit a glib log
message from the *_report() code path, then I'm happy.

Stefan

--uuKVzAmB+c+zQlhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcL35yAAoJEJykq7OBq3PIstwIAKzJVWbAJkVOuPAYwQR7inQc
a7Cl3ny+MFP91EUgKPDz1W5qHq76qu0vkMapAnIDo8mHUctwAfy21q7WYY/hdHEI
PNBMoq9U1BYzqSEn3uC+Xe4W5KBxNtWQWPqulxtWLmgTjWIlsHWVsKV2Wh8cQEsy
jYtgo3ft5qE7Fyvrf25FlsByiWBzgnWu1K7qB4Ccr1DEMjFjbTVEfAmBv/KchCXe
ziNAOsHE6dBPes4wz+CLMzhWqHKR4H1rpHh3YydgqLl0jEl1TiDkVmXta2qjfWux
7bhh/CPjMGtiwExFXbP5sL0aLE2X2ujQt2Gk05jI0O/SOOzkbiKgsbU2G3hIIPI=
=iMAC
-----END PGP SIGNATURE-----

--uuKVzAmB+c+zQlhu--
