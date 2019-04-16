Received: from eggs.gnu.org ([209.51.188.92]:51538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJ1m-0002Fs-Gx
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJ1k-0002bu-RP
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:01:14 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-4-david@redhat.com>
	<50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0fdae81c-eecb-90cd-26f8-b52964d375a3@redhat.com>
Date: Tue, 16 Apr 2019 10:01:05 +0200
MIME-Version: 1.0
In-Reply-To: <50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 12.04.19 23:05, Richard Henderson wrote:
> On 4/11/19 12:07 AM, David Hildenbrand wrote:
>> +    static const GVecGen3 g[5] = {
>> +        { .fni8 = gen_acc8_i64, },
>> +        { .fni8 = gen_acc16_i64, },
>> +        { .fni8 = gen_acc32_i64, },
>> +        { .fni8 = gen_acc_i64, },
>> +        { .fno = gen_helper_gvec_vacc128, },
>> +    };
> 
> Vector versions of the first four are fairly simple too.
> 
> static void gen_acc_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
> {
>     tcgv_vec t = tcg_temp_new_vec_matching(d);
> 
>     tcg_gen_add_vec(vece, t, a, b);
>     tcg_gen_cmp_vec(TCG_COND_LTU, vece, d, r, a);  /* produces -1 for carry */
>     tcg_gen_neg_vec(vece, d, d);                 /* convert to +1 for carry */
> }
> 
>   { .fni8 = gen_acc8_i64,
>     .fniv = gen_acc_vec,
>     .opc = INDEX_op_cmp_vec,
>     .vece = MO_8 },
>   ...
> 

Indeed, I didn't really explore vector operations yet. This is more
compact than I expected :)

> 
> I'm surprised that you're expanding the 128-bit addition out-of-line.
> One possible expansion is
> 
>   tcg_gen_add2_i64(tl, th, al, zero, bl, zero);
>   tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
>   tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
>   /* carry out in th */

Nice trick. Just so I get it right, the third line should actually be

tcg_gen_add2_i64(tl, th, tl, th, bh, zero);

right? Thanks!

-- 

Thanks,

David / dhildenb
