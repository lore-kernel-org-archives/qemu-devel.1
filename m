Received: from eggs.gnu.org ([209.51.188.92]:42301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK1l-0007sC-L2
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK1k-0000TR-Ow
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:05:17 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-11-david@redhat.com>
	<59b43a53-8c25-53ea-c5a8-1cd33b4011e5@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b275e358-6cc4-c8f7-1db4-26ef43eeb7e1@redhat.com>
Date: Tue, 16 Apr 2019 11:05:13 +0200
MIME-Version: 1.0
In-Reply-To: <59b43a53-8c25-53ea-c5a8-1cd33b4011e5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/41] s390x/tcg: Implement VECTOR
 ELEMENT COMPARE *
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

On 13.04.19 01:14, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +                         es | logical ? 0 : MO_SIGN);
> 
> Incorrect operator precedence.  You need:
> 
>   es | (logical ? 0 : MO_SIGN)
> 
> or
> 
>   logical ? es : es | MO_SIGN
> 
> And perhaps cse this expression into a temporary
> and not replicate it between the two reads.
> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

Thanks, good catch! I'll do it like this

+static DisasJumpType op_vec(DisasContext *s, DisasOps *o)
+{
+    uint8_t es = get_field(s->fields, m3);
+    const uint8_t enr = NUM_VEC_ELEMENTS(es) / 2 - 1;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    if (s->fields->op2 == 0xdb) {
+        es |= MO_SIGN;
+    }
+
+    o->in1 = tcg_temp_new_i64();
+    o->in2 = tcg_temp_new_i64();
+    read_vec_element_i64(o->in1, get_field(s->fields, v1), enr, es);
+    read_vec_element_i64(o->in2, get_field(s->fields, v2), enr, es);
+    return DISAS_NEXT;
+}


-- 

Thanks,

David / dhildenb
