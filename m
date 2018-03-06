Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1etFZA-0008SI-A1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1etFZ5-0003k1-DZ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:35:52 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:52812 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1etFZ5-0003jJ-3f
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:35:47 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 6 Mar 2018 17:35:40 +0100
References: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
	<20180305114533.GI7910@stefanha-x1.localdomain>
	<0f1ec3c7-1157-e618-62f8-ffd5e08eb342@kamp.de>
	<20180305145215.GM3131@work-vm>
	<20180306160739.GN31045@stefanha-x1.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <824907bb-3a37-27bd-76db-be17d05bdac0@kamp.de>
Date: Tue, 6 Mar 2018 17:35:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180306160739.GN31045@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] block migration and MAX_IN_FLIGHT_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 06.03.2018 um 17:07 schrieb Stefan Hajnoczi:
> On Mon, Mar 05, 2018 at 02:52:16PM +0000, Dr. David Alan Gilbert wrote:
>> * Peter Lieven (pl@kamp.de) wrote:
>>> Am 05.03.2018 um 12:45 schrieb Stefan Hajnoczi:
>>>> On Thu, Feb 22, 2018 at 12:13:50PM +0100, Peter Lieven wrote:
>>>>> I stumbled across the MAX_INFLIGHT_IO field that was introduced in 2015 and was curious what was the reason
>>>>> to choose 512MB as readahead? The question is that I found that the source VM gets very unresponsive I/O wise
>>>>> while the initial 512MB are read and furthermore seems to stay unreasponsive if we choose a high migration speed
>>>>> and have a fast storage on the destination VM.
>>>>>
>>>>> In our environment I modified this value to 16MB which seems to work much smoother. I wonder if we should make
>>>>> this a user configurable value or define a different rate limit for the block transfer in bulk stage at least?
>>>> I don't know if benchmarks were run when choosing the value.  From the
>>>> commit description it sounds like the main purpose was to limit the
>>>> amount of memory that can be consumed.
>>>>
>>>> 16 MB also fulfills that criteria :), but why is the source VM more
>>>> responsive with a lower value?
>>>>
>>>> Perhaps the issue is queue depth on the storage device - the block
>>>> migration code enqueues up to 512 MB worth of reads, and guest I/O has
>>>> to wait?
>>> That is my guess. Especially if the destination storage is faster we basically alsways have
>>> 512 I/Os in flight on the source storage.
>>>
>>> Does anyone mind if the reduce that value to 16MB or do we need a better mechanism?
>> We've got migration-parameters these days; you could connect it to one
>> of those fairly easily I think.
>> Try: grep -i 'cpu[-_]throttle[-_]initial'  for an example of one that's
>> already there.
>> Then you can set it to whatever you like.
> It would be nice to solve the performance problem without adding a
> tuneable.
>
> On the other hand, QEMU has no idea what the queue depth of the device
> is.  Therefore it cannot prioritize guest I/O over block migration I/O.
>
> 512 parallel requests is much too high.  Most parallel I/O benchmarking
> is done at 32-64 queue depth.
>
> I think that 16 parallel requests is a reasonable maximum number for a
> background job.
>
> We need to be clear though that the purpose of this change is unrelated
> to the original 512 MB memory footprint goal.  It just happens to touch
> the same constant but the goal is now to submit at most 16 I/O requests
> in parallel to avoid monopolizing the I/O device.

I think we should really look at this. The variables that control if we stay in the while loop or not are incremented and decremented
at the following places:

mig_save_device_dirty:
mig_save_device_bulk:
    block_mig_state.submitted++;

blk_mig_read_cb:
    block_mig_state.submitted--;
    block_mig_state.read_done++;

flush_blks:
    block_mig_state.read_done--;

The condition of the while loop is:
(block_mig_state.submitted +
            block_mig_state.read_done) * BLOCK_SIZE <
           qemu_file_get_rate_limit(f) &&
           (block_mig_state.submitted +
            block_mig_state.read_done) <
           MAX_INFLIGHT_IO)

At first I wonder if we ever reach the rate-limit because we put the read buffers onto f AFTER we exit the while loop?

And even if we reach the limit we constantly maintain 512 I/Os in parallel because we immediately decrement read_done
when we put the buffers to f in flush_blks. In the next iteration of the while loop we then read again until we have 512 in-flight I/Os.

And shouldn't we have a time limit to limit the time we stay in the while loop? I think we artificially delay sending data to f?

Peter
