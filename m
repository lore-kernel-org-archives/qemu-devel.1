Received: from eggs.gnu.org ([2001:4830:134:3::10]:39183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYiOO-0004W7-CK
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYiOL-0000qj-8U
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:35:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60371)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYiOL-0000pn-23
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:35:33 -0400
Date: Fri, 21 Jul 2017 20:35:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170722003531.GB9909@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-34-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-34-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 33/34] target/arm: Split out
 thumb_tr_translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:42 -1000, Richard Henderson wrote:
> We need not check for ARM vs Thumb state in order to dispatch
> disassembly of every instruction.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate.c | 134 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 86 insertions(+), 48 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index ebe1c1a..d7c3c10 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
(snip)
> +static void arm_post_translate_insn(CPUARMState *env, DisasContext *dc)
> +{
> +    /* Translation stops when a conditional branch is encountered.
> +     * Otherwise the subsequent code could get translated several times.
> +     * Also stop translation when a page boundary is reached.  This
> +     * ensures prefetch aborts occur at the right place.
> +     *
> +     * We want to stop the TB if the next insn starts in a new page,
> +     * or if it spans between this page and the next. This means that
> +     * if we're looking at the last halfword in the page we need to
> +     * see if it's a 16-bit Thumb insn (which will fit in this TB)
> +     * or a 32-bit Thumb insn (which won't).
> +     * This is to avoid generating a silly TB with a single 16-bit insn
> +     * in it at the end of this page (which would execute correctly
> +     * but isn't very efficient).
> +     */
> +    if (dc->base.is_jmp == DISAS_NEXT
> +        && (dc->pc >= dc->next_page_start
> +            || (dc->pc >= dc->next_page_start - 3
> +                && insn_crosses_page(env, dc)))) {
> +        dc->base.is_jmp = DISAS_TOO_MANY;
>      }
>  
>      if (dc->condjmp && !dc->base.is_jmp) {
>          gen_set_label(dc->condlabel);
>          dc->condjmp = 0;
>      }
> +    dc->base.pc_next = dc->pc;
> +    translator_loop_temp_check(&dc->base);
> +}
>  
> -    if (dc->base.is_jmp == DISAS_NEXT) {
> -        /* Translation stops when a conditional branch is encountered.
> -         * Otherwise the subsequent code could get translated several times.
> -         * Also stop translation when a page boundary is reached.  This
> -         * ensures prefetch aborts occur at the right place.  */
> -
> -        if (dc->pc >= dc->next_page_start ||
> -            (dc->pc >= dc->next_page_start - 3 &&
> -             insn_crosses_page(env, dc))) {
> -            /* We want to stop the TB if the next insn starts in a new page,
> -             * or if it spans between this page and the next. This means that
> -             * if we're looking at the last halfword in the page we need to
> -             * see if it's a 16-bit Thumb insn (which will fit in this TB)
> -             * or a 32-bit Thumb insn (which won't).
> -             * This is to avoid generating a silly TB with a single 16-bit insn
> -             * in it at the end of this page (which would execute correctly
> -             * but isn't very efficient).
> -             */
> -            dc->base.is_jmp = DISAS_TOO_MANY;

Note that we've moved the above hunk ("if (dc->base.is_jmp == DISAS_NEXT)")
above the "if (dc->condjmp && !dc->base.is_jmp)" one; so when we now set
is_jmp to DISAS_TOO_MANY, dc->condjmp might be wrongly cleared by the
second hunk.

My review missed this, but luckily TCG asserts caught it while booting
debian-arm:

[  OK  ] Started Increase datagram queue length.
systemd[1]: Started Increase datagram queue length.
[  OK  ] Mounted POSIX Message Queue File System.
systemd[1]: Mounted POSIX Message Queue File System.
qemu-system-arm: /data/src/qemu/tcg/tcg-op.c:2584: tcg_gen_goto_tb: Assertion `(tcg_ctx.goto_tb_issue_mask & (1 << idx)) == 0' failed.
Aborted (core dumped)

Keeping the original order fixes it.

		Emilio

--8<--
---
 target/arm/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 77fe6a9..9cbace5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11979,6 +11979,11 @@ static bool arm_pre_translate_insn(DisasContext *dc)
 
 static void arm_post_translate_insn(CPUARMState *env, DisasContext *dc)
 {
+    if (dc->condjmp && !dc->base.is_jmp) {
+        gen_set_label(dc->condlabel);
+        dc->condjmp = 0;
+    }
+
     /* Translation stops when a conditional branch is encountered.
      * Otherwise the subsequent code could get translated several times.
      * Also stop translation when a page boundary is reached.  This
@@ -12000,10 +12005,6 @@ static void arm_post_translate_insn(CPUARMState *env, DisasContext *dc)
         dc->base.is_jmp = DISAS_TOO_MANY;
     }
 
-    if (dc->condjmp && !dc->base.is_jmp) {
-        gen_set_label(dc->condlabel);
-        dc->condjmp = 0;
-    }
     dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
-- 
2.7.4
