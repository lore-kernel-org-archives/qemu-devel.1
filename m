Received: from eggs.gnu.org ([2001:4830:134:3::10]:34326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxoB-0006Q1-8k
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxo8-0002Uj-6P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:57:15 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cpxo7-0002UV-W2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:57:12 -0400
Received: by mail-wr0-x242.google.com with SMTP id l37so18218682wrc.3
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 06:57:11 -0700 (PDT)
Date: Mon, 20 Mar 2017 13:57:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320135708.GV17887@stefanha-x1.localdomain>
References: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QILrdhYozogw5Vly"
Content-Disposition: inline
In-Reply-To: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu-ga static compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org


--QILrdhYozogw5Vly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 06:51:37PM +0200, Sameeh Jubran wrote:
> I am trying to compile qemu-ga for Windows statically using the following
> commands:
>=20
> ./configure --disable-docs --target-list=3Dx86_64-softmmu
> --cross-prefix=3Dx86_64-w64-mingw32- --static --enable-guest-agent-msi
> --with-vss-sdk=3D/path/to/VSSSDK72
>=20
> make -j8 qemu-ga
>=20
>=20
> And I keep getting this error:
>=20
> /home/sameeh/Builds/q/stubs/error-printf.c:7: undefined reference to
> `__imp_g_test_config_vars'
> collect2: error: ld returned 1 exit status
> Makefile:444: recipe for target 'qemu-ga.exe' failed
> make: *** [qemu-ga.exe] Error 1
>=20
>=20
> Notes to consider:
> * without --static I can compile it successfully
> * Build machine is running Fedora 25
> * I have upgraded all of the tools to their latest version
> * If I comment out the function which is causing the issue
> (g_test_initialized()), qemu ga compiles statically and runs successfully
> without the need of any dlls.
>=20
> Can anyone reproduce this? Do you have any idea why is this happening?

I guess GLIB_STATIC_COMPILATION is not defined in your build (see the
definition of GLIB_VAR in the glib headers).

The pkg-config file for glib doesn't define GLIB_STATIC_COMPILATION for
pkg-config --static.  I guess we must add it manually.

Does this work?

diff --git a/configure b/configure
index 99d8bec..10f23b7 100755
--- a/configure
+++ b/configure
@@ -3047,6 +3047,10 @@ if test "$modules" =3D yes; then
     glib_modules=3D"$glib_modules gmodule-2.0"
 fi
=20
+if test "$static" =3D yes; then
+    QEMU_CFLAGS=3D"-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
+fi
+
 for i in $glib_modules; do
     if $pkg_config --atleast-version=3D$glib_req_ver $i; then
         glib_cflags=3D$($pkg_config --cflags $i)

--QILrdhYozogw5Vly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz9+0AAoJEJykq7OBq3PIKakIAL3ZtOQhYlIanozuYthXNPk4
ISlaIuK9FYiOmr8ADAFrtAFaVph7QU4RDPAA2REkwZLzfvq6qfmtCBu7KFf1trI0
0RBrH2W/ka1J/5T1b185gAXihsYkG4QtWDOBQDMWUIktQpVw7JUs7enuMOUcWqMF
ktmxXcyLXWrBGtpDFEqxh8nrlRvuwq6Fo1j6f/Tl3yCa44rvt23siti7NkN10ds5
RRDw3dus7IOCtm11RjdNLQO7StRSW3em0Fm5Gk40lgnrMAB+Gn0vYMrHbg/PRIQh
2KVCMXOSAAyc2vOv2h7R6oTO+WdfdW6F3mcArXKm3mFUYtE7f68NfTZ57zVgYek=
=3vQL
-----END PGP SIGNATURE-----

--QILrdhYozogw5Vly--
