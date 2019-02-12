Received: from eggs.gnu.org ([209.51.188.92]:36067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtcd4-00042M-7q
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtcd0-000357-Sz
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:17:58 -0500
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-3-david@redhat.com>
	<4cc9037e-de4d-b2fc-0329-3b97d2b289b9@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <da507cff-1769-e02a-83e4-bc1faa5c190d@redhat.com>
Date: Tue, 12 Feb 2019 19:17:39 +0100
MIME-Version: 1.0
In-Reply-To: <4cc9037e-de4d-b2fc-0329-3b97d2b289b9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/15] s390x/tcg: Fix TEST DATA CLASS
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 12.02.19 19:01, Richard Henderson wrote:
> On 2/12/19 3:02 AM, David Hildenbrand wrote:
>> +static bool s390_tdc32(CPUS390XState *env, float32 f1, uint16_t dc_mask)
>> +{
>> +        const bool neg = float32_is_neg(f1);
>> +        const bool zero = float32_is_zero(f1);
>> +        const bool normal = float32_is_normal(f1);
>> +        const bool denormal = float32_is_denormal(f1);
>> +        const bool infinity = float32_is_infinity(f1);
>> +        const bool quiet_nan = float32_is_quiet_nan(f1, &env->fpu_status);
>> +        const bool sig_nan = float32_is_signaling_nan(f1, &env->fpu_status);
>> +
>> +        return (zero && test_dc_mask(dc_mask, 0, neg)) ||
>> +               (normal && test_dc_mask(dc_mask, 2, neg)) ||
>> +               (denormal && test_dc_mask(dc_mask, 4, neg)) ||
>> +               (infinity && test_dc_mask(dc_mask, 6, neg)) ||
>> +               (quiet_nan && test_dc_mask(dc_mask, 8, neg)) ||
>> +               (sig_nan && test_dc_mask(dc_mask, 10, neg));
>> +}
>> +
> 
> This is doing more work than necessary, since any one fp value can only be one
> of these.
> 
> I think it would be better to structure this like the riscv helper_fclass_*:
> 
> static inline uint32_t dcmask(int bit, bool neg)
> {
>     return 1 << (11 - bit - neg);
> }
> 
> static uint32_t float32_dcmask(CPUS390XState *env, float32 f1)
> {
>     bool neg = float32_is_neg(f1);
> 
>     /* Sorted by most common cases.  */
>     if (float32_is_normal(f1)) {
>         return dc_mask(2, neg);
>     } else if (float32_is_zero(f1)) {
>         return dc_mask(0, neg);
>     } else if (float32_is_zero_or_denormal(f1)) {
>         /* denormal, since zero is eliminated */
>         return dc_mask(4, neg);
>     } else if (float32_is_infinity(f1)) {
>         return dc_mask(6, neg);
>     } else if (float64_is_quiet_nan(f1, &env->fpu_status)) {
>         return dc_mask(8, neg);
>     } else {
>         /* signaling nan, as last remaining case */
>         return dc_mask(10, neg);
>     }
> }
> 
> uint32_t HELPER(tceb)(CPUS390XState *env, uint64_t f1, uint64_t m2)
> {
>     return (m2 & float32_dcmask(env, f1)) != 0;
> }
> 
> You may or may not wish to macro-ise float32_dcmask for the float type.
> 
> 
> r~
> 

Indeed, makes sense! Also thought about macros, but I guess the huge
pile of code for vector instruction support I have lying around make me
lazy :)

Thanks!

-- 

Thanks,

David / dhildenb
