Received: from eggs.gnu.org ([2001:4830:134:3::10]:34024)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cdE9S-000710-4N
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cdE9P-0007A4-1h
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:46:34 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:57757 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cdE9O-00079h-OE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:46:30 -0500
References: <1486051604-32310-1-git-send-email-pl@kamp.de>
	<283ed47f-1252-bbde-6c2b-9476adec04a3@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <a62f64b1-6006-a906-f450-fb31f80f743a@kamp.de>
Date: Mon, 13 Feb 2017 11:46:26 +0100
MIME-Version: 1.0
In-Reply-To: <283ed47f-1252-bbde-6c2b-9476adec04a3@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC][PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com


Am 12.02.2017 um 03:06 schrieb Max Reitz:
> On 02.02.2017 17:06, Peter Lieven wrote:
>> this is something I have been thinking about for almost 2 years now.
>> we heavily have the following two use cases when using qemu-img convert.
>>
>> a) reading from NFS and writing to iSCSI for deploying templates
>> b) reading from iSCSI and writing to NFS for backups
>>
>> In both processes we use libiscsi and libnfs so we have no kernel pagecache.
>> As qemu-img convert is implemented with sync operations that means we
>> read one buffer and then write it. No parallelism and each sync request
>> takes as long as it takes until it is completed.
>>
>> What I put together is an approach to use aio routines for the conversion
>> process to have ideally read and write happening in parallel.
>>
>> The code is far from clean or complete, but I would appreaciate comments
>> and thoughts from you.
>>
>> So far I have the following runtimes when reading an uncompressed QCOW2 from
>> NFS and writing it to iSCSI (raw):
>>
>> qemu-img (master)
>>   nfs -> iscsi 33 secs
>>   nfs -> ram   19 secs
>>   ram -> iscsi 14 secs
>>
>> qemu-img-async
>>   nfs -> iscsi 23 secs
>>   nfs -> ram   17 secs
>>   ram -> iscsi 14 secs
>>
>> Its visible that on master the runtimes add up as expected. The async branch
>> is faster, but not as fast as I would have expected. I would expect the runtime
>> to be as slow as the slowest of the two involved transfers.
>>
>> Thank you,
>> Peter
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   qemu-img.c | 271 +++++++++++++++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 199 insertions(+), 72 deletions(-)
> Asynchronous convert sounds good. But your implementation looks a bit
> weird to me.
>
> Your implementation has four "slots" which receive work from a central
> work queue that they then process. You can do that, but it looks
> counter-intuitive to me. (Or if you do that, I would do it using
> coroutines: Start up four coroutines that simply submit blk_co_* requests.)
>
> What I would have done (if using AIO) is the following: Seek through the
> image, finding the next bit of work to do (without having a central work
> queue). Then submit an AIO request with a newly allocated piece of data
> (not using fixed slots). Continue until four requests are in flight,
> then wait until one is settled.

Hi Max,

thank you very much for you feedback. The reason why I have this worker
queue is that I ended up with recursive invocations of the fill_read/write_queue
functions. The problem is convert_iterate_sectors. Its not only quite expensive
it also leads to callback invocation.

I also tried with coroutines, but ended up in the same problem. But I did not
fire up worker "threads", I fired up a coroutine for each read/write. Let my try
to have x worker threads and let them do the work. The 2 issues that have
to be adressed however are: convert_iterate_sectors must not be called
in parallel and all writes should be sequential.

I will have a look.

Peter
