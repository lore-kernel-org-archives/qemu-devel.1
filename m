Received: from eggs.gnu.org ([2001:4830:134:3::10]:52205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djlXu-00076n-V1
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djlXp-00068b-5u
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:11:06 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170819152312.752zb42qc5ko6rat@postretch>
References: <cover.1502979710.git.berto@igalia.com>
	<112e28c8da085ffd59381d86f3acb0b8f75d5f9a.1502979710.git.berto@igalia.com>
	<20170819152312.752zb42qc5ko6rat@postretch>
Date: Mon, 21 Aug 2017 14:10:59 +0200
Message-ID: <w51efs5nmss.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/4] throttle: Remove throttle_fix_bucket()
 / throttle_unfix_bucket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Sat 19 Aug 2017 05:23:12 PM CEST, Manos Pitsidianakis wrote:
>>-    /* If the bucket is full then we have to wait */
>>-    extra = bkt->level - bkt->max * bkt->burst_length;
>>+    if (!bkt->max) {
>>+        /* If bkt->max is 0 we still want to allow short bursts of I/O
>>+         * from the guest, otherwise every other request will be throttled
>>+         * and performance will suffer considerably. */
>>+        bucket_size = bkt->avg / 10;
>>+        burst_bucket_size = 0;
>
> Might be wrong, but shouldn't that be
>     bucket_size = (bkt->avg / 10) * bkt->burst_length?
>     burst_bucket_size = (bkt->avg / 10) / 10;

if !bkt->max then the user didn't define any bursts, and the I/O is only
throttled to the rate set in bkt->avg.

>>+    } else {
>>+        /* If we have a burst limit then we have to wait until all I/O
>>+         * at burst rate has finished before throttling to bkt->avg */
>>+        bucket_size = bkt->max * bkt->burst_length;
>>+        burst_bucket_size = bkt->max / 10;
>>+    }
>>+
>>+    /* If the main bucket is full then we have to wait */
>>+    extra = bkt->level - bucket_size;
> because it used to be that if bkt->max is 0 then
>  extra = bkt->level - (bkt->avg /10) * bkt->burst_length; //fixed value
>  and now it's
>  extra = bkt->level - (bkt->avg / 10);
>
>  and
>
>>     if (extra > 0) {
>>         return throttle_do_compute_wait(bkt->avg, extra);
>>     }
>>
>>-    /* If the bucket is not full yet we have to make sure that we
>>-     * fulfill the goal of bkt->max units per second. */
>>+    /* If the main bucket is not full yet we still have to check the
>>+     * burst bucket in order to enforce the burst limit */
>>     if (bkt->burst_length > 1) {
>>-        /* We use 1/10 of the max value to smooth the throttling.
>>-         * See throttle_fix_bucket() for more details. */
>>-        extra = bkt->burst_level - bkt->max / 10;
>>+        extra = bkt->burst_level - burst_bucket_size;
> This used to be 
>
>     extra = bkt->burst_level - (bkt->avg / 10) / 10;
> and now it's
>     extra = bkt->burst_level  - 0;

No, if bkt->burst_length > 1 then bkt->max != 0, and therefore
burst_bucket_size is never 0 either.

Perhaps you missed the ! in the first "if (!bkt->max)" ?

Berto
