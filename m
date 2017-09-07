Received: from eggs.gnu.org ([2001:4830:134:3::10]:34308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpwzi-0000em-CH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpwzd-0004HD-Hl
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpwzd-0004Gc-94
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:37:17 -0400
References: <20170907081158.4063-1-famz@redhat.com>
	<20170907081158.4063-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c839e15b-c486-fd7b-f3f6-deb1b7eb85f1@redhat.com>
Date: Thu, 7 Sep 2017 08:37:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170907081158.4063-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="67tKXikd0H519PB8JSsOVM68R7bBAq1dL"
Subject: Re: [Qemu-devel] [PATCH 2/2] docker: Enable features explicitly in
 test-full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--67tKXikd0H519PB8JSsOVM68R7bBAq1dL
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c839e15b-c486-fd7b-f3f6-deb1b7eb85f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] docker: Enable features explicitly in
 test-full
References: <20170907081158.4063-1-famz@redhat.com>
 <20170907081158.4063-3-famz@redhat.com>
In-Reply-To: <20170907081158.4063-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2017 03:11 AM, Fam Zheng wrote:
> Also avoid "set -e".
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-full | 80 ++++++++++++++++++++++++++++++++++++++++++=
++++----
>  1 file changed, 75 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/docker/test-full b/tests/docker/test-full
> index 05f0d491d1..bd095ad91b 100755
> --- a/tests/docker/test-full
> +++ b/tests/docker/test-full
> @@ -1,8 +1,8 @@
> -#!/bin/bash -e
> +#!/bin/bash

When you drop 'set -e'...

>  #
> -# Compile all the targets.
> +# Compile all the targets with as many features enabled as possible
>  #
> -# Copyright (c) 2016 Red Hat Inc.
> +# Copyright 2016, 2017 Red Hat Inc.
>  #
>  # Authors:
>  #  Fam Zheng <famz@redhat.com>
> @@ -15,5 +15,75 @@
> =20
>  cd "$BUILD_DIR"

=2E..then you should explicitly check for failure after commands where yo=
u
really do not want to continue execution if they failed.  I'd write this:=


cd "$BUILD_DIR" || exit 1

or else use && to chain it to...

> =20
> -build_qemu
> -make check $MAKEFLAGS
> +build_qemu \
> +    --enable-attr \

> +    --enable-xfsctl \
> +&& make check $MAKEFLAGS

the rest of your chain.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--67tKXikd0H519PB8JSsOVM68R7bBAq1dL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxS4YACgkQp6FrSiUn
Q2r3fQf/eiE08t0grVNRZ4w2h0fUgblsp12q33qfFOU4OKufUKzE30ylHpRCEZ7E
i4mz4Q4DPqXoi5w8GDNl9q5OVwsx24yS2No6GlZX1/CGeKV9QVpkW02oHTrkS3zL
bjYaReCaJwmA3FHUj4fGkbR6No5ctb0DV+OU3oDmjnR2WfXmFFdGDOoFQ9gkXf46
63regUtXm5VttBxEquTdxpMC0kmOXF3NQp7R+mqjBEEYRrQak5z1X7BdrK2wSIsM
1Cqvhqy9OrKQeNBC0C1PgNNoYZQoV2QVbHOAlrVv/4RwzEVO+N6062KJfv8ZUXlp
5SgZyepoY0jy8a8O897H/5K8xWCaHQ==
=zkYv
-----END PGP SIGNATURE-----

--67tKXikd0H519PB8JSsOVM68R7bBAq1dL--
