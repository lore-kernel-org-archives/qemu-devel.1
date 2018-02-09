Received: from eggs.gnu.org ([2001:4830:134:3::10]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek8Lr-0005w1-Be
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek8Ln-0005AF-CT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:04:27 -0500
References: <20180209113744.11842-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
Date: Fri, 9 Feb 2018 14:04:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180209113744.11842-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hurKYqKXRYFXVfV3MXtJxgGMmvRlI6FYb"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Check the L1 table parameters from
 all internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hurKYqKXRYFXVfV3MXtJxgGMmvRlI6FYb
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
Subject: Re: [PATCH] qcow2: Check the L1 table parameters from all internal
 snapshots
References: <20180209113744.11842-1-berto@igalia.com>
In-Reply-To: <20180209113744.11842-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-09 12:37, Alberto Garcia wrote:
> The code that reads the qcow2 snapshot table takes the offset and size
> of all snapshots' L1 table without doing any kind of checks.
>=20
> Although qcow2_snapshot_load_tmp() does verify that the table size is
> valid, the table offset is not checked at all. On top of that there
> are several other code paths that deal with internal snapshots that
> don't use that function or do any other check.
>=20
> This patch verifies that all L1 tables are correctly aligned and the
> size does not exceed the maximum allowed valued.
>=20
> The check from qcow2_snapshot_load_tmp() is removed since it's now
> useless (opening an image will fail before that).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-snapshot.c     | 14 ++++++++++----
>  tests/qemu-iotests/080     | 10 +++++++++-
>  tests/qemu-iotests/080.out | 10 ++++++++--
>  3 files changed, 27 insertions(+), 7 deletions(-)

I don't like completely refusing to open a qcow2 image if one of the
snapshots is invalid, without giving the user any way of fixing it.

With this patch, the final two images created in 080 cannot be opened at
all (not even with qemu-img info).  Without it, you can, you just can't
load the snapshots.  (Well, in one case.  In the other, you can even do
that, but that's a bug, as you correctly claim.)

More importantly, though, without this patch, you can delete the
snapshots.  qemu-img will complain a bit, and you'll have leaks
afterwards, but that's nothing qemu-img check can't fix.  With this
patch, you can't, because the image cannot be opened at all so it's
basically gone for good (unless you get a hex editor).

Another thing is that the error messages are not really useful...
(which is already an issue, but this patch doesn't make it better.)

Max


--hurKYqKXRYFXVfV3MXtJxgGMmvRlI6FYb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp9nEYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AK3cIAJTiBZqlfqN0vc77fCIOeQNgdMT/kNnj
x2bOvL+lcnf9lDwRHMCigxNZKpzaRtd2O1GG2SeoAnf3OtVdleI1x8o5Xaw8LAtN
57NGI2CWNX/VK/Lbm1FMxiIavHPiLluz7BEcwuXTVQSisn3Uz7CTjxnlYP6CKg2v
oUGizVrnTNzxHojCI8aXxwWdRutE8DmzeEQ6JegweoOoIuykx3kbSPWz8Dv1gfbN
6HhjKmFXfjOZWMc294hz+BlecdZjsQiGY0X9R0VjtBwiuEK1fgEOMiaoxbZRkwXq
E950sE2w9qJlMoAnnh+njZktr0RLw6h9WVLxCfEAHClCL8fv13SZ50E=
=hnPu
-----END PGP SIGNATURE-----

--hurKYqKXRYFXVfV3MXtJxgGMmvRlI6FYb--
