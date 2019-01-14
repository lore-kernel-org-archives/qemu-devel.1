Received: from eggs.gnu.org ([209.51.188.92]:48171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj84H-0006RQ-I9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj84G-0001MT-I3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:38:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gj84G-0001M2-8t
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:38:40 -0500
References: <20190111153451.14304-1-tao3.xu@intel.com>
	<20190111153451.14304-5-tao3.xu@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <859ba7db-4129-1f8b-f4e4-8609f2d3755d@redhat.com>
Date: Mon, 14 Jan 2019 13:38:34 -0600
MIME-Version: 1.0
In-Reply-To: <20190111153451.14304-5-tao3.xu@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U3D62lgsXbIXcNVG21AjRzhmr3sRccmYs"
Subject: Re: [Qemu-devel] [PATCH v2 4/9] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U3D62lgsXbIXcNVG21AjRzhmr3sRccmYs
From: Eric Blake <eblake@redhat.com>
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net
Message-ID: <859ba7db-4129-1f8b-f4e4-8609f2d3755d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/9] Extend the command-line to provide
 memory latency and bandwidth information
References: <20190111153451.14304-1-tao3.xu@intel.com>
 <20190111153451.14304-5-tao3.xu@intel.com>
In-Reply-To: <20190111153451.14304-5-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 9:34 AM, Tao Xu wrote:
> From: Liu Jingqi <jingqi.liu@intel.com>
>=20
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>=20
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  numa.c          | 124 ++++++++++++++++++++++++++++++++++++++++++++++++=

>  qapi/misc.json  |  92 ++++++++++++++++++++++++++++++++++-
>  qemu-options.hx |  28 ++++++++++-
>  3 files changed, 241 insertions(+), 3 deletions(-)

> +++ b/qapi/misc.json
> @@ -2746,10 +2746,12 @@
>  #
>  # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>  #
> +# @hmat-lb: memory latency and bandwidth information (Since: 2.13)

s/2.13/4.0/ (probably in multiple spots in your series)


> +##
> +# @HmatLBMemoryHierarchy:
> +#
> +# The memory hierarchy in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT
> +#
> +# @memory: the structure represents the memory performance
> +#
> +# @last-level: last level memory of memory side cached memory
> +#
> +# @1st-level: first level memory of memory side cached memory
> +#
> +# @2nd-level: second level memory of memory side cached memory
> +#
> +# @3rd-level: third level memory of memory side cached memory

Let's spell these first-level, second-level, third-level (rather than
adding even more spots where we have enums with leading digits)

> +#
> +# Since: 2.13
> +##
> +{ 'enum': 'HmatLBMemoryHierarchy',
> +  'data': [ 'memory', 'last-level', '1st-level',
> +            '2nd-level', '3rd-level' ] }
> +
> +##
> +# @HmatLBDataType:
> +#
> +# Data type in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT
> +#
> +# @access-latency: access latency
> +#
> +# @read-latency: read latency
> +#
> +# @write-latency: write latency
> +#
> +# @access-bandwidth: access bandwitch
> +#

s/bandwitch/bandwidth/

> +# @read-bandwidth: read bandwidth
> +#
> +# @write-bandwidth: write bandwidth

All 6 of these should probably list their units.

> +#
> +# Since: 2.13
> +##
> +{ 'enum': 'HmatLBDataType',
> +  'data': [ 'access-latency', 'read-latency', 'write-latency',
> +            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] =
}
> +
> +##
> +# @NumaHmatLBOptions:
> +#
> +# Set the system locality latency and bandwidth information
> +# between Initiator and Target proximity Domains.
> +#
> +# @initiator: the Initiator Proximity Domain.
> +#
> +# @target: the Target Proximity Domain.
> +#
> +# @hierarchy: the Memory Hierarchy. Indicates the performance
> +#             of memory or side cache.
> +#
> +# @data-type: presents the type of data, access/read/write
> +#             latency or hit latency.
> +#
> +# @base-lat: the base unit for latency in nanoseconds.
> +#
> +# @base-bw: the base unit for bandwidth in megabytes per second(MB/s).=

> +#
> +# @latency: the value of latency based on Base Unit from @initiator
> +#           to @target proximity domain.
> +#
> +# @bandwidth: the value of bandwidth based on Base Unit between
> +#             @initiator and @target proximity domain.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'NumaHmatLBOptions',
> +  'data': {
> +   'initiator': 'uint16',
> +   'target': 'uint16',
> +   'hierarchy': 'HmatLBMemoryHierarchy',
> +   'data-type': 'HmatLBDataType',
> +   '*base-lat': 'uint64',
> +   '*base-bw': 'uint64',
> +   '*latency': 'uint16',
> +   '*bandwidth': 'uint16' }}
> +
>  ##
>  # @HostMemPolicy:
>  #


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--U3D62lgsXbIXcNVG21AjRzhmr3sRccmYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw85ToACgkQp6FrSiUn
Q2rR7wf/cue6faxwnp4GZuXMuucAiVRI0PDIytrlG6vZHQ6Qu0ZfOD2lJAUUBGEU
FUOJGTVmGtADiq/GzwK/hj0bfW5aOhaB3AmrsRONIYTdt5VGBPA/H9Y4WfI8sLVN
R7Ow/t+KdHJdMbLpAZ9RvBvojRP28b/zdAA3dVxoiuVukYZW+ooFbu1qFycPk4vN
VN8DBgPo4F9vat+hRwZwh8mFVOG1hDkBb00Yfepd9zYlxMAKzwXeA5qDaqP6VFvI
0dvy3NGh+vp5BxzHhsRcmbLYroNRcQNvMIuE0Q8EuLDunh/zouqrodebQfxo43Q4
WU06GAWKqMkd6XBG2kxCT5kvSMb34g==
=JFDK
-----END PGP SIGNATURE-----

--U3D62lgsXbIXcNVG21AjRzhmr3sRccmYs--
