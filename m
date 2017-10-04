Received: from eggs.gnu.org ([2001:4830:134:3::10]:47807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dzqqv-0005Ds-M3
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dzqqs-00056B-Cu
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:05:13 -0400
Date: Thu, 5 Oct 2017 00:04:54 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20171004210454.aj4mvxlbgllg4ds7@postretch>
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
	<20171004170501.ttj7tayiqx2vvsjn@postretch>
	<704ce78f-f344-4e49-6e4d-a53b7c868ac2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vvxzf3qzpvfwhtmw"
Content-Disposition: inline
In-Reply-To: <704ce78f-f344-4e49-6e4d-a53b7c868ac2@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--vvxzf3qzpvfwhtmw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 08:09:24PM +0200, Max Reitz wrote:
>On 2017-10-04 19:05, Manos Pitsidianakis wrote:
>> On Wed, Oct 04, 2017 at 02:49:27PM +0200, Max Reitz wrote:
>>> On 2017-08-15 09:45, Manos Pitsidianakis wrote:
>>>> block-insert-node and its pair command block-remove-node provide runti=
me
>>>> insertion and removal of filter nodes.
>>>>
>>>> block-insert-node takes a (parent, child) and (node, child) pair of
>>>> edges and unrefs the (parent, child) BdrvChild relationship and creates
>>>> a new (parent, node) child with the same BdrvChildRole.
>>>>
>>>> This is a different approach than x-blockdev-change which uses the
>>>> driver
>>>> methods bdrv_add_child() and bdrv_del_child(),
>>>
>>> Why? :-)
>>>
>>> Can't we reuse x-blockdev-change? As far as I'm concerned, this was one
>>> of its roles, and at least I don't want to have both x-blockdev-change
>>> and these new commands.
>>>
>>> I think it would be a good idea just to change bdrv_add_child() and
>>> bdrv_del_child(): If the driver has a bdrv_{add,del}_child() callback,
>>> invoke that.=C2=A0 If it doesn't, then just attach the child.
>>>
>>> Of course, it may turn out that x-blockdev-change is lacking something
>>> (e.g. a way to specify as what kind of child a new node is to be
>>> attached).=C2=A0 Then we should either extend it so that it covers what=
 it's
>>> lacking, or replace it completely by these new commands.=C2=A0 In the l=
atter
>>> case, however, they would need to cover the existing use case which is
>>> reconfiguring the quorum driver.=C2=A0 (And that would mean it would ha=
ve to
>>> invoke bdrv_add_child()/bdrv_del_child() when the driver has them.)
>>>
>>> Max
>>>
>>
>> I think the two use cases are this:
>>
>> a) Adding/removing a replication child to an existing quorum node
>> b) Insert a filter between two existing nodes.
>
>For me both are the same: Adding/removing nodes into/from the graph.
>
>The difference is how those children are added (or removed, but it's the
>same in reverse): In case of quorum, you can simply attach a new child
>because it supports a variable number of children.  Another case where
>this would work are all block drivers which support backing files (you
>can freely attach/detach those).

Doesn't blockdev-snapshot-sync cover this? (I may be missing something).
Now that we're on this topic, quorum might be a good candidate for=20
*_reopen when and if it lands on QMP: Reconfiguring the children could=20
be done by reopening the BDS with new options.
>
>In this series, it's not about adding or removing new children, but
>instead "injecting" them into an edge: An existing child is replaced,
>but it now serves as some child of the new one.
>
>(I guess writing too much trying to get my point across, sorry...)
>
>The gist is that for me it's not so much about "quorum" or "filter
>nodes".  It's about adding a new child to a node vs. replacing an
>existing one.
>
>> These are not directly compatible semantically, but as you said
>> x-blockdev-change can perform b) if bdrv_add_child()/bdrv_del_child()
>> are not implemented. Wouldn't that be unnecessary overloading?
>
>Yes, I think it would be. :-)
>
>So say we have these two trees in our graph:
>
>[ Parent BDS -> Child BDS ]
>[ Filter BDS -> Child BDS ]
>
>So here's what you can do with x-blockdev-change (in theory; in practice
>it can only do that for quorum):
>- Remove a child, so
>    [ Parent BDS -> Child BDS ]
>  is split into two trees
>    [ Parent BDS ] and
>    [ Child BDS ]
>- Add a child, so we can merge
>    [ Parent BDS ] and
>    [ Filter BDS -> Child BDS ]
>  into
>    [ Parent BDS -> Filter BDS -> Child BDS ]
>

