Received: from eggs.gnu.org ([2001:4830:134:3::10]:49083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVcRu-0000Fd-9V
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVcRq-0007eO-5q
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVcRp-0007bf-S6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:38:22 -0400
References: <20170713100311.20037-1-f4bug@amsat.org>
	<20170713100311.20037-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f42b464e-6701-163f-dd88-9ada312f2fdf@redhat.com>
Date: Thu, 13 Jul 2017 06:38:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170713100311.20037-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1DOe1m1PWAuKoilsOmKFMJNN5eWV2LplL"
Subject: Re: [Qemu-devel] [RFC PATCH RESEND 1/2] scripts: helper to keep
 console alive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1DOe1m1PWAuKoilsOmKFMJNN5eWV2LplL
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f42b464e-6701-163f-dd88-9ada312f2fdf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH RESEND 1/2] scripts: helper to keep
 console alive
References: <20170713100311.20037-1-f4bug@amsat.org>
 <20170713100311.20037-2-f4bug@amsat.org>
In-Reply-To: <20170713100311.20037-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 05:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> useful to avoid Travis CI jobs getting killed after 10min of inactivity=
=2E
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS          |  1 +
>  scripts/aliveness.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100755 scripts/aliveness.sh
>=20

> +++ b/scripts/aliveness.sh
> @@ -0,0 +1,32 @@
> +#! /usr/bin/env sh

Overkill.  /bin/sh exists everywhere, the only need for using 'env' is
where a program does not have a reliable installation path across platfor=
ms.

> +#
> +# Send an "Alive!" message regularly to stderr
> +#
> +# Copyright (C) 2017 Philippe Mathieu-Daud=C3=A9
> +#
> +# Author: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU LGPL, version 2+.
> +# See the COPYING file in the top-level directory.
> +
> +TIMEOUT_S=3D$1
> +shift 1
> +{
> +  set -e
> +  while true
> +  do
> +    sleep ${TIMEOUT_S}
> +    echo "Alive!" >&2
> +  done
> +} &
> +WATCHDOG_PID=3D$!
> +
> +cleanup() {
> +    echo "killing watchdog ${WATCHDOG_PID}" >&2
> +    kill -TERM ${WATCHDOG_PID}
> +    exit $((1 - $#))

This looks odd - what are you really trying to accomplish here?  A
different exit status according to whether the watchdog exited normally
or was killed?  A reflection of the exit status of the command being run
in parallel with the watchdog?

> +}
> +trap cleanup INT

Don't you want to clean up on more than just INT?  The more typical
spelling is:

trap cleanup 0 1 2 3 15

> +
> +$*

Huh? Oh, you're expecting this to be called as "aliveness.sh $TIMEOUT
$command to run".  Some usage comments would be nice.

> +cleanup 0
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1DOe1m1PWAuKoilsOmKFMJNN5eWV2LplL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ1ulAAoJEKeha0olJ0NqxjoH/07oaiJOoKxdUMN5564DgggA
xFNxqFtdcCJfXU/SkwuJ96tYyAiLPsDLX1oROyUR8Wj24R2eJ4JpFMcEutL/Q6BF
4JQWWzwOI1fjABy6n3OWCU4U/WLp6eVYxiImrLVxNOeztLkkdNEs6yis6g0MDobj
GqpG15aLFQn752wzxkgAU+oWL/JHuEU819LcYSgiUwMGcSfYPNSreWYLSPMiUw8A
JUoKtYu1IIq16pCgC+nHCFxZ7ddQeKG+LOxK4yWD9lrcHSAFuca7LbzlvHeog1GX
V/AnPqM5Fl3aIX5kZ4jDrT0zxWvimHEsAHIOK10WK5UQLwCt05awY63KuDFbX2U=
=Xl6c
-----END PGP SIGNATURE-----

--1DOe1m1PWAuKoilsOmKFMJNN5eWV2LplL--
