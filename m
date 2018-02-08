Received: from eggs.gnu.org ([2001:4830:134:3::10]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejgq3-0004at-GI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejgq0-000617-Cs
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:41:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ejgq0-00060e-4H
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:41:44 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w187ddoP080864
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 02:41:42 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g0dsj98y1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 02:41:41 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 07:41:39 -0000
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 08:41:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180207175014.11157-2-lcapitulino@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <5cb72a0b-5ff0-42ab-d992-ccdd2a565cfa@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, ehabkost@redhat.com, berrange@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>

On 07.02.2018 18:50, Luiz Capitulino wrote:
> The query-cpus command has an extremely serious side effect:
> it always interrupt all running vCPUs so that they can run
> ioctl calls. This can cause a huge performance degradation for
> some workloads. And most of the information retrieved by the
> ioctl calls are not even used by query-cpus.
> 
> This commit introduces a replacement for query-cpus called
> query-cpus-fast, which has the following features:
> 
>  o Never interrupt vCPUs threads. query-cpus-fast only returns
>    vCPU information maintained by QEMU itself, which should be
>    sufficient for most management software needs
> 
>  o Make "halted" field optional: we only return it if the
>    halted state is maintained by QEMU. But this also gives
>    the option of dropping the field in the future (see below)
> 
>  o Drop irrelevant fields such as "current", "pc" and "arch"
I disagree that arch is irrelevant and would strongly suggest to keep
arch and arch-specific fields. At least in the case of s390 there's a
cpu_state field that can be obtained cheaply.
[...]
> diff --git a/cpus.c b/cpus.c
> index 2cb0af9b22..3b68a8146c 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2083,6 +2083,50 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>      return head;
>  }
> 
> +/*
> + * fast means: we NEVER interrupt vCPU threads to retrieve
> + * information from KVM.
> + */
> +CpuInfo2List *qmp_query_cpus_fast(Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    CpuInfo2List *head = NULL, *cur_item = NULL;
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        CpuInfo2List *info = g_malloc0(sizeof(*info));
> +        info->value = g_malloc0(sizeof(*info->value));
> +
> +        info->value->cpu_index = cpu->cpu_index;
> +        info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
> +        info->value->thread_id = cpu->thread_id;
> +
> +        info->value->has_props = !!mc->cpu_index_to_instance_props;
> +        if (info->value->has_props) {
> +            CpuInstanceProperties *props;
> +            props = g_malloc0(sizeof(*props));
> +            *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
> +            info->value->props = props;
> +        }
> +
> +        /* if in kernel irqchip is used, we don't have 'halted' */
> +        info->value->has_halted = !kvm_irqchip_in_kernel();
This is definitely not true for s390. Externally observable CPU state
changes are handled by QEMU there. We may still drop halted if we add a
more appropriate arch-specific field.
> +        if (info->value->has_halted) {
> +            info->value->halted = cpu->halted;
> +        }
[...]

-- 
Regards,
 Viktor Mihajlovski
