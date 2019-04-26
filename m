Received: from eggs.gnu.org ([209.51.188.92]:54788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJyuC-0003M8-4K
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJyuA-0007EV-V1
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:20:36 -0400
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-10-borntraeger@de.ibm.com>
	<c07b4807-787b-3420-1cae-fb29f56dd9b4@redhat.com>
	<41f2c4a5-7f40-3155-ba8c-e92d0c80b53e@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5971a515-53ee-de49-ebe0-6773ce3d4496@redhat.com>
Date: Fri, 26 Apr 2019 13:20:31 +0200
MIME-Version: 1.0
In-Reply-To: <41f2c4a5-7f40-3155-ba8c-e92d0c80b53e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/10] s390x/cpumodel: disable csske and
 bpb from gen15 cpu models onwards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 26.04.19 13:18, Christian Borntraeger wrote:
> 
> 
> On 26.04.19 13:18, David Hildenbrand wrote:
>> On 26.04.19 13:10, Christian Borntraeger wrote:
>>> These facilities are deprecated and no longer needed.
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  target/s390x/gen-features.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>>> index 6260f56dc1..c346b76bdf 100644
>>> --- a/target/s390x/gen-features.c
>>> +++ b/target/s390x/gen-features.c
>>> @@ -13,6 +13,7 @@
>>>  
>>>  #include <inttypes.h>
>>>  #include <stdio.h>
>>> +#include <string.h>
>>>  #include "cpu_features_def.h"
>>>  
>>>  #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
>>> @@ -833,6 +834,11 @@ static void set_bits(uint64_t list[], BitSpec bits)
>>>      }
>>>  }
>>>  
>>> +static inline void clear_bit(uint64_t list[], unsigned long nr)
>>> +{
>>> +    list[nr / 64] &= ~(1ULL << (nr % 64));
>>> +}
>>> +
>>>  static void print_feature_defs(void)
>>>  {
>>>      uint64_t base_feat[S390_FEAT_MAX / 64 + 1] = {};
>>> @@ -843,6 +849,12 @@ static void print_feature_defs(void)
>>>      printf("\n/* CPU model feature list data */\n");
>>>  
>>>      for (i = 0; i < ARRAY_SIZE(CpuFeatDef); i++) {
>>> +        /* With gen15 CSSKE and BPB are deprecated */
>>> +        if (strcmp(CpuFeatDef[i].name, "S390_FEAT_LIST_GEN15_GA1") == 0) {
>>> +            clear_bit(base_feat, S390_FEAT_CONDITIONAL_SSKE);
>>> +            clear_bit(default_feat, S390_FEAT_CONDITIONAL_SSKE);
>>> +            clear_bit(default_feat, S390_FEAT_BPB);
>>> +        }
>>>          set_bits(base_feat, CpuFeatDef[i].base_bits);
>>>          /* add the base to the default features */
>>>          set_bits(default_feat, CpuFeatDef[i].base_bits);
>>>
>>
>> Can you squash that into the previous patch, so it doesn't look like the
>> case model is suddenly changed?
> 
> can do. I wanted it to be separate for better review.
> 

Makes perfect sense.

-- 

Thanks,

David / dhildenb
