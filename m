Received: from eggs.gnu.org ([2001:4830:134:3::10]:41301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1e0SwX-00072J-JG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1e0SwW-0001Hj-7B
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:45:33 -0400
Date: Fri, 6 Oct 2017 16:45:12 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20171006134512.b74fpkvhnw55zkbu@postretch>
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
	<20171004170501.ttj7tayiqx2vvsjn@postretch>
	<704ce78f-f344-4e49-6e4d-a53b7c868ac2@redhat.com>
	<20171004210454.aj4mvxlbgllg4ds7@postretch>
	<82b9734b-8fbf-8d0f-190c-25107013253b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="spcrt7vjutoiozc2"
Content-Disposition: inline
In-Reply-To: <82b9734b-8fbf-8d0f-190c-25107013253b@redhat.com>
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


--spcrt7vjutoiozc2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 02:59:55PM +0200, Max Reitz wrote:
>On 2017-10-04 23:04, Manos Pitsidianakis wrote:
>> On Wed, Oct 04, 2017 at 08:09:24PM +0200, Max Reitz wrote:
>>> On 2017-10-04 19:05, Manos Pitsidianakis wrote:
>>>> On Wed, Oct 04, 2017 at 02:49:27PM +0200, Max Reitz wrote:
>>>>> On 2017-08-15 09:45, Manos Pitsidianakis wrote:
>>>>>> block-insert-node and its pair command block-remove-node provide
>>>>>> runtime
>>>>>> insertion and removal of filter nodes.
>>>>>>
>>>>>> block-insert-node takes a (parent, child) and (node, child) pair of
>>>>>> edges and unrefs the (parent, child) BdrvChild relationship and
>>>>>> creates
>>>>>> a new (parent, node) child with the same BdrvChildRole.
>>>>>>
>>>>>> This is a different approach than x-blockdev-change which uses the
>>>>>> driver
>>>>>> methods bdrv_add_child() and bdrv_del_child(),
>>>>>
>>>>> Why? :-)
>>>>>
>>>>> Can't we reuse x-blockdev-change? As far as I'm concerned, this was o=
ne
>>>>> of its roles, and at least I don't want to have both x-blockdev-change
>>>>> and these new commands.
>>>>>
>>>>> I think it would be a good idea just to change bdrv_add_child() and
>>>>> bdrv_del_child(): If the driver has a bdrv_{add,del}_child() callback,
>>>>> invoke that.=C2=A0 If it doesn't, then just attach the child.
>>>>>
>>>>> Of course, it may turn out that x-blockdev-change is lacking something
>>>>> (e.g. a way to specify as what kind of child a new node is to be
>>>>> attached).=C2=A0 Then we should either extend it so that it covers wh=
at it's
>>>>> lacking, or replace it completely by these new commands.=C2=A0 In the=
 latter
>>>>> case, however, they would need to cover the existing use case which is
>>>>> reconfiguring the quorum driver.=C2=A0 (And that would mean it would =
have to
>>>>> invoke bdrv_add_child()/bdrv_del_child() when the driver has them.)
>>>>>
>>>>> Max
>>>>>
>>>>
>>>> I think the two use cases are this:
>>>>
>>>> a) Adding/removing a replication child to an existing quorum node
>>>> b) Insert a filter between two existing nodes.
>>>
>>> For me both are the same: Adding/removing nodes into/from the graph.
>>>
>>> The difference is how those children are added (or removed, but it's the
>>> same in reverse): In case of quorum, you can simply attach a new child
>>> because it supports a variable number of children.=C2=A0 Another case w=
here
>>> this would work are all block drivers which support backing files (you
>>> can freely attach/detach those).
>>
>> Doesn't blockdev-snapshot-sync cover this? (I may be missing something).
>
>Not really, because it doesn't add a new child.  But it's still a good
>point, because your block-insert-node command would make it obsolete,
>actually.
>
>blockdev-snapshot literally is a special-cased block-insert-node.  And
>blockdev-snapshot-sync then is qemu-img create + blockdev-add +
>blockdev-snapshot.
>
>> Now that we're on this topic, quorum might be a good candidate for
>> *_reopen when and if it lands on QMP: Reconfiguring the children could
>> be done by reopening the BDS with new options.
>
>Hmmm...  I guess that would work, too.  But intuitively, that seems a
>bit heavy-weight to me
>
>>> In this series, it's not about adding or removing new children, but
>>> instead "injecting" them into an edge: An existing child is replaced,
>>> but it now serves as some child of the new one.
>>>
>>> (I guess writing too much trying to get my point across, sorry...)
>>>
>>> The gist is that for me it's not so much about "quorum" or "filter
>>> nodes".=C2=A0 It's about adding a new child to a node vs. replacing an
>>> existing one.
>>>
>>>> These are not directly compatible semantically, but as you said
>>>> x-blockdev-change can perform b) if bdrv_add_child()/bdrv_del_child()
>>>> are not implemented. Wouldn't that be unnecessary overloading?
>>>
>>> Yes, I think it would be. :-)
>>>
>>> So say we have these two trees in our graph:
>>>
>>> [ Parent BDS -> Child BDS ]
>>> [ Filter BDS -> Child BDS ]
>>>
>>> So here's what you can do with x-blockdev-change (in theory; in practice
>>> it can only do that for quorum):
>>> - Remove a child, so
>>> =C2=A0=C2=A0 [ Parent BDS -> Child BDS ]
>>> =C2=A0is split into two trees
>>> =C2=A0=C2=A0 [ Parent BDS ] and
>>> =C2=A0=C2=A0 [ Child BDS ]
>>> - Add a child, so we can merge
>>> =C2=A0=C2=A0 [ Parent BDS ] and
>>> =C2=A0=C2=A0 [ Filter BDS -> Child BDS ]
>>> =C2=A0into
>>> =C2=A0=C2=A0 [ Parent BDS -> Filter BDS -> Child BDS ]
>>>
>>
>> Yes, of course this would have to be done in one transaction.
>
>Would it?  If you want to put Filter BDS into the chain, you can just
>create [ Filter BDS ] without any child, and then use a single
>x-blockdev-change invocation to inject it.
>
>The only thing that's necessary is that the filter BDS would have to be
>able to handle having no child.

