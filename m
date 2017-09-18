Received: from eggs.gnu.org ([2001:4830:134:3::10]:39271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dtyYO-0002db-1d
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dtyYK-0001pW-Rx
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:05:48 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:44173)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dtyYK-0001kt-AQ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:05:44 -0400
Date: Mon, 18 Sep 2017 19:04:34 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170918160434.cfkm7jlg3oig25qj@postretch>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qsst5tvyn4hjp5bc"
Content-Disposition: inline
In-Reply-To: <1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>


--qsst5tvyn4hjp5bc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 06:40:06AM -0400, Pradeep Jagadeesh wrote:
>This patch factors out code to use the ThrottleLimits
>strurcture.
>
>Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>Reviewed-by: Greg Kurz <groug@kaod.org>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>Reviewed-by: Alberto Garcia <berto@igalia.com>
>Reviewed-by: Markus Armbruster <armbru@redhat.com>
>---
> qapi/block-core.json | 78 +++--------------------------------------------=
-----
> 1 file changed, 4 insertions(+), 74 deletions(-)
>
>diff --git a/qapi/block-core.json b/qapi/block-core.json
>index bb11815..d0ccfda 100644
>--- a/qapi/block-core.json
>+++ b/qapi/block-core.json
>@@ -1826,84 +1826,13 @@
> #
> # @device: Block device name (deprecated, use @id instead)
> #
>-# @id: The name or QOM path of the guest device (since: 2.8)
>-#
>-# @bps: total throughput limit in bytes per second
>-#
>-# @bps_rd: read throughput limit in bytes per second
>-#
>-# @bps_wr: write throughput limit in bytes per second
>-#
>-# @iops: total I/O operations per second
>-#
>-# @iops_rd: read I/O operations per second
>-#
>-# @iops_wr: write I/O operations per second
>-#
>-# @bps_max: total throughput limit during bursts,
>-#                     in bytes (Since 1.7)
>-#
>-# @bps_rd_max: read throughput limit during bursts,
>-#                        in bytes (Since 1.7)
>-#
>-# @bps_wr_max: write throughput limit during bursts,
>-#                        in bytes (Since 1.7)
>-#
>-# @iops_max: total I/O operations per second during bursts,
>-#                      in bytes (Since 1.7)
>-#
>-# @iops_rd_max: read I/O operations per second during bursts,
>-#                         in bytes (Since 1.7)
>-#
>-# @iops_wr_max: write I/O operations per second during bursts,
>-#                         in bytes (Since 1.7)
>-#
>-# @bps_max_length: maximum length of the @bps_max burst
>-#                            period, in seconds. It must only
>-#                            be set if @bps_max is set as well.
>-#                            Defaults to 1. (Since 2.6)
>-#
>-# @bps_rd_max_length: maximum length of the @bps_rd_max
>-#                               burst period, in seconds. It must only
>-#                               be set if @bps_rd_max is set as well.
>-#                               Defaults to 1. (Since 2.6)
>-#
>-# @bps_wr_max_length: maximum length of the @bps_wr_max
>-#                               burst period, in seconds. It must only
>-#                               be set if @bps_wr_max is set as well.
>-#                               Defaults to 1. (Since 2.6)
>-#
>-# @iops_max_length: maximum length of the @iops burst
>-#                             period, in seconds. It must only
>-#                             be set if @iops_max is set as well.
>-#                             Defaults to 1. (Since 2.6)
>-#
>-# @iops_rd_max_length: maximum length of the @iops_rd_max
>-#                                burst period, in seconds. It must only
>-#                                be set if @iops_rd_max is set as well.
>-#                                Defaults to 1. (Since 2.6)
>-#
>-# @iops_wr_max_length: maximum length of the @iops_wr_max
>-#                                burst period, in seconds. It must only
>-#                                be set if @iops_wr_max is set as well.
>-#                                Defaults to 1. (Since 2.6)
>-#
>-# @iops_size: an I/O size in bytes (Since 1.7)
>-#
> # @group: throttle group name (Since 2.4)

BlockIOThrottle and ThrottleLimits are not directly compatible, for=20
example here we have iops_rd_max_length as a name,

> #
> # Since: 1.1
> ##
> { 'struct': 'BlockIOThrottle',
>-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
>-            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': =
'int',
>-            '*bps_max': 'int', '*bps_rd_max': 'int',
>-            '*bps_wr_max': 'int', '*iops_max': 'int',
>-            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>-            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>-            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>-            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>-            '*iops_size': 'int', '*group': 'str' } }
>+  'base': 'ThrottleLimits',
>+  'data': { '*device': 'str', '*group': 'str' } }
>
> ##
> # @ThrottleLimits:
>@@ -1913,6 +1842,7 @@
> # transaction. All fields are optional. When setting limits, if a field is
> # missing the current value is not changed.
> #
>+# @id:                     device id
> # @iops-total:             limit total I/O operations per second
> # @iops-total-max:         I/O operations burst
> # @iops-total-max-length:  length of the iops-total-max burst period, in =
seconds
>@@ -1942,7 +1872,7 @@
> # Since: 2.11
> ##
> { 'struct': 'ThrottleLimits',
>-  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
>+  'data': { '*id' : 'str', '*iops-total' : 'int', '*iops-total-max' : 'in=
t',
>             '*iops-total-max-length' : 'int', '*iops-read' : 'int',
>             '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
>             '*iops-write' : 'int', '*iops-write-max' : 'int',

And here it's iops-read-max-length. This breaks the block layer's old=20
throttling API. Do we want the old API replaced for 2.11? I don't know=20
which maintainer is responsible for this, so I CC'd armbru.

--qsst5tvyn4hjp5bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlm/7pIACgkQc2J8L2kN
9xBluw/9GzmBb638I87sBGPuJ1O1cvE+P0VWQ0dEQGiyf8iygW2QgMOpx+vVxBeE
y8cQn8w64bf5C4GshHb0HSxMZxctAgP2wU5HWAW0grWAmbiRF9/8TwZahU4caL7O
oKphdYr22cz12sXA57JFDCOuw7zXyqmTGgCL1yl+WZS3JnVXdAVwPnGU7a17zTXD
BNFo8Jmc5a4cXYw+Hnuh8J7wy5kT9vgzSZy4tljlYZa8vNburgSaj3WN6ncVMnbN
D2LqJFKyi4rAe+UhR4rrM1bgMS9gbd6x+cTS/e/XelJxbbIeQIgiC7mcaT4SGcph
BULoAHSnA5mPy8GYxKBDExe8dpw1QCi627lCtgLu/ajiqJipi9RidZeZnPRMCAWW
2Vq6sFDOiR7xyidCD3tzhRWjfJXwJvECC+vx0EB2LWPBX8o9TLfnCr/fTPwMU3+f
pLy3NacW08cVhJxeBuuor651ib7k3Sw5P5Pp7Kq4n4oIDrmtwVzWx5CJHcnkN3CO
AQURPjspid15vQRwnyO9YKoXxhbVVsm+IoweY22vP8wTxGKo2nZyj5c83mPvi+ul
RpoWBDRGtNaraSntrLqUXV1yetgUcVP3vx2kfaL1fHUE6etnl4bEQgqRMgiAWYtu
KANX1Y70yViWU/FcTcecFQ9JgmTjS4EaLRZ28mGlsSFuhxDa+Pw=
=BeQX
-----END PGP SIGNATURE-----

--qsst5tvyn4hjp5bc--
