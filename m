Received: from eggs.gnu.org ([2001:4830:134:3::10]:53300)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dhuov-00076X-8h
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dhuos-000293-5X
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:41:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:56811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dhuor-00028O-PU
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:40:58 -0400
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-8-famz@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <1278039f-cf0c-ae69-7bc0-2fc45fdf98c4@gmx.com>
Date: Wed, 16 Aug 2017 11:31:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170816072104.24420-8-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0AGqni8DN8ANKxAf01U5EFcjD7Reu85JN"
Subject: Re: [Qemu-devel] [PATCH RFC 7/9] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0AGqni8DN8ANKxAf01U5EFcjD7Reu85JN
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com,
 pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <1278039f-cf0c-ae69-7bc0-2fc45fdf98c4@gmx.com>
Subject: Re: [PATCH RFC 7/9] tests: Add NetBSD image
References: <20170816072104.24420-1-famz@redhat.com>
 <20170816072104.24420-8-famz@redhat.com>
In-Reply-To: <20170816072104.24420-8-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.2017 09:21, Fam Zheng wrote:
> The image is prepared following instructions as in:
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/netbsd | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100755 tests/vm/netbsd
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> new file mode 100755
> index 0000000000..4cd07d3b1b
> --- /dev/null
> +++ b/tests/vm/netbsd
> @@ -0,0 +1,44 @@
> +#!/usr/bin/env python
> +#
> +# NetBSD VM image
> +#
> +# Copyright (C) 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  Se=
e
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import sys
> +import logging
> +import subprocess
> +import tempfile
> +import time
> +import basevm
> +
> +class NetBSDVM(basevm.BaseVM):
> +    name =3D "netbsd"
> +    BUILD_SCRIPT =3D """
> +        set -e;
> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        tar -xf /dev/ld1a;
> +        ./configure --python=3Dpython2.7 {configure_opts};
> +        gmake -j{jobs};
> +        gmake check;
> +    """
> +
> +    def build_image(self, img, rebuild=3DFalse):
> +        if os.path.exists(img) and not rebuild:
> +            return
> +        cimg =3D self._download_with_cache("http://localhost:8000/netb=
sd.img.xz")

http://download.patchew.org/netbsd.img.xz

> +        img_tmp_xz =3D img + ".tmp.xz"
> +        img_tmp =3D img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["mv", img_tmp, img])
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(basevm.main(NetBSDVM))
>=20



--0AGqni8DN8ANKxAf01U5EFcjD7Reu85JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZlBDcAAoJEEuzCOmwLnZsAooP/2Us+9cNlWdtGMDny/tb/rTk
i1RMzEFFO0AaA3g+qB0sMuaDL2jOP5FfRfuAUxfUBfJu2wLkfi4NOW7B77pidzPd
1IkRNcbdbY9hmHpDRqZ1Gq9v7X2RFhA1XZOJPzvHz36c9LxNRttbUPVMzQ9MxhNy
D97wZ5Fi6EatCY7V0osytvKFajM+9WU3u8BEk0pM79m2DZz5fgRZdxYr/oWcT9b/
V54ulx81WzGte3aSDDMDZCjHEEo8ctTqBqwH9lCGGU1sY0jozZ38A10IA8YiK7HS
+TDMf0W1MNEpN3LKCnslEnabzcfqoPmbu7WUtcdMOfJQvHc5WspzosoWeX/QQRTX
m63Q2+rjfcXoQs713bH+/4VMeyrosqaaJoByrnf/zLPSLZh7Onr3bRsgT+B6vTZ/
//S0fg72WezM+locq636/rS7pK7X2OYjrifIbLeQHWtE73pFj63Nr9w7o/seSo2n
j0crZcgDNQthGvxsOt5oltaBEO13FiO6aUra3awCAPAIfB04Yvsad1wvC1Hj5EZW
E2XCzJIA3BfUNaqotbmZ+jzEl2NMkGQRKsJ0WB9BHttexn6rXNiWt4letwHF3WrR
1g/OgvwqSIWC3Eex0sstDZk5x7F71sHm6E8u1QU3AGjpIGma6oJaG3Bz987xN+B/
5ScENljyJJqYPab+gyTt
=T49f
-----END PGP SIGNATURE-----

--0AGqni8DN8ANKxAf01U5EFcjD7Reu85JN--
