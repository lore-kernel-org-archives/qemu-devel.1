Received: from eggs.gnu.org ([2001:4830:134:3::10]:42780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIAn4-0000nU-Re
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIAn0-0004eu-PK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:28:42 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIAn0-0004cS-JC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:28:38 -0400
Received: by mail-wm0-x22f.google.com with SMTP id d64so3683570wmf.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 02:28:35 -0700 (PDT)
Date: Tue, 6 Jun 2017 10:28:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170606092831.GA8013@stefanha-x1.localdomain>
References: <CALfaEa0MirxK6ESnepptGLiugYZBOSQVxe=R72h+c_-GBXkYzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <CALfaEa0MirxK6ESnepptGLiugYZBOSQVxe=R72h+c_-GBXkYzQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] split c and cxx extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruno Dominguez <bru.dominguez@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 02:07:26PM +0100, Bruno Dominguez wrote:
> There was no possibility to add specific cxx flags using the configure
> file. So A new entrance has been created to support it.
>=20
> Duplication of information in configure and rules.mak. Taking
> QEMU_CFLAGS and add them to QEMU_CXXFLAGS, now the value of
> QEMU_CXXFLAGS is stored in config-host.mak, so there is no need for
> it.
>=20
> The makefile for libvixl was adding flags for QEMU_CXXFLAGS in
> QEMU_CFLAGS because of the addition in rules.mak. That was removed, so
> adding them where it should be.
>=20
> -----
> Signed-off-by: Bruno Dominguez <bru.dominguez@gmail.com>
> -----

Please follow the code submission guidelines:
http://wiki.qemu.org/Contribute/SubmitAPatch

 * The commit message (email subject) should have a prefix describing
   the affected component.  Use "git log ./configure" for inspiration.
   I suggest the following:

     configure: split c and cxx extra flags

 * Use git-format-patch(1) so that your patch applies cleanly.  Your
   email has:

   ----
   Signed-off-by: ...
   ----

   This is not the format recognized by tools.  Instead the
   Signed-off-by: should be part of the commit description (no '----')
   and then a line with just three hyphens ('---') denotes the end of
   the commit description:

   Signed-off-by: ...
   ---

 * The email must not be line-wrapped since that breaks the patch.  If
   you use git-send-email(1) to submit patches then this is taken care
   of automatically.

> @@ -1304,6 +1312,7 @@ Advanced options (experts only):
>    --cxx=3DCXX                use C++ compiler CXX [$cxx]
>    --objcc=3DOBJCC            use Objective-C compiler OBJCC [$objcc]
>    --extra-cflags=3DCFLAGS    append extra C compiler flags QEMU_CFLAGS
> +  --extra-cxxflags=3DCXXFLAGS append extra CXX compiler flags QEMU_CXXFL=
AGS

For consistency with the --cxx=3D option description:

s/CXX compiler/C++ compiler/

> @@ -1489,37 +1498,6 @@ if test "$bogus_os" =3D "yes"; then
>      error_exit "Unrecognized host OS $targetos"
>  fi
>=20
> -# Check that the C++ compiler exists and works with the C compiler
> -if has $cxx; then
> -    cat > $TMPC <<EOF
> -int c_function(void);
> -int main(void) { return c_function(); }
> -EOF
> -
> -    compile_object
> -
> -    cat > $TMPCXX <<EOF
> -extern "C" {
> -   int c_function(void);
> -}
> -int c_function(void) { return 42; }
> -EOF
> -
> -    update_cxxflags
> -
> -    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $LDFLAGS; then
> -        # C++ compiler $cxx works ok with C compiler $cc
> -        :
> -    else
> -        echo "C++ compiler $cxx does not work with C compiler $cc"
> -        echo "Disabling C++ specific optional code"
> -        cxx=3D
> -    fi
> -else
> -    echo "No C++ compiler available; disabling C++ specific optional cod=
e"
> -    cxx=3D
> -fi
> -

Why move this code?

>=20
> Bruno
>=20

This signature will break tools that apply the patch.  It's easiest to
use git-send-email(1) to avoid problems like this.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZNnW/AAoJEJykq7OBq3PIlGgH/jmrZfuLgd+yfV3ebsWHFH79
tu89xUxw1jCoHtmZiTFVsOTK5ZH+axKE3zeIV88Dh22EjQ9NUmJMdXQ+ZUdvUzBG
DG9IRSaHOsy9j0LTQNtGqrUcChtpoj1tFnifVK+RFOwnGVfGGlUlyAdcmhb9XXrp
U8xdWiBEbYf8ks3utEkjvG9t6fhgSv98FbmQWvjFl/9FLGg/j65ClKP5vAwxR0kA
4P5rNjKPoNzKhLka7DjRoqC6Dao5DfLHacd1KSwbr3oNVRdjRQEIvnF4vn5A2da/
5IqvSD+kGWHzYWN6P7OIx8LdrttISm/vTMMFcowDnuUJEC9qHGTgarh7Eg2/eWg=
=veB6
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
