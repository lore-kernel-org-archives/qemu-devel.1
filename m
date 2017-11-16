Received: from eggs.gnu.org ([2001:4830:134:3::10]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFIIc-0002HO-Am
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFIIb-0006Ie-CU
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:25:38 -0500
MIME-Version: 1.0
In-Reply-To: <w51d14m9rri.fsf@maestria.local.igalia.com>
References: <20171110151934.16883-1-stefanha@redhat.com>
	<w51d14m9rri.fsf@maestria.local.igalia.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 16 Nov 2017 11:25:35 +0000
Message-ID: <CAJSP0QV_TTz-x77thd9o3hc30v0F=SQsw+x4X1DVSTOPvX0=+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] throttle-groups: drain
 before detaching ThrottleState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Mon, Nov 13, 2017 at 2:29 PM, Alberto Garcia <berto@igalia.com> wrote:
> On Fri 10 Nov 2017 04:19:34 PM CET, Stefan Hajnoczi wrote:
>> I/O requests hang after stop/cont commands at least since QEMU 2.10.0
>> with -drive iops=100:
>>
>>   (guest)$ dd if=/dev/zero of=/dev/vdb oflag=direct count=1000
>>   (qemu) stop
>>   (qemu) cont
>>   ...I/O is stuck...
>>
>> This happens because blk_set_aio_context() detaches the ThrottleState
>> while requests may still be in flight:
>>
>>   if (tgm->throttle_state) {
>>       throttle_group_detach_aio_context(tgm);
>>       throttle_group_attach_aio_context(tgm, new_context);
>>   }
>>
>> This patch encloses the detach/attach calls in a drained region so no
>> I/O request is left hanging.  Also add assertions so we don't make the
>> same mistake again in the future.
>
> I'm wondering about the implications of this change... is it possible
> now to bypass the I/O limits simply by stopping and quickly resuming the
> VM? And is that a problem?

bdrv_set_aio_context() already drains so this patch doesn't change
existing behavior with respect to bypassing throttling.

It's not ideal that certain VM lifecycle operations temporarily
disable throttling, but it's a trade-off since synchronous drain is
usually performance sensitive and should not take a long time.
Perhaps there are ways to improve the situation, I haven't studied it
in detail.

Stefan
