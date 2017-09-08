Received: from eggs.gnu.org ([2001:4830:134:3::10]:43638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dqE3K-0004EX-R1
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dqE3G-0002tz-40
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:50:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45335
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dqE3F-0002rl-Ut
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:50:10 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v887naC4116733
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 03:50:08 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cumuxeqar-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 03:50:08 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 8 Sep 2017 08:50:06 +0100
References: <20170907201335.13956-1-david@redhat.com>
	<20170907201335.13956-8-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 8 Sep 2017 09:50:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170907201335.13956-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c7e13725-d0b5-0082-28ad-22c98357185f@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/21] s390x: move subsystem_reset() to
 s390-virtio-ccw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

On 09/07/2017 10:13 PM, David Hildenbrand wrote:
> Implemented in s390-virtio-ccw.c, so move it to the right header.
> We can also drop the extern. Fix up one include.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  include/hw/s390x/s390-virtio-ccw.h | 2 ++
>  target/s390x/cpu.h                 | 1 -
>  target/s390x/diag.c                | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 41a9d2862b..a9a90c2022 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -56,4 +56,6 @@ bool gs_allowed(void);
>   */
>  bool css_migration_enabled(void);
> 
> +void subsystem_reset(void);
> +
>  #endif
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 2343f2f1f7..3aa2e46aac 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -721,7 +721,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
> 
>  /* outside of target/s390x/ */
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
> -extern void subsystem_reset(void);
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> 
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index e6b5e6de37..82a623948d 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -20,6 +20,7 @@
>  #include "hw/watchdog/wdt_diag288.h"
>  #include "sysemu/cpus.h"
>  #include "hw/s390x/ipl.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> 
>  static int modified_clear_reset(S390CPU *cpu)
>  {
> 
