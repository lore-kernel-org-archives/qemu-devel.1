Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhk54-0005xF-Hj
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhk53-0001aN-AO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:12:58 -0400
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
Date: Tue, 15 Aug 2017 17:12:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170815074513.9055-1-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="esxxI8FQd0uFWQTngBhoHSBbLo5ucWKuD"
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--esxxI8FQd0uFWQTngBhoHSBbLo5ucWKuD
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>
Message-ID: <6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP command
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
In-Reply-To: <20170815074513.9055-1-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 02:45 AM, Manos Pitsidianakis wrote:
> block-insert-node and its pair command block-remove-node provide runtim=
e
> insertion and removal of filter nodes.
>=20
> block-insert-node takes a (parent, child) and (node, child) pair of
> edges and unrefs the (parent, child) BdrvChild relationship and creates=

> a new (parent, node) child with the same BdrvChildRole.
>=20
> This is a different approach than x-blockdev-change which uses the driv=
er
> methods bdrv_add_child() and bdrv_del_child(),
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                    |  192 ++++++++
>  blockdev.c                 |   44 ++
>  include/block/block.h      |    6 +
>  qapi/block-core.json       |   60 +++
>  tests/qemu-iotests/193     |  241 ++++++++++
>  tests/qemu-iotests/193.out | 1116 ++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |    1 +
>  7 files changed, 1660 insertions(+)
>  create mode 100755 tests/qemu-iotests/193
>  create mode 100644 tests/qemu-iotests/193.out

You may want to look at using scripts/git.orderfile, to rearrange your
patch so that interface changes (.json, .h) occur before implementation
(.c).  For now, I'm just focusing on the interface:


> +++ b/qapi/block-core.json
> @@ -3947,3 +3947,63 @@
>    'data' : { 'parent': 'str',
>               '*child': 'str',
>               '*node': 'str' } }
> +
> +##
> +# @block-insert-node:
> +#
> +# Insert a filter node between a specific edge in the block driver sta=
te graph.
> +# @parent:  the name of the parent node or device
> +# @node:    the name of the node to insert under parent
> +# @child:   the name of the child of both node and parent

Is this always going to be between two existing nodes, or can this
command also be used to insert at the end of the chain (for example, if
parent or child is omitted)?


> +#    }
> +# <- { 'return': {} }
> +#
> +##

Missing 'Since: 2.11'.

> +{ 'command': 'block-insert-node',
> +  'data': { 'parent': 'str',
> +             'child': 'str',
> +             'node': 'str'} }

For now, it looks like you require all arguments, and therefore this is
always insertion in the middle.

> +##
> +# @block-remove-node:
> +#
> +# Remove a filter node between two other nodes in the block driver sta=
te graph.
> +# @parent:  the name of the parent node or device
> +# @node:    the name of the node to remove from parent
> +# @child:   the name of the child of node which will go under parent
> +##
> +{ 'command': 'block-remove-node',
> +  'data': { 'parent': 'str',
> +             'child': 'str',
> +             'node': 'str'} }

Likewise missing 2.11.

Overall I'm not seeing problems with the interface from the UI
perspective, but I have not been paying close attention to your larger
efforts on throttling nodes, so I hope other reviewers will chime in.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--esxxI8FQd0uFWQTngBhoHSBbLo5ucWKuD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTcdoACgkQp6FrSiUn
Q2qIKgf+Pq18CDcYOekiFnYyn6WpVdWiqLRh+r/cRYSJOJA5OnztvJswyVllvREh
HpsRaMq5FusgqhmMzBswEksuiLOx66J/2OAirQmx9cSnZMsIyL4Y0zqbfLCJJ/zy
djDcWN2pJqIXABhL8H3fzcfKPNpDEOje6Xf3W0NEGLOXBSi8HckmaAQ/M80I3zI6
3ukPEhIwFQUoSKhncfBZwkSD5b1vtaifkE8YZEYY+An8QtTqR5ww9zlePnxpusBB
uxJN7WcWyhYWhyu0aAjzQltNbRxhtFaOA52zqjK9p5PZAxP1dH+bIcOqagCBP0sD
zHfsrcONn/+ffNmkvF20ZeCWMr+wNw==
=AcHn
-----END PGP SIGNATURE-----

--esxxI8FQd0uFWQTngBhoHSBbLo5ucWKuD--
