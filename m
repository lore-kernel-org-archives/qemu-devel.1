Received: from eggs.gnu.org ([2001:4830:134:3::10]:44463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ee8Zy-0002lZ-B7
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ee8VC-0008Bw-H1
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:06:14 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:38844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ee8VB-00089t-SV
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:01:18 -0500
Received: by mail-pf0-x22d.google.com with SMTP id k19so1611876pfj.5
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 16:01:17 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7Nu-6WvTZyit-xU_bNS6bLKRay3_9e9YtYFmG5tmqr0RXA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <318eed49-c986-897a-0e4d-59e0946d11ad@linaro.org>
Date: Tue, 23 Jan 2018 16:01:13 -0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nu-6WvTZyit-xU_bNS6bLKRay3_9e9YtYFmG5tmqr0RXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 01/23/2018 01:37 PM, Michael Clark wrote:
> 
> 
> On Wed, Jan 3, 2018 at 12:10 PM, Richard Henderson
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 01/02/2018 04:44 PM, Michael Clark wrote:
>     > +/* convert RISC-V rounding mode to IEEE library numbers */
>     > +unsigned int ieee_rm[] = {
> 
>     static const.
> 
> 
> Done. 
> 
>     > +/* obtain rm value to use in computation
>     > + * as the last step, convert rm codes to what the softfloat library expects
>     > + * Adapted from Spike's decode.h:RM
>     > + */
>     > +#define RM ({                                             \
>     > +if (rm == 7) {                                            \
>     > +    rm = env->frm;                               \
>     > +}                                                         \
>     > +if (rm > 4) {                                             \
>     > +    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST); \
>     > +}                                                         \
>     > +ieee_rm[rm]; })
> 
>     Please use inline functions and not these macros.
> 
> 
> Done.
> 
> In fact the previous code would, with normal control flow, dereference
> ieee_rm[rm] with an out of bounds round mode so assuming helper_raise_exception
> does a longjmp, i've inserted g_assert_not_reached() after the exception. An
> analyser could detect that ieee_rm has an out of bounds access assuming normal
> control flow. e.g.
> 
> static inline void set_fp_round_mode(CPURISCVState *env, uint64_t rm)
> {
>     if (rm == 7) {
>         rm = env->frm;
>     } else if (rm > 4) {
>         helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
>         g_assert_not_reached();

Yes, raise_exception exits via longjmp.  This is a good change.

> Are translations not implicitly indexed by cpu_mmu_index? i.e. do we also need
> to add cpu_mmu_index to cpu_get_tb_cpu_state flags to prevent code translated
> for one value of mmu_index running in code with another value of mmu_index (in
> the case of riscv, we currently return processor mode / privilege level in
> cpu_mmu_index).

No, there is no implicit indexing.  That's why I've mentioned exactly this at
least twice in review so far.

There are two ways to do this correctly.  One is to add all the bits that
specify processor state (e.g. Alpha stores pal_code bit and supervisor bit).
Another is to actually encode the mmu_idx into the flags (e.g. ARM).


r~
