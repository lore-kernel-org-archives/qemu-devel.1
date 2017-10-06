Received: from eggs.gnu.org ([2001:4830:134:3::10]:55220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e0SEv-0003L2-4b
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e0SEn-0001yu-0G
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:00:29 -0400
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
	<20171004170501.ttj7tayiqx2vvsjn@postretch>
	<704ce78f-f344-4e49-6e4d-a53b7c868ac2@redhat.com>
	<20171004210454.aj4mvxlbgllg4ds7@postretch>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <82b9734b-8fbf-8d0f-190c-25107013253b@redhat.com>
Date: Fri, 6 Oct 2017 14:59:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171004210454.aj4mvxlbgllg4ds7@postretch>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AX9efKJABONouHrFvFsC3BIBOvGnJDbJe"
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
--AX9efKJABONouHrFvFsC3BIBOvGnJDbJe
From: Max Reitz <mreitz@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>
Message-ID: <82b9734b-8fbf-8d0f-190c-25107013253b@redhat.com>
Subject: Re: [Qemu-block] [PATCH RFC] block: add block-insert-node QMP command
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
 <a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
 <20171004170501.ttj7tayiqx2vvsjn@postretch>
 <704ce78f-f344-4e49-6e4d-a53b7c868ac2@redhat.com>
 <20171004210454.aj4mvxlbgllg4ds7@postretch>
In-Reply-To: <20171004210454.aj4mvxlbgllg4ds7@postretch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-04 23:04, Manos Pitsidianakis wrote:
> On Wed, Oct 04, 2017 at 08:09:24PM +0200, Max Reitz wrote:
>> On 2017-10-04 19:05, Manos Pitsidianakis wrote:
>>> On Wed, Oct 04, 2017 at 02:49:27PM +0200, Max Reitz wrote:
>>>> On 2017-08-15 09:45, Manos Pitsidianakis wrote:
>>>>> block-insert-node and its pair command block-remove-node provide
>>>>> runtime
>>>>> insertion and removal of filter nodes.
>>>>>
>>>>> block-insert-node takes a (parent, child) and (node, child) pair of=

>>>>> edges and unrefs the (parent, child) BdrvChild relationship and
>>>>> creates
>>>>> a new (parent, node) child with the same BdrvChildRole.
>>>>>
>>>>> This is a different approach than x-blockdev-change which uses the
>>>>> driver
>>>>> methods bdrv_add_child() and bdrv_del_child(),
>>>>
>>>> Why? :-)
>>>>
>>>> Can't we reuse x-blockdev-change? As far as I'm concerned, this was =
one
>>>> of its roles, and at least I don't want to have both x-blockdev-chan=
ge
>>>> and these new commands.
>>>>
>>>> I think it would be a good idea just to change bdrv_add_child() and
>>>> bdrv_del_child(): If the driver has a bdrv_{add,del}_child() callbac=
k,
>>>> invoke that.=C2=A0 If it doesn't, then just attach the child.
>>>>
>>>> Of course, it may turn out that x-blockdev-change is lacking somethi=
ng
>>>> (e.g. a way to specify as what kind of child a new node is to be
>>>> attached).=C2=A0 Then we should either extend it so that it covers w=
hat it's
>>>> lacking, or replace it completely by these new commands.=C2=A0 In th=
e latter
>>>> case, however, they would need to cover the existing use case which =
is
>>>> reconfiguring the quorum driver.=C2=A0 (And that would mean it would=
 have to
>>>> invoke bdrv_add_child()/bdrv_del_child() when the driver has them.)
>>>>
>>>> Max
>>>>
>>>
>>> I think the two use cases are this:
>>>
>>> a) Adding/removing a replication child to an existing quorum node
>>> b) Insert a filter between two existing nodes.
>>
>> For me both are the same: Adding/removing nodes into/from the graph.
>>
>> The difference is how those children are added (or removed, but it's t=
he
>> same in reverse): In case of quorum, you can simply attach a new child=

>> because it supports a variable number of children.=C2=A0 Another case =
where
>> this would work are all block drivers which support backing files (you=

>> can freely attach/detach those).
>=20
> Doesn't blockdev-snapshot-sync cover this? (I may be missing something)=
=2E

Not really, because it doesn't add a new child.  But it's still a good
point, because your block-insert-node command would make it obsolete,
actually.

blockdev-snapshot literally is a special-cased block-insert-node.  And
blockdev-snapshot-sync then is qemu-img create + blockdev-add +
blockdev-snapshot.

