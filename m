Received: from eggs.gnu.org ([2001:4830:134:3::10]:53837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhuqB-0008C0-Du
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhuqA-0003Ns-H1
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:42:19 -0400
Date: Wed, 16 Aug 2017 12:41:35 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170816094135.beufpqce3v4amhl3@postretch>
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udp2cy2v6fppw6x4"
Content-Disposition: inline
In-Reply-To: <6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--udp2cy2v6fppw6x4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 05:12:42PM -0500, Eric Blake wrote:
>On 08/15/2017 02:45 AM, Manos Pitsidianakis wrote:
>> block-insert-node and its pair command block-remove-node provide runtime
>> insertion and removal of filter nodes.
>>
>> block-insert-node takes a (parent, child) and (node, child) pair of
>> edges and unrefs the (parent, child) BdrvChild relationship and creates
>> a new (parent, node) child with the same BdrvChildRole.
>>
>> This is a different approach than x-blockdev-change which uses the driver
>> methods bdrv_add_child() and bdrv_del_child(),
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block.c                    |  192 ++++++++
>>  blockdev.c                 |   44 ++
>>  include/block/block.h      |    6 +
>>  qapi/block-core.json       |   60 +++
>>  tests/qemu-iotests/193     |  241 ++++++++++
>>  tests/qemu-iotests/193.out | 1116 +++++++++++++++++++++++++++++++++++++=
+++++++
>>  tests/qemu-iotests/group   |    1 +
>>  7 files changed, 1660 insertions(+)
>>  create mode 100755 tests/qemu-iotests/193
>>  create mode 100644 tests/qemu-iotests/193.out
>
>You may want to look at using scripts/git.orderfile, to rearrange your
>patch so that interface changes (.json, .h) occur before implementation
>(.c).  For now, I'm just focusing on the interface:

Thanks for the tip, I will use it from now on!
>
>
>> +++ b/qapi/block-core.json
>> @@ -3947,3 +3947,63 @@
>>    'data' : { 'parent': 'str',
>>               '*child': 'str',
>>               '*node': 'str' } }
>> +
>> +##
>> +# @block-insert-node:
>> +#
>> +# Insert a filter node between a specific edge in the block driver stat=
e graph.
>> +# @parent:  the name of the parent node or device
>> +# @node:    the name of the node to insert under parent
>> +# @child:   the name of the child of both node and parent
>
>Is this always going to be between two existing nodes, or can this
>command also be used to insert at the end of the chain (for example, if
>parent or child is omitted)?

If this is used for filter nodes, I suppose only between would make=20
sense (for now). Is there a use case for the latter?
>
>
>> +#    }
>> +# <- { 'return': {} }
>> +#
>> +##
>
>Missing 'Since: 2.11'.
>
>> +{ 'command': 'block-insert-node',
>> +  'data': { 'parent': 'str',
>> +             'child': 'str',
>> +             'node': 'str'} }
>
>For now, it looks like you require all arguments, and therefore this is
>always insertion in the middle.
>
>> +##
>> +# @block-remove-node:
>> +#
>> +# Remove a filter node between two other nodes in the block driver stat=
e graph.
>> +# @parent:  the name of the parent node or device
>> +# @node:    the name of the node to remove from parent
>> +# @child:   the name of the child of node which will go under parent
>> +##
>> +{ 'command': 'block-remove-node',
>> +  'data': { 'parent': 'str',
>> +             'child': 'str',
>> +             'node': 'str'} }
>
>Likewise missing 2.11.
>
>Overall I'm not seeing problems with the interface from the UI
>perspective, but I have not been paying close attention to your larger
>efforts on throttling nodes, so I hope other reviewers will chime in.
>
>--=20
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3266
>Virtualization:  qemu.org | libvirt.org
>




--udp2cy2v6fppw6x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmUE08ACgkQc2J8L2kN
9xDhzBAAs2YtzLUsS0nU/tOu2ZhbvuJH+og+ZnDHdj8UVQs5lqiYG5Nk3+nOJ1vN
U53li+WRu+HWUtZ+fN3IuLnlILltTffgwwBbGt+rxsLL7DBLb7sLmZAI/qLc3uCQ
ulDbbvKb3vgVwNn7khrrDvOGNu6rZyrjxxWAL3HotQUz1W9eJo9oX61icP6vTc2R
rf9UVzkb6P3WkpXRcPldoxWWkJLCXpKsboxW2onVZRDBhJiNm+SGghEcSz2UwBAY
ppC/5bAIIlrcB4SA8alq7Uxk+w1ITkBl49rC7mDS3zCc5FICbTfpWQSOXeDLn9FG
hhpUJIOq38a6pdyWT9/IizK2hvyGC+LHn6NHPAwRHTaqCgGQyGHpN2oes3Dfkayy
VzGFF/Oc3JMb/a6X8uOuVlp+wcfkKJMvq2N7wu+80HDsOSWPt2/DWtCSBrwTQyr4
FMdA8vFnum+GgmBtPtr41iOv6g0FNSeS2zBM6Cs3d4BJ7It3sqyg4at1O4Uq6aJX
jtYkQpcjuQQLNB2xMMLSIXNK2reuu8P9h0LtV5p1MWLYph6CFNwlF4o0m9IUrahQ
+bDqX2+KHWDr0v0OnJg7E0WjPVUoFTY57EqoGaBvP77F9YbfADMgGy6Xo74Q/uic
NOow9grdFYMfSHJOqDuhMRYb1uVzlfNPDq5JehqJRq374gvc5HI=
=PVPb
-----END PGP SIGNATURE-----

--udp2cy2v6fppw6x4--
