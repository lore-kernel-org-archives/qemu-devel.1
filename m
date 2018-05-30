Received: from eggs.gnu.org ([2001:4830:134:3::10]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO0KO-0004Qw-VD
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO0KO-0002pO-4L
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:35:45 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <14e14e4f-4d43-9c94-7dd6-c295a09b6432@redhat.com>
Date: Wed, 30 May 2018 14:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="68nlLsyZQV59XHrrC3RPY6gUrWjD6r3dr"
Subject: Re: [Qemu-devel] [PATCH 00/17] iotests: don't choke on disabled
 drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--68nlLsyZQV59XHrrC3RPY6gUrWjD6r3dr
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <14e14e4f-4d43-9c94-7dd6-c295a09b6432@redhat.com>
Subject: Re: [PATCH 00/17] iotests: don't choke on disabled drivers
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> Some iotests assume availability of certain block drivers, and fail if
> the driver is not supported by QEMU because it was disabled at configur=
e
> time.
>=20
> This series tries to address that, by making QEMU report the actual lis=
t
> of supported block drivers in response to "-drive format=3D?", and usin=
g
> this information to skip the parts of the io testsuite that can not be
> run in this configuration.
>=20
> Roman Kagan (17):
>   block: iterate_format with account of whitelisting
>   iotests: iotests.py: prevent deadlock in subprocess
>   iotests: ask qemu for supported formats
>   iotest 030: skip quorum test setup/teardown too
>   iotest 030: require blkdebug
>   iotest 055: skip unsupported backup target formats
>   iotest 055: require blkdebug
>   iotest 056: skip testcases using blkdebug if disabled
>   iotest 071: notrun if blkdebug or blkverify is disabled
>   iotest 081: notrun if quorum is disabled
>   iotest 087: notrun if null-co is disabled
>   iotest 093: notrun if null-co or null-aio is disabled
>   iotest 099: notrun if blkdebug or blkverify is disabled
>   iotest 124: skip testcases using blkdebug if disabled
>   iotest 139: skip testcases using disabled drivers
>   iotest 147: notrun if nbd is disabled
>   iotest 184: notrun if null-co or throttle is disabled
>=20
>  include/block/block.h         |  2 +-
>  block.c                       | 23 ++++++++++++++++++----
>  blockdev.c                    |  4 +++-
>  qemu-img.c                    |  2 +-
>  tests/qemu-iotests/030        |  7 +++++++
>  tests/qemu-iotests/055        | 13 ++++++++++++
>  tests/qemu-iotests/056        |  3 +++
>  tests/qemu-iotests/071        |  1 +
>  tests/qemu-iotests/081        |  1 +
>  tests/qemu-iotests/087        |  1 +
>  tests/qemu-iotests/093        |  1 +
>  tests/qemu-iotests/099        |  1 +
>  tests/qemu-iotests/124        |  5 +++++
>  tests/qemu-iotests/139        |  4 ++++
>  tests/qemu-iotests/147        |  1 +
>  tests/qemu-iotests/184        |  1 +
>  tests/qemu-iotests/common.rc  | 19 ++++++++++++++++++
>  tests/qemu-iotests/iotests.py | 46 ++++++++++++++++++++++++++++++++---=
--------
>  18 files changed, 117 insertions(+), 18 deletions(-)

I'll stop reviewing this series for now, because there are more iotests
that use drivers outside of their format/protocol combination.

For instance:

$ grep -l null-co ??? | wc -l
15
$ grep -l blkdebug ??? | wc -l
30
$ (grep -l '"raw"' ???; grep -l "'raw'" ???) | wc -l
22

As I've written in my reply to patch 8, I'm not sure whether it's the
right solution to check for the availability of these block drivers in
every single test that needs them.  It makes sense for quorum, because
quorum needs an external library for hashing, so it may not be trivial
to enable.  But it does not seem too useful for other formats that do
not have such a dependency (e.g. null-co, blkdebug, raw).

The thing is that it's OK to whitelist everything for testing, and then
disable some drivers when building a release.  I don't think one needs
to run the iotests with the release version if the whole difference is
whether some drivers have been disabled or not.

Max


--68nlLsyZQV59XHrrC3RPY6gUrWjD6r3dr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOmpYACgkQ9AfbAGHV
z0CGaQf/XksGN9atDj7NWK9TKKj4crXzRswVtasinQ6oErgCgEAVl749yiaM97NU
hdHk/11/eti8+bJLXFO8Ts/WacOQcRXmrs9u4nRGSxVw57POJya01SwwKmRkKByq
CFy6rmrnw+SM/vQ0ig9e4m0q8p8/uJYnHP9q3hO3wtobp53YWngZ6kvVWS5Bo1dY
n9yJD22yccpd+unbADZzcQ3XWANUaeTnC55C+gTxki+imgiiaqZo5iqjnqKIuR0r
NIhz0zckNUxy0+/jWjAtbMGxnZBDHwGLKqAypqPX6Iz/MmUmwg4DjhEC5PRRSaKg
SwmG+5ABURJ4J1o0SigTy2+gpRYEHg==
=AMoW
-----END PGP SIGNATURE-----

--68nlLsyZQV59XHrrC3RPY6gUrWjD6r3dr--
