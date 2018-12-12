Received: from eggs.gnu.org ([2001:4830:134:3::10]:43356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXA4C-0005pp-3G
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXA48-00005D-Bz
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:21:07 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXA48-0008Pb-48
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:21:04 -0500
Received: by mail-oi1-x244.google.com with SMTP id y1so14189440oie.12
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 11:20:52 -0800 (PST)
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-12-richard.henderson@linaro.org>
	<CAFEAcA_rRBJNoSkVQXj=+-69aBOk7OAZyzUUKyvf4NQjg=g3iA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72ccb583-108e-3fe8-7064-85db93673ff9@linaro.org>
Date: Wed, 12 Dec 2018 13:20:47 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rRBJNoSkVQXj=+-69aBOk7OAZyzUUKyvf4NQjg=g3iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/26] target/arm: Rearrange decode in
 disas_uncond_b_reg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On 12/11/18 9:40 AM, Peter Maydell wrote:
> On Fri, 7 Dec 2018 at 10:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This will enable PAuth decode in a subsequent patch.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.c | 34 +++++++++++++++++++++++-----------
>>  1 file changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index c84c2dbb66..5fa2647771 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -1989,32 +1989,41 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
>>      rn = extract32(insn, 5, 5);
>>      op4 = extract32(insn, 0, 5);
>>
>> -    if (op4 != 0x0 || op3 != 0x0 || op2 != 0x1f) {
>> -        unallocated_encoding(s);
>> -        return;
>> +    if (op2 != 0x1f) {
>> +        goto do_unallocated;
>>      }
>>
>>      switch (opc) {
>>      case 0: /* BR */
>>      case 1: /* BLR */
>>      case 2: /* RET */
>> -        gen_a64_set_pc(s, cpu_reg(s, rn));
>> +        if (op3 == 0 && op4 == 0) {
>> +            dst = cpu_reg(s, rn);
>> +        } else {
>> +            goto do_unallocated;
>> +        }
>> +        gen_a64_set_pc(s, dst);
>>          /* BLR also needs to load return address */
>>          if (opc == 1) {
>>              tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
>>          }
>>          break;
>> +
>>      case 4: /* ERET */
>>          if (s->current_el == 0) {
>> -            unallocated_encoding(s);
>> -            return;
>> -        }
>> -        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>> -            gen_io_start();
>> +            goto do_unallocated;
>>          }
>>          dst = tcg_temp_new_i64();
>>          tcg_gen_ld_i64(dst, cpu_env,
>>                         offsetof(CPUARMState, elr_el[s->current_el]));
>> +        if (op3 == 0 && op4 == 0) {
>> +            ;
>> +        } else {
>> +            goto do_unallocated;
> 
> 
> This decode check should go before any code has been
> emittede (ie before the tcg_gen_ld_i64 above it).

Well, it could, but only if we duplicate the ld_i64 in the various branches
that require it.  E.g.

  if (op3 == 0 && op4 == 0) {
      tcg_gen_ld_i64(...);
  } else if (dc_ir_feature(aa64_pauth, s) && ...) {
      tcg_gen_ld_i64(...);
      if (s->pauth_active) {
          gen_helper_auti*(...);
      }
  } else {
      goto do_unallocated;
  }

which I suppose isn't so bad.

What I have isn't an error because the ld_i64 will simply be deleted as dead
code by the tcg optimizer.  But I'll rearrange anyway.


r~
