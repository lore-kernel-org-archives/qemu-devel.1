Received: from eggs.gnu.org ([209.51.188.92]:53238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1grWyq-0001eQ-Ml
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1grWyo-00071s-Fh
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:51:47 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1grWyo-0006yp-8C
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:51:46 -0500
Received: by mail-lf1-x142.google.com with SMTP id v5so6766926lfe.7
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 15:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-67-cota@braap.org>
In-Reply-To: <20190130004811.27372-67-cota@braap.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Feb 2019 15:51:00 -0800
Message-ID: <CAKmqyKNP9qun2Vtp7dWCtppPuA+_a7Y+bi0SVhWojgaOmakzsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 66/73] riscv: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Tue, Jan 29, 2019 at 5:30 PM Emilio G. Cota <cota@braap.org> wrote:
>
> Soon we will call cpu_has_work without the BQL.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 28d7e5302f..7b36c09fe0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -257,6 +257,9 @@ static bool riscv_cpu_has_work(CPUState *cs)
>  #ifndef CONFIG_USER_ONLY
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> +
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      /*
>       * Definition of the WFI instruction requires it to ignore the privilege
>       * mode and delegation registers, but respect individual enables
> @@ -343,7 +346,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
>      cc->reset = riscv_cpu_reset;
>
>      cc->class_by_name = riscv_cpu_class_by_name;
> -    cc->has_work = riscv_cpu_has_work;
> +    cc->has_work_with_iothread_lock = riscv_cpu_has_work;
>      cc->do_interrupt = riscv_cpu_do_interrupt;
>      cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
>      cc->dump_state = riscv_cpu_dump_state;
> --
> 2.17.1
>
>
