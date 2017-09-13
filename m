Received: from eggs.gnu.org ([2001:4830:134:3::10]:39046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds8fZ-0003lj-Dr
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds8fU-00024Q-G3
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ds8fU-00023w-AH
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:29:32 -0400
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-9-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fb0909ad-19bb-3a92-27c6-652bf4d32277@redhat.com>
Date: Wed, 13 Sep 2017 16:29:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170913132417.24384-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/22] s390x: move sclp_service_call()
 to sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 13.09.2017 15:24, David Hildenbrand wrote:
> Implemented in sclp.c, so let's move it to the right include file.
> Fix up one include. Do a forward declaration of struct CPUS390XState to
> fix the two sclp consoles complaining.

Is that sentence about the forward declaration still valid? I did not
see that anymore here...

Apart from that:

Reviewed-by: Thomas Huth <thuth@redhat.com>


> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index a72d096081..847ff32f85 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -16,6 +16,7 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/qdev.h"
> +#include "target/s390x/cpu-qom.h"
>  
>  #define SCLP_CMD_CODE_MASK                      0xffff00ff
>  
> @@ -242,5 +243,6 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
>  void sclp_service_interrupt(uint32_t sccb);
>  void raise_irq_cpu_hotplug(void);
> +int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>  
>  #endif
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 4a0a59dfbc..5295bd3c66 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -722,6 +722,5 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>  
>  /* outside of target/s390x/ */
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
> -int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>  
>  #endif
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index b142db71c6..8b07535b02 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/s390x/ebcdic.h"
>  #include "hw/s390x/s390-virtio-hcall.h"
> +#include "hw/s390x/sclp.h"
>  #endif
>  
>  /* #define DEBUG_HELPER */
> 
