Received: from eggs.gnu.org ([2001:4830:134:3::10]:49568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRwe-0002yr-TN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRwb-0001VB-OP
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:40 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRwb-0001V1-J7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:12:37 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so8097386qkq.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 04:12:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498454578-18709-1-git-send-email-thuth@redhat.com>
	<1498454578-18709-3-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c05f2d52-0358-4e64-43be-c3e52684fa55@amsat.org>
Date: Mon, 26 Jun 2017 08:12:34 -0300
MIME-Version: 1.0
In-Reply-To: <1498454578-18709-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/7] Move CONFIG_KVM related definitions
 to kvm_i386.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/26/2017 02:22 AM, Thomas Huth wrote:
> pc.h and sysemu/kvm.h are also included from common code (where
> CONFIG_KVM is not available), so the #defines that depend on CONFIG_KVM
> should not be declared here to avoid that anybody is using them in a
> wrong way. Since we're also going to poison CONFIG_KVM for common code,
> let's move them to kvm_i386.h instead. Most of the dummy definitions
> from sysemu/kvm.h are also unused since the code that uses them is
> only compiled for CONFIG_KVM (e.g. target/i386/kvm.c), so the unused
> defines are also simply dropped here instead of being moved.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/i386/pc_q35.c       |  1 +
>   include/hw/i386/pc.h   | 13 -------------
>   include/sysemu/kvm.h   | 15 ---------------
>   target/i386/kvm_i386.h | 23 +++++++++++++++++++++++
>   4 files changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 1523ef3..8f696b7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -36,6 +36,7 @@
>   #include "hw/timer/mc146818rtc.h"
>   #include "hw/xen/xen.h"
>   #include "sysemu/kvm.h"
> +#include "kvm_i386.h"
>   #include "hw/kvm/clock.h"
>   #include "hw/pci-host/q35.h"
>   #include "exec/address-spaces.h"
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 233216a..f48d167 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -20,19 +20,6 @@
>   
>   #define HPET_INTCAP "hpet-intcap"
>   
> -#ifdef CONFIG_KVM
> -#define kvm_pit_in_kernel() \
> -    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> -#define kvm_pic_in_kernel()  \
> -    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> -#define kvm_ioapic_in_kernel() \
> -    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> -#else
> -#define kvm_pit_in_kernel()      0
> -#define kvm_pic_in_kernel()      0
> -#define kvm_ioapic_in_kernel()   0
> -#endif
> -
>   /**
>    * PCMachineState:
>    * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 1e91613..ca40b6e 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -22,21 +22,6 @@
>   #ifdef CONFIG_KVM
>   #include <linux/kvm.h>
>   #include <linux/kvm_para.h>
> -#else
> -/* These constants must never be used at runtime if kvm_enabled() is false.
> - * They exist so we don't need #ifdefs around KVM-specific code that already
> - * checks kvm_enabled() properly.
> - */
> -#define KVM_CPUID_SIGNATURE      0
> -#define KVM_CPUID_FEATURES       0
> -#define KVM_FEATURE_CLOCKSOURCE  0
> -#define KVM_FEATURE_NOP_IO_DELAY 0
> -#define KVM_FEATURE_MMU_OP       0
> -#define KVM_FEATURE_CLOCKSOURCE2 0
> -#define KVM_FEATURE_ASYNC_PF     0
> -#define KVM_FEATURE_STEAL_TIME   0
> -#define KVM_FEATURE_PV_EOI       0
> -#define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT 0
>   #endif
>   
>   extern bool kvm_allowed;
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index bfce427..1de9876 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -15,6 +15,29 @@
>   
>   #define kvm_apic_in_kernel() (kvm_irqchip_in_kernel())
>   
> +#ifdef CONFIG_KVM
> +
> +#define kvm_pit_in_kernel() \
> +    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> +#define kvm_pic_in_kernel()  \
> +    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> +#define kvm_ioapic_in_kernel() \
> +    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> +
> +#else
> +
> +#define kvm_pit_in_kernel()      0
> +#define kvm_pic_in_kernel()      0
> +#define kvm_ioapic_in_kernel()   0
> +
> +/* These constants must never be used at runtime if kvm_enabled() is false.
> + * They exist so we don't need #ifdefs around KVM-specific code that already
> + * checks kvm_enabled() properly.
> + */
> +#define KVM_CPUID_FEATURES       0
> +
> +#endif  /* CONFIG_KVM */
> +
>   bool kvm_allows_irq0_override(void);
>   bool kvm_has_smm(void);
>   bool kvm_has_adjust_clock_stable(void);
> 
