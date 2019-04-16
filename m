Received: from eggs.gnu.org ([209.51.188.92]:41228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJvK-0005ZX-43
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJvJ-0003RH-3c
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:58:38 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-10-david@redhat.com>
	<71ce854d-da00-565e-0b36-9458a7bc9183@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a7298c65-fea3-7839-6b68-5b3bf5d64c1a@redhat.com>
Date: Tue, 16 Apr 2019 10:58:25 +0200
MIME-Version: 1.0
In-Reply-To: <71ce854d-da00-565e-0b36-9458a7bc9183@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/41] s390x/tcg: Implement VECTOR
 CHECKSUM
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

On 13.04.19 01:01, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +    read_vec_element_i32(sum, get_field(s->fields, v3), 1, ES_32);
>> +    for (i = 0; i < 4; i++) {
>> +        read_vec_element_i32(tmp, get_field(s->fields, v2), i, ES_32);
>> +        tcg_gen_add_i32(sum, sum, tmp);
>> +        tcg_gen_setcond_i32(TCG_COND_LTU, tmp, sum, tmp);
>> +        tcg_gen_add_i32(sum, sum, tmp);
>> +    }
>> +    zero_vec(get_field(s->fields, v1));
>> +    write_vec_element_i32(sum, get_field(s->fields, v1), 1, ES_32);
> 
> It seems like it should be possible to implement this with i64, and fold the
> carry around at the end -- 2 insns instead of 12 for managing carry.  But I
> can't quite tell if that produces the same results.

I had the same in mind but also wasn't sure if it would produce the
exact same result. Feels like it should.
> 
> You could use
> 
>   tcg_gen_add2_i32(sum, tmp, sum, zero, tmp, zero);
>   tcg_gen_add_i32(sum, sum, tmp);

That makes perfect sense, I will use that for now, thanks!

> 
> instead of computing carry manually with setcond.
> 
> That said, your code exactly matches the language in the manual, so
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
