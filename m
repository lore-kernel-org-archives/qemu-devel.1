Received: from eggs.gnu.org ([209.51.188.92]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyGO7-0002Kb-8P
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyGO6-0006ii-BW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:33:43 -0500
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-4-david@redhat.com>
	<295a982e-eb77-84cc-a06e-55e37a1e4c28@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3af198f6-4fde-bf24-5373-f02f1dadad08@redhat.com>
Date: Mon, 25 Feb 2019 14:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <295a982e-eb77-84cc-a06e-55e37a1e4c28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/7] s390x/tcg: Clarify terminology in
 vec_reg_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 25.02.19 13:30, Thomas Huth wrote:
> On 25/02/2019 12.55, David Hildenbrand wrote:
>> We will use s390x speak "Element Size" (es) for MO_8 == 0, MO_16 == 1
>> ... Simple rename of variables.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/translate.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
>> index c646e50eb3..916508b567 100644
>> --- a/target/s390x/translate.c
>> +++ b/target/s390x/translate.c
>> @@ -145,10 +145,10 @@ void s390x_translate_init(void)
>>      }
>>  }
>>  
>> -static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp size)
>> +static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
>>  {
>> -    const uint8_t es = 1 << size;
>> -    int offs = enr * es;
>> +    const uint8_t bytes = 1 << es;
> 
> I'd maybe add a comment at the end of above line, saying "/* Convert
> element size to bytes */" or something similar, so that it is clear to
> the reader that "es" means "element size"...

Can do, in the actual vector instruction part I have a comment
explaining the terminology, but that will be in another file.

> 
>> +    int offs = enr * bytes;
>>  
>>      g_assert(reg < 32);
>>      /*
>> @@ -173,9 +173,9 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp size)
>>       * the two 8 byte elements have to be loaded separately. Let's force all
>>       * 16 byte operations to handle it in a special way.
>>       */
>> -    g_assert(size <= MO_64);
>> +    g_assert(es <= MO_64);
>>  #ifndef HOST_WORDS_BIGENDIAN
>> -    offs ^= (8 - es);
>> +    offs ^= (8 - bytes);
>>  #endif
>>      return offs + offsetof(CPUS390XState, vregs[reg][0].d);
>>  }
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks!


-- 

Thanks,

David / dhildenb
