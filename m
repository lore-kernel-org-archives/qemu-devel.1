Received: from eggs.gnu.org ([2001:4830:134:3::10]:38129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqInq-0006IP-TN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqIno-0000MZ-NL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:59:06 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6c318533-dc87-daeb-1fe8-6b11b0cbec8d@virtuozzo.com>
Date: Thu, 16 Aug 2018 16:58:46 +0300
MIME-Version: 1.0
In-Reply-To: <13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: async handling of fragmented io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

16.08.2018 03:51, Max Reitz wrote:
> On 2018-08-07 19:43, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here is an asynchronous scheme for handling fragmented qcow2
>> reads and writes. Both qcow2 read and write functions loops through
>> sequential portions of data. The series aim it to parallelize these
>> loops iterations.
>>
>> It improves performance for fragmented qcow2 images, I've tested it
>> as follows:
>>
>> I have four 4G qcow2 images (with default 64k block size) on my ssd disk:
>> t-seq.qcow2 - sequentially written qcow2 image
>> t-reverse.qcow2 - filled by writing 64k portions from end to the start
>> t-rand.qcow2 - filled by writing 64k portions (aligned) in random order
>> t-part-rand.qcow2 - filled by shuffling order of 64k writes in 1m clusters
>> (see source code of image generation in the end for details)
>>
>> and the test (sequential io by 1mb chunks):
>>
>> test write:
>>      for t in /ssd/t-*; \
>>          do sync; echo 1 > /proc/sys/vm/drop_caches; echo ===  $t  ===; \
>>          ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none -w $t; \
>>      done
>>
>> test read (same, just drop -w parameter):
>>      for t in /ssd/t-*; \
>>          do sync; echo 1 > /proc/sys/vm/drop_caches; echo ===  $t  ===; \
>>          ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none $t; \
>>      done
>>
>> short info about parameters:
>>    -w - do writes (otherwise do reads)
>>    -c - count of blocks
>>    -s - block size
>>    -t none - disable cache
>>    -n - native aio
>>    -d 1 - don't use parallel requests provided by qemu-img bench itself
> Hm, actually, why not?  And how does a guest behave?
>
> If parallel requests on an SSD perform better, wouldn't a guest issue
> parallel requests to the virtual device and thus to qcow2 anyway?

Guest knows nothing about qcow2 fragmentation, so this kind of 
"asynchronization" could be done only at qcow2 level.
However, if guest do async io, send a lot of parallel requests, it 
behave like qemu-img without -d 1 option, and in this case,
parallel loop iterations in qcow2 doesn't have such great sense. 
However, I think that async parallel requests are better in
general than sequential, because if device have some unused opportunity 
of parallelization, it will be utilized. We've already
use this approach in mirror and qemu-img convert. In Virtuozzo we have 
backup, improved by parallelization of requests
loop too. I think, it would be good to have some general code for such 
things in future.

>
> (I suppose the global qcow2 lock could be an issue here, but then your
> benchmark should work even without -d 1.)
>
> Max
>


-- 
Best regards,
Vladimir
