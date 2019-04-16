Received: from eggs.gnu.org ([209.51.188.92]:39953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJpX-0003cj-EO
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJpW-0008BI-EC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:52:39 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-8-david@redhat.com>
	<0c0c45f1-0721-78a8-fb46-f32e7701da0e@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fd06217f-3fe6-d10d-726a-886c5fab8820@redhat.com>
Date: Tue, 16 Apr 2019 10:52:34 +0200
MIME-Version: 1.0
In-Reply-To: <0c0c45f1-0721-78a8-fb46-f32e7701da0e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/41] s390x/tcg: Implement VECTOR
 AVERAGE
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

On 13.04.19 00:34, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +}
>> +static DisasJumpType op_vavg(DisasContext *s, DisasOps *o)
>> +{
> 
> Watch your spacing.

Whoops.

> 
> 
>> +    static const GVecGen3 g[4] = {
>> +        { .fno = gen_helper_gvec_vavg8, },
>> +        { .fno = gen_helper_gvec_vavg16, },
>> +        { .fni4 = gen_avg_i32, },
>> +        { .fni8 = gen_avg_i64, },
>> +    };
> 
> Pondering possible vector expansions.  I think one possibility is
> 
>   t1 = (a >> 1) + (b >> 1);
> 
> We still have the two "0.5 bits" to add back in, plus we round up by adding
> another 0.5.  This means if either lsb is set, then we have carry in to the 1's
> bit.  So:
> 
>   t1 = t1 + ((a | b) & 1);
> 
> Which leads to
> 
>   tcg_gen_sari_vec(vece, t0, a, 1);
>   tcg_gen_sari_vec(vece, t1, b, 1);
>   tcg_gen_or_vec(vece, t2, a, b);
>   tcg_gen_add_vec(vece, t0, t0, t1);
>   tcg_gen_dupi_vec(vece, t1, 1);
>   tcg_gen_and_vec(vece, t2, t2, t1);
>   tcg_gen_add_vec(vece, t0, t0, t2);
> 
>   { .fnv = gen_avg_vec,
>     .fno = gen_helper_gvec_vavg8,
>     .opc = INDEX_op_sari_vec },
> 
> But what you have here is correct and the above is mere optimization so,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 

Looks sane, as discussed, let's handle vector expansions later.

Thanks!

> 
> r~
> 


-- 

Thanks,

David / dhildenb
