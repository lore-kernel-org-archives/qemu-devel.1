Received: from eggs.gnu.org ([2001:4830:134:3::10]:41237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fTt-00061u-Jc
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6fTs-00019u-KL
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:53:53 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6fTs-00019d-DQ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:53:52 -0400
Received: by mail-oi0-x241.google.com with SMTP id f63-v6so5818321oic.4
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:53:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-11-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-11-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:53:31 +0100
Message-ID: <CAFEAcA8XARzPc-YEoQVQUEoV2gL+ZOLsqzxhh36xzqjXZXniPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 10/22] target/arm: Allow EL change hooks
 to do IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> During code generation, surround CPSR writes and exception returns which
> call the EL change hooks with gen_io_start/end. The immediate need is
> for the PMU to access the clock and icount during EL change to support
> mode filtering.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/translate-a64.c | 2 ++
>  target/arm/translate.c     | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 31ff047..e1ae676 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1919,7 +1919,9 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
>              unallocated_encoding(s);
>              return;
>          }
> +        gen_io_start();
>          gen_helper_exception_return(cpu_env);
> +        gen_io_end();

You don't want to call gen_io_start() or gen_io_end() unless
tb_cflags(s->base.tb) & CF_USE_ICOUNT) is true.

(Ditto in the other cases below.)

>          /* Must exit loop to check un-masked IRQs */
>          s->base.is_jmp = DISAS_EXIT;
>          return;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index ba6ab7d..fd5871e 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -4536,7 +4536,9 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
>       * appropriately depending on the new Thumb bit, so it must
>       * be called after storing the new PC.
>       */
> +    gen_io_start();
>      gen_helper_cpsr_write_eret(cpu_env, cpsr);
> +    gen_io_end();
>      tcg_temp_free_i32(cpsr);
>      /* Must exit loop to check un-masked IRQs */
>      s->base.is_jmp = DISAS_EXIT;
> @@ -9828,7 +9830,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                  if (exc_return) {
>                      /* Restore CPSR from SPSR.  */
>                      tmp = load_cpu_field(spsr);
> +                    gen_io_start();
>                      gen_helper_cpsr_write_eret(cpu_env, tmp);
> +                    gen_io_end();
>                      tcg_temp_free_i32(tmp);
>                      /* Must exit loop to check un-masked IRQs */
>                      s->base.is_jmp = DISAS_EXIT;
> --
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
>

thanks
-- PMM
