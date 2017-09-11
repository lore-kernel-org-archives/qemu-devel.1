Received: from eggs.gnu.org ([2001:4830:134:3::10]:46364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSiQ-00012h-C8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSiP-0004Nz-HO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:41:46 -0400
MIME-Version: 1.0
In-Reply-To: <1505137930-13255-6-git-send-email-peter.maydell@linaro.org>
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-6-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Sep 2017 10:41:11 -0700
Message-ID: <CAKmqyKPjNG5ttpTmSrdqNvWRk6=+Y1_kT6HE2bTah_C+2OvEuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/7] target/arm: Remove unnecessary '|
 0xf0000000' from do_v7m_exception_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Mon, Sep 11, 2017 at 6:52 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> In do_v7m_exception_exit(), there's no need to force the high 4
> bits of 'type' to 1 when calling v7m_exception_taken(), because
> we know that they're always 1 or we could not have got to this
> "handle return to magic exception return address" code. Remove
> the unnecessary ORs.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 1741e0d..fdd5cc6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6306,7 +6306,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>           */
>          env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
> -        v7m_exception_taken(cpu, type | 0xf0000000);
> +        v7m_exception_taken(cpu, type);
>          qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
>                        "stackframe: failed exception return integrity check\n");
>          return;
> @@ -6348,7 +6348,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
>          env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
>          v7m_push_stack(cpu);
> -        v7m_exception_taken(cpu, type | 0xf0000000);
> +        v7m_exception_taken(cpu, type);
>          qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new stackframe: "
>                        "failed exception return integrity check\n");
>          return;
> --
> 2.7.4
>
>
