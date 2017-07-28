Received: from eggs.gnu.org ([2001:4830:134:3::10]:38389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dayV4-0007VW-B3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dayV0-0004hp-37
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:11:50 -0400
References: <20170727143040.7236-1-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7c14185-57ac-36be-9f64-251258145678@redhat.com>
Date: Fri, 28 Jul 2017 08:11:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170727143040.7236-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-system-tricore: segfault when
 entering "x 0" on the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de

On 27.07.2017 16:30, Eduardo Otubo wrote:
> Starting Qemu with "qemu-system-tricore -nographic -M tricore_testboard -S"
> and entering "x 0" at the monitor prompt leads to Segmentation fault. This happens
> because tricore_cpu_get_phys_page_debug() is not implemented yet, this
> is a temporary workaround to avoid the crash.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  target/tricore/cpu.c | 10 ++++++++++
>  target/tricore/cpu.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 08f50e2ba7..5ab5b56454 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -22,6 +22,15 @@
>  #include "cpu.h"
>  #include "qemu-common.h"
>  #include "exec/exec-all.h"
> +#include "qemu/error-report.h"
> +
> +static hwaddr tricore_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
> +                                         MemTxAttrs *attrs)
> +{
> +    error_report("function cpu_get_phys_page_attrs_debug not "
> +                    "implemented, aborting");
> +    return -1;
> +}
>  
>  static inline void set_feature(CPUTriCoreState *env, int feature)
>  {
> @@ -176,6 +185,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
>      cc->dump_state = tricore_cpu_dump_state;
>      cc->set_pc = tricore_cpu_set_pc;
>      cc->synchronize_from_tb = tricore_cpu_synchronize_from_tb;
> +    cc->get_phys_page_attrs_debug = tricore_cpu_get_phys_page_attrs_debug;
>  }
>  
>  static void cpu_register(const TriCoreCPUInfo *info)
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index a3493a123c..2663723955 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -224,6 +224,7 @@ static inline TriCoreCPU *tricore_env_get_cpu(CPUTriCoreState *env)
>  #define ENV_OFFSET offsetof(TriCoreCPU, env)
>  
>  hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +

Unnecessary white-space change ... rather remove the
tricore_cpu_get_phys_page_debug() line instead?

>  void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
>                              fprintf_function cpu_fprintf, int flags);

Apart from the nit above, looks like this fixes the crash indeed:

Tested-by: Thomas Huth <thuth@redhat.com>
