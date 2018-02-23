Received: from eggs.gnu.org ([2001:4830:134:3::10]:39680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epJkS-0000eP-7X
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epJkO-0003DB-2R
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:15:16 -0500
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:44461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epJkN-0003Cx-Qk
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:15:11 -0500
Received: by mail-pf0-x230.google.com with SMTP id 17so3951608pfw.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 12:15:11 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-32-richard.henderson@linaro.org>
	<CAFEAcA9kSgYNVQ6L6b94Gnz2ZnD4RKfeBqJintfgVqW47zq-qA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f3c76f2-fef8-2d23-a334-0e10bd01edf5@linaro.org>
Date: Fri, 23 Feb 2018 12:15:07 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kSgYNVQ6L6b94Gnz2ZnD4RKfeBqJintfgVqW47zq-qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 31/67] target/arm: Implement
 SVE conditionally broadcast/extract element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 07:44 AM, Peter Maydell wrote:
>> +/* Similar to the ARM LastActiveElement pseudocode function, except the
>> +   result is multiplied by the element size.  This includes the not found
>> +   indication; e.g. not found for esz=3 is -8.  */
>> +int32_t HELPER(sve_last_active_element)(void *vg, uint32_t pred_desc)
>> +{
>> +    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
>> +    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
> 
> pred_desc is obviously an encoding of some stuff, so the comment would
> be a good place to mention what it is.

Yeah, and I've also just noticed I'm not totally consistent about it.
I probably want to re-think how some of this is done.


>> +/* Compute CLAST for a scalar.  */
>> +static void do_clast_scalar(DisasContext *s, int esz, int pg, int rm,
>> +                            bool before, TCGv_i64 reg_val)
>> +{
>> +    TCGv_i32 last = tcg_temp_new_i32();
>> +    TCGv_i64 ele, cmp, zero;
>> +
>> +    find_last_active(s, last, esz, pg);
>> +
>> +    /* Extend the original value of last prior to incrementing.  */
>> +    cmp = tcg_temp_new_i64();
>> +    tcg_gen_ext_i32_i64(cmp, last);
>> +
>> +    if (!before) {
>> +        incr_last_active(s, last, esz);
>> +    }
>> +
>> +    /* The conceit here is that while last < 0 indicates not found, after
>> +       adjusting for cpu_env->vfp.zregs[rm], it is still a valid address
>> +       from which we can load garbage.  We then discard the garbage with
>> +       a conditional move.  */
> 
> That's a bit ugly. Can we at least do a compile time assert that the
> worst case (which I guess is offset of zregs[0] minus largest-element-size)
> is still positive ? That way if for some reason we reshuffle fields
> in CPUARMState we'll notice if it's going to fall off the beginning
> of the struct.

I suppose so.  Though as commented above find_last_active, the minimal value is
-8.  I feel fairly confident that zregs[0] will never be shuffled to the
absolute start of the structure.


r~