> Now that we're on this topic, quorum might be a good candidate for
> *_reopen when and if it lands on QMP: Reconfiguring the children could
> be done by reopening the BDS with new options.

Hmmm...  I guess that would work, too.  But intuitively, that seems a
bit heavy-weight to me

>> In this series, it's not about adding or removing new children, but
>> instead "injecting" them into an edge: An existing child is replaced,
>> but it now serves as some child of the new one.
>>
>> (I guess writing too much trying to get my point across, sorry...)
>>
>> The gist is that for me it's not so much about "quorum" or "filter
>> nodes".=C2=A0 It's about adding a new child to a node vs. replacing an=

>> existing one.
>>
>>> These are not directly compatible semantically, but as you said
>>> x-blockdev-change can perform b) if bdrv_add_child()/bdrv_del_child()=

>>> are not implemented. Wouldn't that be unnecessary overloading?
>>
>> Yes, I think it would be. :-)
>>
>> So say we have these two trees in our graph:
>>
>> [ Parent BDS -> Child BDS ]
>> [ Filter BDS -> Child BDS ]
>>
>> So here's what you can do with x-blockdev-change (in theory; in practi=
ce
>> it can only do that for quorum):
>> - Remove a child, so
>> =C2=A0=C2=A0 [ Parent BDS -> Child BDS ]
>> =C2=A0is split into two trees
>> =C2=A0=C2=A0 [ Parent BDS ] and
>> =C2=A0=C2=A0 [ Child BDS ]
>> - Add a child, so we can merge
>> =C2=A0=C2=A0 [ Parent BDS ] and
>> =C2=A0=C2=A0 [ Filter BDS -> Child BDS ]
>> =C2=A0into
>> =C2=A0=C2=A0 [ Parent BDS -> Filter BDS -> Child BDS ]
>>
>=20
> Yes, of course this would have to be done in one transaction.

Would it?  If you want to put Filter BDS into the chain, you can just
create [ Filter BDS ] without any child, and then use a single
x-blockdev-change invocation to inject it.

The only thing that's necessary is that the filter BDS would have to be
able to handle having no child.

[...]

>> So after I've written all of this, I feel like the new insert-node and=

>> remove-node commands are exactly what x-blockdev-change should do when=

>> asked to replace a node.=C2=A0 The only difference is that x-blockdev-=
change
>> would allow you to replace any node with anything, without the
>> constraints that block-insert-node and block-remove-node exact.
>>
>> (And node replacement with x-blockdev-change would work by specifying
>> all three parameters.)
>>
>> Not sure if that makes sense, I hope it does. :-)
>>
>=20
> Hm, I can't think of a way to fit that into x-blockdev-change *and* kee=
p
> the bdrv_add_child/bdrv_del_child functionality into consideration
> (since we'd have to keep both). This is what the current doco is:
>=20
> =C2=A0If @node is specified, it will be inserted under @parent. @child
> =C2=A0may not be specified in this case. If both @parent and @child are=

> =C2=A0specified but @node is not, @child will be detached from @parent.=

>=20
> The simplest thing would be to add a flag as to what operation you want=

> to perform (add/del child versus filter insertion/removal from edges)
> but this is what I was thinking about overloading it, it feels
> convoluted yet the insert and remove commands felt intuitive enough to
> me after experimenting with it a little. What do you think?

I agree that adding a flag is rather pointless, because then you can
simply have multiple commands.

But the idea was that if you specify both @node and @child, @child gets
replaced by @node.  Currently, that combination is not allowed.

Max


--AX9efKJABONouHrFvFsC3BIBOvGnJDbJe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnXfkwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyG0H/1G6gNpiKfR4o0a3AY2L84HOjvBc2GHP
dYxiq6/m7huvz5mF3FZkeUTbQUr5VT3S+8zM574EgFgZ6FsYOk4UCzF31J+2oR1y
tSJu5ChSQH6LR/2tHFWt4DkibEpo7ViOeQjdOt0AtFXCAD6Y3J2SAiKWN1Ivkg1i
cyltbVgdZ5lBK4O3o9IxiuS0cfs/+Px/eo/q+dtcydfwc1am8yxTsGJOGon9y3kA
hnr3zIAaAK8Qgro8jtTWu0fhYCMTqL1s3zpSeyvGWixBVuPoAN7sc2PXi2Yh8QaX
VE7fKfzHFEthJJyvJJ6ns7K/0nsdOZMDopl18CpqTabykPzIko43cJk=
=VH76
-----END PGP SIGNATURE-----

--AX9efKJABONouHrFvFsC3BIBOvGnJDbJe--
