Received: from eggs.gnu.org ([2001:4830:134:3::10]:40636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4GAM-0003o6-Ep
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4GAL-0001I3-I4
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:27:46 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:33489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4GAL-0001Gl-BZ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:27:45 -0400
Received: by mail-pf0-x22f.google.com with SMTP id f15so9752786pfn.0
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 18:27:45 -0700 (PDT)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-7-richard.henderson@linaro.org>
	<87zi2kd4zf.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd60ffee-7a2e-9815-c8ae-d7bcc355cdc8@linaro.org>
Date: Fri, 6 Apr 2018 11:27:38 +1000
MIME-Version: 1.0
In-Reply-To: <87zi2kd4zf.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 06/67] target/arm: Implement
 SVE predicate test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 04/03/2018 07:16 PM, Alex Bennée wrote:
>> +/* Set the cpu flags as per a return from an SVE helper.  */
>> +static void do_pred_flags(TCGv_i32 t)
>> +{
>> +    tcg_gen_mov_i32(cpu_NF, t);
>> +    tcg_gen_andi_i32(cpu_ZF, t, 2);
>> +    tcg_gen_andi_i32(cpu_CF, t, 1);
>> +    tcg_gen_movi_i32(cpu_VF, 0);
>> +}
> 
> Why bother returning a value from the helper to then spend time
> shuffling it into env->cpu_FLAG when we could do this directly? Does
> this aid code generation when flag values are queried?

It means that the helper itself clobbers no TCG global temps, and so does not
invalidate any of the guest integer registers that might be live in host registers.

The arithmetic above is approximately as efficient as plain moves, so I don't
see this as "spending time shuffling" per se.

> Also from above:
> 
>> + * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
>> + * and bit 0 set if C is set.
> 
> So there is assumed knowledge in the encoding of cpu_NF here - maybe a
> reference to cpu.h where this is codified.

I suppose, sure.


r~
