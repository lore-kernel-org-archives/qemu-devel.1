Received: from eggs.gnu.org ([209.51.188.92]:35654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzl7E-0001EK-N1
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzl7D-0007ft-RV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:34:28 -0500
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-14-david@redhat.com>
	<546b95fb-09a7-d406-40d0-f33a55deecb4@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ec74ce07-b585-9248-5e60-ee8e611eb215@redhat.com>
Date: Fri, 1 Mar 2019 17:33:53 +0100
MIME-Version: 1.0
In-Reply-To: <546b95fb-09a7-d406-40d0-f33a55deecb4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/32] s390x/tcg: Implement VECTOR LOAD
 MULTIPLE
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

On 01.03.19 17:26, Richard Henderson wrote:
> On 3/1/19 3:53 AM, David Hildenbrand wrote:
>> +    /*
>> +     * Check for possible access exceptions by trying to load the last
>> +     * element. The first element will be checked first next.
>> +     */
>> +    t = tcg_temp_new_i64();
>> +    gen_addi_and_wrap_i64(s, t, o->addr1, (v3 - v1) * 16 + 8);
>> +    tcg_gen_qemu_ld_i64(t, t, get_mem_index(s), MO_TEQ);
> 
> qemu_ld expands to enough code that it is a shame to discard this value and
> reload it during this loop.  Perhaps load this to t2...
> 
>> +
>> +    for (;; v1++) {
>> +        tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TEQ);
>> +        write_vec_element_i64(t, v1, 0, ES_64);
> 
> Move v1 == v3 break here...
> 
>> +        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
>> +        tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TEQ);
>> +        write_vec_element_i64(t, v1, 1, ES_64);
>> +        if (v1 == v3) {
>> +            break;
>> +        }
>> +        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
>> +    }
> 
> ... and store t2 into v3 element 1 after the loop.

Yes, makes perfect sense, thanks!


-- 

Thanks,

David / dhildenb
