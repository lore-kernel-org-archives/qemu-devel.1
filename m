Received: from eggs.gnu.org ([2001:4830:134:3::10]:52315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5ngU-00057I-4C
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5ngQ-0004tC-Sz
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:22:46 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:39259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d5ngQ-0004sn-Io
	for qemu-devel@nongnu.org; Wed, 03 May 2017 02:22:42 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B6AFFE8B94
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 08:22:39 +0200 (CEST)
Date: Wed, 3 May 2017 08:22:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170503082232.1cd2ac92@bahia>
In-Reply-To: <1493735386-39622-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-2-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/+5EfUopAGM4JAnOBwBLkfA_";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] Throttle: Create IOThrottle
 structure
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

--Sig_/+5EfUopAGM4JAnOBwBLkfA_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

s/Throttle/throttle

On Tue,  2 May 2017 10:29:43 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patchset introduces a new io throttle structure. This will be

s/patchset/patch

> used in both block and fsdev devices.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  qapi/block-core.json | 76 ++--------------------------------------------
>  qapi/iothrottle.json | 86 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 89 insertions(+), 73 deletions(-)
>  create mode 100644 qapi/iothrottle.json
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 87fb747..93d346b 100644
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
> @@ -1760,84 +1761,13 @@
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
> index 0000000..124ab40
> --- /dev/null
> +++ b/qapi/iothrottle.json
> @@ -0,0 +1,86 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D=3D QAPI IOThrottle definitions
> +##
> +# @IOThrottle:
> +#
> +# A set of parameters describing iothrottle

s/iothrottle/IO throttling/

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


--Sig_/+5EfUopAGM4JAnOBwBLkfA_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkJdygACgkQAvw66wEB28IYmwCeOwYMJNPL+9BAGPYqckt7qjLb
8iYAnRlxM/oMulvLkHXkAO94jwEMlOXn
=yIEK
-----END PGP SIGNATURE-----

--Sig_/+5EfUopAGM4JAnOBwBLkfA_--
