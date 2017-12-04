Received: from eggs.gnu.org ([2001:4830:134:3::10]:38877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLz9S-0002iC-Jr
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLz9P-00040j-FJ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eLz9P-0003zr-6T
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:23:47 -0500
References: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
	<20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8435b741-1bfc-fbe8-baa8-00bc98e60e0f@redhat.com>
Date: Mon, 4 Dec 2017 23:23:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kMOLh1Xupxla6rdaUeCqXQ8QQgpAT7iI1"
Subject: Re: [Qemu-devel] [PATCH v4 1/1] tests/qemu-iotests: adding
 savevm/loadvm with postcopy flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kMOLh1Xupxla6rdaUeCqXQ8QQgpAT7iI1
From: Max Reitz <mreitz@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <8435b741-1bfc-fbe8-baa8-00bc98e60e0f@redhat.com>
Subject: Re: [PATCH v4 1/1] tests/qemu-iotests: adding savevm/loadvm with
 postcopy flag test
References: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
 <20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
In-Reply-To: <20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-04 16:17, Daniel Henrique Barboza wrote:
> This patch implements a test case for the scenario that was failing
> prior to the patch "migration/ram.c: do not set 'postcopy_running' in
> POSTCOPY_INCOMING_END", commit acab30b85d.
>=20
> This new test file 201 was derived from the test file 181 authored
> by Kevin Wolf.
>=20
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  tests/qemu-iotests/201     | 116 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/201.out |  23 +++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 140 insertions(+)
>  create mode 100755 tests/qemu-iotests/201
>  create mode 100644 tests/qemu-iotests/201.out
>=20
> diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
> new file mode 100755
> index 0000000000..9b6e23bbfc
> --- /dev/null
> +++ b/tests/qemu-iotests/201
> @@ -0,0 +1,116 @@
> +#!/bin/bash
> +#
> +# Test savevm and loadvm after live migration with postcopy flag
> +#
> +# Copyright (C) 2017, IBM Corporation.
> +#
> +# This file is derived from tests/qemu-iotests/181 by Kevin Wolf
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
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +status=3D1	# failure is the default!
> +
> +MIG_SOCKET=3D"${TEST_DIR}/migrate"
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +
> +_cleanup()
> +{
> +    rm -f "${MIG_SOCKET}"
> +    _cleanup_test_img
> +    _cleanup_qemu
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_supported_fmt qcow2
> +_supported_proto generic
> +_supported_os Linux

Sorry, I had to unqueue the patch again, because I only just saw there's
something like

> # Internal snapshots are (currently) impossible with refcount_bits=3D1 =
                                                                         =
                                                                         =
                     =20
> _unsupported_imgopts 'refcount_bits=3D1[^0-9]'

missing here (taken from 080).

(Without that, the test fails with
 $ ./check -T -qcow2 -o refcount_bits=3D1 201
)

I could have added it myself, but that seemed a bit too much of a change
to me...

Max

> +
> +size=3D64M
> +_make_test_img $size


--kMOLh1Xupxla6rdaUeCqXQ8QQgpAT7iI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlolyu8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhysH/0v57O3KhYVKrU20WOKuc3g5AWEBOCCN
MBmRx8LOMUuOw88oXIWBJXjO+qPeHTDIQiq43p6sEhNruOS5QwOX8mJD09PmUPT4
TuwRrvrtNAx4Q1AZ3USOSd5cQNGMqBIfBDd7oQdrh6xC1nlYQJY63nu0i7iT6lAj
wMntNwxugVOuStNSyXXVTIw9oWYDzgJepUQ3mShjZlnc0ai2VHHULewCcdAyU75a
NLTZmmUdWn3ipzMLekqJVg+WLyQX8R+kuQHUwr9rkDLJ8Q2O0MU8bn/aig/irxnY
NrgmjRD8X052R7kDsEQ6bAJiFtt8g1XZR4qyHQ6cZKuWhsD5i3fBxrc=
=Gha7
-----END PGP SIGNATURE-----

--kMOLh1Xupxla6rdaUeCqXQ8QQgpAT7iI1--
