Received: from eggs.gnu.org ([2001:4830:134:3::10]:59988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6ozp-0004cd-AW
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6ozl-0003z3-1i
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:31:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <alpine.DEB.2.10.1710211105550.27209@sstabellini-ThinkPad-X260>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <410334d8-4c51-bd2d-84be-daeefab85041@amsat.org>
Date: Mon, 23 Oct 2017 23:31:00 -0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710211105550.27209@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2] fix WFI/WFE length in
 syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Stefano,

On 10/21/2017 03:09 PM, Stefano Stabellini wrote:
[...]
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

this alloc'd tmp var needs to be free'd.

>              /* This is a special case because we don't want to just halt the CPU
>               * if trying to debug across a WFI.
>               */
>              gen_a64_set_pc_im(dc->pc);
> -            gen_helper_wfi(cpu_env);
> +            gen_helper_wfi(cpu_env, tmp);

as:
               tcg_temp_free_i32(tmp);

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
> +            gen_helper_wfi(cpu_env, tmp);

ditto.

>              /* The helper doesn't necessarily throw an exception, but we
>               * must go back to the main loop to check for interrupts anyway.
>               */
>              tcg_gen_exit_tb(0);
>              break;
> +        }
>          case DISAS_WFE:
>              gen_helper_wfe(cpu_env);
>              break;
> 

Regards,

Phil.
