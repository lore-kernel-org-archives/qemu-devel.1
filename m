Received: from eggs.gnu.org ([2001:4830:134:3::10]:43588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eORjE-0000ky-5Y
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eORjC-0007RX-Sq
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:18:56 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
	<8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
	<a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
	<a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
	<6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
	<115a5939-fff8-8861-f02f-0204aea5b3e2@redhat.com>
	<5f704858-1983-f1bb-2281-f12f43c5f2b6@redhat.com>
	<09cebfbf-e95c-8f09-5a0a-9345e1e1804d@redhat.com>
	<23523fec-96b1-f50b-6937-85daea8a832a@redhat.com>
	<f3918f16-774b-4c73-7df4-8ec3e757ae3c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2448d35a-69cc-e056-200a-b77f8cbb667c@redhat.com>
Date: Mon, 11 Dec 2017 12:18:47 -0500
MIME-Version: 1.0
In-Reply-To: <f3918f16-774b-4c73-7df4-8ec3e757ae3c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockdev-backup: enable
 non-root nodes for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com



On 12/11/2017 12:05 PM, Max Reitz wrote:
> On 2017-12-11 17:47, John Snow wrote:
>> On 12/11/2017 11:31 AM, Max Reitz wrote:
>>> On 2017-12-08 18:09, John Snow wrote:
>>>> On 12/08/2017 09:30 AM, Max Reitz wrote:
>>>>> On 2017-12-05 01:48, John Snow wrote:
>>>>>>
>>>>>> I would say that a bitmap attached to a BlockBackend should behave in
>>>>>> the way you say: writes to any children should change the bitmap here.
>>>>>>
>>>>>> bitmaps attached to nodes shouldn't worry about such things.
>>>>>
>>>>> Do we have bitmaps attached to BlockBackends?  I sure hope not.
>>>>>
>>>>> We should not have any interface that requires the use of BlockBackends
>>>>> by now.  If we do, that's something that has to be fixed.
>>>>>
>>>>>
>>>>
>>>> I'm not sure what the right paradigm is anymore, then.
>>>>
>>>> A node is just a node, but something has to represent the "drive" as far
>>>> as the device model sees it. I thought that *was* the BlockBackend, but
>>>> is it not?
>>>
>>> Yes, and on the other side the BB represents the device model for the
>>> block layer.  But the thing is that the user should be blissfully
>>> unaware...  Or do you want to make bitmaps attachable to guest devices
>>> (through the QOM path or ID) instead?
>>>
>>
>> OK, sure -- the user can specify a device model to attach it to instead
>> of a node. They don't have to be aware of the BB itself.
>>
>> The implementation though, I imagine it associates with that BB.
> 
> But that would be a whole new implementation...
> 

Yeah.

>>> (The block layer would then internally translate that to a BB.  But
>>> that's a bad internal interface because the bitmap is still attached to
>>> a BDS, and it's a bad external interface because currently you can
>>> attach bitmaps to nodes and only to nodes...)
>>
>> What if the type of bitmap we want to track trans-node changes was not
>> attached to a BDS? That'd be one way to obviously discriminate between
>> "This tracks tree-wide changes" and "This tracks node-local changes."
> 
> A new type of bitmap? :-/
> 

"type" may be too strong of a word, but... all the ones we use currently
are node-local.

>> Implementation wise I don't have any actual thought as to how this could
>> possibly be efficient. Maybe a bitmap reference at each BDS that is a
>> child of that particular BB?
>>
>> On attach, the BDS gets a set-only reference to that bitmap.
>> On detach, we remove the reference.
>>
>> Then, any writes anywhere in the tree will coagulate in one place. It
>> may or may not be particularly true or correct, because a write down the
>> tree doesn't necessarily mean the visible data has changed at the top
>> layer, but I don't think we have anything institutionally set in place
>> to determine if we are changing visible data up-graph with a write
>> down-graph.
> 
> Hmmm...  The first thing to clarify is whether we want two types of
> bitmaps.  I don't think there is much use to node-local bitmaps, all
> bitmaps should track every dirtying of their associated node (wherever
> it comes from).
> 

I don't disagree, but if that's the case then attaching bitmaps to
non-root nodes should be prohibited and we ought to shore up the
semantic idea that bitmaps must collect writes from their children.

I'm not sure that's any better inherently than expanding the idea to
include obvious differences between node-local and tree-wide bitmaps.
Currently, we just confuse the two concepts and do a poor job of either.

> However, if that is too much of a performance penalty...  Then we
> probably do have to distinguish between the two so that users only add
> tree-wide bitmaps when they need them.
> 
> OTOH, I guess that in the common case it's not a performance penalty at
> all, if done right.  Usually, a node you attach a bitmap to will not
> have child nodes that are written to by other nodes.  So in the common
> case your tree-wide bitmap is just a plain local bitmap and thus just as
> efficient.
> 
> And if some child node is indeed written to by some other node...  I
> think you always want a tree-wide bitmap anyway.
> 
> So I think all bitmaps should be tree-wide and the fact that they
> currently are not is a bug.
I could agree with this viewpoint, but that means we need to disallow
bitmaps to be attached to any non-root BDS, and then implement an
ability to give set-only references to children.

That's a bit of an extreme tactic that might prevent us from ever using
node-local bitmaps with anything resembling a sane API in the future.
Maybe that's OK, but it is a commitment.

I'm not sure there are any good reasons to have node-local bitmaps, but
the idea was one I more or less inherited when I started working in this
area because specifying specific BDS nodes with "device=" was going out
of vogue, but what exactly a BB was wasn't really defined yet, so I got
stuck with a QMP interface named "node=" and an implementation that has
an affinity for nodes.
