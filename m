Received: from eggs.gnu.org ([2001:4830:134:3::10]:49703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTCsb-0001Gy-7X
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTCsY-0002T0-5w
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTCsX-0002S2-Sn
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:00:30 -0400
Date: Wed, 13 Jun 2018 18:00:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613210022.GG24764@localhost.localdomain>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180612184616.90838-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612184616.90838-2-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] kvm: support -realtime cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>

On Tue, Jun 12, 2018 at 09:47:11PM +0300, Michael S. Tsirkin wrote:
> With this flag, kvm allows guest to control host CPU power state.  This
> increases latency for other processes using same host CPU in an
> unpredictable way, but if decreases idle entry/exit times for the
> running VCPU.
> 
> Follow-up patches will expose this capability to guest
> (using mwait leaf).
> 
> Based on a patch by Wanpeng Li <kernellwp@gmail.com> .
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/sysemu/sysemu.h |  1 +
>  target/i386/kvm.c       | 22 ++++++++++++++++++++++
>  vl.c                    |  6 ++++++
>  qemu-options.hx         |  9 +++++++--
>  4 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index e893f72f3b..b921c6f3b7 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -128,6 +128,7 @@ extern bool boot_strict;
>  extern uint8_t *boot_splash_filedata;
>  extern size_t boot_splash_filedata_size;
>  extern bool enable_mlock;
> +extern bool enable_cpu_pm;

After looking at patch 2/2, I see that the global variable is
useful, and it's consistent with the existing enable_mlock
variable.

>  extern uint8_t qemu_extra_params_fw[2];
>  extern QEMUClockType rtc_clock;
>  extern const char *mem_path;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 44f70733e7..f093d55209 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1357,6 +1357,28 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          smram_machine_done.notify = register_smram_listener;
>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>      }
> +
> +    if (enable_cpu_pm) {
> +        int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
> +        int ret;
> +
> +/* Work around for kernel header with a typo. TODO: fix header and drop. */
> +#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
> +#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
> +#endif
> +        if (disable_exits) {
> +            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
> +                              KVM_X86_DISABLE_EXITS_HLT |
> +                              KVM_X86_DISABLE_EXITS_PAUSE);
> +        }
> +
> +        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> +                                disable_exits);

Isn't the kvm_vm_enable_cap() call supposed to be inside the "if
(disable_exits)" block?

> +        if (ret < 0) {
> +            error_report("kvm: guest stopping CPU not supported: %s", strerror(-ret));
> +        }
> +    }
> +
>      return 0;
>  }
[...]

-- 
Eduardo
