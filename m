Received: from eggs.gnu.org ([2001:4830:134:3::10]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLQCX-0008E2-IY
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLQCU-0006ND-Cp
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:32:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLQCU-0006N3-3T
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:32:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1BCAC04B32C
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 08:32:20 +0000 (UTC)
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
	<1497468113-2874-5-git-send-email-thuth@redhat.com>
	<2037063369.8589818.1497473942575.JavaMail.zimbra@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e3369520-79ec-8387-2a35-902464390b84@redhat.com>
Date: Thu, 15 Jun 2017 10:32:17 +0200
MIME-Version: 1.0
In-Reply-To: <2037063369.8589818.1497473942575.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] include/exec/poison: Mark CONFIG_KVM
 as poisoned, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 14.06.2017 22:59, Paolo Bonzini wrote:
> 
> ----- Original Message -----
>> From: "Thomas Huth" <thuth@redhat.com>
>> To: qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>
>> Sent: Wednesday, June 14, 2017 9:21:53 PM
>> Subject: [PATCH 4/4] include/exec/poison: Mark CONFIG_KVM as poisoned, too
>>
>> We unfortunately need some additional "#ifndef NEED_CPU_H" fuzz in
>> include/sysemu/kvm.h for this, so that the header can still be included
>> from common code (which is done all over the place), but now we can
>> finally be sure that nobody uses this define in a wrong place anymore.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/acpi/ich9.c        |  1 -
>>  include/exec/poison.h |  1 +
>>  include/sysemu/kvm.h  | 37 +++++++++++++++++++++++++++++++++++--
>>  3 files changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>> index 5c279bb..c5d8646 100644
>> --- a/hw/acpi/ich9.c
>> +++ b/hw/acpi/ich9.c
>> @@ -33,7 +33,6 @@
>>  #include "sysemu/sysemu.h"
>>  #include "hw/acpi/acpi.h"
>>  #include "hw/acpi/tco.h"
>> -#include "sysemu/kvm.h"
>>  #include "exec/address-spaces.h"
>>  
>>  #include "hw/i386/ich9.h"
>> diff --git a/include/exec/poison.h b/include/exec/poison.h
>> index 5ffed4d..540fc70 100644
>> --- a/include/exec/poison.h
>> +++ b/include/exec/poison.h
>> @@ -80,6 +80,7 @@
>>  
>>  #pragma GCC poison CONFIG_LINUX_USER
>>  #pragma GCC poison CONFIG_VHOST_NET
>> +#pragma GCC poison CONFIG_KVM
>>  
>>  #endif
>>  #endif
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 1e91613..8cc57e4 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -19,6 +19,8 @@
>>  #include "exec/memattrs.h"
>>  #include "hw/irq.h"
>>  
>> +#ifdef NEED_CPU_H
>> +
>>  #ifdef CONFIG_KVM
>>  #include <linux/kvm.h>
>>  #include <linux/kvm_para.h>
>> @@ -39,6 +41,8 @@
>>  #define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT 0
> 
> These defines can be moved to kvm_i386.h too.

OK. I think we could likely even get rid of most of them. Apart from
KVM_CPUID_FEATURES, all the defines are only used in target/i386/kvm.c
or in hw/i386/kvm/* files, as far as I can see, and CONFIG_KVM should
always be defined there.

>>  #endif
>>  
>> +#endif /* NEED_CPU_H */
>> +
>>  extern bool kvm_allowed;
>>  extern bool kvm_kernel_irqchip;
>>  extern bool kvm_split_irqchip;
>> @@ -55,7 +59,8 @@ extern bool kvm_direct_msi_allowed;
>>  extern bool kvm_ioeventfd_any_length_allowed;
>>  extern bool kvm_msi_use_devid;
>>  
>> -#if defined CONFIG_KVM || !defined NEED_CPU_H
>> +#if !defined(NEED_CPU_H)
>> +
>>  #define kvm_enabled()           (kvm_allowed)
>>  /**
>>   * kvm_irqchip_in_kernel:
>> @@ -178,6 +183,31 @@ extern bool kvm_msi_use_devid;
>>  #define kvm_msi_devid_required() (kvm_msi_use_devid)
>>  
>>  #else
>> +
>> +#ifdef CONFIG_KVM
>> +
>> +/*
>> + * Same definitions again, but we need to keep them separate
>> + * since CONFIG_KVM is poisoned without NEED_CPU_H
>> + */
> 
> Maybe
> 
> #ifndef NEED_CPU_H
> # define CONFIG_KVM_POSSIBLE
> #elif defined CONFIG_KVM
> # define CONFIG_KVM_POSSIBLE
> #endif
> 
> #ifdef CONFIG_KVM_POSSIBLE
> #define kvm_enabled()           (kvm_allowed)
> ...
> #else
> #define kvm_enabled()           0
> ...
> #endif
> 
> ?

Good idea, I'll change that!

>> +#define kvm_enabled()           (kvm_allowed)
>> +#define kvm_irqchip_in_kernel() (kvm_kernel_irqchip)
>> +#define kvm_irqchip_is_split() (kvm_split_irqchip)
>> +#define kvm_async_interrupts_enabled() (kvm_async_interrupts_allowed)
>> +#define kvm_halt_in_kernel() (kvm_halt_in_kernel_allowed)
>> +#define kvm_eventfds_enabled() (kvm_eventfds_allowed)
>> +#define kvm_irqfds_enabled() (kvm_irqfds_allowed)
>> +#define kvm_resamplefds_enabled() (kvm_resamplefds_allowed)
>> +#define kvm_msi_via_irqfd_enabled() (kvm_msi_via_irqfd_allowed)
>> +#define kvm_gsi_routing_enabled() (kvm_gsi_routing_allowed)
>> +#define kvm_gsi_direct_mapping() (kvm_gsi_direct_mapping)
>> +#define kvm_readonly_mem_enabled() (kvm_readonly_mem_allowed)
>> +#define kvm_direct_msi_enabled() (kvm_direct_msi_allowed)
>> +#define kvm_ioeventfd_any_length_enabled()
>> (kvm_ioeventfd_any_length_allowed)
>> +#define kvm_msi_devid_required() (kvm_msi_use_devid)
>> +
>> +#else
>> +
>>  #define kvm_enabled()           (0)
>>  #define kvm_irqchip_in_kernel() (false)
>>  #define kvm_irqchip_is_split() (false)
>> @@ -193,7 +223,10 @@ extern bool kvm_msi_use_devid;
>>  #define kvm_direct_msi_enabled() (false)
>>  #define kvm_ioeventfd_any_length_enabled() (false)
>>  #define kvm_msi_devid_required() (false)
>> -#endif
>> +
>> +#endif  /* CONFIG_KVM */
>> +
>> +#endif  /* NEED_CPU_H */
>>  
>>  struct kvm_run;
>>  struct kvm_lapic_state;
>> --
>> 1.8.3.1
>>
>>
