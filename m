Received: from eggs.gnu.org ([2001:4830:134:3::10]:36525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1exx5b-0005dI-Ug
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1exx5Y-000655-RN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:52:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1exx5Y-00064j-LD
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:52:44 -0400
References: <1521450289-5005-1-git-send-email-chao.qin@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b933eb30-9947-563b-e4da-6e37cf3f18f8@redhat.com>
Date: Mon, 19 Mar 2018 16:52:38 +0100
MIME-Version: 1.0
In-Reply-To: <1521450289-5005-1-git-send-email-chao.qin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hax: Properly handle IA32_APIC_BASE MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: chao.qin@linux.intel.com, qemu-devel@nongnu.org
Cc: yu.ning@linux.intel.com, Qin Chao <chao.qin@intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 19/03/2018 10:04, chao.qin@linux.intel.com wrote:
> From: Qin Chao <chao.qin@intel.com>
> 
> Emulation of IA32_APIC_BASE MSR in HAXM is not correct, such as bit
> 8, which is BSP flag and should be set to 1 for the bootstrap
> processor and set to 0 for the application processors, but it's set
> to 0 for all processors in HAXM. So guest OSes that expect a valid
> BSP flag, such as Zircon (the core of Google Fuchsia OS), cannot
> boot with "-accel hax". To solve this problem, HAXM (which lacks
> APIC virtualization) and QEMU must notify each other of any change
> to guest IA32_APIC_BASE MSR. The HAXM patch has been merged into
> HAXM source. QEMU needs to use the new HAXM API (apic_base in
> "struct hax_tunnel") to initialize the guest IA32_APIC_BASE MSR,
> and then, update its own copy at every return from
> HAX_VCPU_IOCTL_RUN.
> 
> There will be a backward compatility issue caused by the new field
> "apic_base" added into "struct hax_tunnel". In order to fix the
> problem, the validation for size of "struct hax_tunnel" is removed
> and a new capability flag "HAX_CAP_TUNNEL_PAGE" is added, which
> means that one page (4KB) is allocated in HAXM kernel to store
> "struct hax_tunnel", instead of the size of "struct hax_tunnel".
> 
> Change-Id: I8505bc1d75c495dd2765e581d6014125dcb538f3
> Signed-off-by: Qin Chao <chao.qin@intel.com>
> ---
>  target/i386/hax-all.c       | 24 +++++++++++++++++++-----
>  target/i386/hax-darwin.c    |  6 ------
>  target/i386/hax-i386.h      |  2 +-
>  target/i386/hax-interface.h |  3 +++
>  target/i386/hax-windows.c   |  5 -----
>  5 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index cad7531..6a840d9 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -62,11 +62,6 @@ int hax_enabled(void)
>      return hax_allowed;
>  }
>  
> -int valid_hax_tunnel_size(uint16_t size)
> -{
> -    return size >= sizeof(struct hax_tunnel);
> -}
> -
>  hax_fd hax_vcpu_get_fd(CPUArchState *env)
>  {
>      struct hax_vcpu_state *vcpu = ENV_GET_CPU(env)->hax_vcpu;
> @@ -104,6 +99,7 @@ static int hax_get_capability(struct hax_state *hax)
>      }
>  
>      hax->supports_64bit_ramblock = !!(cap->winfo & HAX_CAP_64BIT_RAMBLOCK);
> +    hax->supports_tunnel_page = !!(cap->winfo & HAX_CAP_TUNNEL_PAGE);
>  
>      if (cap->wstatus & HAX_CAP_MEMQUOTA) {
>          if (cap->mem_quota < hax->mem_quota) {
> @@ -520,6 +516,21 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>          cpu_exec_end(cpu);
>          qemu_mutex_lock_iothread();
>  
> +        /*
> +         * Every time HAXM exits to QEMU, sync IA32_APIC_BASE MSR from HAXM and
> +         * pass it to the emulated APIC.
> +         */
> +        if (hax_global.supports_tunnel_page) {
> +            /*
> +             * ht->apic_base is not available in HAXM kernel module if HAXM does
> +             * not support HAX_CAP_SUPPORT_TUNNEL_PAGE.
> +             * TODO: HAX_CAP_SUPPORT_TUNNEL_PAGE is used for backward
> +             * compatibility with HAXM kernel module. Remove this check when we
> +             * drop support for HAXM versions that lack this feature.
> +             */
> +            cpu_set_apic_base(x86_cpu->apic_state, ht->apic_base);
> +        }
> +
>          /* Simply continue the vcpu_run if system call interrupted */
>          if (hax_ret == -EINTR || hax_ret == -EAGAIN) {
>              DPRINTF("io window interrupted\n");
> @@ -933,6 +944,9 @@ static int hax_set_msrs(CPUArchState *env)
>      hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->fmask);
>      hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE, env->kernelgsbase);
>  #endif
> +    hax_msr_entry_set(&msrs[n++], MSR_IA32_APICBASE, \
> +                      cpu_get_apic_base(x86_env_get_cpu(env)->apic_state));
> +
>      md.nr_msr = n;
>      md.done = 0;
>  
> diff --git a/target/i386/hax-darwin.c b/target/i386/hax-darwin.c
> index acdde47..3e2fd4f 100644
> --- a/target/i386/hax-darwin.c
> +++ b/target/i386/hax-darwin.c
> @@ -244,12 +244,6 @@ int hax_host_setup_vcpu_channel(struct hax_vcpu_state *vcpu)
>          return ret;
>      }
>  
> -    if (!valid_hax_tunnel_size(info.size)) {
> -        fprintf(stderr, "Invalid hax tunnel size %x\n", info.size);
> -        ret = -EINVAL;
> -        return ret;
> -    }
> -
>      vcpu->tunnel = (struct hax_tunnel *) (intptr_t) (info.va);
>      vcpu->iobuf = (unsigned char *) (intptr_t) (info.io_va);
>      return 0;
> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
> index 6abc156..b04bf24 100644
> --- a/target/i386/hax-i386.h
> +++ b/target/i386/hax-i386.h
> @@ -38,6 +38,7 @@ struct hax_state {
>      struct hax_vm *vm;
>      uint64_t mem_quota;
>      bool supports_64bit_ramblock;
> +    bool supports_tunnel_page;
>  };
>  
>  #define HAX_MAX_VCPU 0x10
> @@ -53,7 +54,6 @@ struct hax_vm {
>  #ifdef NEED_CPU_H
>  /* Functions exported to host specific mode */
>  hax_fd hax_vcpu_get_fd(CPUArchState *env);
> -int valid_hax_tunnel_size(uint16_t size);
>  
>  /* Host specific functions */
>  int hax_mod_version(struct hax_state *hax, struct hax_module_version *version);
> diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
> index 93d5fcb..715a64a 100644
> --- a/target/i386/hax-interface.h
> +++ b/target/i386/hax-interface.h
> @@ -280,6 +280,7 @@ struct hax_tunnel {
>          struct {
>          } state;
>      };
> +    uint64_t apic_base;
>  } __attribute__ ((__packed__));
>  
>  struct hax_module_version {
> @@ -335,6 +336,8 @@ struct hax_set_ram_info {
>  #define HAX_CAP_MEMQUOTA           0x2
>  #define HAX_CAP_UG                 0x4
>  #define HAX_CAP_64BIT_RAMBLOCK     0x8
> +#define HAX_CAP_TUNNEL_PAGE        0x20
> +
>  
>  struct hax_capabilityinfo {
>      /* bit 0: 1 - working
> diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
> index b1ac737..6ed4f22 100644
> --- a/target/i386/hax-windows.c
> +++ b/target/i386/hax-windows.c
> @@ -347,11 +347,6 @@ int hax_host_setup_vcpu_channel(struct hax_vcpu_state *vcpu)
>          return -1;
>      }
>  
> -    if (!valid_hax_tunnel_size(info.size)) {
> -        fprintf(stderr, "Invalid hax tunnel size %x\n", info.size);
> -        ret = -EINVAL;
> -        return ret;
> -    }
>      vcpu->tunnel = (struct hax_tunnel *) (intptr_t) (info.va);
>      vcpu->iobuf = (unsigned char *) (intptr_t) (info.io_va);
>      return 0;
> 

Queued, thanks.

Paolo
