Received: from eggs.gnu.org ([2001:4830:134:3::10]:42682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFj3x-0007Al-7L
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFj3s-0003mN-9e
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:28:01 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36315 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFj3r-0003kK-V4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:27:56 -0400
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
	<20170530104857.70083-2-vsementsov@virtuozzo.com>
	<21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bd1de229-7eda-be84-c297-920d0de7b85f@virtuozzo.com>
Date: Tue, 30 May 2017 18:27:50 +0300
MIME-Version: 1.0
In-Reply-To: <21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] block: add bdrv_get_format_alloc_stat
 format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

30.05.2017 17:53, Eric Blake wrote:
> On 05/30/2017 05:48 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The function should collect statistics, about allocted/unallocated by
>> top-level format driver space (in its .file) and allocation status
>> (allocated/hole/after eof) of corresponding areas in this .file.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c                   | 16 ++++++++++++++++
>>   include/block/block.h     |  3 +++
>>   include/block/block_int.h |  2 ++
>>   qapi/block-core.json      | 26 ++++++++++++++++++++++++++
>>   4 files changed, 47 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index 50ba264143..7d720ae0c2 100644
>> --- a/block.c
>> +++ b/qapi/block-core.json
>> @@ -139,6 +139,32 @@
>>              '*format-specific': 'ImageInfoSpecific' } }
>>   
>>   ##
>> +# @BlockFormatAllocInfo:
>> +#
>> +# Information about allocations, including metadata. All fields are in bytes.
>> +#
>> +# @alloc_alloc: allocated by format driver and allocated in underlying file
>> +#
> New structs should favor naming with '-' rather than '_'. So this should
> be 'alloc-alloc', if we like the name.
>
> So this statistic represents the portions of the format file that are in
> use by the format, and which are backed by data in the underlying protocol.
>
>> +# @alloc_hole: allocated by format driver but actually is a hole in
>> +#              underlying file
> The portions of the format file in use by the format, but where the
> entire cluster is a hole in the underlying file (note that with cluster
> size large enough, you can get a cluster that is part-data/part-hole in
> the underlying file, it looks like you are counting those as data).

No, I account on sector boundary on bs->file. So it is not cluster-aligned.

>
>> +#
>> +# @alloc_overhead: allocated by format driver after end of underlying file
> The portions of the format file in use by the format, but where the
> entire cluster is beyond the end of the underlying file (the effective
> hole).  Do we really need to distinguish between hole within the
> underlying file and hole beyond the end of the file? Or can this number
> be combined with the previous?

alloc_alloc + alloc_hole + hole_alloc + hole_hole = size of bs->file, I 
think this is good and clear.

these 4 stats describes bs->file usage in details (not on cluster 
boundary, but on sector, based on bs->file block status), alloc_overhead 
is separate.

>
>> +#
>> +# @hole_alloc: not allocated by format driver but allocated in underlying file
> I'm not sure I like this name.  "Hole" in file-system terminology means
> "reads-as-zero" - but here we are talking about portions of the format
> layer that are unallocated (defer to backing file, and we can't
> guarantee they read as zero unless there is no backing file).
>
> This statistic represents the portion of the underlying file that has
> been previously allocated to hold data, but which is now unused by the
> format layer (in other words, leaked clusters that can be reclaimed, or
> which can be reused instead of growing the underlying the file if new
> clusters are allocated).
>
>> +#
>> +# @hole_hole: not allocated by format driver hole in underlying file
> This statistic represents fragmentation - portions of the format layer
> that are no longer in use, but which are also occupying no space in the
> underlying file.  A refragmentation operation (if we ever implemented
> one) could remove the address space used by these clusters, but would
> not change the disk usage.
>
>> +#
>> +# Since: 2.10
>> +#
>> +##
>> +{ 'struct': 'BlockFormatAllocInfo',
>> +  'data': {'alloc_alloc':    'uint64',
>> +           'alloc_hole':     'uint64',
>> +           'alloc_overhead': 'uint64',
>> +           'hole_alloc':     'uint64',
>> +           'hole_hole':      'uint64' } }
> The idea seems okay, but the naming needs to be fixed.  Also, I'm not
> sure if we need all 5, or if 4 is enough; and I'm not sure if we have
> the right names ("how does alloc-hole differ from hole-alloc?"), or if
> we can come up with something more descriptive.  Particularly since
> "hole-" is not a hole in the filesystem sense, so much as unused
> clusters.  But I'm also not coming up with better names to suggest at
> the moment.
>
yes, naming is a problem. Proposed has the advantage of short names, and 
easy to use, if you have read documentation) But without reading docs, 
it is hard to distinguish, what do they mean..


-- 
Best regards,
Vladimir
