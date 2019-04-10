Received: from eggs.gnu.org ([209.51.188.92]:38788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBk0-0002VT-Uw
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBjz-0005dg-Sz
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:50:08 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:40838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1hEBjz-0005c9-EA
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:50:07 -0400
Date: Wed, 10 Apr 2019 14:50:01 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-3-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190407115839.25054-3-skrtbhtngr@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v2 2/2] cpus: move
 hvf_cpu_synchronize* calls to cpu_synchronize* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sun, Apr 07, 2019 at 05:28:39PM +0530, Sukrit Bhatnagar wrote:
> Keep the calls made to synchronize cpu by all hypervisors in one place
> inside cpu_synchronize_* functions in include/sysemu/hw_accel.h
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>  cpus.c                    | 12 ------------
>  include/sysemu/hw_accel.h | 10 ++++++++++
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index e83f72b48b..026df0dc5f 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1021,10 +1021,6 @@ void cpu_synchronize_all_states(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_state(cpu);
> -        /* TODO: move to cpu_synchronize_state() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_state(cpu);
> -        }
>      }
>  }
>  
> @@ -1034,10 +1030,6 @@ void cpu_synchronize_all_post_reset(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_reset(cpu);
> -        /* TODO: move to cpu_synchronize_post_reset() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_post_reset(cpu);
> -        }
>      }
>  }
>  
> @@ -1047,10 +1039,6 @@ void cpu_synchronize_all_post_init(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_init(cpu);
> -        /* TODO: move to cpu_synchronize_post_init() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_post_init(cpu);
> -        }
>      }
>  }
>  
> diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> index d2ddfb5ad0..bf081b4026 100644
> --- a/include/sysemu/hw_accel.h
> +++ b/include/sysemu/hw_accel.h
> @@ -15,6 +15,7 @@
>  #include "sysemu/hax.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/whpx.h"
> +#include "sysemu/hvf.h"
>  
>  static inline void cpu_synchronize_state(CPUState *cpu)
>  {
> @@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_state(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_state(cpu);
> +    }
>  }
>  
>  static inline void cpu_synchronize_post_reset(CPUState *cpu)
> @@ -40,6 +44,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_post_reset(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_post_reset(cpu);
> +    }
>  }
>  
>  static inline void cpu_synchronize_post_init(CPUState *cpu)
> @@ -53,6 +60,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_post_init(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_post_init(cpu);
> +    }
>  }
>  
>  static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> -- 
> 2.20.1
> 
> 

Hi Sukrit,

The commit itself looks sane but qemu starts to hang during BIOS boot
after I've applied it if I run it with hvf accel.

Thanks,
Roman
