Received: from eggs.gnu.org ([2001:4830:134:3::10]:38836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNLQx-0004r1-0v
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNLQt-0003uM-Re
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:15 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNLQt-0003t4-HY
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:11 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 00D3A5CA20
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 17:51:09 +0200 (CEST)
Date: Tue, 20 Jun 2017 17:51:03 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620175103.2b48fb75@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1497877896-35700-3-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1497877896-35700-3-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/O2sz_GuUA3JBpEr7Oj=0Wp2";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 2/5] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani
	kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/O2sz_GuUA3JBpEr7Oj=0Wp2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jun 2017 09:11:33 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch enables qmp interfaces for the fsdev
> devices. This provides two interfaces one=20
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>=20

No blank line here.

> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json | 76 ++-------------------------------------------
>  qapi/iothrottle.json | 88 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 91 insertions(+), 73 deletions(-)
>  create mode 100644 qapi/iothrottle.json
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f85c223..9320974 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -6,6 +6,7 @@
> =20
>  # QAPI common definitions
>  { 'include': 'common.json' }
> +{ 'include': 'iothrottle.json' }
> =20
>  ##
>  # @SnapshotInfo:
> @@ -1761,84 +1762,13 @@
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
> +  'base': 'IOThrottle',
> +  'data': { '*device': 'str', '*group': 'str' } }
> =20
>  ##
>  # @block-stream:
> diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
> new file mode 100644
> index 0000000..0f067c3
> --- /dev/null
> +++ b/qapi/iothrottle.json
> @@ -0,0 +1,88 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D=3D QAPI IOThrottle definitions
> +##
> +
> +##
> +# @IOThrottle:
> +#
> +# A set of parameters describing IO throttling
> +#
> +# @id: The name or QOM path of the guest device (since: 2.8)
> +#
> +# @bps: total throughput limit in bytes per second
> +#
> +# @bps_rd: read throughput limit in bytes per second
> +#
> +# @bps_wr: write throughput limit in bytes per second
> +#
> +# @iops: total I/O operations per second
> +#
> +# @iops_rd: read I/O operations per second
> +#
> +# @iops_wr: write I/O operations per second
> +#
> +# @bps_max: total throughput limit during bursts,
> +#                     in bytes (Since 1.7)
> +#
> +# @bps_rd_max: read throughput limit during bursts,
> +#                        in bytes (Since 1.7)
> +#
> +# @bps_wr_max: write throughput limit during bursts,
> +#                        in bytes (Since 1.7)
> +#
> +# @iops_max: total I/O operations per second during bursts,
> +#                      in bytes (Since 1.7)
> +#
> +# @iops_rd_max: read I/O operations per second during bursts,
> +#                         in bytes (Since 1.7)
> +#
> +# @iops_wr_max: write I/O operations per second during bursts,
> +#                         in bytes (Since 1.7)
> +#
> +# @bps_max_length: maximum length of the @bps_max burst
> +#                            period, in seconds. It must only
> +#                            be set if @bps_max is set as well.
> +#                            Defaults to 1. (Since 2.6)
> +#
> +# @bps_rd_max_length: maximum length of the @bps_rd_max
> +#                               burst period, in seconds. It must only
> +#                               be set if @bps_rd_max is set as well.
> +#                               Defaults to 1. (Since 2.6)
> +#
> +# @bps_wr_max_length: maximum length of the @bps_wr_max
> +#                               burst period, in seconds. It must only
> +#                               be set if @bps_wr_max is set as well.
> +#                               Defaults to 1. (Since 2.6)
> +#
> +# @iops_max_length: maximum length of the @iops burst
> +#                             period, in seconds. It must only
> +#                             be set if @iops_max is set as well.
> +#                             Defaults to 1. (Since 2.6)
> +#
> +# @iops_rd_max_length: maximum length of the @iops_rd_max
> +#                                burst period, in seconds. It must only
> +#                                be set if @iops_rd_max is set as well.
> +#                                Defaults to 1. (Since 2.6)
> +#
> +# @iops_wr_max_length: maximum length of the @iops_wr_max
> +#                                burst period, in seconds. It must only
> +#                                be set if @iops_wr_max is set as well.
> +#                                Defaults to 1. (Since 2.6)
> +#
> +# @iops_size: an I/O size in bytes (Since 1.7)
> +#
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'IOThrottle',
> +  'data': { '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
> +            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr':=
 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> +            '*iops_size': 'int' } }


--Sig_/O2sz_GuUA3JBpEr7Oj=0Wp2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllJRGcACgkQAvw66wEB28IM1QCfWk4dY5+Uk5j2YeN0TL9OLnzh
F8cAn3vmyrJB/Ay2DD3avuIM4mLcopJy
=AzE5
-----END PGP SIGNATURE-----

--Sig_/O2sz_GuUA3JBpEr7Oj=0Wp2--
