Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dihB8-0004Lz-Kp
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dihB4-0004QR-Jm
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:19:10 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dihB4-0004QI-BP
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:19:06 -0400
Received: by mail-lf0-x244.google.com with SMTP id w199so6278406lff.2
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 06:19:04 -0700 (PDT)
Date: Fri, 18 Aug 2017 14:18:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170818131853.GB17654@stefanha-x1.localdomain>
References: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
Subject: Re: [Qemu-devel] Memory use with >100 virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 03:39:20PM +1000, Alexey Kardashevskiy wrote:
> ==94451== -------------------- 4 of 10 --------------------
> ==94451== max-live:    314,649,600 in 150 blocks
> ==94451== tot-alloc:   314,649,600 in 150 blocks (avg size 2097664.00)
> ==94451== deaths:      none (none of these blocks were freed)
> ==94451== acc-ratios:  0.00 rd, 0.00 wr  (0 b-read, 0 b-written)
> ==94451==    at 0x4895600: memalign (in
> /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
> ==94451==    by 0x48957E7: posix_memalign (in
> /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
> ==94451==    by 0xB744AB: qemu_try_memalign (oslib-posix.c:106)
> ==94451==    by 0xA92053: qemu_try_blockalign (io.c:2493)
> ==94451==    by 0xA34DDF: qcow2_do_open (qcow2.c:1365)
> ==94451==    by 0xA35627: qcow2_open (qcow2.c:1526)
> ==94451==    by 0x9FB94F: bdrv_open_driver (block.c:1109)
> ==94451==    by 0x9FC413: bdrv_open_common (block.c:1365)
> ==94451==    by 0x9FF823: bdrv_open_inherit (block.c:2542)
> ==94451==    by 0x9FFC17: bdrv_open (block.c:2626)
> ==94451==    by 0xA71027: blk_new_open (block-backend.c:267)
> ==94451==    by 0x6D3E6B: blockdev_init (blockdev.c:588)

This allocation is unnecessary.  Most qcow2 files are not encrypted so
s->cluster_data does not need to be allocated upfront.

I'll send a patch.

Stefan

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZluk9AAoJEJykq7OBq3PIa1IH/3phP/qGW4n5XoU0m/MwVWyk
qZK3huJD7OMMxG6mePecjC78ropQClseWcBoXTWCFu0GDMYAEZkTr9tQnjtlGXiJ
AA2VyioATqGby6DYX9mGIrVsXfo8dNg5EQAvhBqbk7ynTJ+osxr4kzBxiMq2e4nI
en5JodM6X+zXs46a3/P55bXgTnSIEgumJEPj0nGeAcui4eTkhqjdeSnmz1rjTHi8
OPl3R7KkqYuhy0oFZ1jQC3oUJUlM7oYXoN03+mAuqA4HW5I+MHqUorjkCiNyotr3
QU01NUX4kvY9zosoxPXr+FfSEWtpmRZYjh5MGCupHicGdUzRTdTug1d46jR9nV4=
=j2Xk
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
