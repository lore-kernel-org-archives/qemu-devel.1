Received: from eggs.gnu.org ([2001:4830:134:3::10]:40326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKLfg-0002dL-Jw
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKLfb-0002rJ-ND
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:30:04 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKLfb-0002r4-D9
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:29:59 -0400
Received: by mail-wr0-x242.google.com with SMTP id v104so20564089wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 02:29:59 -0700 (PDT)
Date: Mon, 12 Jun 2017 10:29:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170612092946.GA3628@stefanha-x1.localdomain>
References: <20170508141536.20690-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20170508141536.20690-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/9] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>, stefanha@redhat.com


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 10:15:27AM -0400, Stefan Hajnoczi wrote:
> v6:
>  * Change bdrv_measure() return type to BlockMeasureInfo * [Eric]
>  * Clarify that holes in sparse POSIX files are still counted [Eric]
>=20
> v5:
>  * Use UINT64_MAX instead of ~0ULL [Berto]
>  * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
>    [Berto]
>=20
> v4:
>  * Make qcow2 refcount calculation conservative [Maor]
>  * Include actual qemu-img convert image size in test cases
>=20
> v3:
>  * Drop RFC, this is ready to go for QEMU 2.10
>  * Use "required size" instead of "required bytes" in qemu-img output for
>    consistency [Nir]
>  * Clarify BlockMeasureInfo semantics [Max]
>  * Clarify bdrv_measure() opts argument and error handling [Nir]
>  * Handle -o backing_file=3D for qcow2 [Max]
>  * Handle snapshot options in qemu-img measure
>  * Probe input image for allocated data clusters for qcow2.  Didn't centr=
alize
>    this because there are format-specific aspects such as the cluster_siz=
e.  It
>    may make sense to centralize it later (with a bit more complexity) if
>    support is added to more formats.
>  * Add qemu-img(1) man page section for 'measure' sub-command [Max]
>  * Extend test case to cover additional scenarios [Nir]
>=20
> RFCv2:
>  * Publishing RFC again to discuss the new user-visible interfaces.  Code=
 has
>    changed quite a bit, I have not kept any Reviewed-by tags.
>  * Rename qemu-img sub-command "measure" and API bdrv_measure() [Nir]
>  * Report both "required bytes" and "fully allocated bytes" to handle the=
 empty
>    image file and prealloc use cases [Nir and Dan]
>  * Use bdrv_getlength() instead of bdrv_nb_sectors() [Berto]
>  * Rename "err" label "out" in qemu-img-cmds.c [Nir]
>  * Add basic qcow2 support, doesn't support qemu-img convert from existin=
g files yet
>=20
> RFCv1:
>  * Publishing patch series with just raw support, no qcow2 yet.  Please r=
eview
>    the command-line interface and let me know if you are happy with this
>    approach.
>=20
> Users and management tools sometimes need to know the size required for a=
 new
> disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of =
time.
> Image formats like qcow2 have non-trivial metadata that makes it hard to
> estimate the exact size without knowledge of file format internals.
>=20
> This patch series introduces a new qemu-img sub-command that calculates t=
he
> required size for both image creation and conversion scenarios.
>=20
> The conversion scenario is:
>=20
>   $ qemu-img measure -f raw -O qcow2 input.img
>   required size: 1327680
>   fully allocated size: 1074069504
>=20
> Here an existing image file is taken and the output includes the space re=
quired
> for data from the input image file.
>=20
> The creation scenario is:
>=20
>   $ qemu-img measure -O qcow2 --size 5G
>   required size: 327680
>   fully allocated size: 1074069504
>=20
> Stefan Hajnoczi (9):
>   block: add bdrv_measure() API
>   raw-format: add bdrv_measure() support
>   qcow2: extract preallocation calculation function
>   qcow2: make refcount size calculation conservative
>   qcow2: extract image creation option parsing
>   qcow2: add bdrv_measure() support
>   qemu-img: add measure subcommand
>   qemu-iotests: support per-format golden output files
>   iotests: add test 178 for qemu-img measure
>=20
>  qapi/block-core.json             |  25 +++
>  include/block/block.h            |   2 +
>  include/block/block_int.h        |   2 +
>  block.c                          |  35 ++++
>  block/qcow2.c                    | 372 +++++++++++++++++++++++++++++----=
------
>  block/raw-format.c               |  26 +++
>  qemu-img.c                       | 228 ++++++++++++++++++++++++
>  qemu-img-cmds.hx                 |   6 +
>  qemu-img.texi                    |  30 ++++
>  tests/qemu-iotests/178           | 168 ++++++++++++++++++
>  tests/qemu-iotests/178.out.qcow2 | 278 +++++++++++++++++++++++++++++
>  tests/qemu-iotests/178.out.raw   | 146 +++++++++++++++
>  tests/qemu-iotests/check         |   5 +
>  tests/qemu-iotests/group         |   1 +
>  14 files changed, 1230 insertions(+), 94 deletions(-)
>  create mode 100755 tests/qemu-iotests/178
>  create mode 100644 tests/qemu-iotests/178.out.qcow2
>  create mode 100644 tests/qemu-iotests/178.out.raw

Ping ^ 2

Stefan

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZPl8KAAoJEJykq7OBq3PIfxwIAKOS2FLJf6YUPhw+ywFBIsYA
80xCWxDoWoblh0ZLByoZ2Eb1QizhL0NkKpVuO/w+ha0kkoBR2+k6XrAqp9t8zHd5
+15CO1M3oNNv93AxQFazIAvtWTMsTc5YfGwxMzc6aU7774vH7pk5JPl3GzkkWiTY
L36zJSl63ApBwnjtRxkIeXIVru9mWgbs5De0cNWe+REJ+Aqzditf9/FFZQQrv8Mp
+aY78l4ygMiAbkyFupE3FU4GlGZ9h3dhF86+el6pZKY1RNBhp/2Yw5981hYvnTYZ
hXZKKzgNYK+ClHVF6p2b/l99dIye6AxxhgjpWV2jA88dXukX1mMiP687XT/APzQ=
=DGqv
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
