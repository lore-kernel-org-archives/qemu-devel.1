Received: from eggs.gnu.org ([2001:4830:134:3::10]:56922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gXPcj-00016A-EF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gXPce-0003g5-DS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:57:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gXPce-0003fM-4t
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:57:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B3BD30020C3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:57:43 +0000 (UTC)
Date: Thu, 13 Dec 2018 12:57:41 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20181213115741.GD19201@natto.ory.fergeau.eu>
References: <20181213112612.31242-1-cfergeau@redhat.com>
	<20181213115212.GF5171@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20181213115212.GF5171@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 11:52:12AM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Dec 13, 2018 at 12:26:12PM +0100, Christophe Fergeau wrote:
> > This commit adds a qemu_init_logging() helper which calls
> > g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> > are handled similarly to other QEMU logs. This means they will get a
> > timestamp if timestamps are enabled, and they will go through the
> > monitor if one is configured.
> > This commit also adds a call to qemu_init_logging() to the binaries
> > installed by QEMU.
> >=20
> > At the moment, this change will mostly impact SPICE logging if your
> > spice version is >=3D 0.14.1. With older spice versions, this is not go=
ing
> > to work as expected, but will not have any ill effect, so this call is
> > not conditional on the SPICE version.
> >=20
> > Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> > ---
> > Changes since v1:
> > - introduced a qemu_init_logging() helper, and call that in more
> >   binaries than just vl.c
>=20
> > +static void qemu_log_func(const gchar *log_domain,
> > +                          GLogLevelFlags log_level,
> > +                          const gchar *message,
> > +                          gpointer user_data)
> > +{
> > +    switch (log_level & G_LOG_LEVEL_MASK) {
> > +    case G_LOG_LEVEL_DEBUG:
> > +        break;
> > +    case G_LOG_LEVEL_INFO:
> > +        /* Fall through */
> > +    case G_LOG_LEVEL_MESSAGE:
> > +        info_report("%s", message);
> > +        break;
> > +    case G_LOG_LEVEL_WARNING:
> > +        /* Fall through */
> > +    case G_LOG_LEVEL_CRITICAL:
> > +        warn_report("%s", message);
> > +        break;
>=20
> This didn't adress my previous comment that _CRITICAL should do an
> error_report, not warn_reoprt.

My bad, sorry for missing it, v3 incoming.

Christophe

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlwSSTEACgkQqdjCFCms
bIJiDg/9GCwHuCwz9oo556/LGZf4YfbjFiv/Hh4XTFpSIQXPBJT6cF4artwLqibF
UQWI/+pop4KYvpyOHic17mV3qnIZoBksmUnaJSGkPaFsZMzclDwaBpGe+rj0jGkk
83AgOGgkHCXLmbqPsI5VTJL9k7JwO8ALJPR88Yn23vFSSX6Z+3vtKUeQda6hyMte
Lz3KqgCwf8bmSI+TJ4+7clHQRdnc2cdYCKGwM27x7rR7v3Me1ls/zNKBs//MK3BP
o0G7bUkCnbG/VzVtqu2uH4c0xZD1z/qdrDBDauDYQhuKg52b8jfQWgy3Ih5rwu7c
1ZllbCo0k+orrsijwGqx6Abw/RhET0k85IqFwcdNtmuLAFYY+hiuuYr4ferhk17E
XmMunwowtRckDtaMzA9V50guA89OXfmvL7/txLW1T5P+OZRoI+wBX7lN0LIJa4JP
TPEETP/d0j/wyFRofuFbdWiLfp6hda2gbxI+csOFRedE2Q7EoD1s7nKm5U0ufwU4
vPiYl7nGfvIUqdoH6bwI20X0BUXZXreD5tPzvzLyDzpL7hzUCUkdz5+NoxuHE2uv
UGCthMDcRz6ZkBS+9uYHWgOFLWjwtsywNfULhEWLjZpsDD0jTlmxLF4MY1xwLU3h
br5gTSTBLXbrZUV30/wrXtGr5eCIF4EAYxaEoPLqmWdYinaRGa4=
=EK8S
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
