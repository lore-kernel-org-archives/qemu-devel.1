Received: from eggs.gnu.org ([209.51.188.92]:41658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHjc-0004aK-JK
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHjb-0004zs-QS
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:12:08 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-30-david@redhat.com>
	<3c7484d3-4bea-61f7-eee9-234e0750bba9@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <43079e6e-00f1-0d51-f70e-325be1d50295@redhat.com>
Date: Thu, 28 Feb 2019 10:11:57 +0100
MIME-Version: 1.0
In-Reply-To: <3c7484d3-4bea-61f7-eee9-234e0750bba9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 29/33] s390x/tcg: Implement VECTOR STORE
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

On 28.02.19 00:46, Richard Henderson wrote:
> On 2/26/19 3:39 AM, David Hildenbrand wrote:
>> +static DisasJumpType op_vst(DisasContext *s, DisasOps *o)
>> +{
>> +    /*
>> +     * FIXME: On exceptions we must not modify any memory.
>> +     */
>> +    store_vec_element(s, get_field(s->fields, v1), 0, o->addr1, MO_64);
>> +    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
>> +    store_vec_element(s, get_field(s->fields, v1), 1, o->addr1, MO_64);
>> +    return DISAS_NEXT;
> 
> Should handle alignment though.

Again, as unaligned access must not trigger an exception, I don't think
we can use MO_ALIGN.

> 
> FWIW, there is a probe_write function that can be called to make sure a region
> is writable before actually accessing it.  But this is common enough that we
> should probably just handle 16-byte quantities as a native tcg type.

That would make most sense. It won't help for the VECTOR_STORE_MULTIPLE
part, though.

I'll keep it as is for now.

Thanks!

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
