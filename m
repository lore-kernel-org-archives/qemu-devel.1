Received: from eggs.gnu.org ([2001:4830:134:3::10]:51729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpnIS-00069e-QK
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpnIO-0004ft-OF
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:16:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56201
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjrosato@linux.vnet.ibm.com>)
	id 1dpnIO-0004fV-Hy
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:16:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v873DegW094957
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 23:16:00 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctq57tnyu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 23:15:59 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mjrosato@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 23:15:59 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-15-david@redhat.com>
From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 23:15:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-15-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <22c96c28-6dc2-25be-b3ae-60bcf23846dd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/19] target/s390x: rename next_cpu_id
 to next_core_id
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
> Adapt to the new term "core_id". While at it, fix the type and drop the
> initialization to 0 (which is superfluous).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Given the prior patch, this rename makes sense.

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

> ---
>  target/s390x/cpu-qom.h |  2 +-
>  target/s390x/cpu.c     | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index c8fbf8ae03..21ea15e642 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -52,7 +52,7 @@ typedef struct S390CPUClass {
>      bool is_migration_safe;
>      const char *desc;
> 
> -    int64_t next_cpu_id;
> +    uint32_t next_core_id;
> 
>      DeviceRealize parent_realize;
>      void (*parent_reset)(CPUState *cpu);
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index a2570bbc6b..105ff13034 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -197,7 +197,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>      }
>  #else
>      /* implicitly set for linux-user only */
> -    cpu->env.core_id = scc->next_cpu_id;
> +    cpu->env.core_id = scc->next_core_id;
>  #endif
> 
>      if (cpu_exists(cpu->env.core_id)) {
> @@ -205,10 +205,10 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>                     cpu->env.core_id);
>          goto out;
>      }
> -    if (cpu->env.core_id != scc->next_cpu_id) {
> +    if (cpu->env.core_id != scc->next_core_id) {
>          error_setg(&err, "Unable to add CPU: %" PRIu32
> -                   ", the next available nr is %" PRIi64, cpu->env.core_id,
> -                   scc->next_cpu_id);
> +                   ", the next available id is %" PRIu32, cpu->env.core_id,
> +                   scc->next_core_id);
>          goto out;
>      }
> 
> @@ -218,7 +218,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>      if (err != NULL) {
>          goto out;
>      }
> -    scc->next_cpu_id++;
> +    scc->next_core_id++;
> 
>  #if !defined(CONFIG_USER_ONLY)
>      qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
> @@ -463,7 +463,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>      CPUClass *cc = CPU_CLASS(scc);
>      DeviceClass *dc = DEVICE_CLASS(oc);
> 
> -    scc->next_cpu_id = 0;
>      scc->parent_realize = dc->realize;
>      dc->realize = s390_cpu_realizefn;
>      dc->props = s390x_cpu_properties;
> 
