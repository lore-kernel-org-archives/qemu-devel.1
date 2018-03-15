Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewMWW-0000Ii-2B
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 02:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewMWV-0006da-Bv
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 02:38:00 -0400
Date: Thu, 15 Mar 2018 14:37:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180315063746.GD2733@lemon.usersys.redhat.com>
References: <8848a27f-4bac-b6be-08ab-a366438791a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8848a27f-4bac-b6be-08ab-a366438791a6@huawei.com>
Subject: Re: [Qemu-devel] Question: an IO hang problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, "Lulina (A)" <lina.lulina@huawei.com>, qemu-block@nongnu.org, "Subo (A)" <subo7@huawei.com>, "Fangyi (C)" <eric.fangyi@huawei.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, 03/13 17:38, sochin.jiang wrote:
> 
>  Hi, guys,
> 
>  Recently, I encountered an IO hang problem in occasion which I cannot reproduce it now.
> 
>  I analyzed this problem carefully, the critical stack is as following:
> 
> 
> After reading the codes in linux-aio.c(see ioq_submit() function), I found two situations could lead us here.
> 
> 1) no AIOs are in flight(s->ioq.in_flight is 0) and another call to io_submit returns -EAGAIN

So if there is no inflight I/O, why it would return -EAGAIN? The tricky thing
here is that since we're not expecting a completion, when should we retry?

> 
> 2) no AIOs are in flight(s->ioq.in_flight is 0) and s->io_q.pending IOs reach to MAX_EVENTS at once

I don't understand this case. We have,

        len = 0;
        QSIMPLEQ_FOREACH(aiocb, &s->io_q.pending, next) {
            iocbs[len++] = &aiocb->iocb;
            if (s->io_q.in_flight + len >= MAX_EVENTS) {
                break;
            }
        }

        ret = io_submit(s->ctx, len, iocbs);

If in_flight is 0, only (MAX_EVENTS - 1) requests can be added to iocbs, so
io_submit shouldn't return -EAGAIN.

> 
> In both the two situations above, the do{...}while loop breaks out and set s->io_q.blocked true.
> 
> After that, AIO completion callback will never be called,  ioq_submit() either, all pended requests will hang.
> 
> 
> Is there a proper way we can fix this while do not affect(stuck) the guest ?

Fam
