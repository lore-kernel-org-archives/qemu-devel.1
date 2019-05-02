Received: from eggs.gnu.org ([209.51.188.92]:36223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDur-0005w3-Gh
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDuq-0001dE-Jj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:46:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:46246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDuq-0001cw-Ah
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:46:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id j11so1304624pff.13
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:46:32 -0700 (PDT)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-18-richard.henderson@linaro.org>
	<878svo6hxq.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <018043d5-9c52-31ce-a241-9119fbdf77a2@linaro.org>
Date: Thu, 2 May 2019 08:46:27 -0700
MIME-Version: 1.0
In-Reply-To: <878svo6hxq.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 17/29] tcg: Add gvec expanders for
 vector shift by scalar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 5/2/19 7:37 AM, Alex Bennée wrote:
>> +void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
>> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
>> +{
>> +    static const TCGOpcode scalar_list[] = { INDEX_op_shls_vec, 0 };
>> +    static const TCGOpcode vector_list[] = { INDEX_op_shlv_vec, 0 };
>> +    static gen_helper_gvec_2 * const fno[4] = {
>> +        gen_helper_gvec_shl8i,
>> +        gen_helper_gvec_shl16i,
>> +        gen_helper_gvec_shl32i,
>> +        gen_helper_gvec_shl64i,
>> +    };
>> +
>> +    tcg_debug_assert(vece <= MO_64);
>> +    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
>> +                   vece == MO_32 ? tcg_gen_shl_i32 : NULL,
>> +                   vece == MO_64 ? tcg_gen_shl_i64 : NULL,
>> +                   tcg_gen_shls_vec, tcg_gen_shlv_vec, fno[vece],
>> +                   scalar_list, vector_list);
> 
> Hmm I guess:
> 
>     static GVecGenFoo const ops[4] = {
>         {
>             .fno = gen_helper_gvec_shl8i
>         },
>         {
>             .fno = gen_helper_gvec_shl16i
>         },
>         {
>             .fno = gen_helper_gvec_shl32i,
>             .fni4 = tcg_gen_shl_i32
>         },
>         {
>             .fno = gen_helper_gvec_shl64i,
>             .fni8 = tcg_gen_shl_i64
>         }
>     };
>     tcg_debug_assert(vece <= MO_64);
>     do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &ops[vece],
>                    tcg_gen_shls_vec, tcg_gen_shlv_vec,
>                    scalar_list, vector_list);
> 
> gets a little verbose....

That's exactly it.

The GVecGenFoo structures were created so that front ends would be able to
define their own.  For that I wanted full generality.  This case didn't seem to
warrant that.

I suppose I could create a denser GVecGenFoo for this case.
Which actually seems like a good idea now I think about it.

r~
