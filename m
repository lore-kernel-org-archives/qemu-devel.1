Received: from eggs.gnu.org ([2001:4830:134:3::10]:40448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc7LJ-0008Lx-V2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc7LG-00021T-OQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:50:30 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dc7LG-00020x-GE
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:50:26 -0400
Received: by mail-wm0-x22d.google.com with SMTP id k20so13927205wmg.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 02:50:26 -0700 (PDT)
Date: Mon, 31 Jul 2017 10:50:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170731095023.GG11830@stefanha-x1.localdomain>
References: <20170728133657.5525-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline
In-Reply-To: <20170728133657.5525-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] trace: ensure unique function /
 variable names per .stp file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 02:36:57PM +0100, Daniel P. Berrange wrote:
> The simpletrace compatibility code for systemtap creates a
> function and some global variables for mapping to event ID
> numbers. We generate multiple -simpletrace.stp files though,
> one per target and systemtap considers functions & variables
> to be globally scoped, not per file. So if trying to use the
> simpletrace compat probes, systemtap will complain:
>=20
>  # stap -e 'probe qemu.system.arm.simpletrace.visit_type_str { print( "he=
llo")}'
>  semantic error: conflicting global variables: identifier 'event_name_to_=
id_map' at /usr/share/systemtap/tapset/qemu-aarch64-simpletrace.stp:3:8
>         source: global event_name_to_id_map
>                        ^
>  identifier 'event_name_to_id_map' at /usr/share/systemtap/tapset/qemu-sy=
stem-arm-simpletrace.stp:3:8
>         source: global event_name_to_id_map
>                        ^
>=20
>  WARNING: cross-file global variable reference to identifier 'event_name_=
to_id_map' at /usr/share/systemtap/tapset/qemu-system-arm-simpletrace.stp:3=
:8 from: identifier 'event_name_to_id_map' at /usr/share/systemtap/tapset/q=
emu-aarch64-simpletrace.stp:8:21
>  source:     if (!([name] in event_name_to_id_map)) {
>                              ^
>  WARNING: cross-file global variable reference to identifier 'event_next_=
id' at /usr/share/systemtap/tapset/qemu-system-arm-simpletrace.stp:4:8 from=
: identifier 'event_next_id' at :9:38
>  source:         event_name_to_id_map[name] =3D event_next_id
>                                               ^
>=20
> We already have a string used to prefix probe names, so just
> replace '.' with '_' to get a function / variable name prefix
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/tracetool/format/simpletrace_stap.py | 29 ++++++++++++++++++----=
------
>  1 file changed, 19 insertions(+), 10 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZfv1fAAoJEJykq7OBq3PIxQUIAJHI7a4fARpXerWQTAlICBKg
+ggICqJ7iGHU+FCZrbLk1Ybl/qbk+Vd+wm/5VgVwqjpTHb4wRHkV5taFFTHhEMr1
qCzOW7YULCpWPKYsB+gXP4g9L0bcP5LVZ/QnesHc+d8Hp9kpyjIAhs0vfYj/FmfP
IghqOMKHYIIEmyNfe/HZbqQShDoZ2cTCQryfPd5qJzaFg/I5qaIhQPhzWv2Ut0p4
pBDLejRVvaxw4fT8egpQwguPk0RajMtr9vv5ZO0+FlBXv0uN5ZwK5LesgGUN/ooZ
JakWTSi2mj7rqVDg1jTEB1rD9owUHOLdYk++bmytSL03FR7o8SlAZF0BD8ggAJI=
=rEVD
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
