Received: from eggs.gnu.org ([2001:4830:134:3::10]:46203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQXc-0004qx-PN
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQXZ-0003Qg-5R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwQXY-0003QS-SM
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:05 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-10-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d1e53b94-8545-5db0-d4e9-58b5ce5fef1f@redhat.com>
Date: Mon, 25 Sep 2017 12:22:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/27] target/s390x: factor out handling
 of WAIT PSW into handle_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 18.09.2017 17:59, David Hildenbrand wrote:
> This will now also detect crashes under TCG. We can directly use
> cpu->env.psw.addr instead of kvm_run, as we do a
> cpu_synchronize_state().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c   | 28 ++++++++++++++++++++++------
>  target/s390x/internal.h |  1 +
>  target/s390x/kvm.c      | 15 +--------------
>  3 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index e22b93258b..75ceb0bf2b 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -26,6 +26,7 @@
>  #include "qemu/timer.h"
>  #include "exec/exec-all.h"
>  #include "hw/s390x/ioinst.h"
> +#include "sysemu/hw_accel.h"
>  #ifndef CONFIG_USER_ONLY
>  #include "sysemu/sysemu.h"
>  #endif
> @@ -113,6 +114,26 @@ hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr vaddr)
>      return phys_addr;
>  }
>  
> +static inline bool is_special_wait_psw(uint64_t psw_addr)
> +{
> +    /* signal quiesce */
> +    return psw_addr == 0xfffUL;
> +}
> +
> +void handle_wait(S390CPU *cpu)

"handle_wait" is a very generic name ... could you maybe at least name
this "s390x_handle_wait" or so?

> +{
> +    cpu_synchronize_state(CPU(cpu));
> +    if (s390_cpu_halt(cpu) == 0) {
> +#ifndef CONFIG_USER_ONLY
> +        if (is_special_wait_psw(cpu->env.psw.addr)) {
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        } else {
> +            qemu_system_guest_panicked(NULL);
> +        }
> +#endif
> +    }
> +}
> +
>  void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
>  {
>      uint64_t old_mask = env->psw.mask;
> @@ -128,12 +149,7 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
>      }
>  
>      if (mask & PSW_MASK_WAIT) {
> -        S390CPU *cpu = s390_env_get_cpu(env);
> -        if (s390_cpu_halt(cpu) == 0) {
> -#ifndef CONFIG_USER_ONLY
> -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> -#endif
> -        }
> +        handle_wait(s390_env_get_cpu(env));
>      }
>  }
>  
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index 15743ec40f..cb331f35ea 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -280,6 +280,7 @@ const char *cc_name(enum cc_op cc_op);
>  void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
>  uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
>                   uint64_t vr);
> +void handle_wait(S390CPU *cpu);
>  
>  
>  /* cpu.c */
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 3f9983154f..14f864697d 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1936,12 +1936,6 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
>      return r;
>  }
>  
> -static bool is_special_wait_psw(CPUState *cs)
> -{
> -    /* signal quiesce */
> -    return cs->kvm_run->psw_addr == 0xfffUL;
> -}
> -
>  static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
>  {
>      CPUState *cs = CPU(cpu);
> @@ -2012,14 +2006,7 @@ static int handle_intercept(S390CPU *cpu)
>              break;
>          case ICPT_WAITPSW:
>              /* disabled wait, since enabled wait is handled in kernel */
> -            cpu_synchronize_state(cs);

Maybe we should rather keep the cpu_synchronize_state() here instead of
putting it in helper.c? No other function in helper.c seems to call that
on its own yet...

> -            if (s390_cpu_halt(cpu) == 0) {
> -                if (is_special_wait_psw(cs)) {
> -                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> -                } else {
> -                    qemu_system_guest_panicked(NULL);
> -                }
> -            }
> +            handle_wait(cpu);
>              r = EXCP_HALTED;
>              break;
>          case ICPT_CPU_STOP:
> 

 Thomas
