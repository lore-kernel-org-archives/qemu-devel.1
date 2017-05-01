Received: from eggs.gnu.org ([2001:4830:134:3::10]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d50nb-0006My-M9
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 22:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d50nX-0000HZ-TP
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 22:10:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d50nX-0000HI-M0
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 22:10:47 -0400
Date: Sun, 30 Apr 2017 22:10:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170501021045.GA19416@flamenco>
References: <20170427120006.20564-1-rth@twiddle.net>
	<1493407045-24172-1-git-send-email-cota@braap.org>
	<1493407045-24172-2-git-send-email-cota@braap.org>
	<20170428192238.GA24988@flamenco>
	<33f75663-0254-0274-d451-7f081bc1acf5@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f75663-0254-0274-d451-7f081bc1acf5@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v5 + 1/2] target/aarch64: optimize
 cross-page direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Sat, Apr 29, 2017 at 12:30:08 +0200, Richard Henderson wrote:
> On 04/28/2017 09:22 PM, Emilio G. Cota wrote:
> >On Fri, Apr 28, 2017 at 15:17:24 -0400, Emilio G. Cota wrote:
> >>+++ b/target/arm/translate-a64.c
> >>@@ -373,8 +373,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
> >>          } else if (s->singlestep_enabled) {
> >>              gen_exception_internal(EXCP_DEBUG);
> >>          } else {
> >>-            tcg_gen_exit_tb(0);
> >>-            s->is_jmp = DISAS_TB_JUMP;
> >
> >I'm not sure about removing this line though. Would it be better to leave it?
> >I can't see how TB_JUMP ends up doing anything in the rest of the file.
> 
> Why not just replace this with
> 
>   s->is_jmp = DISAS_JUMP
> 
> and not emit the lookup_and_goto_ptr here at all?

If we don't emit anything here, we get the error you reported
in the other message (icount whatever in cpu-exec.c:599).

I think this is due to callers assuming get_goto_tb does indeed
generate code, instead of deferring it via is_jmp. For example:

    if (cond < 0x0e) {
        /* genuinely conditional branches */
        TCGLabel *label_match = gen_new_label();
        arm_gen_test_cc(cond, label_match);
        gen_goto_tb(s, 0, s->pc);
        gen_set_label(label_match);
        gen_goto_tb(s, 1, addr);
    } else { [...]

So the simplest solution here seems to just emit the goto_ptr helper
in gen_goto_tb().

Regarding the setting of is_jmp to DISAS_TB_JUMP, after having
looked at the code more closely, I think it shouldn't
be removed, since this is the way we break out of the loop in
gen_intermediate_code(), thereby marking this instruction as the
last of the current TB.

I have updated patch 1/2 accordingly. You can cherry-pick it from:
  https://github.com/cota/qemu/tree/tcg-next-v5+

Thanks,

		Emilio
