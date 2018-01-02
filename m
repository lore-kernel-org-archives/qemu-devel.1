Received: from eggs.gnu.org ([2001:4830:134:3::10]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWW3Q-0004YW-QJ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWW3O-0006Ky-1g
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:33:08 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:59983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWW3N-0006Hx-P8
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:33:05 -0500
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-8-laurent@vivier.eu>
	<1acae1a1-68f8-9b16-ecde-7b18d1c89662@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <77b9b527-946c-e745-6a51-7646966c4846@vivier.eu>
Date: Wed, 3 Jan 2018 00:33:00 +0100
MIME-Version: 1.0
In-Reply-To: <1acae1a1-68f8-9b16-ecde-7b18d1c89662@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 07/17] target/m68k: add chk and chk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

Le 02/01/2018 à 17:41, Richard Henderson a écrit :
> On 01/01/2018 05:10 PM, Laurent Vivier wrote:
>> +    SRC_EA(env, tsrc, opsize, 1, NULL);
>> +    src = tcg_temp_local_new();
>> +    tcg_gen_mov_i32(src, tsrc);
>> +
>> +    reg = tcg_temp_local_new();
>> +    gen_ext(reg, DREG(insn, 9), opsize, 1);
>> +    gen_flush_flags(s);
>> +    update_cc_op(s);
>> +
>> +    l1 = gen_new_label();
>> +    l2 = gen_new_label();
>> +    tcg_gen_brcondi_i32(TCG_COND_GE, reg, 0, l1);
>> +    tcg_gen_movi_i32(QREG_CC_N, -1);
>> +    tcg_gen_movi_i32(QREG_PC, s->pc);
>> +    gen_raise_exception(EXCP_CHK);
>> +    tcg_gen_br(l2);
> 
> Unreachable branch after exception.
> 
>> +    gen_set_label(l1);
>> +    tcg_gen_brcond_i32(TCG_COND_LE, reg, src, l2);
>> +    tcg_gen_movi_i32(QREG_CC_N, 0);
>> +    tcg_gen_movi_i32(QREG_PC, s->pc);
>> +    gen_raise_exception(EXCP_CHK);
>> +    gen_set_label(l2);
>> +    tcg_temp_free(src);
>> +    tcg_temp_free(reg);
> 
> Does real hardware not change flags at all if the chk passes?  The manual says

Real hardware (68040) always clears N if reg > 0.

> it is undefined, which would greatly simplify all this.  Especially just
> assigning reg to CC_N...
> 
> Generally I put conditional traps like this into a helper, which allows
> straight-line optimization of the non-trapping path to continue.  In this case,
> something like
> 
> void HELPER(chk)(CPUM68kState *env, int32_t val, int32_t ub)
> {
>     if (val < 0 || val > ub) {
>         CPUState *cs = CPU(m68k_env_get_cpu(env));
> 
> 	/* Recover PC and CC_OP for the beginning of the insn.  */
>         cpu_restore_state(cs, GETPC());
> 
>         /* Adjust PC and FLAGS to end of the insn.  */
>         env->pc += 2;
>         helper_flush_flags(env, env->cc_op);
>         env->cc_n = val;
> 
>         cs->exception_index = EXCP_CHK;
>         cpu_loop_exit(cs);
>     }
> }

Even with assigning reg directly to CC_N the use of an helper seems
better. I'm going to update the patch with your helper, and add one for
chk2 too.

Thanks,
Laurent
