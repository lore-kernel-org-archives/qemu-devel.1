Received: from eggs.gnu.org ([2001:4830:134:3::10]:60544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVkwm-0006sy-Qw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVkwl-0007Kw-T1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:42:52 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:36799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dVkwl-0007K0-Mq
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:42:51 -0400
Received: by mail-it0-x22a.google.com with SMTP id m68so4254165ith.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 13:42:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170712192902.15493-1-rth@twiddle.net>
References: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
	<20170712192902.15493-1-rth@twiddle.net>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 13 Jul 2017 22:42:28 +0200
Message-ID: <CAPybu_3ffLp2NWkSyVjs159Udopn38SHZA3WBcAedYXCXvbMpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: Fix BLSR and BLSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

Hi Richard

The simple example works as expected, but my big application
(gobject-introspection) still crashes with sigsegv :(.

it seems to be something related to the bmi and tbm instructions. If I
disable them in gcc ( -mno-bmi -mno-tbm), the application
runs ok.

A look at qemu's code does not show anything obvious, but I am not
that familiar with qemu source yet to find something like this through
static analysis.

My plan (as soon as I have some time) is to create a small set of apps
to validate bmi/tbm/ (Are you aware of something already existing for
this?)
My stupid guess is that maybe the ops are switched, or the flags are
not properly modified.

If you want, I can share the application that crashes with you, just
be aware that the number of dependencies is considerable.

BTW I can only run the gdb stub on version 2.8.0. On git HEAD I am getting only:

Quit
(gdb) c
Continuing.
warning: Remote failure reply: E22

Program stopped.
0x00000040017bac07 in ?? ()
(gdb) c
Continuing.



Thanks for your help, it is greatly appreciated!

On Wed, Jul 12, 2017 at 9:29 PM, Richard Henderson <rth@twiddle.net> wrote:
> The implementation of these two instructions was swapped.
> At the same time, unify the setup of eflags for the insn group.
>
> Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/i386/translate.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 9d5f1c3..69d3787 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4031,34 +4031,26 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
>                  ot = mo_64_32(s->dflag);
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>
> +                tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
>                  switch (reg & 7) {
>                  case 1: /* blsr By,Ey */
> -                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
> +                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
>                      tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
> -                    gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
> -                    gen_op_update2_cc();
> -                    set_cc_op(s, CC_OP_BMILGB + ot);
>                      break;
> -
>                  case 2: /* blsmsk By,Ey */
> -                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
> -                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
> -                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_cc_src);
> -                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -                    set_cc_op(s, CC_OP_BMILGB + ot);
> +                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
> +                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
>                      break;
> -
>                  case 3: /* blsi By, Ey */
> -                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
> -                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
> -                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_cc_src);
> -                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -                    set_cc_op(s, CC_OP_BMILGB + ot);
> +                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
> +                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
>                      break;
> -
>                  default:
>                      goto unknown_op;
>                  }
> +                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> +                gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
> +                set_cc_op(s, CC_OP_BMILGB + ot);
>                  break;
>
>              default:
> --
> 2.9.4
>



-- 
Ricardo Ribalda
