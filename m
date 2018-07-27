Received: from eggs.gnu.org ([2001:4830:134:3::10]:51288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fj50e-0002Pt-5I
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fj50Z-0000HL-9j
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:50:28 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fj50Z-0000G3-01
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:50:23 -0400
Received: by mail-pl0-x242.google.com with SMTP id w3-v6so2483499plq.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 08:50:22 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-24-git-send-email-stefan.markovic@rt-rk.com>
	<b2be38da-84b6-904c-a826-1c86fed7e03c@linaro.org>
	<SN6PR08MB4879EDCAD5A9D3EBC076F2C0C62A0@SN6PR08MB4879.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5dca6edd-e849-ca6e-18ea-84eeeb99ff97@linaro.org>
Date: Fri, 27 Jul 2018 08:50:17 -0700
MIME-Version: 1.0
In-Reply-To: <SN6PR08MB4879EDCAD5A9D3EBC076F2C0C62A0@SN6PR08MB4879.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 23/40] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 07/27/2018 08:29 AM, Aleksandar Markovic wrote:
> static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
>                      uint32_t reg1, uint32_t reg2)
> {
>     TCGv taddr = tcg_temp_new();
>     TCGv_i64 tval = tcg_temp_new_i64();
>     TCGv tmp1 = tcg_temp_new();
>     TCGv tmp2 = tcg_temp_new();
>     TCGv tmp3 = tcg_temp_new();
>     TCGLabel *l1 = gen_new_label();
> 
>     gen_base_offset_addr(ctx, taddr, base, offset);
>     tcg_gen_andi_tl(tmp3, taddr, 0x7);
>     tcg_gen_brcondi_tl(TCG_COND_EQ, tmp3, 0, l1);
>     tcg_temp_free(tmp3);
>     tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
>     generate_exception(ctx, EXCP_AdES);
>     gen_set_label(l1);

You shouldn't need this, as it is implied by

cpu.h:#define ALIGNED_ONLY

and will, for softmmu anyway, fault

>     tcg_gen_qemu_ld64(tval, taddr, ctx->mem_idx);

here.

(If you are testing -linux-user, there are many other missing
alignment faults and I suggest you ignore the issue entirely; it needs to be
dealt with generically.)

>     tcg_gen_extr_i64_tl(tmp1, tmp2, tval);
>     gen_store_gpr(tmp1, reg1);
>     tcg_temp_free(tmp1);
>     gen_store_gpr(tmp2, reg2);
>     tcg_temp_free(tmp2);

Has the swap of register numbers for big vs little-endian happened in the
caller?  You didn't show enough context to tell.



> static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
>                      uint32_t reg1, uint32_t reg2)
> {
>     TCGv taddr = tcg_temp_new();
>     TCGv lladdr = tcg_temp_new();
>     TCGv_i64 tval = tcg_temp_new_i64();
>     TCGv_i64 llval = tcg_temp_new_i64();
>     TCGv_i64 val = tcg_temp_new_i64();
>     TCGv tmp1 = tcg_temp_new();
>     TCGv tmp2 = tcg_temp_new();
>     TCGLabel *l1 = gen_new_label();
>     TCGLabel *lab_fail = gen_new_label();
>     TCGLabel *lab_done = gen_new_label();
>  
>     gen_base_offset_addr(ctx, taddr, base, offset);
>     tcg_gen_andi_tl(tmp1, taddr, 0x7);
>     tcg_gen_brcondi_tl(TCG_COND_EQ, tmp1, 0, l1);
>     tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
>     generate_exception(ctx, EXCP_AdES);
> 
>     gen_set_label(l1);

Hmm.  You could perhaps move the alignment test to the lab_fail path, because

>     tcg_gen_ld_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
>     tcg_gen_brcond_tl(TCG_COND_NE, taddr, lladdr, lab_fail);

if we pass this test we know that taddr == lladdr, and that lladdr is aligned
because the load for LLWP did not fault.  Even if that were not the case, the
cmpxchg itself would trigger an alignment fault.

>     gen_load_gpr(tmp1, reg1);
>     gen_load_gpr(tmp2, reg2);
>     tcg_gen_concat_tl_i64(tval, tmp1, tmp2);

Again, did a the reg1/reg2 swap happen in the caller?

>     tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
>     tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
>                                ctx->mem_idx, MO_64);
>     tcg_gen_setcond_i64(TCG_COND_EQ, val, val, llval);
>     tcg_gen_br(lab_done);

You failed to write back "val" to GPR[rt].

>  
>     gen_set_label(lab_fail);
>     tcg_gen_movi_tl(cpu_gpr[reg2], 0);
>  
>     gen_set_label(lab_done);
>     tcg_gen_movi_tl(lladdr, -1);
>     tcg_gen_st_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
> }
> 


r~
