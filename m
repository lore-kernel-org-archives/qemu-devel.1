Received: from eggs.gnu.org ([2001:4830:134:3::10]:48671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAWzQ-00045U-45
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAWzI-0000yi-H3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gAWzD-0000v3-7a
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:10:29 -0400
References: <20181009205652.10605-1-david@redhat.com>
	<20181009205652.10605-5-david@redhat.com>
	<20181011090821.GC2483@work-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a2305986-84c9-671a-af1d-463814e5cfd6@redhat.com>
Date: Thu, 11 Oct 2018 11:10:18 +0200
MIME-Version: 1.0
In-Reply-To: <20181011090821.GC2483@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/7] range: add some more functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

On 11/10/2018 11:08, Dr. David Alan Gilbert wrote:
> * David Hildenbrand (david@redhat.com) wrote:
>> Add some more functions that will be used in memory-device context.
>>
>> range_init(): Init using lower bound and size
>> range_valid(): Check if there would be an overflow when initializin
>> range_size(): Extract the size of a range
>> range_overlaps_range(): Check for overlaps of two ranges
>> range_contains_range(): Check if one range is contained in the other
>> range_starts_before_range(): Check if one range starts before another
>> range_ends_after_range(): Check if one range ends after another
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/qemu/range.h | 80 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/include/qemu/range.h b/include/qemu/range.h
>> index 7e75f4e655..18e8acf22f 100644
>> --- a/include/qemu/range.h
>> +++ b/include/qemu/range.h
>> @@ -112,6 +112,86 @@ static inline uint64_t range_upb(Range *range)
>>      return range->upb;
>>  }
>>  
>> +/*
>> + * Initialize @range to span the interval [@lob,@lob + @size - 1].
>> + * @size may be 0.
>> + */
>> +static inline void range_init(Range *range, uint64_t lob, uint64_t size)
>> +{
>> +    range->lob = lob;
>> +    range->upb = lob + size - 1;
>> +    range_invariant(range);
>> +}
>> +
>> +/*
>> + * Check if the interval [@lob,@lob + @size - 1] would be valid or not
>> + * (result in an overflow).
>> + */
>> +static inline bool range_valid(uint64_t lob, uint64_t size)
>> +{
>> +    return lob + size >= lob;
>> +}
> 
> That name confused me, I'd expected that to have taken a range and check
> it for something (like a non-asserting version of the invariant).

Then we have to remove all the variant asserts from the initializer
functions (well, because then it is no longer an invariant then). Other
ideas?

-- 

Thanks,

David / dhildenb
