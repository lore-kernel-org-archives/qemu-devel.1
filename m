Received: from eggs.gnu.org ([209.51.188.92]:39098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmyl5-00010i-Kg
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmyl4-0008P5-Ga
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:30:47 -0500
Date: Fri, 25 Jan 2019 11:30:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190125103015.GA9055@linux.fritz.box>
References: <20190124141731.21509-1-kwolf@redhat.com>
	<f3b34487-5c86-287e-00b5-331adf9ac931@virtuozzo.com>
	<20190124151105.GH4601@localhost.localdomain>
	<093415a1-c31c-c727-583f-bf3176621336@virtuozzo.com>
	<20190124154248.GK4601@localhost.localdomain>
	<3cf90de9-5fc5-c24c-b232-bd0f564202a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf90de9-5fc5-c24c-b232-bd0f564202a9@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 25.01.2019 um 11:10 hat Paolo Bonzini geschrieben:
> On 24/01/19 16:42, Kevin Wolf wrote:
> >> Recently Paolo asked me not to add more users of AioContext lock. Unfortunately
> >> I don't understand the whole picture around it.. Doesn't this apply here?
> >> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg03410.html
> > I don't know. Honestly I feel nobody except Paolo knows, because we
> > don't know his patches yet.
> 
> This is true.  On the other hand, the AioContext lock is only used in
> some special cases around block jobs and blk_set_aio_context, and in
> general the block devices already should not have any dependencies
> (unless they crept in without me noticing).

It's also used in those cases where coroutines don't need locking, but
threads would. Did you audit all of the drivers for such cases?

> In particular...
> 
> > But raw doesn't have an s->lock yet, so I
> > think removing the AioContext lock involves some work on it anyway and
> > adding this doesn't really change the amount of work.
> 
> ... BDRVRawState doesn't have any data that changes after open, does it?
>  This is why it doesn't have an s->lock.

No important data anyway. We do things like setting s->has_write_zeroes
= false after failure, but if we got a race and end up trying twice
before disabling it, it doesn't really hurt either.

Then there is reopen, but that involves a drain anyway. And that's it
probably.

So do you think I should introduce a CoMutex for raw here? Or QemuMutex?

Kevin
