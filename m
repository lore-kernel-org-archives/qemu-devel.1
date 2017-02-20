Received: from eggs.gnu.org ([2001:4830:134:3::10]:58222)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cfpRP-000756-RO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cfpRL-0008Fz-R0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:59:51 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:38475 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cfpRL-0008Ej-HU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:59:47 -0500
References: <1487347224-8667-1-git-send-email-pl@kamp.de>
	<20170220145011.GJ21255@stefanha-x1.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
Date: Mon, 20 Feb 2017 15:59:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170220145011.GJ21255@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH V4] qemu-img: make convert
 async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Am 20.02.2017 um 15:50 schrieb Stefan Hajnoczi:
> On Fri, Feb 17, 2017 at 05:00:24PM +0100, Peter Lieven wrote:
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
>> This is version 4 of the approach using coroutine worker "threads".
>>
>> So far I have the following runtimes when reading an uncompressed QCOW2 from
>> NFS and writing it to iSCSI (raw):
>>
>> qemu-img (master)
>>   nfs -> iscsi 22.8 secs
>>   nfs -> ram   11.7 secs
>>   ram -> iscsi 12.3 secs
>>
>> qemu-img-async (8 coroutines, in-order write disabled)
>>   nfs -> iscsi 11.0 secs
>>   nfs -> ram   10.4 secs
>>   ram -> iscsi  9.0 secs
>>
>> The following are the runtimes found with different settings between V3 and V4.
>> This is always the best runtime out of 10 runs when converting from nfs to iscsi.
>> Please note that in V4 in-order write scenarios show a very high jitter. I think
>> this is because the get_block_status on the NFS share is delayed by concurrent read
>> requests.
>>
>>                         in-order        out-of-order
>> V3  - 16 coroutines    12.4 seconds    11.1 seconds
>>      -  8 coroutines    12.2 seconds    11.3 seconds
>>      -  4 coroutines    12.5 seconds    11.1 seconds
>>      -  2 coroutines    14.8 seconds    14.9 seconds
>>
>> V4  - 32 coroutines    15.9 seconds    11.5 seconds
>>      - 16 coroutines    12.5 seconds    11.0 seconds
>>      -  8 coroutines    12.9 seconds    11.0 seconds
>>      -  4 coroutines    14.1 seconds    11.5 seconds
>>      -  2 coroutines    16.9 seconds    13.2 seconds
> Does this patch work with compressed images?  Especially the
> out-of-order write mode may be problematic with a compressed qcow2 image.

It does, but you are right, out-of-order writes and compression should
be mutually exclusive.

>
> How should a user decide between in-order and out-of-order?

In general, out of order is ok, when we write to a preallocated device (e.g. all raw
devices or qcow2 with preallocation=full). default is in-order write. the user has
to manually enable out of order.

>
>> @@ -1651,12 +1680,117 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>>       return 0;
>>   }
>>   
>> -static int convert_do_copy(ImgConvertState *s)
>> +static void convert_co_do_copy(void *opaque)
> Missing coroutine_fn here and for convert_co_read()/convert_co_write().
> Functions that must be called from coroutine context (because they
> yield, use coroutine mutexes, etc) need to be marked as such.

okay.

>
>> +        if (s->wr_in_order) {
>> +            /* reenter the coroutine that might have waited
>> +             * for this write to complete */
>> +            s->wr_offs = sector_num + n;
>> +            for (i = 0; i < s->num_coroutines; i++) {
>> +                if (s->co[i] && s->wait_sector_num[i] == s->wr_offs) {
>> +                    qemu_coroutine_enter(s->co[i]);
>> +                    break;
> This qemu_coroutine_enter() call relies on the yield pattern between
> sibling coroutines having no recursive qemu_coroutine_enter() calls.
> QEMU aborts if there is a code path where coroutine A enters B and then
> B enters A again before yielding.
>
> Paolo's new aio_co_wake() API solves this issue by deferring the
> qemu_coroutine_enter() to the event loop.  It's similar to CoQueue
> wakeup.  aio_co_wake() is part of my latest block pull request (should
> be merged into qemu.git soon).
>
> I *think* this patch has no A -> B -> A situation thanks to yields in
> the code path, but it would be nicer to use aio_co_wake() where this can
> never happen.

I also believe this can't happen. Would it be also okay to use
qemu_coroutine_enter_if_inactive() here?

>
>> +        case 'm':
>> +            num_coroutines = atoi(optarg);
>> +            if (num_coroutines > MAX_COROUTINES) {
>> +                error_report("Maximum allowed number of coroutines is %d",
>> +                             MAX_COROUTINES);
>> +                ret = -1;
>> +                goto fail_getopt;
>> +            }
> Missing input validation for the < 1 case.

Right.

Thank you,
Peter
