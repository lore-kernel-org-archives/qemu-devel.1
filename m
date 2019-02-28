Received: from eggs.gnu.org ([209.51.188.92]:36301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHPJ-00061o-9P
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHFV-000077-6B
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:41:01 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-16-david@redhat.com>
	<80bed043-7fa2-bce0-327f-d298d6799b75@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0455a800-aa6d-d5ff-f51b-f2e4aa2991ce@redhat.com>
Date: Thu, 28 Feb 2019 09:40:57 +0100
MIME-Version: 1.0
In-Reply-To: <80bed043-7fa2-bce0-327f-d298d6799b75@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 15/33] s390x/tcg: Implement VECTOR LOAD
 TO BLOCK BOUNDARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 27.02.19 17:08, Richard Henderson wrote:
> On 2/26/19 3:38 AM, David Hildenbrand wrote:
>> +void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
>> +{
>> +    S390Vector tmp = {};
>> +    int i;
>> +
>> +    bytes = MIN(bytes, 16);
>> +    for (i = 0; i < bytes; i++) {
>> +        uint8_t byte = cpu_ldub_data_ra(env, addr, GETPC());
>> +
>> +        s390_vec_write_element8(&tmp, i, byte);
>> +        addr = wrap_address(env, addr + 1);
>> +    }
> 
> TODO:
> 
>     if (likely(bytes >= 16)) {
>         uint64_t t0 = cpu_ldq_data_ra(env, addr, GETPC());
>         uint64_t t1 = cpu_ldq_data_ra(env, addr, GETPC());

adding + wrapping the address of course.

>         s390_vec_write_element64(v1, 0, t0);
>         s390_vec_write_element64(v1, 1, t1);
>     } else {
>         // byte loop
>     }
> 
> But what you have is correct, so

Makes sense and gets rid of the MIN(), so changed :)

Thanks!

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
