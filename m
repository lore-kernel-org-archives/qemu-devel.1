Received: from eggs.gnu.org ([2001:4830:134:3::10]:40512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e71Wa-000205-BD
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e71WZ-0002jp-Ey
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:53:52 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:53425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e71WZ-0002jQ-7q
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:53:51 -0400
Received: by mail-wr0-x233.google.com with SMTP id u40so15305943wrf.10
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 08:53:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710211105550.27209@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710211105550.27209@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2017 16:53:29 +0100
Message-ID: <CAFEAcA_-b5kb=_jDeDbCGugmzvcuUGKvWV0myThVJuTDbg9jNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 October 2017 at 19:09, Stefano Stabellini <sstabellini@kernel.org> wrote:
> WFI/E are often, but not always, 4 bytes long. When they are, we need to
> set ARM_EL_IL_SHIFT in the syndrome register.
>
> Pass the instruction length to HELPER(wfi), use it to decrement pc
> appropriately and to pass an is_16bit flag to syn_wfx, which sets
> ARM_EL_IL_SHIFT if needed.
>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index a39b9d3..6f74589 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11380,17 +11380,20 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>              gen_helper_yield(cpu_env);
>              break;
>          case DISAS_WFI:
> +        {
> +            TCGv_i32 tmp = tcg_const_i32((dc->insn & (1U << 31)) ? 4 : 2);

This is the A64 translator, we know that WFI (like every instruction)
is 32 bit.

>              /* This is a special case because we don't want to just halt the CPU
>               * if trying to debug across a WFI.
>               */
>              gen_a64_set_pc_im(dc->pc);
> -            gen_helper_wfi(cpu_env);
> +            gen_helper_wfi(cpu_env, tmp);

As Philippe says, you need to free the TCG temp here.

>              /* The helper doesn't necessarily throw an exception, but we
>               * must go back to the main loop to check for interrupts anyway.
>               */
>              tcg_gen_exit_tb(0);
>              break;
>          }
> +        }
>      }
>
>      /* Functions above can change dc->pc, so re-align db->pc_next */
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4da1a4c..a89518f 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -12325,12 +12325,15 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>              /* nothing more to generate */
>              break;
>          case DISAS_WFI:
> -            gen_helper_wfi(cpu_env);
> +        {
> +            TCGv_i32 tmp = tcg_const_i32((dc->insn & (1U << 31)) ? 4 : 2);

This won't work, because dc->insn is only populated by the translate-a64.c
A64 translator, not by the A32/T32 code. I guess 'principle of least
surprise' suggests we should populate it for Thumb and ARM too.

> +            gen_helper_wfi(cpu_env, tmp);
>              /* The helper doesn't necessarily throw an exception, but we
>               * must go back to the main loop to check for interrupts anyway.
>               */
>              tcg_gen_exit_tb(0);
>              break;
> +        }
>          case DISAS_WFE:
>              gen_helper_wfe(cpu_env);
>              break;

thanks
-- PMM
