Received: from eggs.gnu.org ([209.51.188.92]:53996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyIwP-0004cu-NZ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyIwN-0007QI-9Z
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:17:17 -0500
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-8-david@redhat.com>
	<17cce95e-8e0d-5f49-920a-1e35c9ce8968@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6ac53abd-d461-e1f3-8e34-06f8584e85fc@redhat.com>
Date: Mon, 25 Feb 2019 17:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <17cce95e-8e0d-5f49-920a-1e35c9ce8968@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 7/7] s390x/tcg: Implement LOAD COUNT TO
 BLOCK BOUNDARY
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

On 25.02.19 17:14, Richard Henderson wrote:
> On 2/25/19 3:55 AM, David Hildenbrand wrote:
>> +uint64_t HELPER(lcbb)(uint64_t addr, uint32_t m3)
>> +{
>> +    const uint32_t block_size = 1ul << (m3 + 6);
>> +    const uint64_t rounded_addr = ROUND_UP(addr, block_size);
>> +    uint32_t to_load = 16;
>> +
>> +    if (rounded_addr != addr) {
>> +        to_load = MIN(rounded_addr - addr, to_load);
>> +    }
>> +    return to_load;
>> +}
> 
> I don't understand all of this "blocksize" business, when they are all powers
> of two, and the maximum value returned is 16.
> 
> As far as I can see, the result is obtained by -(addr | -16) regardless of the
> value of m3.

Let's assume we have addr = 63;

Assume block size is 64:
-> to_load = 1

Assume block size is 128:
-> to_load = 16

Or am i missing something?

-- 

Thanks,

David / dhildenb
