Received: from eggs.gnu.org ([2001:4830:134:3::10]:56997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zhP-0004Bf-02
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zhN-0001Gn-MW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:48:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-8-f4bug@amsat.org>
	<877f1oyov4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3109e990-3c5a-fb7d-515d-af3771ddfa50@amsat.org>
Date: Thu, 11 May 2017 22:48:42 -0300
MIME-Version: 1.0
In-Reply-To: <877f1oyov4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/8] target/ppc: optimize various functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

Hi Nikunj,

On 05/11/2017 01:54 AM, Nikunj A Dadhania wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> Applied using Coccinelle script.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  target/ppc/translate.c              |  9 +++------
>>  target/ppc/translate/vsx-impl.inc.c | 21 +++++++--------------
>>  2 files changed, 10 insertions(+), 20 deletions(-)
>>
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index f40b5a1abf..64ab412bf3 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -868,8 +868,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
>>              }
>>              tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w/ carry */
>>              tcg_temp_free(t1);
>> -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
>> -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
>> +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
>>              if (is_isa300(ctx)) {
>>                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>>              }
>> @@ -1399,8 +1398,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>>              tcg_temp_free(inv1);
>>              tcg_gen_xor_tl(cpu_ca, t0, t1);         /* bits changes w/ carry */
>>              tcg_temp_free(t1);
>> -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
>> -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
>> +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
>>              if (is_isa300(ctx)) {
>>                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>>              }
>
> Above changes are correct.
>
> Rest of them are wrong as discussed above in the thread with Richard.
 >

I tried to correct the cocci script and ran it again (will post in few 
min as v3) and got:

$ docker run -it -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle --sp-file 
scripts/coccinelle/tcg_gen_extract.cocci --macro-file 
scripts/cocci-macro-file.h --dir target/ppc
init_defs_builtins: /usr/lib64/coccinelle/standard.h
init_defs: scripts/cocci-macro-file.h
HANDLING: target/ppc/mfrom_table_gen.c
HANDLING: target/ppc/user_only_helper.c
HANDLING: target/ppc/mmu-hash64.c
HANDLING: target/ppc/timebase_helper.c
HANDLING: target/ppc/gdbstub.c
HANDLING: target/ppc/translate.c
candidate at target/ppc/translate.c:5386
   op_size: tl/tl (same)
   low_bits: 4 (value: 0xf)
   len: 0xf
   len_bits == low_bits
   candidate IS optimizable

candidate at target/ppc/translate.c:871
   op_size: tl/tl (same)
   low_bits: 1 (value: 0x1)
   len: 0x1
   len_bits == low_bits
   candidate IS optimizable

candidate at target/ppc/translate.c:1402
   op_size: tl/tl (same)
   low_bits: 1 (value: 0x1)
   len: 0x1
   len_bits == low_bits
   candidate IS optimizable

>> @@ -5383,8 +5381,7 @@ static void gen_mfsri(DisasContext *ctx)
>>      CHK_SV;
>>      t0 = tcg_temp_new();
>>      gen_addr_reg_index(ctx, t0);
>> -    tcg_gen_shri_tl(t0, t0, 28);
>> -    tcg_gen_andi_tl(t0, t0, 0xF);
>> +    tcg_gen_extract_tl(t0, t0, 28, 0xF);
>>      gen_helper_load_sr(cpu_gpr[rd], cpu_env, t0);
>>      tcg_temp_free(t0);
>>      if (ra != 0 && ra != rd)

0xF = 0b1111 so this one seems correct to, right?

Then I got:

candidate at target/ppc/translate/vsx-impl.inc.c:1265
   op_size: i64/i64 (same)
   low_bits: 15 (value: 0x7fff)
   len: 0x7fff
   len_bits == low_bits
   candidate IS optimizable

candidate at target/ppc/translate/vsx-impl.inc.c:1451
   op_size: i64/i64 (same)
   low_bits: 11 (value: 0x7ff)
   len: 0x7ff
   len_bits == low_bits
   candidate IS optimizable

candidate at target/ppc/translate/vsx-impl.inc.c:1453
   op_size: i64/i64 (same)
   low_bits: 11 (value: 0x7ff)
   len: 0x7ff
   len_bits == low_bits
   candidate IS optimizable

