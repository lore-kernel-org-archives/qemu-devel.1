Received: from eggs.gnu.org ([2001:4830:134:3::10]:43456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsSBj-00052D-2N
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsSBf-0005B9-Tp
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:20:07 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:50357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsSBf-00059l-Kh
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:20:03 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4D0FBAC03F
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 13:20:02 +0200 (CEST)
Date: Thu, 14 Sep 2017 13:19:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170914131955.380099a8@bahia.lan>
In-Reply-To: <1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/JCL6l=3LiFeOHgNZhMwiIl2";
	protocol="application/pgp-signature"
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
Cc: eric blake <eblake@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

--Sig_/JCL6l=3LiFeOHgNZhMwiIl2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2017 06:40:06 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch factors out code to use the ThrottleLimits
> strurcture.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 78 +++-------------------------------------------=
------

Uhhh... what happened here ? Where did the lines go ? I've never reviewed t=
his
patch before...

>  1 file changed, 4 insertions(+), 74 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index bb11815..d0ccfda 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1826,84 +1826,13 @@
>  #
>  # @device: Block device name (deprecated, use @id instead)
>  #
> -# @id: The name or QOM path of the guest device (since: 2.8)
> -#
> -# @bps: total throughput limit in bytes per second
> -#
> -# @bps_rd: read throughput limit in bytes per second
> -#
> -# @bps_wr: write throughput limit in bytes per second
> -#
> -# @iops: total I/O operations per second
> -#
> -# @iops_rd: read I/O operations per second
> -#
> -# @iops_wr: write I/O operations per second
> -#
> -# @bps_max: total throughput limit during bursts,
> -#                     in bytes (Since 1.7)
> -#
> -# @bps_rd_max: read throughput limit during bursts,
> -#                        in bytes (Since 1.7)
> -#
> -# @bps_wr_max: write throughput limit during bursts,
> -#                        in bytes (Since 1.7)
> -#
> -# @iops_max: total I/O operations per second during bursts,
> -#                      in bytes (Since 1.7)
> -#
> -# @iops_rd_max: read I/O operations per second during bursts,
> -#                         in bytes (Since 1.7)
> -#
> -# @iops_wr_max: write I/O operations per second during bursts,
> -#                         in bytes (Since 1.7)
> -#
> -# @bps_max_length: maximum length of the @bps_max burst
> -#                            period, in seconds. It must only
> -#                            be set if @bps_max is set as well.
> -#                            Defaults to 1. (Since 2.6)
> -#
> -# @bps_rd_max_length: maximum length of the @bps_rd_max
> -#                               burst period, in seconds. It must only
> -#                               be set if @bps_rd_max is set as well.
> -#                               Defaults to 1. (Since 2.6)
> -#
> -# @bps_wr_max_length: maximum length of the @bps_wr_max
> -#                               burst period, in seconds. It must only
> -#                               be set if @bps_wr_max is set as well.
> -#                               Defaults to 1. (Since 2.6)
> -#
> -# @iops_max_length: maximum length of the @iops burst
> -#                             period, in seconds. It must only
> -#                             be set if @iops_max is set as well.
> -#                             Defaults to 1. (Since 2.6)
> -#
> -# @iops_rd_max_length: maximum length of the @iops_rd_max
> -#                                burst period, in seconds. It must only
> -#                                be set if @iops_rd_max is set as well.
> -#                                Defaults to 1. (Since 2.6)
> -#
> -# @iops_wr_max_length: maximum length of the @iops_wr_max
> -#                                burst period, in seconds. It must only
> -#                                be set if @iops_wr_max is set as well.
> -#                                Defaults to 1. (Since 2.6)
> -#
> -# @iops_size: an I/O size in bytes (Since 1.7)
> -#
>  # @group: throttle group name (Since 2.4)
>  #
>  # Since: 1.1
>  ##
>  { 'struct': 'BlockIOThrottle',
> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int=
',
> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr':=
 'int',
> -            '*bps_max': 'int', '*bps_rd_max': 'int',
> -            '*bps_wr_max': 'int', '*iops_max': 'int',
> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> -            '*iops_size': 'int', '*group': 'str' } }
> +  'base': 'ThrottleLimits',
> +  'data': { '*device': 'str', '*group': 'str' } }
> =20
>  ##
>  # @ThrottleLimits:
> @@ -1913,6 +1842,7 @@
>  # transaction. All fields are optional. When setting limits, if a field =
is
>  # missing the current value is not changed.
>  #
> +# @id:                     device id
>  # @iops-total:             limit total I/O operations per second
>  # @iops-total-max:         I/O operations burst
>  # @iops-total-max-length:  length of the iops-total-max burst period, in=
 seconds
> @@ -1942,7 +1872,7 @@
>  # Since: 2.11
>  ##
>  { 'struct': 'ThrottleLimits',
> -  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
> +  'data': { '*id' : 'str', '*iops-total' : 'int', '*iops-total-max' : 'i=
nt',
>              '*iops-total-max-length' : 'int', '*iops-read' : 'int',
>              '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
>              '*iops-write' : 'int', '*iops-write-max' : 'int',


--Sig_/JCL6l=3LiFeOHgNZhMwiIl2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbpl2wAKCRAC/DrrAQHb
wqA1AKCKjnU19Gf4+t67aCz4RRqR16d+OQCeLreoVSxwOs+PeuZutO5b+eT21XM=
=/M9v
-----END PGP SIGNATURE-----

--Sig_/JCL6l=3LiFeOHgNZhMwiIl2--
