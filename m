Received: from eggs.gnu.org ([2001:4830:134:3::10]:48695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAM9-0005p4-FA
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAM4-00051J-C6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:18:13 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fOAM4-000519-5a
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:18:08 -0400
Received: by mail-pg0-x242.google.com with SMTP id p21-v6so8809658pgd.11
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:18:08 -0700 (PDT)
Date: Thu, 31 May 2018 08:18:04 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180530231804.GX3652@lianli.shorne-pla.net>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527141324.11937-9-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 08/20] target/openrisc: Merge tlb
 allocation into CPUOpenRISCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Sun, May 27, 2018 at 09:13:12AM -0500, Richard Henderson wrote:
> There is no reason to allocate this separately.  This was probably
> copied from target/mips which makes the same mistake.
> 
> While doing so, move tlb into the clear-on-reset range.  While not
> all of the TLB bits are guaranteed zero on reset, all of the valid
> bits are cleared, and the rest of the bits are unspecified.
> Therefore clearing the whole of the TLB is correct.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>

>  target/openrisc/cpu.h              |  6 ++++--
>  target/openrisc/interrupt.c        |  4 ++--
>  target/openrisc/interrupt_helper.c |  8 +++----
>  target/openrisc/machine.c          | 15 ++++++-------
>  target/openrisc/mmu.c              | 34 ++++++++++++++----------------
>  target/openrisc/sys_helper.c       | 28 ++++++++++++------------
>  6 files changed, 46 insertions(+), 49 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 35cab65f11..edc06be40e 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -301,6 +301,10 @@ typedef struct CPUOpenRISCState {
>  
>      uint32_t dflag;           /* In delay slot (boolean) */
>  
> +#ifndef CONFIG_USER_ONLY
> +    CPUOpenRISCTLBContext tlb;
> +#endif
> +
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>  
> @@ -310,8 +314,6 @@ typedef struct CPUOpenRISCState {
>      uint32_t cpucfgr;         /* CPU configure register */
>  
>  #ifndef CONFIG_USER_ONLY
> -    CPUOpenRISCTLBContext * tlb;
> -
>      QEMUTimer *timer;
>      uint32_t ttmr;          /* Timer tick mode register */
>      int is_counting;
[...]
>  
> diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
> index 0a793eb14d..c10d28b055 100644
> --- a/target/openrisc/machine.c
> +++ b/target/openrisc/machine.c
> @@ -30,18 +30,18 @@ static int env_post_load(void *opaque, int version_id)
>  
>      /* Restore MMU handlers */
>      if (env->sr & SR_DME) {
> -        env->tlb->cpu_openrisc_map_address_data =
> +        env->tlb.cpu_openrisc_map_address_data =
>              &cpu_openrisc_get_phys_data;
>      } else {
> -        env->tlb->cpu_openrisc_map_address_data =
> +        env->tlb.cpu_openrisc_map_address_data =
>              &cpu_openrisc_get_phys_nommu;
>      }
>  
>      if (env->sr & SR_IME) {
> -        env->tlb->cpu_openrisc_map_address_code =
> +        env->tlb.cpu_openrisc_map_address_code =
>              &cpu_openrisc_get_phys_code;
>      } else {
> -        env->tlb->cpu_openrisc_map_address_code =
> +        env->tlb.cpu_openrisc_map_address_code =
>              &cpu_openrisc_get_phys_nommu;
>      }
>  
> @@ -77,10 +77,6 @@ static const VMStateDescription vmstate_cpu_tlb = {
>      }
>  };
>  
> -#define VMSTATE_CPU_TLB(_f, _s)                             \
> -    VMSTATE_STRUCT_POINTER(_f, _s, vmstate_cpu_tlb, CPUOpenRISCTLBContext)
> -
> -
>  static int get_sr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
>  {
>      CPUOpenRISCState *env = opaque;
> @@ -143,7 +139,8 @@ static const VMStateDescription vmstate_env = {
>          VMSTATE_UINT32(fpcsr, CPUOpenRISCState),
>          VMSTATE_UINT64(mac, CPUOpenRISCState),
>  
> -        VMSTATE_CPU_TLB(tlb, CPUOpenRISCState),
> +        VMSTATE_STRUCT(tlb, CPUOpenRISCState, 1,
> +                       vmstate_cpu_tlb, CPUOpenRISCTLBContext),

As discussed no need for version update here since no actual change to
serialized bits.

>  
>          VMSTATE_TIMER_PTR(timer, CPUOpenRISCState),
>          VMSTATE_UINT32(ttmr, CPUOpenRISCState),
