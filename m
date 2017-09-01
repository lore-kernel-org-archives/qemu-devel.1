Received: from eggs.gnu.org ([2001:4830:134:3::10]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqmm-00028r-KD
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqmj-0007Rh-Gt
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqmj-0007RB-86
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:35:17 -0400
References: <20170901152200.5953-1-famz@redhat.com>
	<20170901152200.5953-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc1cf740-09d8-edfd-c953-e559395363cd@redhat.com>
Date: Fri, 1 Sep 2017 13:35:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170901152200.5953-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EiNgTbJdAHftqc9XEQ1mVfh823UCKsFn3"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kchamart@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EiNgTbJdAHftqc9XEQ1mVfh823UCKsFn3
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kchamart@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dc1cf740-09d8-edfd-c953-e559395363cd@redhat.com>
Subject: Re: [PATCH v3 3/3] docker: Add test-block
References: <20170901152200.5953-1-famz@redhat.com>
 <20170901152200.5953-4-famz@redhat.com>
In-Reply-To: <20170901152200.5953-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 10:22 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-block | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100755 tests/docker/test-block
>=20
> diff --git a/tests/docker/test-block b/tests/docker/test-block
> new file mode 100755
> index 0000000000..efc77b4b91
> --- /dev/null
> +++ b/tests/docker/test-block
> @@ -0,0 +1,22 @@
> +#!/bin/bash -e

'set -e' is awful; it exists for backwards-compatibility with shell
scripts that pre-date functions, but is NOT intuitive and generally does
NOT do what you want when shell functions are added to the mix.  You're
better off doing manual error checking than relying on 'set -e' to check
for errors on your behalf.

> +#
> +# Run block test cases
> +#
> +# Copyright (c) 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +. common.rc

Are we sure that '.' is early enough on $PATH that this will pick up the
right common.rc? Safer is '. ./common.rc'.

> +
> +cd "$BUILD_DIR"
> +
> +build_qemu --target-list=3Dx86_64-softmmu
> +cd tests/qemu-iotests
> +for t in raw qcow2 nbd luks; do
> +    ./check -g quick -$t
> +done

That said, this script (and common.rc) is small enough to verify that
you probably aren't going to trip over those non-intuitive 'set -e'
behaviors, so the real reason to avoid it is if we want to be able to
copy-and-paste into other scripts that aren't using 'set -e' (on the
premise that avoiding implicit global state, like 'set -e', and being
explicit instead, is a good thing).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EiNgTbJdAHftqc9XEQ1mVfh823UCKsFn3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpqGAACgkQp6FrSiUn
Q2q6EggAhpPbR11T0hXHKVOWKHeejrjKuXq9YZbUd3f2rOVUjnjOO19R9IXkW5Jg
FSS12RPEKNnshKFCATxvlCBVSZa+GMRfAQ7kfYc6sJaTwUraBYMhQtUR2KslyE0Y
hhAdC94ts6qNc5/oOtOFUA7u2I6LekVZ9n7rm0KpX/jJKzFcnEHWDkvQHNHc6W5V
dSCz2gmdNwWVCli1rkBJx6yzNp9DhFShQfttR8VnnUOiPkqpfKIB2OQXCo+LnM65
TqQiJdcehV+EcVnCEmA5jmBtMNLgLa+n4g8kSkmC4XWLAk4eQO3X1B0m6QB0zEdZ
qUyX0/lIEO26dbvlS4AHGpUu6ksxwQ==
=m/ql
-----END PGP SIGNATURE-----

--EiNgTbJdAHftqc9XEQ1mVfh823UCKsFn3--
