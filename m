Received: from eggs.gnu.org ([2001:4830:134:3::10]:55613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMKl-0004Le-Rs
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMKh-0002tB-Qt
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:21:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56872
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cwMKh-0002so-LR
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:21:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v375J8Vd144148
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 01:21:14 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29p20appp4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 01:21:14 -0400
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 7 Apr 2017 10:51:11 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <2f858a60-0824-96c1-8248-49325fac2721@twiddle.net>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-4-nikunj@linux.vnet.ibm.com>
	<2f858a60-0824-96c1-8248-49325fac2721@twiddle.net>
Date: Fri, 07 Apr 2017 10:51:04 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zifsrdxb.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH RFC v1 3/3] target/ppc: Generate fence
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 04/06/2017 03:22 AM, Nikunj A Dadhania wrote:
>> @@ -3028,6 +3030,7 @@ static void gen_##name(DisasContext *ctx)                            \
>>      tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop);                \
>>      tcg_gen_mov_tl(cpu_reserve, t0);                                 \
>>      tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
>> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);                           \
>
> Please put the barrier next to the load.
> I hope we can merge these soon.

Sure

>
>> @@ -3196,6 +3199,7 @@ static void gen_##name(DisasContext *ctx)                   \
>>      if (len > 1) {                                          \
>>          gen_check_align(ctx, t0, (len) - 1);                \
>>      }                                                       \
>> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);                  \
>>      gen_conditional_store(ctx, t0, rS(ctx->opcode), memop); \
>>      tcg_temp_free(t0);                                      \
>>  }
>
> This one is more complicated...
>
> The success path includes an atomic_cmpxchg, which itself is a SC barrier. 
> However, the fail path branches across the cmpxchg and so sees no barrier, but 
> one is still required by the architecture.  How about a gen_conditional_store 
> that looks like this:
>
> {
>    TCGLabel *l1 = gen_new_label();
>    TCGLabel *l2 = gen_new_label();
>    TCGv t0;
>
>    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
>
>    t0 = tcg_temp_new();
>    tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
>                              cpu_gpr[reg], ctx->mem_idx,
>                              DEF_MEMOP(memop) | MO_ALIGN);
>    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
>    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
>    tcg_gen_or_tl(t0, t0, cpu_so);
>    tcg_gen_trunc_tl(cpu_crf[0], t0);
>    tcg_temp_free(t0);
>    tcg_gen_br(l2);
>
>    gen_set_label(l1);
>
>    /* Address mismatch implies failure.  But we still need to provide the
>       memory barrier semantics of the instruction.  */
>    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>    tcg_gen_trunc_tl(cpu_crf[0], cpu_so);
>
>    gen_set_label(l2);
>    tcg_gen_movi_tl(cpu_reserve, -1);
> }
>
> Note that you don't need to reset cpu_reserve_val at all.

Sure.

> I just thought of something we might need to check for this and other ll/sc 
> implemetations -- do we need to check for address misalignment along the 
> address comparison failure path?

We do that in the macro:

      if (len > 1) {                                          \
          gen_check_align(ctx, t0, (len) - 1);                \
      }                                                       \

Would we still need a barrier before the alignment check?

> I suspect that we do.

Regards
Nikunj
