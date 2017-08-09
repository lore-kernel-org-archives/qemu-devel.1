Received: from eggs.gnu.org ([2001:4830:134:3::10]:56145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfTJA-0005MS-D4
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfTJ9-0002Vt-CE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:54:08 -0400
Date: Wed, 9 Aug 2017 16:53:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809155355.GA8330@stefanha-x1.localdomain>
References: <20170808175711.12203-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20170808175711.12203-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/4] IDE: Do not flush empty
 drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 01:57:07PM -0400, John Snow wrote:
> Patches one and two here are a 2.10 bandaid that avoids a crash.
> Patches three and four are a more comprehensive fix as written by
> Kevin in another discussion and are being posted here for the sake
> of a discussion.
>=20
> Patch three as written causes hangs in iotests 20, 39, 97, 98, 129,
> 153, 176, and 185. 124 actually segfaults.
>=20
> For the purposes of 2.10, we'll likely just want patches 1 and 2
> for now.
>=20
> The problem in a nutshell: incrementing the in-flight counter of the
> BDS from the BB layer assumes that every BB always has a BDS. That's
> not true; and some devices like IDE have not in the past checked to
> see if a given blk_ operation WOULD fail.
>=20
> This culminates in a new regression where issuing a cache flush to a
> CDROM (which is, for some reason, specification valid) will crash QEMU
> due to a null dereference when attempting to atomically increment that
> backend's in-flight counter.
>=20
> John Snow (1):
>   IDE: Do not flush empty CDROM drives
>=20
> Kevin Wolf (3):
>   IDE: test flush on empty CDROM
>   block-backend: shift in-flight counter to BB from BDS
>   block-backend: test flush op on empty backend
>=20
>  block.c                    |  2 +-
>  block/block-backend.c      | 40 +++++++++++++++++++++++++-----
>  hw/ide/core.c              | 11 +++++---
>  tests/Makefile.include     |  2 ++
>  tests/ide-test.c           | 19 ++++++++++++++
>  tests/test-block-backend.c | 62 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 125 insertions(+), 11 deletions(-)
>  create mode 100644 tests/test-block-backend.c

John will be offline until Monday.  I'm sending a new patch series for
2.10 with updated versions of Patch 1 & 2.

Stefan

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZizATAAoJEJykq7OBq3PIWv0H/2rHVq57GPu/6eIjksKRIwtc
mpPDkRay8EdZ38tikhzlcu3FHE9efbRGW6XA0lFTorubnn1WhQEH5dvKYL6s3NhD
CHxGUZ+aXmMRNKOjghze5gmo08z5qno1VXVmnMlKpLNav1pKEnn4s0xR/homnwkL
PkgbYDV/PyA95WH2QNUq/DBfKSIPtRCBEJVTExSPhlFk//h/6UAehEUd1LOZgaY4
tip1jun/mszT8l+QR9azOPQ4ypCDC84Sro/4oXP8s1Q3JPJu4AeTSFcO8kJ9W+Y0
NIbZryOVFCSvUd4hL35nTnC1X+mguKrCIwW0/yl/DIH82QxddrNexqT8UpNvue8=
=/mad
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
