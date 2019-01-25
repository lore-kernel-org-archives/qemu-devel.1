Received: from eggs.gnu.org ([209.51.188.92]:34346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gn591-0001dZ-Hi
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gn590-0007if-F8
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:19:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gn590-0007PT-44
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:19:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A6DB2D4B72
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 17:19:30 +0000 (UTC)
Date: Fri, 25 Jan 2019 18:19:24 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190125171924.GP30040@natto.ory.fergeau.eu>
References: <20190121170434.13592-1-cfergeau@redhat.com>
	<87munqc9zf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGmrTRZxVujQoXMz"
Content-Disposition: inline
In-Reply-To: <87munqc9zf.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>


--MGmrTRZxVujQoXMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 05:10:28PM +0100, Markus Armbruster wrote:
> Christophe Fergeau <cfergeau@redhat.com> writes:
>=20
> > This commit adds a qemu_init_logging() helper which calls
> > g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> > are handled similarly to other QEMU logs. This means they will get a
> > timestamp if timestamps are enabled, and they will go through the
> > monitor if one is configured.
>=20
> s/monitor/HMP monitor/
>=20
> I see why one would like to extend the timestamp feature to GLib log
> messages.  Routing them through the HMP monitor is perhaps debatable.
> Cc: Dave in case he has an opinion.

Yep, I don't mind whether this goes through HMP or not, this definitely
was not one of my goals when writing this patch. I mention it in the
commit log because this is what the current code is going to do.

> > [snip]
> > diff --git a/util/qemu-error.c b/util/qemu-error.c
> > index fcbe8a1f74..1118ed4695 100644
> > --- a/util/qemu-error.c
> > +++ b/util/qemu-error.c
> > @@ -345,3 +345,50 @@ bool warn_report_once_cond(bool *printed, const ch=
ar *fmt, ...)
> >      va_end(ap);
> >      return true;
> >  }
> > +
> > +static char *qemu_glog_domains;
> > +
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
>=20
> Wing both ends of the comment, please.

Fixed.

>=20
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
>=20
> g_log_default_handler() applies G_MESSAGES_DEBUG suppression logic to
> G_LOG_LEVEL_INFO messages, too.  Do you deviate intentionally?

Nope, I thought INFO and MESSAGE were equivalent. Fixed now.

>=20
> > +    case G_LOG_LEVEL_MESSAGE:
> > +        info_report("%s: %s", log_domain, message);
>=20
> @log_domain can be null.  You even check for that above.

Fixed.

>=20
> > +        break;
> > +    case G_LOG_LEVEL_WARNING:
> > +        warn_report("%s: %s", log_domain, message);
> > +        break;
> > +    case G_LOG_LEVEL_CRITICAL:
> > +        /* Fall through */
> > +    case G_LOG_LEVEL_ERROR:
> > +        error_report("%s: %s", log_domain, message);
> > +        break;
>=20
> Sure we don't need to check for G_LOG_FLAG_RECURSION?
> g_log_default_handler() has a conditional for that...
>=20
> Not sure it has anything for G_LOG_FLAG_FATAL; it's code is surprisingly
> complex.

Both are filtered out from the switch() through G_LOG_LEVEL_MASK:
   switch (log_level & G_LOG_LEVEL_MASK) {
and
https://developer.gnome.org/glib/2.58/glib-Message-Logging.html#G-LOG-FLAG-=
RECURSION:CAPS
documents G_LOG_FLAG_FATAL and G_LOG_FLAG_RECURSION as fatal.

However, g_log_set_handler() then mentions handling them anyways:
https://developer.gnome.org/glib/2.58/glib-Message-Logging.html#g-log-set-h=
andler
"Sets the log handler for a domain and a set of log levels. To handle
fatal and recursive messages the log_levels parameter must be combined
with the G_LOG_FLAG_FATAL and G_LOG_FLAG_RECURSION bit flags."

My understanding of glib's code is if any of these 2 flags is set, glib
is going to abort anyways, so handling or not handling these flags is
not going to make a big difference.

>=20
> > +    }
> > +}
> > +
> > +/*
> > + * Init QEMU logging subsystem. This sets up glib logging so libraries=
 using it
> > + * also print their logs through {info,warn,error}_report.
> > + */
>=20
> Format like the other function comments:
>=20
>    /*
>     * Init QEMU logging subsystem.
>     * This sets up glib logging so libraries using it also print their lo=
gs
>     * through error_report(), warn_report(), info_report().
>     */
>=20
> Braces expanded for better grepability.
>=20
> > +void qemu_init_logging(void)
>=20
> Naming is hard...  Yes, this "initializes logging" in a sense: it
> installs a GLib default log handler that routes GLib log messages
> through this module.  But that's detail; the callers don't care what
> this function does, all they care for is "must call early".  If this
> module ever grows a need to initialize something else before it gets
> used, we'll regret naming its initialization function
> qemu_init_logging().
>=20
> Hmm, it has already grown such a need: initializing @progname.
> error_set_progname() does it.  Asking a module's users to call *two*
> initializtion functions is not nice.
>=20
> Fuse the two into error_init(const char *argv0)?

Ok, I've done that now, I'll send a v6.

Thanks for the review,

Christophe

--MGmrTRZxVujQoXMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlxLRRgACgkQqdjCFCms
bIJ/Mg//U6isw9ToT1reDvLCsragx+8Cy3CQYUb3X9SJBVrBqrzFBzgWrt1rtUEa
kGaYj7O+VDpSGeIQPSLErhi5OeWjiRWX03lWYXF31DRkj2ApyzE6GgTtx41ZMlR5
Pq7QFoKJVS9StUabD9NpSbawE25y908eXDRyEs1La1K0GNIuPFThd6/QuYLMDVjr
c6vyKnou/f37zSFiI+ZTqjRasB1SAswxIkVv9bvtEsBQlG5W12jnxoMryurrzagY
jRBtfx4h/JUShevTFyikKk6AMpipOAv5gTyax42LI6e7sdQ15U/J7b2wPiU0ours
OVC8HIPS4b/Ap1YfObPDXudveJXdqQwORzfJGyaGbT4wCaJehydUeIqboNXtailC
uYkhAPVTdwSdNKxsnkvfcb2LyBVEojz/JmVcGOetKXSkt0Gqz90UUjN6Mzju8S9n
3fB/AXmcfq6BkxRtsiQD5uIoMZP0R4zSzsvnoJpGAQihHNBv2OaxDdMlPaC+7lez
FKKJ6PleLu+riO4EMSrVMdx6Znp8fXcmtmvIcBMBQQcrmHggmWZ3uyxHf4nULhwU
Q+KXW4l7xoGnJSUWqq31G0jtu7C46ECx7AKP1HjjUl9QezpGOAMcKAPdEQpNlbXM
LWx7Ic7An3P2hwAc5C5cTSCIiwb/KI5D+eMIuB/y8JYbFafZkQE=
=e/jN
-----END PGP SIGNATURE-----

--MGmrTRZxVujQoXMz--
