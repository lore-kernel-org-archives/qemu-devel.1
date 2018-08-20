Received: from eggs.gnu.org ([2001:4830:134:3::10]:55843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fro60-0004kR-K7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fro5y-0000h4-J5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:36:04 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
	<f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
	<8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
	<7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
	<c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
	<cc79c692-8f1b-1bb1-e926-89ee73327f31@redhat.com>
	<37d9972a-77c5-647f-c103-b40281744a40@virtuozzo.com>
	<1c1b2056-19d6-843d-619d-0208b837970b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ca86b264-0694-973f-59aa-9d10a756bdda@virtuozzo.com>
Date: Mon, 20 Aug 2018 20:35:50 +0300
MIME-Version: 1.0
In-Reply-To: <1c1b2056-19d6-843d-619d-0208b837970b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

20.08.2018 20:13, Max Reitz wrote:
> On 2018-08-20 19:04, Vladimir Sementsov-Ogievskiy wrote:
>> 20.08.2018 19:35, Max Reitz wrote:
>>> On 2018-08-20 17:13, Vladimir Sementsov-Ogievskiy wrote:
>>>> 20.08.2018 16:44, Max Reitz wrote:
>>>>> On 2018-08-20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>>> [...]
>>>
>>>>>> My goal is to get graphviz representation of block graph with all th=
e
>>>>>> parents for debugging. And I'm absolutely ok to do it with x-debug-.
>>>>>> Then we shouldn't care about enum for role type now. So, it the
>>>>>> patch ok
>>>>>> for you with x-debug- prefix?
>>>>> Actually, no, because I'm not sure whether using points for the IDs
>>>>> is a
>>>>> good idea.=C2=A0 That may defeat ASLR, and that would be a problem ev=
en with
>>>>> x-debug-.
>>>> Good point, agree.
>>>>
>>>>> So I'd prefer using e.g. a hash map to map pointers to freshly
>>>>> generated
>>>>> IDs (just incrementing integers).
>>> (By the way, that would also improve the speed of checking whether a
>>> certain node needs to be added to the @nodes list still.)
>>>
>>>>> In any case, I'll take a further look at the patch later, but another
>>>>> thing that I've just seen is that using the opaque pointers to identi=
fy
>>>>> a parent is something that doesn't look like it's guaranteed to work.
>>>> Hm, isn't it a bug? Can you point to an example?
>>> Ah, no, it's OK.=C2=A0 Well, kind of.=C2=A0 It's OK in the sense that i=
t is unique
>>> when set.=C2=A0 I didn't notice that you only use it for the non-node
>>> parents, sorry.
>> hm, no, I use opaque for all. So, it can be zero? In what case? In this
>> case, I cant get its parent?
> As far as I can see, you only use it for BLOCK_GRAPH_NODE_TYPE_OTHER,
> and you only do it when the parent is indeed not a BDS (because BDS are
> always children of some sort, so they'll be automatically accounted for
> anyway).
>
> Ah, but you set edge->parent =3D (uint64_t)child->opaque.  I see, because
> you assume it's always going to point to the BDS.

... or to some non-bds parent

>
> Yeah, generally, you can't get the parent.  That's the whole point.  I
> suppose in practice your code works, but that's not how it's supposed to
> be.  You generally cannot go from child to parent, only through the
> interface defined through BdrvChildRole (which uses the opaque pointer).
>
> As I said, a safe way to do this would be to enumerate all possible
> block graph roots; those being (as far as I know) all BlockBackends and
> all monitor-owned BDSs (see bdrv_close_all(), which handles exactly
> those two cases).  Then you can walk down from the roots through the tree=
s.

hmm, what about block jobs here?

>
>>> Still, it probably would be better to just use the BdrvChild object, as
>>> that should be unique as well, and it is obviously non-NULL.
>>> (BdrvChild.opaque may be NULL, even though it isn't in practice.)
>> but BdrvChild corresponds to edge in a graph, not to the node. I need
>> identificators for nodes..
> But an edge identifies two nodes.  All edges have at least one BDS on
> one end.
>
> Since you can identify all BDS through the BDS itself, if you have a
> non-BDS node, you can use the edge to identify it (because the other end
> of the edge is going to be a BDS which you can identify by itself).

But non-bds node may have several children, therefore several=20
BdrvChild's with different pointers.. And only opque point should be the=20
same for them.

>
> Or, well, if you take my suggestion and walk down the trees starting at
> the roots, you'll see that the only non-BDS nodes in the block graph are
> BlockBackends.  And you can just use their addresses to identify them
> (just internally, of course; externally you'll still want to generate a
> new ID).

As I understand, I'll not see block jobs in this way to be non-bds nodes..

>
> Max
>


--=20
Best regards,
Vladimir
