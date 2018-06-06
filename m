Received: from eggs.gnu.org ([2001:4830:134:3::10]:47958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQXcc-0004AJ-Vw
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQXcZ-0000yM-Sg
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:33:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fQXcZ-0000xO-MF
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:32:59 -0400
References: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
	<20170712184540.12352-1-rth@twiddle.net>
	<CAPybu_334DoALQ_a4bSf9VPHwMLw6hyLr1-OvCD+EqhvTAsE6g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f2d314a-350e-bdd9-b938-a8435ec15726@redhat.com>
Date: Wed, 6 Jun 2018 14:32:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAPybu_334DoALQ_a4bSf9VPHwMLw6hyLr1-OvCD+EqhvTAsE6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fix BLSR and BLSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On 06/06/2018 11:13, Ricardo Ribalda Delgado wrote:
> Hi Richard,
> 
> I cannot find this patch on qemu master branch. Do you need any help
> to get this done?

I queued it now, thanks for the reminder!

Paolo


> Thanks!
> On Wed, Jul 12, 2017 at 8:45 PM Richard Henderson <rth@twiddle.net> wrote:
>>
>> The implementation of these two instructions was swapped.
>> At the same time, unify the setup of eflags for the insn group.
>>
>> Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  target/i386/translate.c | 25 ++++++++-----------------
>>  1 file changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 8365a6d..087a2e6 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -4029,36 +4029,27 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
>>                      goto illegal_op;
>>                  }
>>                  ot = mo_64_32(s->dflag);
>> -                gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>> +                gen_ldst_modrm(env, s, modrm, ot, OR_TMP1, 0);
>>
>>                  switch (reg & 7) {
>>                  case 1: /* blsr By,Ey */
>> -                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
>> +                    tcg_gen_subi_tl(cpu_T0, cpu_T1, 1);
>>                      tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
>>                      gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
>> -                    gen_op_update2_cc();
>> -                    set_cc_op(s, CC_OP_BMILGB + ot);
>>                      break;
>> -
>>                  case 2: /* blsmsk By,Ey */
>> -                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
>> -                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
>> -                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_cc_src);
>> -                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
>> -                    set_cc_op(s, CC_OP_BMILGB + ot);
>> +                    tcg_gen_subi_tl(cpu_T0, cpu_T1, 1);
>> +                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
>>                      break;
>> -
>>                  case 3: /* blsi By, Ey */
>> -                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
>> -                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
>> -                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_cc_src);
>> -                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
>> -                    set_cc_op(s, CC_OP_BMILGB + ot);
>> +                    tcg_gen_neg_tl(cpu_T0, cpu_T1);
>> +                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
>>                      break;
>> -
>>                  default:
>>                      goto unknown_op;
>>                  }
>> +                gen_op_update2_cc();
>> +                set_cc_op(s, CC_OP_BMILGB + ot);
>>                  break;
>>
>>              default:
>> --
>> 2.9.4
>>
> 
> 
