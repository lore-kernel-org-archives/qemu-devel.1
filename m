Received: from eggs.gnu.org ([2001:4830:134:3::10]:48341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cw9hU-0003Dh-PC
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cw9hU-0007uX-25
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:51:56 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-2-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fae5703d-136e-5e45-1579-2670acf9500c@twiddle.net>
Date: Thu, 6 Apr 2017 08:51:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170406102249.20383-2-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v1 1/3] target/ppc: Emulate LL/SC using
 cmpxchg helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

On 04/06/2017 03:22 AM, Nikunj A Dadhania wrote:
> +    TCGv_i32 tmp = tcg_temp_local_new_i32();
> +    TCGv t0;
>
> +    tcg_gen_movi_i32(tmp, 0);
>      tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
>      l1 = gen_new_label();
>      tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
> -    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
> -    tcg_gen_qemu_st_tl(cpu_gpr[reg], EA, ctx->mem_idx, memop);
> +
> +    t0 = tcg_temp_new();
> +    tcg_gen_atomic_cmpxchg_tl(t0, EA, cpu_reserve_val, cpu_gpr[reg],
> +                              ctx->mem_idx, DEF_MEMOP(memop));
> +    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
> +    tcg_gen_trunc_tl_i32(tmp, t0);
> +
>      gen_set_label(l1);
> +    tcg_gen_shli_i32(tmp, tmp, CRF_EQ_BIT);
> +    tcg_gen_or_i32(cpu_crf[0], cpu_crf[0], tmp);

I encourage you to move these two lines up beside the setcond.
That way you don't need to use a local tmp, which implies a
spill/restore from the stack.


r~
