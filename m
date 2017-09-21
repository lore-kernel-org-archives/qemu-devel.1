Received: from eggs.gnu.org ([2001:4830:134:3::10]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv3Is-0001dx-8I
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv3Ip-0000s7-H3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:22:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dv3Ip-0000rr-7g
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:22:11 -0400
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfa1fda4-78d2-664a-1fb4-eb46b9c74dba@redhat.com>
Date: Thu, 21 Sep 2017 10:22:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170921150755.19914-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="86kfXX6aGPpDUbmmdkAxlWBETDDfQHdfG"
Subject: Re: [Qemu-devel] [PATCH v11 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--86kfXX6aGPpDUbmmdkAxlWBETDDfQHdfG
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <dfa1fda4-78d2-664a-1fb4-eb46b9c74dba@redhat.com>
Subject: Re: [PATCH v11 03/13] scripts: Add archive-source.sh
References: <20170921150755.19914-1-famz@redhat.com>
 <20170921150755.19914-4-famz@redhat.com>
In-Reply-To: <20170921150755.19914-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2017 10:07 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/archive-source.sh | 51 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>=20
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..8aa363d3a0
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,51 @@
> +#!/bin/bash
> +#
> +# Author: Fam Zheng <famz@redhat.com>
> +#
> +# Archive source tree, including submodules. This is created for test =
code to
> +# export the source files, in order to be built in a different enviorn=
ment,

s/enviornment/environment/

> +# such as in a docker instance or VM.
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +
> +error() {
> +    echo "$@" >&2

slightly risky if $@ contains \ - using 'printf %s\\n "$*"' is nicer.
But this particular script can get away with it, as I don't see use of \
(other than if you have a weird $0).

> +
> +if test -n "$submodules"; then
> +    {
> +        git ls-files || error "git ls-files failed"
> +        for sm in $submodules; do
> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> +            if test "${PIPESTATUS[0]} ${PIPESTATUS[1]}" !=3D "0 0"; th=
en

Could shorten to "${PIPESTATUS[*]}", as discussed in another mail, but
this works too.

With the typo fixed, and your choice of how to handle my other two nits
(including doing nothing),
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--86kfXX6aGPpDUbmmdkAxlWBETDDfQHdfG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnD2RsACgkQp6FrSiUn
Q2poUgf+O3pL4cPV3HZW4utfGzgt06lfG6/GyajXyVkc4v9wUfeN1qsUpDU5klJu
7F1w2KK9qNQR8EjVpbTnnxQzDyYVX+2AfWqzcPZ2MfeiM1C2TKzhnS8yKc7zQCko
IlFdYZCcrJJTXU6kguyX4t55pnE2ltuVIk70ep8BXxYF+9cQeESwzQVax7a6sBLB
4SU23DACUUeAAvFQoVvmhH6uLLq3JB2POAz2Pa0sioeKIXTv5ggEb/zLonSOkdCd
wYK8XcTMFojAECZA8mcDLcB+wKmeenx1rrkMaL8p3XztlIj5yZyb6rYHO6pafYlw
RJJN2MU+xEY8MdVOs5Ke32CTrtuVeQ==
=97y1
-----END PGP SIGNATURE-----

--86kfXX6aGPpDUbmmdkAxlWBETDDfQHdfG--
