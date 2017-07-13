Received: from eggs.gnu.org ([2001:4830:134:3::10]:43998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVm5s-0000oq-Ch
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVm5r-000394-4D
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:56:20 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dVm5q-00038Y-SR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:56:19 -0400
Received: by mail-it0-x244.google.com with SMTP id v193so9535943itc.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 14:56:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPybu_3ffLp2NWkSyVjs159Udopn38SHZA3WBcAedYXCXvbMpg@mail.gmail.com>
References: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
	<20170712192902.15493-1-rth@twiddle.net>
	<CAPybu_3ffLp2NWkSyVjs159Udopn38SHZA3WBcAedYXCXvbMpg@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 13 Jul 2017 23:55:56 +0200
Message-ID: <CAPybu_0LvnN0epxnj=JGJc-6zdVGhNd2A_67n3ZYnE89O07gNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: Fix BLSR and BLSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

Hi again

Some progress here, I think that I have found a bug in andn, I have
already send a patch.

I have made a rudimentary testcase for bmi. I will try tomorrow o
build something similar for tbm.

For reference, I am using this script:

for a in $(seq 0 255); do for b in $(seq 0 255); do for c in $(seq 0
255); do /tmp/qemu/x86_64-linux-user/qemu-x86_64 -cpu qemu64,+bmi1
./a.out $a $b $c >/tmp/res.qemu; ./pc $a $b $c > /tmp/res.pc; if !
diff  /tmp/res.pc /tmp/res.qemu; then echo $a $b $c; fi ; done ; done
; done

with this build options
gcc kk.c -mbmi -O3 -Wall
gcc kk.c -march=native -O3 -Wall -o pc

and this code:

#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>


long test_blsr(long val){

return (val & (val - 1));
}

long test_blsi(long val){

return (val & (-val));
}

long test_blmsk(long val){

return (val ^ (val -1));
}

long test_andn(long v1, long v2){

return (~v1 & v2);
}

long test_tzcnt(long val) {
#ifdef PC
return val ? __builtin_ctz(val) : 32;
#else
return __tzcnt_u32(val);
#endif
}

long test_bextr(long src, unsigned char start, unsigned char len) {
#ifdef PC
return (src >> start) & ((1 << len)-1);
#else
return __bextr_u32(src, start | len <<8);
#endif
}

int main(int argc, char *argv[]) {
long op1, op2, op3;
long ret;

if (argc < 4) {
fprintf(stderr, "use %s op1 op2 op3\n", argv[0]);
return -1;
}
op1 = strtoul(argv[1], NULL, 0);
op2 = strtoul(argv[2], NULL, 0);
op3 = strtoul(argv[3], NULL, 0);

fprintf(stdout, "op 1 %ld (0x%lx)\n", op1, op1);
fprintf(stdout, "op 2 %ld (0x%lx)\n", op2, op2);

ret = test_blsr(op1);
fprintf(stdout, "blsr %ld (0x%lx)\n",ret, ret);

ret = test_blsi(op1);
fprintf(stdout, "blsi %ld (0x%lx)\n",ret, ret);

ret = test_blmsk(op1);
fprintf(stdout, "blmsk %ld (0x%lx)\n",ret, ret);

ret = test_andn(op1,op2);
fprintf(stdout, "andn %ld (0x%lx)\n",ret, ret);

ret = test_tzcnt(op1);
fprintf(stdout, "tzcnt %ld (0x%lx)\n",ret, ret);

ret = test_bextr(op1, op2, op3);
fprintf(stdout, "bextr %ld (0x%lx)\n",ret, ret);

return 0;
}

On Thu, Jul 13, 2017 at 10:42 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Hi Richard
>
> The simple example works as expected, but my big application
> (gobject-introspection) still crashes with sigsegv :(.
>
> it seems to be something related to the bmi and tbm instructions. If I
> disable them in gcc ( -mno-bmi -mno-tbm), the application
> runs ok.
>
> A look at qemu's code does not show anything obvious, but I am not
> that familiar with qemu source yet to find something like this through
> static analysis.
>
> My plan (as soon as I have some time) is to create a small set of apps
> to validate bmi/tbm/ (Are you aware of something already existing for
> this?)
> My stupid guess is that maybe the ops are switched, or the flags are
> not properly modified.
>
> If you want, I can share the application that crashes with you, just
> be aware that the number of dependencies is considerable.
>
> BTW I can only run the gdb stub on version 2.8.0. On git HEAD I am getting only:
>
> Quit
> (gdb) c
> Continuing.
> warning: Remote failure reply: E22
>
> Program stopped.
> 0x00000040017bac07 in ?? ()
> (gdb) c
> Continuing.
>
>
>
> Thanks for your help, it is greatly appreciated!
>
> On Wed, Jul 12, 2017 at 9:29 PM, Richard Henderson <rth@twiddle.net> wrote:
>> The implementation of these two instructions was swapped.
>> At the same time, unify the setup of eflags for the insn group.
>>
>> Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  target/i386/translate.c | 26 +++++++++-----------------
>>  1 file changed, 9 insertions(+), 17 deletions(-)
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 9d5f1c3..69d3787 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -4031,34 +4031,26 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
>>                  ot = mo_64_32(s->dflag);
>>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>>
>> +                tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
>>                  switch (reg & 7) {
>>                  case 1: /* blsr By,Ey */
>> -                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
>> +                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
>>                      tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
>> -                    gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
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
>> +                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
>> +                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
>>                      break;
>> -
>>                  case 3: /* blsi By, Ey */
>> -                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
>> -                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
>> -                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_cc_src);
>> -                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
>> -                    set_cc_op(s, CC_OP_BMILGB + ot);
>> +                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
>> +                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
>>                      break;
>> -
>>                  default:
>>                      goto unknown_op;
>>                  }
>> +                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
>> +                gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
>> +                set_cc_op(s, CC_OP_BMILGB + ot);
>>                  break;
>>
>>              default:
>> --
>> 2.9.4
>>
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
