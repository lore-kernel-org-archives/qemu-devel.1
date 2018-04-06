Received: from eggs.gnu.org ([2001:4830:134:3::10]:34185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4U30-0005Q3-Bo
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4U2z-0003ph-Eq
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:17:06 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4U2z-0003pY-8l
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:17:05 -0400
Received: by mail-oi0-x241.google.com with SMTP id x9-v6so1542368oig.7
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 09:17:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_LknKJeabd74Vp6=3J1cv7yevOYW6+-TvRE9FJtSdKMQ@mail.gmail.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
	<OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
	<CAFEAcA82xrYHYg3WvCpXwqm2ajv6SEUCL7cJsXFF+rccXxrUpg@mail.gmail.com>
	<CAFEAcA_LknKJeabd74Vp6=3J1cv7yevOYW6+-TvRE9FJtSdKMQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 17:16:44 +0100
Message-ID: <CAFEAcA9oLqZYhmLcNp6H6e_e-3sh17btZs00oZSJhdwgTd7Y=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>

On 6 April 2018 at 15:51, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 April 2018 at 14:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On this end I should try this with a 32-bit Linux host.
>
> I've now done this, and can reproduce the problem. So the
> issue is generic to 32-bit hosts.
>
> I'll see if I can figure out what's going wrong.

I've tracked down the issue -- it is with the arm frontend's
handling of the tcg_insn_start parameters. Specifically, we
have a 3-operand tcg_insn_start:
    tcg_gen_insn_start(dc->pc,
                       (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
                       0);
    dc->insn_start = tcg_last_op();

where we patch in the 3rd operand later sometimes in
disas_set_insn_syndrome():
    tcg_set_insn_param(s->insn_start, 2, syn);

Unfortunately, if we're running on a setup where
TARGET_LONG_BITS > TCG_TARGET_REG_BITS (ie 32 bit guest
on 64 bit host), tcg_gen_insn_start() has under the hood
split the 3 operands we gave it into 6, and so we end
up patching the wrong one.

The effect is that the first time the icount code needs to
call io_recompile, we set condexec_bits to a bogus value
which is also too big for its space in tb_flags and the
CPSR, and execution starts to diverge from there onward.

The following change fixes this:


diff --git a/target/arm/translate.h b/target/arm/translate.h
index c47febf99d..f04ece9cfd 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -120,7 +120,15 @@ static inline void
disas_set_insn_syndrome(DisasContext *s, uint32_t syn)

     /* We check and clear insn_start_idx to catch multiple updates.  */
     assert(s->insn_start != NULL);
+#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
     tcg_set_insn_param(s->insn_start, 2, syn);
+#else
+    /* tcg_gen_insn_start has split every target_ulong argument to
+     * op_insn_start into two 32-bit arguments, so we want the low
+     * half of the 3rd input argument, which is at index 4.
+     */
+    tcg_set_insn_param(s->insn_start, 4, syn);
+#endif
     s->insn_start = NULL;
 }


but I'm not convinced it's the neatest way to do it.

Nobody else plays this game with tcg_set_insn_param() (except
icount, which doesn't do it with target_ulong sized values),
so this bug is specific to the arm target.

Richard: do you have a cleaner suggestion than throwing this
ifdef into the arm code?

thanks
-- PMM
