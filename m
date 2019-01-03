Received: from eggs.gnu.org ([208.118.235.92]:33162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gf3m1-00038S-Kx
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gf3ly-0002dA-DR
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:15:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gf3ly-0002cl-5f
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:14:58 -0500
Date: Thu, 3 Jan 2019 15:14:55 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190103141455.GP20900@natto.ory.fergeau.eu>
References: <20181214105642.673-1-cfergeau@redhat.com>
	<20190103105425.GF7733@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZVOC9e0LfXEId8h2"
Content-Disposition: inline
In-Reply-To: <20190103105425.GF7733@stefanha-x1.localdomain>
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


--ZVOC9e0LfXEId8h2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jan 03, 2019 at 10:54:25AM +0000, Stefan Hajnoczi wrote:
> On Fri, Dec 14, 2018 at 11:56:42AM +0100, Christophe Fergeau wrote:
> > +static void qemu_log_func(const gchar *log_domain,
> > +                          GLogLevelFlags log_level,
> > +                          const gchar *message,
> > +                          gpointer user_data)
> > +{
> > +    switch (log_level & G_LOG_LEVEL_MASK) {
> > +    case G_LOG_LEVEL_DEBUG:
> > +        /* Use same G_MESSAGES_DEBUG logic as glib to enable/disable d=
ebug
> > +         * messages
> > +         */
> > +        if (qemu_glog_domains =3D=3D NULL) {
> > +            break;
> > +        }
> > +        if (strcmp(qemu_glog_domains, "all") !=3D 0 &&
> > +          (log_domain =3D=3D NULL || !strstr(qemu_glog_domains, log_do=
main))) {
> > +            break;
> > +        }
> > +        /* Fall through */
> > +    case G_LOG_LEVEL_INFO:
> > +        /* Fall through */
> > +    case G_LOG_LEVEL_MESSAGE:
> > +        info_report("%s: %s", log_domain, message);
>=20
> QEMU itself uses glib, so what happens if *_report() emit more log
> messages?  Can this result in an infinite loop?

If *_report try to output messages through the g_log API, glib will
catch it and will abort, so not an infinite loop, but not a
desirable outcome either.

Some low-level logging functions which are going to dump the message
without glib (or using g_log_default_handler()) are needed.
The timestamping/prepending of 'error:', 'warning:' to the error message
is done right below *_report (in vreport) so this looked like a good
place for that.

Christophe

--ZVOC9e0LfXEId8h2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlwuGNsACgkQqdjCFCms
bIJv2w/9Eth3c9qTJKMm5N8wAzea177ZOYIZE4fPFF4RE98IBPdfm4yKbVAZTFiN
Fa34Lr4dCRaWDhlla/jxGV0yOKtt1VLK9CXZsTJKYSoWVwwtMTYGxsH6NA2MgXbw
05HrtWr8eWc1nju4dTBZM/4QEzJSGrQEYWN6TlG813CPUDlbc/2IkYTcgr8IyMcF
HubBKMBnxZpEqKj4YVtORdYheWkeM7iz3ZnxMulpJ+5B44oYzmAPFNrN6+U8H1R2
r8SyhiYoMQ0i70o0/LIJOq3efikaF04TOC79eNe0zsxhZETadKPqlEaTg2H9bU0I
FBuwH59OWYdr/nAtnA0rLuIwCyff7vydFYWf/IFZLsJEuIeINBy3lByShP2Fav27
i3f2yW4zmNn/lm8gahIELj5qM/iD+dZU9HajwZlUTduXegpahHwzolQjlsyOl0o/
Mgp+F0bDWW82VNqiiGgJpb5GZIL85jIPB8fl0qsY+4+UqWfdecopR3qOj/n4B1e3
o5Iajs5yI1zg5ZwJSO51cMj+DJmnAo9xypBwnkN4Vx2YMMqdT7v0A4ZYlleoYNyv
KsRAmSp+WsapqbmrHcN/RxigpYZre4gIICz3R4TJ52e9RJnhI2j2pjq2c3qlEqpH
j3UfCFeXFpIgH/qBNi05zsXBawl+aZfsn56pKQGi+v9p2qATWvA=
=U0Ns
-----END PGP SIGNATURE-----

--ZVOC9e0LfXEId8h2--
