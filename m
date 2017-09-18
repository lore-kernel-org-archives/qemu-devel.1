Received: from eggs.gnu.org ([2001:4830:134:3::10]:43882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxlA-0000uI-3D
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxl7-0000ov-DH
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtxl7-0000oG-4Y
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:14:53 -0400
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <949c1fef-4e95-ab61-02a6-b37ea7894006@redhat.com>
Date: Mon, 18 Sep 2017 10:14:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170918024402.3265-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mV00hIMmH1nTfAxTUtGBLDT379E4MB3qg"
Subject: Re: [Qemu-devel] [PATCH v8 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mV00hIMmH1nTfAxTUtGBLDT379E4MB3qg
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <949c1fef-4e95-ab61-02a6-b37ea7894006@redhat.com>
Subject: Re: [PATCH v8 03/13] scripts: Add archive-source.sh
References: <20170918024402.3265-1-famz@redhat.com>
 <20170918024402.3265-4-famz@redhat.com>
In-Reply-To: <20170918024402.3265-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/17/2017 09:43 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/archive-source.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>=20
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..8b373e3090
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +#
> +# Author: Fam Zheng <famz@redhat.com>
> +#
> +# Archive source tree, including submodules. This is created for test =
code to
> +# export the source files, in order to be built in a different enviorn=
ment,
> +# such as in a docker instance or VM.
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +
> +set -e

Do we want to rely on 'set -e'?  The alternative would be:

> +
> +if test $# -lt 1; then
> +    echo "Usage: $0 <output tarball>"
> +    exit 1
> +fi
> +
> +submodules=3D$(git submodule foreach --recursive --quiet 'echo $name')=

> +

=2E..Check here that the $() ran (rather than git being missing)

> +if test -n "$submodules"; then
> +    {
> +        git ls-files

=2E..and that this ran

> +        for sm in $submodules; do
> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> +        done
> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > =
"$1".list

=2E..and the grep

> +else
> +    git ls-files > "$1".list

=2E..and the git ls-files

> +fi
> +
> +tar -cf "$1" -T "$1".list

=2E..and the tar

> +rm "$1".list
>=20

I'm not opposed to the patch going in as-is; but I do like to flag
reliance on 'set -e' as it tends to NOT do what you think it does, and
ends up getting in the way more than it helps.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mV00hIMmH1nTfAxTUtGBLDT379E4MB3qg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/4uUACgkQp6FrSiUn
Q2rX9gf8DBtw745addwFkPDgBrhZNkY5jm0/1e+z3SkgJi8Sc9zmFuc80qkLwn2s
zzAevps8hiR34z/BQqT1BVqU50SPUWl1i8jwf7PqZ114EMem1Pw9qw83UtRQ6URY
5r/rLGBJLE0uZsA8vtc0u/NYLjcJHdz4wVoeBxH+hwaV2MDIy9arSwPQuW3/rLnO
bI+I6kwUjI0H/WWaWrQ1svwKspMzLwPqUezIIhSj1Vvua8fVzc5JQ8uBxf+mp/8W
0MgNpgp4RFnY5+Q/470EdogoHgl9GrrI1IUxEFTC+7NjGvB2bD1wqK0OVvDqArNe
zntQy2BmU5cf473PTrcbQArkGnEO7A==
=ZTCN
-----END PGP SIGNATURE-----

--mV00hIMmH1nTfAxTUtGBLDT379E4MB3qg--
