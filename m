Received: from eggs.gnu.org ([2001:4830:134:3::10]:52907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cyggX-0003yv-9w
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 11:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cyggT-0001JI-9d
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 11:29:25 -0400
MIME-Version: 1.0
In-Reply-To: <c74d2b7d-d185-53ba-9bf9-8cf976d8f684@redhat.com>
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
	<20170412235420.GB8607@lemon>
	<20170413011109.GC15762@localhost.localdomain>
	<c74d2b7d-d185-53ba-9bf9-8cf976d8f684@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Apr 2017 16:29:17 +0100
Message-ID: <CAJSP0QUgg5RkEu_9-MFm65f_DrYEQ7xpL2HzerDxv+sxVZHq_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-block] Regression from 2.8: stuck in
 bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Apr 13, 2017 at 6:45 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 13/04/2017 09:11, Jeff Cody wrote:
>>> It didn't make it into 2.9-rc4 because of limited time. :(
>>>
>>> Looks like there is no -rc5, we'll have to document this as a known issue.
>>> Users should "block-job-complete/cancel" as soon as possible to avoid such a
>>> hang.
>>
>> I'd argue for including a fix for 2.9, since this is both a regression, and
>> a hard lock without possible recovery short of restarting the QEMU process.
>
> It is a bit of a corner case (and jobs on I/O thread are relatively rare
> too), so maybe it's not worth delaying 2.9.  It has been delayed already
> quite a bit.  Another reason I think I prefer to wait is to ensure that
> we have an entry in qemu-iotests to avoid the future regression.
>
> Fam explained to me what happens, and the root cause is that bdrv_drain
> never does a release/acquire pair in this case, so the I/O thread run
> remains stuck in a callback that tries to acquire.  Ironically
> reintroducing RFifoLock would probably fix this (not 100% sure).  Oops.
>
> His solution is a bit hacky, but we will hopefully be able to revert it
> in 2.10 or whenever aio_context_acquire/release will go away.

Fam, many of us will be offline Friday and Monday due to public
holidays.  Can you work on a patch that addresses Kevin's concerns
with "[PATCH for-2.9 4/5] block: Drain BH in bdrv_drained_begin"?

I'll be officially offline too but am willing to review the patch.

Thanks,
Stefan
