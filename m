Received: from eggs.gnu.org ([2001:4830:134:3::10]:48467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fEBXH-0007n9-OP
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fEBXE-0000b5-LW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:32:27 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
	<b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
	<w51h8nqcijb.fsf@maestria.local.igalia.com>
	<aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
Date: Thu, 03 May 2018 12:32:21 +0200
Message-ID: <w51bmdx6nd6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 02 May 2018 04:12:49 PM CEST, Max Reitz wrote:
> On 2018-05-02 15:07, Alberto Garcia wrote:
>> On Wed 25 Apr 2018 04:03:22 PM CEST, Max Reitz wrote:
>>>>> But the question stands whether we need simple node replacement when
>>>>> we want bdrv_reopen() anyway.  In addition, we don't need just
>>>>> replacement, we also need addition and removal (e.g. for backing
>>>>> files or quorum children) -- and especially in the case of quorum,
>>>>> that is going to be a pain (mostly naming the children).
>>>>>
>>>>> With bdrv_reopen(), we can just require the user to respecify all
>>>>> children, so we don't run into the issue of how to name things at
>>>>> least.
>>>>
>>>> So in this example, if you want to replace [B] with [E] you would
>>>> reopen [C] specifying the new backing file?
>>>>
>>>>    [A] <- [B] <- [C] <- [D]
>>>>
>>>>           [E]
>>>
>>> You can just use child node name references like in blockdev-add.
>> 
>> Were the (more or less) exact requirements of QMP blockdev-reopen
>> discussed? How is it different from qemu-io's "reopen" command? What are
>> the options that you can and can not change?
>
> I can't quite remember, I'm afraid.  I think it was supposed to be
> pretty much qemu-io's reopen (so just bdrv_reopen()).  I suppose you
> cannot change the driver (obviously) or probably the node name,
> because either would result in the node being replaced by a completely
> new one.

I was testing qemu-io's reopen and it didn't seem like you could change
the backing chain at all, so this would probably need to do more things.

> Other than that, it probably depends on what the block driver
> supports, but ideally you should be able to change everything.

I agree.

>> Also, you could replace an element in the backing chain using reopen,
>> but can you replace a node that is not a backing image of another
>> one?
>
> Node replacement only makes sense if the node is used as the child of
> something.  Otherwise it's just a blockdev-add + blockdev-del.

But how do you do blockdev-del of a root node if it's being used by the
guest?

> But it doesn't have to be in a backing chain, of course.  It would
> work for Quorum children, too.

Sure, I meant "child" when I said "backing image" :-)

>> With QMP blockdev-replace you could use the existing blockdev-add
>> command and create an arbitrary tree and then simply do
>> blockdev-replace so I suppose that for some use cases at least it
>> would be pretty straightforward.
>
> You can do the same with reopen.  Just use a reference for the child
> name.

Yes, yes, I agree. I mean that the implementation with blockdev-replace
seems much simpler.

Although there are cases where blockdev-replace would probably not work,
e.g. if you want to change the options of an image opened in read-write
mode. In this case you cannot open the image again with the new options
and replace the old with the new one because of the image locks. So you
would need to reopen the image instead.

Berto
