Received: from eggs.gnu.org ([209.51.188.92]:44034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBdh-0004gl-2j
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBdc-0001Lb-UJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:39:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkBdX-0001FO-BM
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:39:29 -0500
References: <1547745248-1750-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <336eb7de-0713-af5e-b1b4-54bec55d6753@redhat.com>
Date: Thu, 17 Jan 2019 11:39:22 -0600
MIME-Version: 1.0
In-Reply-To: <1547745248-1750-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B4478gGoAAeAYCZyUVhw3diqNmnm8tBhk"
Subject: Re: [Qemu-devel] [PATCH] configure: Add a proper check for
 openpty() in libutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B4478gGoAAeAYCZyUVhw3diqNmnm8tBhk
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <336eb7de-0713-af5e-b1b4-54bec55d6753@redhat.com>
Subject: Re: [PATCH] configure: Add a proper check for openpty() in libutil
References: <1547745248-1750-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547745248-1750-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 11:14 AM, Thomas Huth wrote:
> On Linux (and maybe some BSDs), we require libutil for the openpty()
> function. However, this library is not available on some other systems,=
 so
> we currently use a fragile if-statement in the configure script to chec=
k
> whether we need the library or not. Unfortunately, we also hard-coded a=

> "-lutil" in the tests/Makefile.include file, so this breaks the build o=
n
> Solaris, for example (see buglink below). To fix the issue, add the "-l=
util"
> to "libs_tools" in the configure script instead, then this gets properl=
y
> propagated to the tests, too.
> And while we're at it, also replace the fragile if-statement in the con=
fi-
> gure script with a proper link-check for the availablity of this functi=
on.

Interesting that you split "confi-" and "gure" across lines, I guess to
appear less ragged.

s/availablity/availability/

>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1777252
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure              | 12 ++++++++++--
>  tests/Makefile.include |  4 ----
>  2 files changed, 10 insertions(+), 6 deletions(-)

Feature-based testing is always better than hard-coded knowledge ;)

> -if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$solaris" !=3D=
 yes -a \
> -        "$haiku" !=3D "yes" ; then
> +# Check whether we need to link libutil for openpty()
> +cat > $TMPC << EOF
> +extern int openpty(int *am, int *as, char *name, void *termp, void *wi=
np);
> +int main(void) { return openpty(0, 0, 0, 0, 0); }
> +EOF
> +
> +if ! compile_prog "" "" ; then
> +  if compile_prog "" "-lutil" ; then
>      libs_softmmu=3D"-lutil $libs_softmmu"
> +    libs_tools=3D"-lutil $libs_tools"
> +  fi
>  fi

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--B4478gGoAAeAYCZyUVhw3diqNmnm8tBhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAvcoACgkQp6FrSiUn
Q2qfkAgApX9lLQuoDCZ0V1Py/LtRmTuolQuTFqKmVrpFvuqReXj1AiPRXhtsktkG
yMvsOLz5fVzJlNedl1bJCvDb+gpLTe/DQC3r8YjFuPkQ+o1677eOxKSB22oo0Eh+
xoUDJYn1ijnYe8sgk7ai1xxHPneRNo+SvH2f1G4YPtUaRydnZwOO8vY1qUaINCe6
YgYmSLnQuPJ4BKrsXczSwYCbFh8hn1HB1nF/Xlf9DuZxuUIBhB/RlTburhGgfbcf
I11GBbIvh8H+p+9xPfy4Rfr3hy45sDJIiGV8wgn5C38jzXX/I22CJKU6n52BG0+l
vn2EZzZx2JyiqMsod+a6IxpNA47lnw==
=4ACA
-----END PGP SIGNATURE-----

--B4478gGoAAeAYCZyUVhw3diqNmnm8tBhk--
