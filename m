Received: from eggs.gnu.org ([2001:4830:134:3::10]:53531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coAYc-00031P-TP
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coAYb-0005xv-TD
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:09:46 -0400
References: <20170314171120.80741-1-vsementsov@virtuozzo.com>
	<20170315110351.GG4030@noname.str.redhat.com>
	<9a68a30f-8765-ca91-572f-ed8d7083b202@redhat.com>
	<20170315143032.GK4030@noname.str.redhat.com>
	<87bb192d-b910-5ac2-886b-fefeb4a2ec4d@redhat.com>
	<20170315150210.GL4030@noname.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f49061f-a73c-35ea-9d8b-89d21e22cbfe@redhat.com>
Date: Wed, 15 Mar 2017 16:09:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170315150210.GL4030@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blk: fix aio context loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com



On 15/03/2017 16:02, Kevin Wolf wrote:
> Am 15.03.2017 um 15:43 hat Paolo Bonzini geschrieben:
>> On 15/03/2017 15:30, Kevin Wolf wrote:
>>> Am 15.03.2017 um 14:39 hat Paolo Bonzini geschrieben:
>>>> On 15/03/2017 12:03, Kevin Wolf wrote:
>>>>> But we discussed this earlier, and while I'm not completely sure any
>>>>> more about the details, I seem to remeber that Paolo said something
>>>>> along the lines that AioContext is going away anyway and building the
>>>>> code for proper management would be wasted time.
>>>>
>>>> AioContext is going to stay, but everybody will be able to send
>>>> operations to a BB/BDS from any AioContext.  The BDS AioContext will
>>>> only matter for network devices, since they have to attach the file
>>>> descriptor handlers somewhere.  For files it won't matter at all because
>>>> you can use multiple Linux AIO context or thread pools at the same time.
>>>
>>> Should the iothread option then become a -blockdev option rather than a
>>> -device one?
>>
>> Well, both.  The device also needs an I/O thread to attach its ioeventfd
>> handler.  And it makes sense to use the -device I/O thread if -blockdev
>> specified none.
> 
> Right, that makes sense. I just wasn't aware until now that we would get
> a per-node option, so that's good to know.

I hadn't thought about it either. :)

>>>> There should be a policy on which BB sets AioContext on the BDS (e.g.
>>>> only the device does it), but apart from that, it should not be an issue.
>>>
>>> We don't know which BBs are going to be attached. We don't necessarily
>>> have a device at all, or we could have two of them.
>>
>> Wow, can we really have two? :-O
> 
> What would prevent you from doing this? The whole blockdev work was
> about making the block layer more flexible, so now we have this
> flexibility of attaching more or less anything to anything (unless op
> blockers prevent it, which is why they are important for actually
> supporting blockdev).

Yeah, the actual question was more "will the blockers allow two" devices
behind the same BDS.  But I suppose there's no reason to prevent that
(emulating multipath, for example).

>>> Though maybe we should try to keep a BDS and its children in the same
>>> AioContext anyway if that's possible? Will it make a difference?
>>
>> Everything can make sense---but yes, keeping the whole hierarchy in the
>> same AioContext makes sense more often.
> 
> So I take this to mean that it does make a difference. :-)
> 
> If we want to keep users and their child nodes in the same AioContext by
> default, we'll probably still need to implement all of the callbacks
> that we would need for proper AioContext management today.

Or just assume that in the common case people won't specify iothread on
-blockdev, only on -device.

Paolo
