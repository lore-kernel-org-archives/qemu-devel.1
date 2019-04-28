Received: from eggs.gnu.org ([209.51.188.92]:50098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKshp-0004i5-UV
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKsho-0007Iq-K0
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:55:33 -0400
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
Date: Mon, 29 Apr 2019 00:55:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190402153730.54145-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nkDe19NtnX0dms35SobhN9BjQiGecCibO"
Subject: Re: [Qemu-devel] [PATCH v5 01/10] tests/perf: Test qemu-img convert
 from raw to encrypted qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nkDe19NtnX0dms35SobhN9BjQiGecCibO
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
Subject: Re: [PATCH v5 01/10] tests/perf: Test qemu-img convert from raw to
 encrypted qcow2
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/perf/block/qcow2/convert-to-encrypted | 48 +++++++++++++++++++++=

>  1 file changed, 48 insertions(+)
>  create mode 100755 tests/perf/block/qcow2/convert-to-encrypted

Thanks for the test case, but I don=E2=80=99t know whether this is the ri=
ght way
to include it.

A concrete problem is that it doesn=E2=80=99t work with out-of-tree build=
s (I
only do out-of-tree builds).  I wonder whether it would be possible and
make sense (I have no idea) to add a subdirectory "perf" to the iotests
and reuse its infrastructure?  Those tests wouldn=E2=80=99t run by defaul=
t.

Max

> diff --git a/tests/perf/block/qcow2/convert-to-encrypted b/tests/perf/b=
lock/qcow2/convert-to-encrypted
> new file mode 100755
> index 0000000000..7a6b7b1cab
> --- /dev/null
> +++ b/tests/perf/block/qcow2/convert-to-encrypted
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +#
> +# Test qemu-img convert from raw to encrypted qcow2
> +#
> +# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved=
=2E
> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +
> +if [ "$#" -lt 2 ]; then
> +    echo "Usage: $0 SOURCE_FILE DESTINATION_FILE [additional qemu-img =
convert parameters]"
> +    exit 1
> +fi
> +
> +ROOT_DIR=3D"$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../.." >/dev=
/null 2>&1 && pwd )"
> +QEMU_IMG=3D"$ROOT_DIR/qemu-img"
> +QEMU_IO=3D"$ROOT_DIR/qemu-io"
> +
> +size=3D1G
> +
> +src=3D"$1"
> +shift
> +
> +dst=3D"$1"
> +shift
> +
> +(
> +# create source
> +$QEMU_IMG create -f raw "$src" $size
> +$QEMU_IO -f raw -c "write -P 0xa 0 $size" "$src"
> +
> +# create target
> +$QEMU_IMG create -f qcow2 --object secret,id=3Dsec0,data=3Dtest -o enc=
rypt.format=3Dluks,encrypt.key-secret=3Dsec0 "$dst" $size
> +) > /dev/null
> +
> +# test with additional parameters left in $@
> +/usr/bin/time -f %e $QEMU_IMG convert "$@" -f raw --object secret,id=3D=
sec0,data=3Dtest --target-image-opts -n "$src" "driver=3Dqcow2,file.filen=
ame=3D$dst,encrypt.key-secret=3Dsec0"
>=20



--nkDe19NtnX0dms35SobhN9BjQiGecCibO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzGL1oACgkQ9AfbAGHV
z0Dv1gf9Fgb33NPbFmkgMoU+ruqbe1qnNS2ijYN+zyLQ4/STFN3HmTCgYydagZr1
c11XUgm1+DPpQRwAX+mc3vKCsHI6paoPDCnq55VssKd3Tx2mkygTrC6AIUdWBojJ
flA/sizxYXGq0QAY7I3UbTFoLlbBJ2ABhwQ2rVPoNrlqcMNLmLwlKYaXXRFHR02b
zXXFdib9IMqOB4ijLO9EoWNIa+UbLOwGlYpfkRbSawxgMtjT1veOfAa0UYfGsYU/
Pz1m2XHzfRUSt49qLe3bx37aukbakyX//VrrCs4pPynBzMujz8Pc37ZtJbXVTCWR
+g2p3/02n1dMllNC2RACQgY/E/wcSA==
=gH2V
-----END PGP SIGNATURE-----

--nkDe19NtnX0dms35SobhN9BjQiGecCibO--
