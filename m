Received: from eggs.gnu.org ([2001:4830:134:3::10]:51276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgWks-0004Ee-Lh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgWkp-0002O3-Tc
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:14:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170222111433.GA3386@stefanha-x1.localdomain>
References: <20170220165204.1980-1-stefanha@redhat.com>
	<w51tw7nbykn.fsf@maestria.local.igalia.com>
	<20170222111433.GA3386@stefanha-x1.localdomain>
Date: Wed, 22 Feb 2017 14:14:08 +0100
Message-ID: <w51lgsyz7tr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-options: explain disk I/O throttling
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org

On Wed 22 Feb 2017 12:14:33 PM CET, Stefan Hajnoczi wrote:
>> > Values must be larger than the maximum
>> > +request size to avoid timeouts or hangs in the guest.  At minimum use 2 MB/s
>> > +for disks.
>> 
>> Is this so? throttle_compute_wait() does not use the request size at
>> all. The size is used to do the accounting afterwards. In other
>> words: requests are not throttled if they exceed the limit, they are
>> throttled after the limit has been exceeded by previous requests.
>> 
>> A low limit will certainly slow down the guest and can cause
>> timeouts, but I don't know if being larger or smaller than the maximum
>> request size is what makes the difference.
>
> You are right, I'm still have the behavior of the old throttling
> implementation in mind.
>
> I'd still like to recommend a sane minimum because anything around the
> size of a single request leads to timeouts and hangs inside the guest.

Yes, that sounds sensible.

> How about:
>
>   Small values can lead to timeouts or hangs inside the guest.  A safe
>   minimum for disks is 2 MB/s.

Looks good to me.

>> > +@item bps_max=@var{bm},bps_rd_max=@var{rm},bps_wr_max=@var{wm}
>> > +Specify bursts in bytes per second, either for all request types or for reads
>> > +or writes only.  Bursts allow the guest I/O to spike above the limit
>> > +temporarily.  The default burst value is 1/10th of the limit.
>> 
>> "The default burst value is 1/10th of the limit" is an implementation
>> detail that the user doesn't need to know about. What it means is that a
>> bps limit of 10 MB/s is implemented internally as 1MB per 100ms.
>>
>> I would leave that out, it doesn't even make sense that the burst limit
>> is lower than the normal limit, we actually forbid that (aaa1e77ffae52).
>
> Unfortunately the bps_max = avg / 10 default value is visible via
> query-block.  A bug was recently reported about this:
> https://bugzilla.redhat.com/show_bug.cgi?id=1414630
>
> Would you prefer a private field in the throttling code so this detail
> is hidden from users?

Oh, I see. I would rather hide it from the user, either in throttle.c or
even in bdrv_block_device_info().

Berto
