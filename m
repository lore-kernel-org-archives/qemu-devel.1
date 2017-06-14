Received: from eggs.gnu.org ([2001:4830:134:3::10]:60551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL5h1-0004Lk-1I
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL5gx-0007sM-TD
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:38:31 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL5gx-0007rm-LB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:38:27 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 77so35887193wrb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 03:38:27 -0700 (PDT)
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
	<87vao4b4z5.fsf@linaro.org>
	<9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
	<20170611050730.GA12317@flamenco> <20170613225352.GA26288@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170613225352.GA26288@flamenco>
Date: Wed, 14 Jun 2017 11:38:59 +0100
Message-ID: <87shj2j1ks.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/aarch64: exit to main loop after
 handling MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> The appended fixes it for me. Can you please test?
> [ apply with `git am --scissors' ]
>
> Thanks,
>
> 		Emilio
>
> ---- 8< ----
>
> Commit e75449a3 ("target/aarch64: optimize indirect branches") causes
> a regression by which aarch64 guests freeze under TCG with -smp > 1,
> even with `-accel accel=tcg,thread=single' (i.e. MTTCG disabled).
>
> I isolated the problem to the MSR handler. This patch forces an exit
> after the handler is executed, which fixes the regression.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Tested-by: Alex Bennée <alex.bennee@linaro.org>

But what exactly is the mechanism here? DISAS_UPDATE should have ensured
that the PC was updated before we get to the helper. Is this a case of
msr_i_pstate somehow getting missed or not causing a flag update which
confuses the next TB calculation?

> ---
>  target/arm/translate-a64.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 860e279..5a609a0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1422,7 +1422,7 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>          gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
>          tcg_temp_free_i32(tcg_imm);
>          tcg_temp_free_i32(tcg_op);
> -        s->is_jmp = DISAS_UPDATE;
> +        s->is_jmp = DISAS_EXIT;
>          break;
>      }
>      default:
> @@ -11362,6 +11362,10 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
>          case DISAS_NEXT:
>              gen_goto_tb(dc, 1, dc->pc);
>              break;
> +        case DISAS_EXIT:
> +            gen_a64_set_pc_im(dc->pc);
> +            tcg_gen_exit_tb(0);
> +            break;
>          default:
>          case DISAS_UPDATE:
>              gen_a64_set_pc_im(dc->pc);


--
Alex Bennée
