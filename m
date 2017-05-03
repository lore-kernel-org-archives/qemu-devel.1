Received: from eggs.gnu.org ([2001:4830:134:3::10]:34481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d5wYc-000554-DT
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d5wYY-0004au-E5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:51:14 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:32953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d5wYY-0004Ze-4c
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:51:10 -0400
Date: Wed, 3 May 2017 11:51:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170503155107.GA13895@flamenco>
References: <20170502192300.2124-1-rth@twiddle.net>
	<6d583a19-0134-3332-e116-dba4ed2e758e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d583a19-0134-3332-e116-dba4ed2e758e@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v6 00/25] tcg cross-tb optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Tue, May 02, 2017 at 20:36:52 -0700, Richard Henderson wrote:
> On 05/02/2017 12:22 PM, Richard Henderson wrote:
> >Changes since v5:
> ...
> >   * Alpha frontend patch rewritten; the former patch appears to
> >     drop clock interrupts, not exiting the kernel's idle loop.
> >     I never *really* figured out why, since both patches seem
> >     to annotate the same TBs in the same way.
> 
> There's definitely something odd going on.
> 
> With a rebuild from scratch, the same symptoms have re-appeared for Alpha.
> So it really had nothing to do with the original patch.  I'm at a bit of a
> loss...

I can reliably reproduce a freeze upon booting.

Not sure this can help much (this is the first time I run an Alpha
guest), but here are some findings.

In my testing, if I disable the lookup for JMP/JSR/ret, I can boot OK.
This works:

+++ b/target/alpha/translate.c
@@ -2435,12 +2435,16 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         if (ra != 31) {
             tcg_gen_movi_i64(ctx->ir[ra], ctx->pc);
         }
+#if 0
         if (use_exit_tb(ctx)) {
             ret = EXIT_PC_UPDATED;
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
             ret = EXIT_GOTO_TB;
         }
+#else
+        ret = EXIT_PC_UPDATED;
+#endif
         break;

However, this doesn't tell us much, since these jumps are pretty common.

Interestingly, if I leave the lookup_and_goto_ptr above (s/#if 0/#if 1/), but
change the lookup_ptr helper to bypass tb_jmp_cache and directly check the
htable, it boots OK.

Could it be that we're forgetting to clear (or set) tb_jmp_cache somewhere?

		Emilio
