Received: from eggs.gnu.org ([2001:4830:134:3::10]:58068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDYVt-00020I-FB
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDYVr-0005Xg-Ix
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:24:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gDYVr-0005WW-CO
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:24:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id d23-v6so2700890pls.11
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 10:24:39 -0700 (PDT)
Date: Fri, 19 Oct 2018 10:24:37 -0700 (PDT)
In-Reply-To: <20181019010625.25294-52-cota@braap.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-06bdb774-88d4-4a05-9cc0-f120a26646cd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v3 51/56] riscv: acquire the BQL in
 cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de

On Thu, 18 Oct 2018 18:06:20 PDT (-0700), cota@braap.org wrote:
> Soon we will call cpu_has_work without the BQL.
>
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/cpu.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d630e8fd6c..b10995c807 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -18,6 +18,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/log.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> @@ -244,11 +245,14 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
>      env->pc = tb->pc;
>  }
>
> -static bool riscv_cpu_has_work(CPUState *cs)
> +static bool riscv_cpu_has_work_locked(CPUState *cs)
>  {
>  #ifndef CONFIG_USER_ONLY
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> +
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      /*
>       * Definition of the WFI instruction requires it to ignore the privilege
>       * mode and delegation registers, but respect individual enables
> @@ -259,6 +263,21 @@ static bool riscv_cpu_has_work(CPUState *cs)
>  #endif
>  }
>
> +static bool riscv_cpu_has_work(CPUState *cs)
> +{
> +    if (!qemu_mutex_iothread_locked()) {
> +        bool ret;
> +
> +        cpu_mutex_unlock(cs);
> +        qemu_mutex_lock_iothread();
> +        cpu_mutex_lock(cs);
> +        ret = riscv_cpu_has_work_locked(cs);
> +        qemu_mutex_unlock_iothread();
> +        return ret;
> +    }
> +    return riscv_cpu_has_work_locked(cs);
> +}
> +
>  void restore_state_to_opc(CPURISCVState *env, TranslationBlock *tb,
>                            target_ulong *data)
>  {

I'm afraid I don't understand the locking scheme, but as far as the RISC-V 
stuff goes this looks fine.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
