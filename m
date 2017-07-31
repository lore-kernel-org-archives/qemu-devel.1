Received: from eggs.gnu.org ([2001:4830:134:3::10]:42980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcDf4-0006vd-2w
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcDf1-0006g7-Cj
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:35:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcDf1-0006fX-6C
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:35:15 -0400
Date: Mon, 31 Jul 2017 17:35:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170731163511.GB24783@stefanha-x1.localdomain>
References: <20170731140718.22010-1-stefanha@redhat.com>
	<20170731140718.22010-2-stefanha@redhat.com>
	<20170731151639.GE21310@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20170731151639.GE21310@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] trace: add
 TRACE_<event>_BACKEND_DSTATE()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 04:16:39PM +0100, Daniel P. Berrange wrote:
> On Mon, Jul 31, 2017 at 03:07:17PM +0100, Stefan Hajnoczi wrote:
> > diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/ba=
ckend/dtrace.py
> > index c6812b70a2..17f902cc62 100644
> > --- a/scripts/tracetool/backend/dtrace.py
> > +++ b/scripts/tracetool/backend/dtrace.py
> > @@ -44,8 +44,20 @@ def generate_h_begin(events, group):
> >      out('#include "%s"' % header,
> >          '')
> > =20
> > +    # SystemTap defines <provider>_<name>_ENABLED() but other DTrace
> > +    # implementations might not.
> > +    for e in events:
> > +        out('#ifndef QEMU_%(uppername)s_ENABLED',
> > +            '#define QEMU_%(uppername)s_ENABLED() false',
> > +            '#endif',
> > +            uppername=3De.name.upper())
>=20
>=20
> IIUC, this means that on other DTrace impls, any trace points guarded by
> QEMU_*_ENABLED() will never run, even if DTrace probes are set. Having
> some trace points silently never run makes it pretty useless IMHO.
>=20
> IOW, you need the opposite, #define it to true. The probe will still
> only be executed if DTrace has enabled it, but you'll have to take the
> hit of evaluating the probe arguments regardless. Not as optimized
> performance-wise, but functionally correct at least.

Good point!  Thank you, will fix when merging.

Stefan

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZf1w/AAoJEJykq7OBq3PInZcIAIMExXptd7Q2AtvwEx+bcFju
VPHsKOir65HCswZCRwPNDPaNTZwTBX1gjLGHdo0NRvhW/CzSaONVAN7hFgEWFxcq
Lzb5sIGOCY6kcAQVX9Qro5A+gQG5j5jkxQ3f4PLwVRKlzYSI731VGWD2bZX6w5Qp
OmhAzQSJJLhRyvMeuyQJOdYksychr5w6vAnFqvfBbo96beskbzx5S8kQiAYLpSvz
3yFgmQSQHMFMJtqyqedta7Rswgwe7d67MSZ7lIC/tb/g7pA4XYCaK+/gnfX9Vo82
6frgOvOGVZO4Tprt5k1qWctHX7qhFEbxy9gkI5acWsuZkGj4luJBWAuTRoxZCZ0=
=9JML
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
