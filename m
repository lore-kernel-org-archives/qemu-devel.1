Received: from eggs.gnu.org ([2001:4830:134:3::10]:48623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmNXX-0007hJ-Cc
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmNXU-000175-AZ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:37:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cmNXU-000165-2S
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:37:12 -0500
References: <1489141097-28587-1-git-send-email-he.chen@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89688700-069c-1700-b226-0c1e81203c76@redhat.com>
Date: Fri, 10 Mar 2017 10:37:08 -0600
MIME-Version: 1.0
In-Reply-To: <1489141097-28587-1-git-send-email-he.chen@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gPA1iHBce0WqRjsjmb0id0e5u6hvQSl8F"
Subject: Re: [Qemu-devel] [PATCH] x86: Allow to set NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gPA1iHBce0WqRjsjmb0id0e5u6hvQSl8F
From: Eric Blake <eblake@redhat.com>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <89688700-069c-1700-b226-0c1e81203c76@redhat.com>
Subject: Re: [PATCH] x86: Allow to set NUMA distance for different NUMA nodes
References: <1489141097-28587-1-git-send-email-he.chen@linux.intel.com>
In-Reply-To: <1489141097-28587-1-git-send-email-he.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2017 04:18 AM, He Chen wrote:
> Current, QEMU does not provide a clear command to set vNUMA distance fo=
r
> guest although we already have `-numa` command to set vNUMA nodes.
>=20

>=20
> This patch is going to add SLIT table support in QEMU, and provides
> addtional option `dist` for command `-numa` to allow user set vNUMA

s/addtional/additional/

> distance by QEMU command.
>=20
> With this patch, when a user wants to create a guest that contains
> several vNUMA nodes and also wants to set distance among those nodes,
> the QEMU command would like:
>=20
> ```
> -object memory-backend-ram,size=3D1G,prealloc=3Dyes,host-nodes=3D0,poli=
cy=3Dbind,id=3Dnode0 \
> -numa node,nodeid=3D0,cpus=3D0,memdev=3Dnode0 \
> -object memory-backend-ram,size=3D1G,prealloc=3Dyes,host-nodes=3D1,poli=
cy=3Dbind,id=3Dnode1 \
> -numa node,nodeid=3D1,cpus=3D1,memdev=3Dnode1 \
> -object memory-backend-ram,size=3D1G,prealloc=3Dyes,host-nodes=3D2,poli=
cy=3Dbind,id=3Dnode2 \
> -numa node,nodeid=3D2,cpus=3D2,memdev=3Dnode2 \
> -object memory-backend-ram,size=3D1G,prealloc=3Dyes,host-nodes=3D3,poli=
cy=3Dbind,id=3Dnode3 \
> -numa node,nodeid=3D3,cpus=3D3,memdev=3Dnode3 \
> -numa dist,a=3D0,b=3D1,val=3D21 \
> -numa dist,a=3D0,b=3D2,val=3D31 \
> -numa dist,a=3D0,b=3D3,val=3D41 \
> -numa dist,a=3D1,b=3D0,val=3D21 \
> ...
> ```


> +++ b/qapi-schema.json
> @@ -5647,7 +5647,7 @@
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node' ] }
> +  'data': [ 'node', 'dist' ] }

Missing documentation, including the fact that 'dist' is added in 2.10
(you've missed 2.9).

> =20
>  ##
> +# @NumaDistOptions:
> +#
> +# Set distance between 2 NUMA nodes. (for OptsVisitor)
> +#
> +# @a: first NUMA node.
> +#
> +# @b: second NUMA node.
> +#
> +# @val: NUMA distance between 2 given NUMA nodes.
> +#
> +# Since: 2.9

This is a new feature, but you've missed soft freeze; this will have to
be 2.10.

> +##
> +{ 'struct': 'NumaDistOptions',
> +  'data': {
> +   'a':   'uint8',
> +   'b':   'uint8',
> +   'val': 'uint8' }}

Using uint8 limits us to at most 256 numa nodes. Is that going to bite
us in the future?

Is 'a' and 'b' really the best naming convention to use (it's concise,
but maybe 'first' and 'second', or 'source' and 'destination' is better)?=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gPA1iHBce0WqRjsjmb0id0e5u6hvQSl8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwtY1AAoJEKeha0olJ0Nq+wAH/0X5hklKCW45KMi5P6BYf/r2
pJjPRK/AHMgEfT9YC+LdfYKFqQChqh62J4XDprRNlNNx1V57ek+2HGrsude+A/M9
ozBxsNgH5yG3S7Po6eq5YiMLrr+GI+T0OqlbQLlyS3+r4kJUMK9Y34gt8k02cWpt
IefX+84aNnZ/5vwGx8Rp8MhI53TmmGP3Z2O3zho+37XWcvoUw2URGWPUCzfDeXiU
KX1inCDoYv3KhIJV2JVZHJzDNSfoPGw+h9KehqY9mYC3iZKr7dKLPalD3kj2EJL/
eJPDS/+RxkdpbYGja+LdhFBqVMzn7Q8luqxcz6w32OvSogpIfCLI+e6qhTCWpkg=
=YjZ2
-----END PGP SIGNATURE-----

--gPA1iHBce0WqRjsjmb0id0e5u6hvQSl8F--
