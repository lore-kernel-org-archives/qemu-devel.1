Received: from eggs.gnu.org ([2001:4830:134:3::10]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzo75-0000mt-Lc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzo74-0004KO-90
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:09:43 -0400
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
	<20171004170501.ttj7tayiqx2vvsjn@postretch>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <704ce78f-f344-4e49-6e4d-a53b7c868ac2@redhat.com>
Date: Wed, 4 Oct 2017 20:09:24 +0200
MIME-Version: 1.0
In-Reply-To: <20171004170501.ttj7tayiqx2vvsjn@postretch>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cPP5MESj4Sl7OkITNvUuPpT0K2CgE06aK"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] block: add
 block-insert-node QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cPP5MESj4Sl7OkITNvUuPpT0K2CgE06aK
From: Max Reitz <mreitz@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>
Message-ID: <704ce78f-f344-4e49-6e4d-a53b7c868ac2@redhat.com>
Subject: Re: [Qemu-block] [PATCH RFC] block: add block-insert-node QMP command
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
 <a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
 <20171004170501.ttj7tayiqx2vvsjn@postretch>
In-Reply-To: <20171004170501.ttj7tayiqx2vvsjn@postretch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-04 19:05, Manos Pitsidianakis wrote:
> On Wed, Oct 04, 2017 at 02:49:27PM +0200, Max Reitz wrote:
>> On 2017-08-15 09:45, Manos Pitsidianakis wrote:
>>> block-insert-node and its pair command block-remove-node provide runt=
ime
>>> insertion and removal of filter nodes.
>>>
>>> block-insert-node takes a (parent, child) and (node, child) pair of
>>> edges and unrefs the (parent, child) BdrvChild relationship and creat=
es
>>> a new (parent, node) child with the same BdrvChildRole.
>>>
>>> This is a different approach than x-blockdev-change which uses the
>>> driver
>>> methods bdrv_add_child() and bdrv_del_child(),
>>
>> Why? :-)
>>
>> Can't we reuse x-blockdev-change? As far as I'm concerned, this was on=
e
>> of its roles, and at least I don't want to have both x-blockdev-change=

>> and these new commands.
>>
>> I think it would be a good idea just to change bdrv_add_child() and
>> bdrv_del_child(): If the driver has a bdrv_{add,del}_child() callback,=

>> invoke that.=C2=A0 If it doesn't, then just attach the child.
>>
>> Of course, it may turn out that x-blockdev-change is lacking something=

>> (e.g. a way to specify as what kind of child a new node is to be
>> attached).=C2=A0 Then we should either extend it so that it covers wha=
t it's
>> lacking, or replace it completely by these new commands.=C2=A0 In the =
latter
>> case, however, they would need to cover the existing use case which is=

>> reconfiguring the quorum driver.=C2=A0 (And that would mean it would h=
ave to
>> invoke bdrv_add_child()/bdrv_del_child() when the driver has them.)
>>
>> Max
>>
>=20
> I think the two use cases are this:
>=20
> a) Adding/removing a replication child to an existing quorum node
> b) Insert a filter between two existing nodes.

For me both are the same: Adding/removing nodes into/from the graph.

The difference is how those children are added (or removed, but it's the
same in reverse): In case of quorum, you can simply attach a new child
because it supports a variable number of children.  Another case where
this would work are all block drivers which support backing files (you
can freely attach/detach those).

In this series, it's not about adding or removing new children, but
instead "injecting" them into an edge: An existing child is replaced,
but it now serves as some child of the new one.

(I guess writing too much trying to get my point across, sorry...)

The gist is that for me it's not so much about "quorum" or "filter
nodes".  It's about adding a new child to a node vs. replacing an
existing one.

> These are not directly compatible semantically, but as you said
> x-blockdev-change can perform b) if bdrv_add_child()/bdrv_del_child()
> are not implemented. Wouldn't that be unnecessary overloading?

Yes, I think it would be. :-)

So say we have these two trees in our graph:

[ Parent BDS -> Child BDS ]
[ Filter BDS -> Child BDS ]

So here's what you can do with x-blockdev-change (in theory; in practice
it can only do that for quorum):
- Remove a child, so
    [ Parent BDS -> Child BDS ]
  is split into two trees
    [ Parent BDS ] and
    [ Child BDS ]
- Add a child, so we can merge
    [ Parent BDS ] and
    [ Filter BDS -> Child BDS ]
  into
    [ Parent BDS -> Filter BDS -> Child BDS ]

However, this is only possible with quorum because usually block drivers
don't support detaching children.

And here's what you can do with your commands (from what I can see):
- Replace a child (you call it insertion, but it really is just
  replacement of an existing child with the constraint that both nodes
  involved must have the same child):
    [ Parent BDS -> Child BDS ]
    [ Filter BDS -> Child BDS ]
  to
    [ Parent BDS -> Filter BDS -> Child BDS ]
- Replace a child (you call it removal, but it really is just
  replacement of a child with its child):
    [ Parent BDS -> Filter BDS -> Child BDS ]
  to
    [ Parent BDS -> Child BDS ]

This works on all BDSs because you don't change the number of children.


The interesting thing of course is that the "change" command can
actually add and remove children; where as the "insert" and "remove"
commands can only replace children.  So that's already a bit funny (one
command does two things; two commands do one thing).

And then of course you can simply modify x-blockdev-change so it can do
the same thing block-insert-node and block-remove-node can do: It just
needs another mode which can be used to replace a child (and its
description already states that it is supposed to be usable for that at
some point in the future).


So after I've written all of this, I feel like the new insert-node and
remove-node commands are exactly what x-blockdev-change should do when
asked to replace a node.  The only difference is that x-blockdev-change
would allow you to replace any node with anything, without the
constraints that block-insert-node and block-remove-node exact.

(And node replacement with x-blockdev-change would work by specifying
all three parameters.)

Not sure if that makes sense, I hope it does. :-)

Max


--cPP5MESj4Sl7OkITNvUuPpT0K2CgE06aK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnVI9QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/loIAK+eV2082FcomhR8mAw2EVhoDaH+jB55
evRI/mP1ZiPJwYwX1efVuC98BLUKc3UdwKlFNIL69z2u1y8rtp6TgPTwCCuik19Z
UDMMW/AGZighyBZTWznbSiqa7c0mKmt1OphlvNICxhl9LMt1/iG1vmBxcvtY3KhJ
ETqfYIUWo4Q8vpq3mXDWjMMq9iWUUTZPEBN2jfQ2kWvNUEj46yMKf8dOC7NlpEy5
5KSbijkFAqXN6Yg4jxP+tJfbLt95LbdyshN4zDOPHX1cy1GA5BP58tuBeM1+Dx1M
qJW9aiCJLyHGHXusDHvJDpLTfQyKsQm8QpwLKmz1kXXIz3pHl2IzuSs=
=RnSM
-----END PGP SIGNATURE-----

--cPP5MESj4Sl7OkITNvUuPpT0K2CgE06aK--
