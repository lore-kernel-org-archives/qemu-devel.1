Received: from eggs.gnu.org ([2001:4830:134:3::10]:55421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMf1q-0004bo-QB
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMeyv-0007Wd-UL
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:08:18 -0500
MIME-Version: 1.0
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
	<20181108120628.29926-3-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181108120628.29926-3-kbastian@mail.uni-paderborn.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Nov 2018 12:07:43 -0800
Message-ID: <CAKmqyKMovbJcChitESLqep_4D4-kgMjaUSaESghPu5+EYKSu5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] target/riscv: Fix sfence.vm/a both
 available in any priv version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Nov 8, 2018 at 4:07 AM Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> sfence.vm has been replaced in priv v1.10 spec by sfence.vma.
>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 5359088e24..f44eb9c41b 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1292,10 +1292,14 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
>  #ifndef CONFIG_USER_ONLY
>      /* Extract funct7 value and check whether it matches SFENCE.VMA */
>      if ((opc == OPC_RISC_ECALL) && ((csr >> 5) == 9)) {
> -        /* sfence.vma */
> -        /* TODO: handle ASID specific fences */
> -        gen_helper_tlb_flush(cpu_env);
> -        return;
> +        if (env->priv_ver == PRIV_VERSION_1_10_0) {
> +            /* sfence.vma */
> +            /* TODO: handle ASID specific fences */
> +            gen_helper_tlb_flush(cpu_env);
> +            return;
> +        } else {
> +            gen_exception_illegal(ctx);
> +        }
>      }
>  #endif
>
> @@ -1342,7 +1346,11 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
>              gen_helper_wfi(cpu_env);
>              break;
>          case 0x104: /* SFENCE.VM */
> -            gen_helper_tlb_flush(cpu_env);
> +            if (env->priv_ver <= PRIV_VERSION_1_09_1) {
> +                gen_helper_tlb_flush(cpu_env);
> +            } else {
> +                gen_exception_illegal(ctx);
> +            }
>              break;
>  #endif
>          default:
> --
> 2.19.1
>
>
