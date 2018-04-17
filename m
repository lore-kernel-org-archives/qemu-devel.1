Received: from eggs.gnu.org ([2001:4830:134:3::10]:33482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8Wr1-0006UM-Id
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8Wqx-0000kf-Ub
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8Wqx-0000XS-1s
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:05:23 -0400
Date: Tue, 17 Apr 2018 17:05:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417200512.GY29865@localhost.localdomain>
References: <1523991487-241006-1-git-send-email-mst@redhat.com>
	<1523991487-241006-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523991487-241006-4-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] x86/cpu: use
 standard-headers/asm-x86.kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Wanpeng Li <kernellwp@gmail.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Tue, Apr 17, 2018 at 09:58:25PM +0300, Michael S. Tsirkin wrote:
> Switch to the header we imported from Linux,
> this allows us to drop a hack in kvm_i386.h.
> More code will be dropped in the next patch.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/sysemu/kvm.h   | 1 -
>  target/i386/cpu.h      | 2 --
>  target/i386/kvm_i386.h | 6 ------
>  hw/i386/kvm/clock.c    | 2 +-
>  target/i386/cpu.c      | 4 +---
>  target/i386/kvm.c      | 4 ++--
>  6 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 23669c4..0b64b8e 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -22,7 +22,6 @@
>  #ifdef NEED_CPU_H
>  # ifdef CONFIG_KVM
>  #  include <linux/kvm.h>
> -#  include <linux/kvm_para.h>
>  #  define CONFIG_KVM_IS_POSSIBLE
>  # endif
>  #else
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1b219fa..9aaab70 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -685,8 +685,6 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
>  
> -#define KVM_HINTS_DEDICATED (1U << 0)

include/standard-headers/asm-x86/kvm_para.h defines it as 0, but
the only user is fixed below, so this is OK.

> -
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
>  
>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 1de9876..e5df24c 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -30,12 +30,6 @@
>  #define kvm_pic_in_kernel()      0
>  #define kvm_ioapic_in_kernel()   0
>  
> -/* These constants must never be used at runtime if kvm_enabled() is false.
> - * They exist so we don't need #ifdefs around KVM-specific code that already
> - * checks kvm_enabled() properly.
> - */
> -#define KVM_CPUID_FEATURES       0

The only usage of this macro without CONFIG_KVM is in
feature_word_info, so this change isn't just harmless: it's
necessary to make feature_word_info accurate.


> -
>  #endif  /* CONFIG_KVM */
>  
>  bool kvm_allows_irq0_override(void);
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 7dac319..0bf1c60 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -26,7 +26,7 @@
>  #include "qapi/error.h"
>  
>  #include <linux/kvm.h>
> -#include <linux/kvm_para.h>
> +#include "standard-headers/asm-x86/kvm_para.h"
>  
>  #define TYPE_KVM_CLOCK "kvmclock"
>  #define KVM_CLOCK(obj) OBJECT_CHECK(KVMClockState, (obj), TYPE_KVM_CLOCK)
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1a6b082..efdca33 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -40,9 +40,7 @@
>  #include "qom/qom-qobject.h"
>  #include "sysemu/arch_init.h"
>  
> -#if defined(CONFIG_KVM)
> -#include <linux/kvm_para.h>
> -#endif
> +#include "standard-headers/asm-x86/kvm_para.h"
>  
>  #include "sysemu/sysemu.h"
>  #include "hw/qdev-properties.h"
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6c49954..44f8584 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -18,7 +18,7 @@
>  #include <sys/utsname.h>
>  
>  #include <linux/kvm.h>
> -#include <linux/kvm_para.h>
> +#include "standard-headers/asm-x86/kvm_para.h"
>  
>  #include "qemu-common.h"
>  #include "cpu.h"
> @@ -385,7 +385,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>              ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
>          }
>      } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
> -        ret |= KVM_HINTS_DEDICATED;
> +        ret |= 1U << KVM_HINTS_DEDICATED;
>          found = 1;

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
