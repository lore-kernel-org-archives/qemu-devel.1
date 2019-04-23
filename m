Received: from eggs.gnu.org ([209.51.188.92]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ4UF-0007iM-Rx
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ4UC-0005qy-MB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:06:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ4UA-0005jW-8v
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:05:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so10590545wrr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:05:46 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-20-richard.henderson@linaro.org>
	<e10e5627-25b2-0563-e971-2864256727d6@redhat.com>
	<0bd7fd6a-1fcb-ac0c-b4bf-7b04ada4443c@redhat.com>
	<eebc0218-4334-2b68-9081-a3a4d2d12172@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a886fc7-5746-d87f-5422-49f3ae5f4bed@redhat.com>
Date: Wed, 24 Apr 2019 01:05:44 +0200
MIME-Version: 1.0
In-Reply-To: <eebc0218-4334-2b68-9081-a3a4d2d12172@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/38] tcg: Add support for integer
 absolute value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 4/24/19 12:29 AM, Richard Henderson wrote:
> On 4/23/19 3:09 PM, Philippe Mathieu-Daudé wrote:
>> On 4/23/19 8:37 PM, David Hildenbrand wrote:
>>> On 20.04.19 09:34, Richard Henderson wrote:
>>>> Remove a function of the same name from target/arm/.
>>>> Use a branchless implementation of abs that gcc uses for x86.
>>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>  tcg/tcg-op.h           |  5 +++++
>>>>  target/arm/translate.c | 10 ----------
>>>>  tcg/tcg-op.c           | 20 ++++++++++++++++++++
>>>>  3 files changed, 25 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
>>>> index 472b73cb38..660fe205d0 100644
>>>> --- a/tcg/tcg-op.h
>>>> +++ b/tcg/tcg-op.h
>>>> @@ -335,6 +335,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>>>  void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>>>  void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>>>  void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>>>> +void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
>>>>  
>>>>  static inline void tcg_gen_discard_i32(TCGv_i32 arg)
>>>>  {
>>>> @@ -534,6 +535,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>>>  void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>>>  void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>>>  void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>>>> +void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
>>>>  
>>>>  #if TCG_TARGET_REG_BITS == 64
>>>>  static inline void tcg_gen_discard_i64(TCGv_i64 arg)
>>>> @@ -973,6 +975,7 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>>  void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>>>>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>>>> +void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>>>>  void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>>  void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>>  void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>>>> @@ -1019,6 +1022,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
>>>>  #define tcg_gen_addi_tl tcg_gen_addi_i64
>>>>  #define tcg_gen_sub_tl tcg_gen_sub_i64
>>>>  #define tcg_gen_neg_tl tcg_gen_neg_i64
>>>> +#define tcg_gen_abs_tl tcg_gen_abs_i64
>>>>  #define tcg_gen_subfi_tl tcg_gen_subfi_i64
>>>>  #define tcg_gen_subi_tl tcg_gen_subi_i64
>>>>  #define tcg_gen_and_tl tcg_gen_and_i64
>>>> @@ -1131,6 +1135,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
>>>>  #define tcg_gen_addi_tl tcg_gen_addi_i32
>>>>  #define tcg_gen_sub_tl tcg_gen_sub_i32
>>>>  #define tcg_gen_neg_tl tcg_gen_neg_i32
>>>> +#define tcg_gen_abs_tl tcg_gen_abs_i32
>>>>  #define tcg_gen_subfi_tl tcg_gen_subfi_i32
>>>>  #define tcg_gen_subi_tl tcg_gen_subi_i32
>>>>  #define tcg_gen_and_tl tcg_gen_and_i32
>>>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>>>> index 83a008e945..721171794d 100644
>>>> --- a/target/arm/translate.c
>>>> +++ b/target/arm/translate.c
>>>> @@ -603,16 +603,6 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
>>>>      tcg_temp_free_i32(tmp1);
>>>>  }
>>>>  
>>>> -static void tcg_gen_abs_i32(TCGv_i32 dest, TCGv_i32 src)
>>>> -{
>>>> -    TCGv_i32 c0 = tcg_const_i32(0);
>>>> -    TCGv_i32 tmp = tcg_temp_new_i32();
>>>> -    tcg_gen_neg_i32(tmp, src);
>>>> -    tcg_gen_movcond_i32(TCG_COND_GT, dest, src, c0, src, tmp);
>>>> -    tcg_temp_free_i32(c0);
>>>> -    tcg_temp_free_i32(tmp);
>>>> -}
>>>> -
>>>>  static void shifter_out_im(TCGv_i32 var, int shift)
>>>>  {
>>>>      if (shift == 0) {
>>>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>>>> index a00d1df37e..0ac291f1c4 100644
>>>> --- a/tcg/tcg-op.c
>>>> +++ b/tcg/tcg-op.c
>>>> @@ -1091,6 +1091,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>>>>      tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
>>>>  }
>>>>  
>>>> +void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
>>>> +{
>>>> +    TCGv_i32 t = tcg_temp_new_i32();
>>>> +
>>>> +    tcg_gen_sari_i32(t, a, 31);
>>>> +    tcg_gen_xor_i32(ret, a, t);
>>>> +    tcg_gen_sub_i32(ret, ret, t);
>>>> +    tcg_temp_free_i32(t);
>>>> +}
>>>> +
>>>>  /* 64-bit ops */
>>>>  
>>>>  #if TCG_TARGET_REG_BITS == 32
>>>> @@ -2548,6 +2558,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>>>>      tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
>>>>  }
>>>>  
>>>> +void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
>>>> +{
>>>> +    TCGv_i64 t = tcg_temp_new_i64();
>>>> +
>>>> +    tcg_gen_sari_i64(t, a, 63);
>>>> +    tcg_gen_xor_i64(ret, a, t);
>>>> +    tcg_gen_sub_i64(ret, ret, t);
>>>> +    tcg_temp_free_i64(t);
>>>> +}
>>>> +
>>>>  /* Size changing operations.  */
>>>>  
>>>>  void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
>>>>
>>>
>>> Nice trick
>>
>> Per commit 7dcfb0897b99, I think it's worth a:
>>
>> Inspired-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> 
> *shrug* As per the comment, I got the sequence from gcc -O2 -S.

Now I understand better your comment "Use a branchless implementation of
abs that gcc uses for x86". Previously I misunderstood it =)

Back to commit 7dcfb0897b99, eventually Edgar figured the same trick
from GCC.

Regards,

Phil.
