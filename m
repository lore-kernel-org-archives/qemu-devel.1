Received: from eggs.gnu.org ([2001:4830:134:3::10]:60474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwNfB-00086O-Im
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwNf8-00009H-AT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:18:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwNf7-0008Gs-L9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:18:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8P7EaYw051781
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 03:18:18 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6sv61r5q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 03:18:18 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Sep 2017 08:18:15 +0100
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Sep 2017 09:18:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <54d45b80-4b24-7c27-9640-0bb50d77f14d@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/27] s390x: raise CPU hotplug irq
 after really hotplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 05:59 PM, David Hildenbrand wrote:
> Let's move it into the machine, so we trigger the IRQ after setting
> ms->possible_cpus (which SCLP uses to construct the list of
> online CPUs).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Makes sense
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  hw/s390x/s390-virtio-ccw.c | 4 ++++
>  target/s390x/cpu.c         | 8 --------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 0471407187..d5a12a2472 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -327,6 +327,10 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> 
>      g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
>      ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
> +
> +    if (dev->hotplugged) {
> +        raise_irq_cpu_hotplug();
> +    }
>  }
> 
>  static void s390_machine_reset(void)
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 34538c3ab9..4920da3625 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -41,7 +41,6 @@
>  #include "hw/hw.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> -#include "hw/s390x/sclp.h"
>  #endif
> 
>  #define CR0_RESET       0xE0UL
> @@ -227,13 +226,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
> 
>      scc->parent_realize(dev, &err);
> -
> -#if !defined(CONFIG_USER_ONLY)
> -    if (dev->hotplugged) {
> -        raise_irq_cpu_hotplug();
> -    }
> -#endif
> -
>  out:
>      error_propagate(errp, err);
>  }
> 
