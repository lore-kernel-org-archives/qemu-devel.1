Received: from eggs.gnu.org ([2001:4830:134:3::10]:51753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpZI-0002E3-1A
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpZE-0006vM-Q8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:07:44 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXpZE-0006v7-Is
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:07:40 -0400
Received: by mail-pf0-x244.google.com with SMTP id y8-v6so8218867pfm.10
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:07:40 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-31-richard.henderson@linaro.org>
	<CAFEAcA8jwqotqyGHSA5BFniRa9XttAebQgwpsWgL68WArZkJHQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <459b4639-7d79-7ab6-4a9c-77797658ea92@linaro.org>
Date: Tue, 26 Jun 2018 08:07:36 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jwqotqyGHSA5BFniRa9XttAebQgwpsWgL68WArZkJHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 30/35] target/arm: Pass index to AdvSIMD
 FCMLA (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/26/2018 06:38 AM, Peter Maydell wrote:
> On 21 June 2018 at 02:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> The original commit failed to pass, or use, the index.
>>
>> Fixes: d17b7cdcf4ea
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.c | 21 ++++++++++++---------
>>  target/arm/vec_helper.c    | 10 ++++++----
>>  2 files changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 8d8a4cecb0..038e48278f 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -12669,15 +12669,18 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>>      case 0x13: /* FCMLA #90 */
>>      case 0x15: /* FCMLA #180 */
>>      case 0x17: /* FCMLA #270 */
>> -        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
>> -                           vec_full_reg_offset(s, rn),
>> -                           vec_reg_offset(s, rm, index, size), fpst,
>> -                           is_q ? 16 : 8, vec_full_reg_size(s),
>> -                           extract32(insn, 13, 2), /* rot */
>> -                           size == MO_64
>> -                           ? gen_helper_gvec_fcmlas_idx
>> -                           : gen_helper_gvec_fcmlah_idx);
>> -        tcg_temp_free_ptr(fpst);
>> +        {
>> +            int rot = extract32(insn, 13, 2);
>> +            int data = index * 4 + rot;
> 
> Using arithmetic to do bit operations again.
> 
>> +            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
>> +                               vec_full_reg_offset(s, rn),
>> +                               vec_reg_offset(s, rm, index, size), fpst,
>> +                               is_q ? 16 : 8, vec_full_reg_size(s), data,
>> +                               size == MO_64
>> +                               ? gen_helper_gvec_fcmlas_idx
>> +                               : gen_helper_gvec_fcmlah_idx);
> 
> We're already using vec_reg_offset() to pass the helper the address
> of the index'th element in Vm -- why do we need to also add
> 2*index when we use that pointer as an array base in the helper?

Ah, bug.  Because of SVE, we must pass index (since it applies per 128-bit
segment), and we should pass the full_reg as the pointer.


r~
