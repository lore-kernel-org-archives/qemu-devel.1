Received: from eggs.gnu.org ([2001:4830:134:3::10]:45016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ioo-00069s-4w
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7iok-0001rJ-64
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ioj-0001qW-Sv
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:30 -0400
Date: Thu, 26 Oct 2017 16:05:14 +0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171026140514.GE7706@localhost.localdomain>
References: <20171026135814.20773-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026135814.20773-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tcg: Avoid setting tcg_initialize if
 !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Oct 26, 2017 at 03:58:14PM +0200, Richard Henderson wrote:
> Fix the build for --disable-tcg.
> 
> Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c            | 2 ++
>  target/i386/cpu.c           | 2 ++
>  target/mips/cpu.c           | 2 ++
>  target/ppc/translate_init.c | 2 ++
>  target/s390x/cpu.c          | 2 ++
>  5 files changed, 10 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 056284985d..a7f03eabe8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1760,7 +1760,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
>  #endif
>  
>      cc->disas_set_info = arm_disas_set_info;
> +#ifdef CONFIG_TCG
>      cc->tcg_initialize = arm_translate_init;
> +#endif

I'd prefer to have *_translate_init() stubs instead of the
#ifdefs, but I guess it's better to fix the build as soon as
possible, and worry about eliminating #ifdefs later.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>  }
>  
>  static void cpu_register(const ARMCPUInfo *info)
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 53ec94ac9b..2f556c0ea3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4212,7 +4212,9 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>  #endif
>      cc->cpu_exec_enter = x86_cpu_exec_enter;
>      cc->cpu_exec_exit = x86_cpu_exec_exit;
> +#ifdef CONFIG_TCG
>      cc->tcg_initialize = tcg_x86_init;
> +#endif
>  
>      dc->user_creatable = true;
>  }
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 0ae70288dd..80812f3e08 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -198,7 +198,9 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
>      cc->vmsd = &vmstate_mips_cpu;
>  #endif
>      cc->disas_set_info = mips_cpu_disas_set_info;
> +#ifdef CONFIG_TCG
>      cc->tcg_initialize = mips_tcg_init;
> +#endif
>  
>      cc->gdb_num_core_regs = 73;
>      cc->gdb_stop_before_watchpoint = true;
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 13436e4760..61a9552c1c 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10578,7 +10578,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>  #ifndef CONFIG_USER_ONLY
>      cc->virtio_is_big_endian = ppc_cpu_is_big_endian;
>  #endif
> +#ifdef CONFIG_TCG
>      cc->tcg_initialize = ppc_translate_init;
> +#endif
>  
>      dc->fw_name = "PowerPC,UNKNOWN";
>  }
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 824dfd6b65..ae3cee91a2 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -497,7 +497,9 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>  #endif
>  #endif
>      cc->disas_set_info = s390_cpu_disas_set_info;
> +#ifdef CONFIG_TCG
>      cc->tcg_initialize = s390x_translate_init;
> +#endif
>  
>      cc->gdb_num_core_regs = S390_NUM_CORE_REGS;
>      cc->gdb_core_xml_file = "s390x-core64.xml";
> -- 
> 2.13.6
> 

-- 
Eduardo