candidate at target/ppc/translate/vsx-impl.inc.c:1434
   op_size: i64/i64 (same)
   low_bits: 8 (value: 0xff)
   len: 0xff000000ff
   len_bits != low_bits
   candidate is NOT optimizable

candidate at target/ppc/translate/vsx-impl.inc.c:1436
   op_size: i64/i64 (same)
   low_bits: 8 (value: 0xff)
   len: 0xff000000ff
   len_bits != low_bits
   candidate is NOT optimizable

candidate at target/ppc/translate/vsx-impl.inc.c:1477
   op_size: i64/i64 (same)
   low_bits: 11 (value: 0x7ff)
   len: 0x7ff
   len_bits == low_bits
   candidate IS optimizable

candidate at target/ppc/translate/vsx-impl.inc.c:1485
   op_size: i64/i64 (same)
   low_bits: 11 (value: 0x7ff)
   len: 0x7ff
   len_bits == low_bits
   candidate IS optimizable

>> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
>> index 7f12908029..354a6b113a 100644
>> --- a/target/ppc/translate/vsx-impl.inc.c
>> +++ b/target/ppc/translate/vsx-impl.inc.c
>> @@ -1262,8 +1262,7 @@ static void gen_xsxexpqp(DisasContext *ctx)
>>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>>          return;
>>      }
>> -    tcg_gen_shri_i64(xth, xbh, 48);
>> -    tcg_gen_andi_i64(xth, xth, 0x7FFF);
>> +    tcg_gen_extract_i64(xth, xbh, 48, 0x7FFF);
>>      tcg_gen_movi_i64(xtl, 0);
>>  }

0x7FFF = 0b111111111111111 (15 bits set)

This one is correct too?

>>
>> @@ -1431,10 +1430,8 @@ static void gen_xvxexpsp(DisasContext *ctx)
>>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>>          return;
>>      }
>> -    tcg_gen_shri_i64(xth, xbh, 23);
>> -    tcg_gen_andi_i64(xth, xth, 0xFF000000FF);
>> -    tcg_gen_shri_i64(xtl, xbl, 23);
>> -    tcg_gen_andi_i64(xtl, xtl, 0xFF000000FF);
>> +    tcg_gen_extract_i64(xth, xbh, 23, 0xFF000000FF);
>> +    tcg_gen_extract_i64(xtl, xbl, 23, 0xFF000000FF);
>>  }

WRONG

>>
>>  static void gen_xvxexpdp(DisasContext *ctx)
>> @@ -1448,10 +1445,8 @@ static void gen_xvxexpdp(DisasContext *ctx)
>>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>>          return;
>>      }
>> -    tcg_gen_shri_i64(xth, xbh, 52);
>> -    tcg_gen_andi_i64(xth, xth, 0x7FF);
>> -    tcg_gen_shri_i64(xtl, xbl, 52);
>> -    tcg_gen_andi_i64(xtl, xtl, 0x7FF);
>> +    tcg_gen_extract_i64(xth, xbh, 52, 0x7FF);
>> +    tcg_gen_extract_i64(xtl, xbl, 52, 0x7FF);
>>  }

0x7FF = 0b11111111111 (11 bits set)

correct too? (same next too)

>>
>>  GEN_VSX_HELPER_2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
>> @@ -1474,16 +1469,14 @@ static void gen_xvxsigdp(DisasContext *ctx)
>>      zr = tcg_const_i64(0);
>>      nan = tcg_const_i64(2047);
>>
>> -    tcg_gen_shri_i64(exp, xbh, 52);
>> -    tcg_gen_andi_i64(exp, exp, 0x7FF);
>> +    tcg_gen_extract_i64(exp, xbh, 52, 0x7FF);
>>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
>>      tcg_gen_andi_i64(xth, xbh, 0x000FFFFFFFFFFFFF);
>>      tcg_gen_or_i64(xth, xth, t0);
>>
>> -    tcg_gen_shri_i64(exp, xbl, 52);
>> -    tcg_gen_andi_i64(exp, exp, 0x7FF);
>> +    tcg_gen_extract_i64(exp, xbl, 52, 0x7FF);
>>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
>
> Regards
> Nikunj

Regards,

Phil.
