Received: from eggs.gnu.org ([209.51.188.92]:51254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKeR-0008V8-WC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKeQ-0006BX-Va
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:45:15 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-32-david@redhat.com>
	<6594280f-cefb-cfb0-35b4-fcf53c32d871@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <129e5499-a05c-15f1-fe26-6ae0a78cfa7b@redhat.com>
Date: Tue, 16 Apr 2019 11:45:09 +0200
MIME-Version: 1.0
In-Reply-To: <6594280f-cefb-cfb0-35b4-fcf53c32d871@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 31/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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

On 13.04.19 02:54, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
>> +{
>> +    int src_idx = get_field(s->fields, i4) & 0xf;
>> +
>> +    if (src_idx == 0) {
>> +        gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
>> +    } else {
>> +        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2),
>> +                       get_field(s->fields, v3), src_idx,
>> +                       gen_helper_gvec_vsldb);
>> +        return DISAS_NEXT;
> 
> You could also expand this inline using your new extract2 primitive.
> 
>   int i4 = get_field(s->fields, i4);
>   int left_shift, right_shift;
> 
>   left_shift = (i4 & 7) * 8;
>   right_shift = 64 - left_shift;
> 
>   if ((i4 & 8) == 0) {
>       read_vec_element_i64(t0, get_field(s->fields, v2), 0, ES_64);
>       read_vec_element_i64(t1, get_field(s->fields, v2), 1, ES_64);
>       read_vec_element_i64(t2, get_field(s->fields, v3), 0, ES_64);
>   } else {
>       read_vec_element_i64(t0, get_field(s->fields, v2), 1, ES_64);
>       read_vec_element_i64(t1, get_field(s->fields, v3), 0, ES_64);
>       read_vec_element_i64(t2, get_field(s->fields, v3), 1, ES_64);
>   }
>   tcg_gen_extract2_i64(t0, t1, t0, right_shift);
>   tcg_gen_extract2_i64(t1, t2, t1, right_shift);

Trying to understand the magic, left_shift is really only used to to
calculate right_shift, right?

>   write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
>   write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
