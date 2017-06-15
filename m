Received: from eggs.gnu.org ([2001:4830:134:3::10]:59469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLPm3-0002US-8Z
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLPlz-0006MD-9s
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:05:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLPlz-0006Ls-0E
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:04:59 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C733C3D94E
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 08:04:57 +0000 (UTC)
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
	<1497468113-2874-4-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36e982da-e993-2d25-e047-5d086972ba81@redhat.com>
Date: Thu, 15 Jun 2017 10:04:54 +0200
MIME-Version: 1.0
In-Reply-To: <1497468113-2874-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] include/hw/i386/pc.h: Move CONFIG_KVM
 related definitions to kvm_i386.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 14/06/2017 21:21, Thomas Huth wrote:
> pc.h is included from common code (where is CONFIG_KVM is not available),
> so the #defines that depend on CONFIG_KVM should not be declared here
> to avoid that anybody is using them in a wrong way.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i386/pc_q35.c       |  1 +
>  include/hw/i386/pc.h   | 13 -------------
>  target/i386/kvm_i386.h | 13 +++++++++++++
>  3 files changed, 14 insertions(+), 13 deletions(-)

Please move the ones in includes/sysemu/kvm.h in this patch, too.

Thanks,

Paolo

> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 1523ef3..8f696b7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -36,6 +36,7 @@
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/xen/xen.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_i386.h"
>  #include "hw/kvm/clock.h"
>  #include "hw/pci-host/q35.h"
>  #include "exec/address-spaces.h"
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d071c9c..a31f7aa 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -20,19 +20,6 @@
>  
>  #define HPET_INTCAP "hpet-intcap"
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
>  /**
>   * PCMachineState:
>   * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index bfce427..ac33f39 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -15,6 +15,19 @@
>  
>  #define kvm_apic_in_kernel() (kvm_irqchip_in_kernel())
>  
> +#ifdef CONFIG_KVM
> +#define kvm_pit_in_kernel() \
> +    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> +#define kvm_pic_in_kernel()  \
> +    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> +#define kvm_ioapic_in_kernel() \
> +    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> +#else
> +#define kvm_pit_in_kernel()      0
> +#define kvm_pic_in_kernel()      0
> +#define kvm_ioapic_in_kernel()   0
> +#endif
> +
>  bool kvm_allows_irq0_override(void);
>  bool kvm_has_smm(void);
>  bool kvm_has_adjust_clock_stable(void);
> 
