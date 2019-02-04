Received: from eggs.gnu.org ([209.51.188.92]:59817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqbKN-00042V-HU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqbKM-0001I6-Or
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:18:11 -0500
References: <20190124141731.21509-1-kwolf@redhat.com>
	<f3b34487-5c86-287e-00b5-331adf9ac931@virtuozzo.com>
	<20190124151105.GH4601@localhost.localdomain>
	<093415a1-c31c-c727-583f-bf3176621336@virtuozzo.com>
	<20190124154248.GK4601@localhost.localdomain>
	<3cf90de9-5fc5-c24c-b232-bd0f564202a9@redhat.com>
	<20190125103015.GA9055@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7ce2a07-8cd8-cb63-0e35-bd1c41dfd7c7@redhat.com>
Date: Mon, 4 Feb 2019 11:17:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190125103015.GA9055@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 25/01/19 11:30, Kevin Wolf wrote:
>> On the other hand, the AioContext lock is only used in
>> some special cases around block jobs and blk_set_aio_context, and in
>> general the block devices already should not have any dependencies
>> (unless they crept in without me noticing).
> It's also used in those cases where coroutines don't need locking, but
> threads would. Did you audit all of the drivers for such cases?

I did and the drivers already have a QemuMutex if that's the case (e.g.
curl, iscsi).

>> In particular...
>>
>>> But raw doesn't have an s->lock yet, so I
>>> think removing the AioContext lock involves some work on it anyway and
>>> adding this doesn't really change the amount of work.
>> ... BDRVRawState doesn't have any data that changes after open, does it?
>>  This is why it doesn't have an s->lock.
> No important data anyway. We do things like setting s->has_write_zeroes
> = false after failure, but if we got a race and end up trying twice
> before disabling it, it doesn't really hurt either.
> 
> Then there is reopen, but that involves a drain anyway. And that's it
> probably.
> 
> So do you think I should introduce a CoMutex for raw here? Or QemuMutex?

For the cache you can introduce either a CoMutex or QemuMutex, it's the
same.

Paolo
