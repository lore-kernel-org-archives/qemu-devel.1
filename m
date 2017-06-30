Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQkDA-0000tg-M3
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQkD9-0000rd-8v
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:55:04 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
	<50f19b1d-9736-b8b3-5616-67c3393336f3@redhat.com>
	<8eb8d7bc-deba-f3cf-dc6f-a455eda81a44@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6e4fe097-c125-9f0b-1716-e12173f73e67@redhat.com>
Date: Thu, 29 Jun 2017 20:54:53 -0400
MIME-Version: 1.0
In-Reply-To: <8eb8d7bc-deba-f3cf-dc6f-a455eda81a44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: add
 bdrv_get_format_alloc_stat format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org



On 06/29/2017 08:45 PM, Eric Blake wrote:
> On 06/29/2017 07:27 PM, John Snow wrote:
>>
>>
>> On 06/06/2017 12:26 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> The function should collect statistics, about used/unused by top-level
>>> format driver space (in its .file) and allocation status
>>> (data/zero/discarded/after-eof) of corresponding areas in this .file.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
> 
>>> +#
>>> +# Allocation relations between format file and underlying protocol file.
>>> +# All fields are in bytes.
>>> +#
>>
>> I guess this is a relation in the sense that the format differentiates
>> between used-unused and the protocol differentiates between
>> data-zero-trim which gives us the 2D matrix, showing a relation between
>> "two" files.
>>
>> I find the use of the word "file" here a bit of a misdirection, though,
>> as qcow2 (or any other format) in this sense is not a file but rather a
>> schema used for interpreting data, and the file itself belongs solely to
>> the protocol.
>>
>> I might suggest phrasing this as ...
>>
>> "Allocation information of an underlying protocol file, as partitioned
>> by a format driver's utilization of said allocations."
>>
>> Maybe that's too wordy. Eric?
> 
> No, that actually sounds quite reasonable! We're stating how much of the
> protocol BDS is allocated, and subdividing those allocations by how much
> the format layer is using the allocation (where the format layer usage
> includes metadata not visible to the guest).  Our division of
> information will let us spot both directions of mismatches:
> 
> - the format layer is not currently referencing anything from the
> protocol layer, but the protocol layer doesn't have a hole (for example,
> possible in qcow2 both after a guest trims clusters, or when you delete
> an internal snapshot - and where we don't punch holes when freeing clusters)
> 
> - the format layer is currently spending bytes to reference arbitrary
> data from the protocol layer, but the protocol layer has a hole, so the
> format layer could use a more compact representation (for example, qcow2
> has an allocated cluster and assumes it is arbitrary data, but the
> underlying protocol layer has a hole, and bdrv_get_block_status returns
> a combination of BDRV_BLOCK_DATA|BDRV_BLOCK_ZERO thanks to its recursive
> calls to both BDS)
> 
>>
>> Here's an attempt:
>>
>> "Allocations may be considered either used or unused by the format
>> driver interpreting those allocations. It is at the discretion of the
>> format driver (e.g. qcow2) which regions of its backing storage are
>> considered in-use or not."
>>
>> I'm trying to clarify that it is not up to the qcow2 driver what "used"
>> or "unused" *means* but rather that only the qcow2 driver itself can
>> know which segments are used or unused, as these are semantic
>> distinctions that belong to the format driver layer. Does that make sense?
> 
> Works for me.
> 
> 
>> "Which is data referenced by the format driver located beyond EOF of the
>> protocol file."
>>
>> The key thing I am trying to illustrate in the phrase is that the format
>> file specifies or alludes to the existence of data that is beyond the
>> EOF for the protocol file.
>>
>> I think -- though I cannot prove -- that this is almost certainly a
>> special case of read-as-zero. If that is the case, perhaps we could
>> mention as much.
> 
> Yes, all format drivers that allow use of clusters beyond EOF of the
> underlying protocol treat that additional data as read-as-zero (at any
> rate, bdrv_co_get_block_status() already has that interpretation,
> because it adds BDRV_BLOCK_ZERO to the return value).
> 
>>
>> An example here would be really illustrative:
>>
>> "For example, a partially allocated cluster at the end of a QCOW2 file,
>> where Qcow2 generally operates on complete clusters."
>>
>>> +# So, the fields are:
>>> +#
>>> +# @used-data: used by the format file and backed by data in the underlying file
>>> +#
>>> +# @used-zero: used by the format file and backed by a hole in the underlying
>>> +#             file
>>> +#
>>
>> Maybe "backed by zeroes in the underlying file; which may be a
>> filesystem hole for e.g. POSIX files."
> 
> "for e.g." is redundant use of "for" (I remember a mnemonic for e.g. as
> "example given" [better than looking up the actual Latin abbreviation];
> but idiomatically, it's easiest to pronounce "e.g." as "for example").
> 

I surrender.

> 
>>
>>> +# @used-discarded: used by the format file but actually unallocated in the
>>> +#                  underlying file
>>> +#
>>
>> Which would almost certainly be an error, right? Mentioning as much
>> might be good.
> 
> Not necessarily an error, if it corresponds to a section that the guest
> has done a TRIM operation on, but where we did not have the means to
> punch a hole in the protocol layer.  The semantics of guest TRIM is that
> the data can no longer be reliably read, making it weaker (and thus
> easier to implement) than explicitly writing things to zero (although
> writing zeroes can often be sped up by trimming, when you have
> guarantees on what will be read later).
> 

But the data is considered "used" -- if it cannot be reliably read but
the format driver expects to be able to read it, is this not inherently
a category that signifies a semantic error?

Data that is considered "Discarded" by the protocol (we succeeded in
passing on the TRIM request from the guest through to the protocol)
should almost certainly no longer be considered "used" by the format...?

>>
>>> +# @used-overrun: used by the format file beyond the end of the underlying file
>>> +#
>>
>> Which may or may not be an error, depending on how the protocol file
>> (for the format driver?) handles reads to areas out of bounds.
> 
> Back to that read-as-zero semantics beyond EOF we mentioned above - as
> long as the format driver is okay with reads-as-zero content at those
> offsets, it is not an error.  But yeah, if someone truncated the
> underlying protocol file behind the format layer's back, then it's a
> data corruption issue (maybe only the metadata, but more likely also the
> guest-visible data).
> 
>>
>>> +# @unused-data: allocated data in the underlying file not used by the format
>>> +#
>>> +# @unused-zero: holes in the underlying file not used by the format file
>>> +#
>>> +# @unused-discarded: unallocated areas in the underlying file not used by the
>>> +#                    format file
>>> +#
>>> +# Note: sum of 6 fields {used,unused}-{data,zero,discarded} is equal to the
>>> +#       length of the underlying file.
>>> +#
>>> +# Since: 2.10
>>> +#
>>> +##
>>> +{ 'struct': 'BlockFormatAllocInfo',
>>> +  'data': {'used-data':        'uint64',
>>> +           'used-zero':        'uint64',
>>> +           'used-discarded':   'uint64',
>>> +           'used-overrun':     'uint64',
>>> +           'unused-data':      'uint64',
>>> +           'unused-zero':      'uint64',
>>> +           'unused-discarded': 'uint64' } }
>>> +
>>> +##
>>>  # @ImageCheck:
>>>  #
>>>  # Information about a QEMU image file check
>>>
>>
>> All of my suggestions here are purely on phrasings. The mechanics of
>> this patch are now clear to me and I think it is useful information to
>> have in qemu.
>>
>> Thanks for putting up with my questions!
>>
> 
