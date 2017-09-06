Received: from eggs.gnu.org ([2001:4830:134:3::10]:49144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpesX-0002nX-Gl
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpesT-00051r-G5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:16:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjrosato@linux.vnet.ibm.com>)
	id 1dpesT-000509-A6
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:16:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86IEVIl138062
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 14:16:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ctmrwf77s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 14:16:40 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mjrosato@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 14:16:40 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-12-david@redhat.com>
From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 14:16:34 -0400
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2c620927-0406-2fc1-895c-09ffc2e44a4e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/19] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com

On 09/04/2017 11:43 AM, David Hildenbrand wrote:
> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
> guest tries to bring these CPUs up but fails), because we don't support
> multiple CPUs on s390x under TCG.
> 
> Let's bail out if more than 1 is specified, so we don't raise people's
> hope. Make it a define, so we can easily bump it up later.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Makes sense.  Ran the described environment without this patch (errors)
and again with this patch (graceful exit w/ message).

Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

>  hw/s390x/s390-virtio-ccw.c | 7 +++++++
>  target/s390x/cpu.h         | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index f67b4b5d58..f7ca20d77a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -23,6 +23,7 @@
>  #include "hw/s390x/css.h"
>  #include "virtio-ccw.h"
>  #include "qemu/config-file.h"
> +#include "qemu/error-report.h"
>  #include "s390-pci-bus.h"
>  #include "hw/s390x/storage-keys.h"
>  #include "hw/s390x/storage-attributes.h"
> @@ -55,6 +56,12 @@ static void s390_init_cpus(MachineState *machine)
>      if (machine->cpu_model == NULL) {
>          machine->cpu_model = s390_default_cpu_model_name();
>      }
> +    if (tcg_enabled() && max_cpus > S390_TCG_MAX_CPUS) {
> +        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
> +                     "supported by TCG (%d) on s390x", max_cpus,
> +                     S390_TCG_MAX_CPUS);
> +        exit(1);
> +    }
> 
>      cpu_states = g_new0(S390CPU *, max_cpus);
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 147aceba28..dca6aa9aae 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -209,6 +209,8 @@ static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
> 
>  #define ENV_OFFSET offsetof(S390CPU, env)
> 
> +#define S390_TCG_MAX_CPUS 1
> +
>  #ifndef CONFIG_USER_ONLY
>  extern const struct VMStateDescription vmstate_s390_cpu;
>  #endif
> 
