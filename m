Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E71C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFB7214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFB7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdfhx-0002J9-GL
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 14:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdfgU-0001BE-DK
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdfgT-00058z-4I
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:51:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdfgS-00058F-S0
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:51:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C5513005029;
 Wed, 19 Jun 2019 18:51:48 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 906CE608A5;
 Wed, 19 Jun 2019 18:51:47 +0000 (UTC)
Date: Wed, 19 Jun 2019 15:51:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190619185146.GB13027@habkost.net>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
 <20190612084104.34984-3-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612084104.34984-3-like.xu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 19 Jun 2019 18:51:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/9] hw/i386: Adjust nr_dies with
 configured smp_dies for PCMachine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 04:40:57PM +0800, Like Xu wrote:
> To support multiple dies configuration on PCMachine, the best place to
> set CPUX86State->nr_dies with requested PCMachineState->smp_dies is in
> pc_new_cpu() and pc_cpu_pre_plug(). Refactoring pc_new_cpu() is applied
> and redundant parameter "const char *typename" would be removed.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  hw/i386/pc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9e9a42f007..af2e95a1b9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1520,12 +1520,16 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
>      }
>  }
>  
> -static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
> +static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
>  {
>      Object *cpu = NULL;
>      Error *local_err = NULL;
> +    CPUX86State *env = NULL;
>  
> -    cpu = object_new(typename);
> +    cpu = object_new(MACHINE(pcms)->cpu_type);
> +
> +    env = &X86_CPU(cpu)->env;
> +    env->nr_dies = pcms->smp_dies;
>  
>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
>      object_property_set_bool(cpu, true, "realized", &local_err);
> @@ -1551,7 +1555,7 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
>          return;
>      }
>  
> -    pc_new_cpu(ms->cpu_type, apic_id, &local_err);
> +    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -1576,8 +1580,7 @@ void pc_cpus_init(PCMachineState *pcms)
>                                                       ms->smp.max_cpus - 1) + 1;
>      possible_cpus = mc->possible_cpu_arch_ids(ms);
>      for (i = 0; i < ms->smp.cpus; i++) {
> -        pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
> -                   &error_fatal);
> +        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
>      }
>  }
>  
> @@ -2297,6 +2300,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      CPUArchId *cpu_slot;
>      X86CPUTopoInfo topo;
>      X86CPU *cpu = X86_CPU(dev);
> +    CPUX86State *env = &cpu->env;
>      MachineState *ms = MACHINE(hotplug_dev);
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>      unsigned int smp_cores = ms->smp.cores;
> @@ -2308,6 +2312,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> +    env->nr_dies = pcms->smp_dies;
> +
>      /*
>       * If APIC ID is not set,
>       * set it based on socket/die/core/thread properties.
> -- 
> 2.21.0
> 

-- 
Eduardo

