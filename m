Received: from eggs.gnu.org ([2001:4830:134:3::10]:47726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUbar-0001L9-04
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUbaq-0001qB-0G
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:31:29 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
	<20170710154749.13624-3-alex.bennee@linaro.org>
	<CAFEAcA8OjCS9=UJ6NV2_PgT7zciOmcnvrzpTY6FL55D8x965aw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0b397419-08d4-b29d-028e-fe196d8122a3@twiddle.net>
Date: Mon, 10 Jul 2017 06:31:15 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OjCS9=UJ6NV2_PgT7zciOmcnvrzpTY6FL55D8x965aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/6] target/arm/translate.c: make
 DISAS_UPDATE match declared semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 07/10/2017 06:13 AM, Peter Maydell wrote:
> On 10 July 2017 at 16:47, Alex Bennée <alex.bennee@linaro.org> wrote:
>> DISAS_UPDATE should be used when the wider CPU state other than just
>> the PC has been updated and we should therefor exit the TCG runtime
>> and return to the main execution loop rather assuming DISAS_JUMP would
>> do that.
>>
>> As some DISAS_UPDATE users may update the PC dynamically via a helper
>> we also push the updating to the PC to hhe call sites which set
>> ->is_jmp to DISAS_UPDATE.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   target/arm/translate.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 0862f9e4aa..f9c4aee1b6 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -4430,6 +4430,7 @@ static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
>>       tcg_temp_free_i32(tcg_tgtmode);
>>       tcg_temp_free_i32(tcg_regno);
>>       tcg_temp_free_i32(tcg_reg);
>> +    gen_set_pc_im(s, s->pc);
>>       s->is_jmp = DISAS_UPDATE;
>>   }
>>
>> @@ -4452,6 +4453,7 @@ static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
>>       tcg_temp_free_i32(tcg_tgtmode);
>>       tcg_temp_free_i32(tcg_regno);
>>       store_reg(s, rn, tcg_reg);
>> +    gen_set_pc_im(s, s->pc);
>>       s->is_jmp = DISAS_UPDATE;
>>   }
>>
>> @@ -8058,6 +8060,7 @@ static void gen_srs(DisasContext *s,
>>           tcg_temp_free_i32(tmp);
>>       }
>>       tcg_temp_free_i32(addr);
>> +    gen_set_pc_im(s, s->pc);
>>       s->is_jmp = DISAS_UPDATE;
>>   }
>>
>> @@ -8146,6 +8149,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>>               /* setend */
>>               if (((insn >> 9) & 1) != !!(s->be_data == MO_BE)) {
>>                   gen_helper_setend(cpu_env);
>> +                gen_set_pc_im(s, s->pc);
>>                   s->is_jmp = DISAS_UPDATE;
>>               }
>>               return;
>> @@ -11619,6 +11623,7 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
>>                   ARCH(6);
>>                   if (((insn >> 3) & 1) != !!(s->be_data == MO_BE)) {
>>                       gen_helper_setend(cpu_env);
>> +                    gen_set_pc_im(s, s->pc);
>>                       s->is_jmp = DISAS_UPDATE;
>>                   }
>>                   break;
>> @@ -12076,7 +12081,6 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>>               break;
>>           case DISAS_NEXT:
>>           case DISAS_UPDATE:
>> -            gen_set_pc_im(dc, dc->pc);
>>               /* fall through */
>>           default:
>>               /* FIXME: Single stepping a WFI insn will not halt the CPU. */
>> @@ -12095,12 +12099,11 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>>           case DISAS_NEXT:
>>               gen_goto_tb(dc, 1, dc->pc);
>>               break;
>> -        case DISAS_UPDATE:
>> -            gen_set_pc_im(dc, dc->pc);
>> -            /* fall through */
>>           case DISAS_JUMP:
>>               gen_goto_ptr();
>>               break;
>> +        case DISAS_UPDATE:
>> +            /* fall through */
>>           default:
>>               /* indicate that the hash table must be used to find the next TB */
>>               tcg_gen_exit_tb(0);
> 
> I'm not a great fan of this, because we've taken five cases that
> all want the same behaviour for ending the TB, and we've made
> them handle part of it themselves rather than just letting
> the end-of-TB code do it for them.

I agree.

Indeed, the fact that you've found 5 cases that are all the same suggests there 
*should* be common handling for them, and you're undoing that.

Enumeratiors are not expensive.  If you found that none of the existing cases 
works for some case, then add another enumerator.


r~
