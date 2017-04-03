Received: from eggs.gnu.org ([2001:4830:134:3::10]:53467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7Bc-0007sk-Ea
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7BZ-0003za-D9
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cv7BZ-0003zO-4C
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:58:41 -0400
References: <1491042326-24335-1-git-send-email-he.chen@linux.intel.com>
	<20170403083851.u6f7ktakdqtmzwhj@kamzik.brq.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d69719c-914e-0538-e816-7a613a6af95e@redhat.com>
Date: Mon, 3 Apr 2017 13:58:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170403083851.u6f7ktakdqtmzwhj@kamzik.brq.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F1vHlx4PkDE7M6pUBnAbom5htDa42LvRo"
Subject: Re: [Qemu-devel] [PATCH v4] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, He Chen <he.chen@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F1vHlx4PkDE7M6pUBnAbom5htDa42LvRo
From: Eric Blake <eblake@redhat.com>
To: Andrew Jones <drjones@redhat.com>, He Chen <he.chen@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <3d69719c-914e-0538-e816-7a613a6af95e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] Allow setting NUMA distance for different
 NUMA nodes
References: <1491042326-24335-1-git-send-email-he.chen@linux.intel.com>
 <20170403083851.u6f7ktakdqtmzwhj@kamzik.brq.redhat.com>
In-Reply-To: <20170403083851.u6f7ktakdqtmzwhj@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 03:38 AM, Andrew Jones wrote:
> On Sat, Apr 01, 2017 at 06:25:26PM +0800, He Chen wrote:
>> Current, QEMU does not provide a clear command to set vNUMA distance f=
or
>> guest although we already have `-numa` command to set vNUMA nodes.
>>

>> +++ b/qapi-schema.json
>> @@ -5644,10 +5644,14 @@
>>  ##
>>  # @NumaOptionsType:
>>  #
>> +# @node: NUMA nodes configuration
>> +#
>> +# @dist: NUMA distance configuration
>> +#

Missing a '(since 2.10)' tag on @dist.


>>  ##
>> +# @NumaDistOptions:
>> +#
>> +# Set the distance between 2 NUMA nodes.
>> +#
>> +# @src: source NUMA node.
>> +#
>> +# @dst: destination NUMA node.
>> +#
>> +# @val: NUMA distance from source node to destination node.

Missing mention of the magic of 255.

>> +#
>> +# Since: 2.10
>> +##
>> +{ 'struct': 'NumaDistOptions',
>> +  'data': {
>> +   'src': 'uint16',
>> +   'dst': 'uint16',
>> +   'val': 'uint8' }}
>> +

Is a user allowed to pass { "src":0, "dst":0, "val":11 }, or do you
hard-validate that the diagonal of the matrix is always 10 (the user can
omit it, but if specified it must be 10).  Do you enforce that no
distance is less than 10?

>> +@var{source} and @var{destination} are NUMA node IDs.
>> +@var{distance} is the NUMA distance from @var{source} to @var{destina=
tion}.
>> +The distance from node A to node B may be different from the distance=
 from
>> +node B to node A as the distance can to be asymmetrical. If a node is=

>> +unreachable, set 255 as distance.
>=20
> The distance from a node to itself is always 10.  If no distance values=

> are given for node pairs, then the default distance of 20 is used for e=
ach
> pair.  If any pair of nodes is given a distance, then all pairs must be=

> given distances.  Although, when distances are only given in one direct=
ion
> for each pair of nodes, then the distances in the opposite directions a=
re
> assumed to be the same.  If, however, an asymmetrical pair of distances=
 is
> given for even one node pair, then all node pairs must be provided
> distance values for both directions, even when they are symmetrical.  W=
hen
> a node is unreachable from another node, set the pair's distance to 255=
=2E

I don't like duplication where it is not necessary, but don't know if
there's an easy way to make the .json file and qemu-options.hx refer to
one another, since they both feed separate user-visible documentation.
So you may have to repeat some of this in the .json file (such as my
mention above that at least documenting that 255 is special).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--F1vHlx4PkDE7M6pUBnAbom5htDa42LvRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4ptbAAoJEKeha0olJ0NqHQEIAKEOB0aIKYDYNhy/z5/6g86C
n2+hssSICimWDodKHpMIwi99FrmVsjkIHTTkPARMcF1WbsA0wQEiWyGe1lWgLaq6
RyvLS88sVKi2w6uzXGzlsMDeMcoriKAGEhWmip/wavGIwl3EGmdXywQMIq6Io0dk
YaNEtGz9yWgZwHwrj7NqhDaRH+U5DGgvbDvmZWwGPyiyTAldSdc6vOpqsOhH4+Fz
i5YYWd9iRJbDNce+sBuaZ46oRFT+HYjeVWlnSu3LHbzH8QcXV2QrJsK4vD2t+sVX
e96rH3zBmm1kstw1+neCw76Ofll+9T97PgxOcNZZTBX7tUiKHbh1gv558X4FcfA=
=3uiu
-----END PGP SIGNATURE-----

--F1vHlx4PkDE7M6pUBnAbom5htDa42LvRo--