Yes, of course this would have to be done in one transaction.

>However, this is only possible with quorum because usually block drivers
>don't support detaching children.
>
>And here's what you can do with your commands (from what I can see):
>- Replace a child (you call it insertion, but it really is just
>  replacement of an existing child with the constraint that both nodes
>  involved must have the same child):
>    [ Parent BDS -> Child BDS ]
>    [ Filter BDS -> Child BDS ]
>  to
>    [ Parent BDS -> Filter BDS -> Child BDS ]
>- Replace a child (you call it removal, but it really is just
>  replacement of a child with its child):
>    [ Parent BDS -> Filter BDS -> Child BDS ]
>  to
>    [ Parent BDS -> Child BDS ]
>
>This works on all BDSs because you don't change the number of children.
>
>
>The interesting thing of course is that the "change" command can
>actually add and remove children; where as the "insert" and "remove"
>commands can only replace children.  So that's already a bit funny (one
>command does two things; two commands do one thing).

That is true, but the replacing is more in terms of inserting and=20
removing a node in a BDS chain.
>
>And then of course you can simply modify x-blockdev-change so it can do
>the same thing block-insert-node and block-remove-node can do: It just
>needs another mode which can be used to replace a child (and its
>description already states that it is supposed to be usable for that at
>some point in the future).
>
>
>So after I've written all of this, I feel like the new insert-node and
>remove-node commands are exactly what x-blockdev-change should do when
>asked to replace a node.  The only difference is that x-blockdev-change
>would allow you to replace any node with anything, without the
>constraints that block-insert-node and block-remove-node exact.
>
>(And node replacement with x-blockdev-change would work by specifying
>all three parameters.)
>
>Not sure if that makes sense, I hope it does. :-)
>

Hm, I can't think of a way to fit that into x-blockdev-change *and* keep=20
the bdrv_add_child/bdrv_del_child functionality into consideration=20
(since we'd have to keep both). This is what the current doco is:

  If @node is specified, it will be inserted under @parent. @child
  may not be specified in this case. If both @parent and @child are
  specified but @node is not, @child will be detached from @parent.

The simplest thing would be to add a flag as to what operation you want=20
to perform (add/del child versus filter insertion/removal from edges)=20
but this is what I was thinking about overloading it, it feels=20
convoluted yet the insert and remove commands felt intuitive enough to=20
me after experimenting with it a little. What do you think?

--vvxzf3qzpvfwhtmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnVTPYACgkQc2J8L2kN
9xC/eg/9GJs9L8QICmZjfFKjPuswurpIB1CPgQWaZVTusnjtP526WaEPSI7Dbbis
Jdrx59nufupJS2mCmiXBtTKtU4YeenrOqRd+nIqgpsEC/9PnLdaojqo1KBTnKzQn
f1Yj4X38C+7p1xWCvUdODvwVD6o6fvHpignzPDqxLm0O+H+wwa/VDBG9FP2eq8QH
yFHGEPsxe35esmH5EjXxOZ7Rq/jNmTW53pokvm/yxW0bXrkLPQwq0eiTEoovPW0E
d+XYhEoC1ITyKVWccUyxpIEPGSb3+kXMzp1XGHax0Yj0h8g5cFqEls0G7agMbNJ4
YhJ1d57cM5+dh/Mu4WaJXJcZpuJq5d9meJsaH2egNMg5c3JfahMwjiF9fQZ9gJNM
pqjVVb7R21JC+lIF48YndXYinmU68e6QHgOfEo1ZgmOpY28MyvKBYdaO6y9pV+YH
bUR8OTTeR6wrS9DV4aNRTz28uQTkYDS+ZcjufGDcWOPaxjkXWzPxW3ptoPQetUuv
RSbAsDdZkX6Fb0ffGde5us6mseBi2N7qFk4IvcVb4uvIf9UfoLD3sQ1F8v4FVYX8
aR3sGjvJGeZvMuGlbC2o94eBMJfpNB7DxBqAn4um7yrAxdSKXGsc//1RTt4ToWIn
1nA1fvq0K5U33y8kDI9gKxZTetFq5uwEzWja9YVL4kUvUglnNGc=
=F5zv
-----END PGP SIGNATURE-----

--vvxzf3qzpvfwhtmw--