Yeah that was what I had in mind.
>
>[...]
>
>>> So after I've written all of this, I feel like the new insert-node and
>>> remove-node commands are exactly what x-blockdev-change should do when
>>> asked to replace a node.=C2=A0 The only difference is that x-blockdev-c=
hange
>>> would allow you to replace any node with anything, without the
>>> constraints that block-insert-node and block-remove-node exact.
>>>
>>> (And node replacement with x-blockdev-change would work by specifying
>>> all three parameters.)
>>>
>>> Not sure if that makes sense, I hope it does. :-)
>>>
>>
>> Hm, I can't think of a way to fit that into x-blockdev-change *and* keep
>> the bdrv_add_child/bdrv_del_child functionality into consideration
>> (since we'd have to keep both). This is what the current doco is:
>>
>> =C2=A0If @node is specified, it will be inserted under @parent. @child
>> =C2=A0may not be specified in this case. If both @parent and @child are
>> =C2=A0specified but @node is not, @child will be detached from @parent.
>>
>> The simplest thing would be to add a flag as to what operation you want
>> to perform (add/del child versus filter insertion/removal from edges)
>> but this is what I was thinking about overloading it, it feels
>> convoluted yet the insert and remove commands felt intuitive enough to
>> me after experimenting with it a little. What do you think?
>
>I agree that adding a flag is rather pointless, because then you can
>simply have multiple commands.
>
>But the idea was that if you specify both @node and @child, @child gets
>replaced by @node.  Currently, that combination is not allowed.

And removal is to swap @node and @child and leave @node an orphan, but=20
with the constraint that @child is a child of @parent and @node is a=20
child of @parent.

Okay, I don't have any more arguments!. If there are no objections I can=20
look into a new RFC patch for x-blockdev-change.

--spcrt7vjutoiozc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnXiOgACgkQc2J8L2kN
9xA4Zw//ZGazvfCscQyS2KKCYa503WQgWFeXBVRxeI3YqYVrDqj+lHMdkLQg1yxX
X8HOQBCnTk8Cj7Y5XtHyhxJtX0Trzov5M/Zf7NnRaDFGF744yTBx81QDVDotHt7P
RHqBH9Tnq8/DKgIcF5gKjlGPeE1XYv8oCbB0X4k2yHmRAvRcchPxMbHeRK4tDkwl
xA05k1DTukqmUGFNWssgmcjPjtvBfTxms+u30J5nEArxTPbBNQwPzYMo/RiDapXO
uDxtYUuJhRps53LxxEiXvqZTJ5ml/Ef0lDNsSRTJhUNzAhoBK4vsJhJZaUd5I33k
0Y/LxkLqNVdCc84e2heIyr3XYNySgashe5HnvJfmZNSngFee1XL7boHMC3pfbxmk
5MAyClselRsBYbKWq/Guk5vwcenxIlQXHYPdECesRhGoHkyJ550VylXfpe0yrg8W
r2eIJ+GnVW5OxzXc3PU66pdLAzZe4og/5GAKSFNOpsTrb1tZodO7UFq76Nz/6+ag
MtYFaWxL/+AUf/T5o39WZUQRW0vZMZkyFxI6B1efAobknncbyQ+nD1xoe5dK4rZK
4EerwkySZuvZdOcpiqkm/VuaxTBfS/A2Xcy/xojskFKXuvDV71BJb5wP6vooXI37
AwfLVhT0M38iAl5b/Oex/8URrj5n2DmL2sdhDcFxN5d9/JTn5MI=
=H9xZ
-----END PGP SIGNATURE-----

--spcrt7vjutoiozc2--
