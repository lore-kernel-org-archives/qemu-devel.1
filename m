Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AAAC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EA924658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYAXI9NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EA924658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irU6h-0000zz-Fx
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 16:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1irU5Y-0000Pe-Oh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1irU5Q-0007Ys-Ek
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:51:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1irU5Q-0007YN-AZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579038655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uK8HX/UdvDVEyWjVStrjsl6hqfGO/hXztn3ZIglDxJs=;
 b=NYAXI9NNS+Qw8ox2aoC6haybZaCsCvxX6zOHWKuipn/ouEaIcJzl5tP0Wpq3a1Q9caBsuT
 5KFkbdi/Wc/IvHwpjCKSCii2qTZRdHab0gIy27gqRQejyxmLzc8xr9NDCM4BXhdyPFfTEp
 uVW4KnZJ0XizHruWMbbKM0QTqfTTEX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-UCq4dJwWNBC_IZ0WX48SEw-1; Tue, 14 Jan 2020 16:50:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C5EC800D41;
 Tue, 14 Jan 2020 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-21.bne.redhat.com [10.64.54.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41774842A7;
 Tue, 14 Jan 2020 21:50:46 +0000 (UTC)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
References: <20191219040612.28431-1-gshan@redhat.com>
Message-ID: <cfe51b6c-2af1-5c43-f045-29eb2fba6822@redhat.com>
Date: Wed, 15 Jan 2020 08:50:44 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191219040612.28431-1-gshan@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UCq4dJwWNBC_IZ0WX48SEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 3:06 PM, Gavin Shan wrote:
> This supports NMI injection for virtual machine and currently it's only
> supported on GICv3 controller, which is emulated by qemu or host kernel.
> The design is highlighted as below:
> 
>     * The NMI is identified by its priority (0x20). In the guest (linux)
>       kernel, the GICC_PMR is set to 0x80, to block all interrupts except
>       the NMIs when the external interrupt is disabled. It means the FIQ
>       and IRQ bit in PSTATE isn't touched when the functionality (NMI) is
>       functional.
>     * LPIs aren't considered as NMIs because of their nature. It means NMI
>       is either SPI or PPI. Besides, the NMIs are injected in round-robin
>       fashion is there are multiple NMIs existing.
>     * When the GICv3 controller is emulated by qemu, the interrupt states
>       (e.g. enabled, priority) is fetched from the corresponding data struct
>       directly. However, we have to pause all CPUs to fetch the interrupt
>       states from host in advance if the GICv3 controller is emulated by
>       host.
> 
> The testing scenario is to tweak guest (linux) kernel where the pl011 SPI
> can be enabled as NMI by request_nmi(). Check "/proc/interrupts" after injecting
> several NMIs, to see if the interrupt count is increased or not. The result
> is just as expected.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/arm/virt.c                      | 24 ++++++++
>   hw/intc/arm_gicv3.c                | 76 ++++++++++++++++++++++++
>   hw/intc/arm_gicv3_kvm.c            | 92 ++++++++++++++++++++++++++++++
>   include/hw/intc/arm_gicv3_common.h |  2 +
>   4 files changed, 194 insertions(+)
> 

Peter, could you please take a look when you have free time? Thanks in advance
for your comments :)

Thanks,
Gavin

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 39ab5f47e0..fc58ee70b4 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -71,6 +71,8 @@
>   #include "hw/mem/pc-dimm.h"
>   #include "hw/mem/nvdimm.h"
>   #include "hw/acpi/generic_event_device.h"
> +#include "hw/nmi.h"
> +#include "hw/intc/arm_gicv3.h"
>   
>   #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>       static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1980,6 +1982,25 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                  " type: %s", object_get_typename(OBJECT(dev)));
>   }
>   
> +static void virt_nmi(NMIState *n, int cpu_index, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(n);
> +    ARMGICv3CommonClass *agcc;
> +
> +    if (vms->gic_version != 3) {
> +        error_setg(errp, "NMI is only supported by GICv3");
> +        return;
> +    }
> +
> +    agcc = ARM_GICV3_COMMON_GET_CLASS(vms->gic);
> +    if (agcc->inject_nmi) {
> +        agcc->inject_nmi(vms->gic, cpu_index, errp);
> +    } else {
> +        error_setg(errp, "NMI injection isn't supported by %s",
> +                   object_get_typename(OBJECT(vms->gic)));
> +    }
> +}
> +
>   static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>                                                           DeviceState *dev)
>   {
> @@ -2025,6 +2046,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
> +    NMIClass *nc = NMI_CLASS(oc);
>   
>       mc->init = machvirt_init;
>       /* Start with max_cpus set to 512, which is the maximum supported by KVM.
> @@ -2051,6 +2073,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       hc->pre_plug = virt_machine_device_pre_plug_cb;
>       hc->plug = virt_machine_device_plug_cb;
>       hc->unplug_request = virt_machine_device_unplug_request_cb;
> +    nc->nmi_monitor_handler = virt_nmi;
>       mc->numa_mem_supported = true;
>       mc->auto_enable_numa_with_memhp = true;
>   }
> @@ -2136,6 +2159,7 @@ static const TypeInfo virt_machine_info = {
>       .instance_init = virt_instance_init,
>       .interfaces = (InterfaceInfo[]) {
>            { TYPE_HOTPLUG_HANDLER },
> +         { TYPE_NMI },
>            { }
>       },
>   };
> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
> index 66eaa97198..d3409cb6ef 100644
> --- a/hw/intc/arm_gicv3.c
> +++ b/hw/intc/arm_gicv3.c
> @@ -338,6 +338,81 @@ static void gicv3_set_irq(void *opaque, int irq, int level)
>       }
>   }
>   
> +static bool arm_gicv3_inject_nmi_once(GICv3State*s, int start, int end)
> +{
> +    GICv3CPUState *cs;
> +    int irq_count = (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
> +    int i, cpu, irq;
> +
> +    /* SPIs */
> +    for (i = start; (i < end) && (i < (s->num_irq - GIC_INTERNAL)); i++) {
> +        if (gicv3_gicd_enabled_test(s, i + GIC_INTERNAL) &&
> +            s->gicd_ipriority[i + GIC_INTERNAL] == 0x20) {
> +
> +            /*
> +             * Reset the level and toggling the pending bit will ensure
> +             * the interrupt is queued.
> +             */
> +            if (gicv3_gicd_level_test(s, i + GIC_INTERNAL)) {
> +                gicv3_set_irq(s, i, false);
> +            }
> +
> +            gicv3_gicd_pending_set(s, i + GIC_INTERNAL);
> +            gicv3_set_irq(s, i, true);
> +
> +            s->last_nmi_index = (i + 1);
> +            return true;
> +        }
> +    }
> +
> +    /* PPIs */
> +    if (start < (s->num_irq - GIC_INTERNAL)) {
> +        start = (s->num_irq - GIC_INTERNAL);
> +    }
> +
> +    for (i = start; (i < end) && (i < irq_count); i++) {
> +        cpu = (i - ((s->num_irq - GIC_INTERNAL))) / GIC_INTERNAL;
> +        irq = (i - ((s->num_irq - GIC_INTERNAL))) % GIC_INTERNAL;
> +        cs = &s->cpu[cpu];
> +
> +        if ((cs->gicr_ienabler0 & (1 << irq)) &&
> +            cs->gicr_ipriorityr[irq] == 0x20) {
> +
> +            if (extract32(cs->level, irq, 1)) {
> +                gicv3_set_irq(s, i, false);
> +            }
> +
> +            deposit32(cs->gicr_ipendr0, irq, 1, 1);
> +            gicv3_set_irq(s, i, true);
> +
> +            s->last_nmi_index = (i + 1);
> +            if (s->last_nmi_index > irq_count) {
> +                s->last_nmi_index = 0;
> +            }
> +
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static void arm_gicv3_inject_nmi(DeviceState *dev, int cpu_index, Error **errp)
> +{
> +    GICv3State *s = ARM_GICV3(dev);
> +    int irq_count = (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
> +    bool injected;
> +
> +    injected = arm_gicv3_inject_nmi_once(s, s->last_nmi_index, irq_count);
> +    if (!injected) {
> +        injected = arm_gicv3_inject_nmi_once(s, 0, s->last_nmi_index);
> +    }
> +
> +    if (!injected) {
> +        error_setg(errp, "No NMI found");
> +    }
> +}
> +
>   static void arm_gicv3_post_load(GICv3State *s)
>   {
>       /* Recalculate our cached idea of the current highest priority
> @@ -395,6 +470,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, void *data)
>       ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
>       ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
>   
> +    agcc->inject_nmi = arm_gicv3_inject_nmi;
>       agcc->post_load = arm_gicv3_post_load;
>       device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
>   }
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 9c7f4ab871..b076d67c52 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -31,6 +31,7 @@
>   #include "gicv3_internal.h"
>   #include "vgic_common.h"
>   #include "migration/blocker.h"
> +#include "sysemu/cpus.h"
>   
>   #ifdef DEBUG_GICV3_KVM
>   #define DPRINTF(fmt, ...) \
> @@ -506,6 +507,96 @@ static void kvm_arm_gicv3_put(GICv3State *s)
>       }
>   }
>   
> +static bool kvm_arm_gicv3_inject_nmi_once(GICv3State *s, int start, int end)
> +{
> +    GICv3CPUState *cs;
> +    int irq_count = (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
> +    int i, cpu, irq;
> +
> +    /* SPIs */
> +    for (i = start; (i < end) && (i < (s->num_irq - GIC_INTERNAL)); i++) {
> +        if (gicv3_gicd_enabled_test(s, i + GIC_INTERNAL) &&
> +            s->gicd_ipriority[i + GIC_INTERNAL] == 0x20) {
> +            kvm_arm_gicv3_set_irq(s, i, true);
> +
> +            s->last_nmi_index = (i + 1);
> +            return true;
> +        }
> +    }
> +
> +    /* PPIs */
> +    if (start < (s->num_irq - GIC_INTERNAL)) {
> +        start = (s->num_irq - GIC_INTERNAL);
> +    }
> +
> +    for (i = start; (i < end) && (i < irq_count); i++) {
> +        cpu = (i - ((s->num_irq - GIC_INTERNAL))) / GIC_INTERNAL;
> +        irq = (i - ((s->num_irq - GIC_INTERNAL))) % GIC_INTERNAL;
> +        cs = &s->cpu[cpu];
> +
> +        if ((cs->gicr_ienabler0 & (1 << irq)) &&
> +            cs->gicr_ipriorityr[irq] == 0x20) {
> +            kvm_arm_gicv3_set_irq(s, i, true);
> +
> +            s->last_nmi_index = (i + 1);
> +            if (s->last_nmi_index > irq_count) {
> +                s->last_nmi_index = 0;
> +            }
> +
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static void kvm_arm_gicv3_snapshot(GICv3State *s)
> +{
> +    GICv3CPUState *c;
> +    uint32_t val;
> +    int i, j;
> +
> +    pause_all_vcpus();
> +
> +    kvm_dist_getbmp(s, GICD_ISENABLER, s->enabled);
> +    kvm_dist_get_priority(s, GICD_IPRIORITYR, s->gicd_ipriority);
> +    for (i = 0; i < s->num_cpu; i++) {
> +        c = &s->cpu[i];
> +
> +        kvm_gicr_access(s, GICR_ISENABLER0, i, &val, false);
> +        c->gicr_ienabler0 = val;
> +
> +        for (j = 0; j < GIC_INTERNAL; j += 4) {
> +            kvm_gicr_access(s, GICR_IPRIORITYR + j, i, &val, false);
> +            c->gicr_ipriorityr[j] = extract32(val, 0, 8);
> +            c->gicr_ipriorityr[j + 1] = extract32(val, 8, 8);
> +            c->gicr_ipriorityr[j + 2] = extract32(val, 16, 8);
> +            c->gicr_ipriorityr[j + 3] = extract32(val, 24, 8);
> +        }
> +    }
> +
> +    resume_all_vcpus();
> +}
> +
> +static void kvm_arm_gicv3_inject_nmi(DeviceState *dev,
> +                                     int cpu_index, Error **errp)
> +{
> +    GICv3State *s = KVM_ARM_GICV3(dev);
> +    int irq_count = (s->num_irq + (GIC_INTERNAL * (s->num_cpu - 1)));
> +    bool injected;
> +
> +    kvm_arm_gicv3_snapshot(s);
> +
> +    injected = kvm_arm_gicv3_inject_nmi_once(s, s->last_nmi_index, irq_count);
> +    if (!injected) {
> +        injected = kvm_arm_gicv3_inject_nmi_once(s, 0, s->last_nmi_index);
> +    }
> +
> +    if (!injected) {
> +        error_setg(errp, "No NMI found");
> +    }
> +}
> +
>   static void kvm_arm_gicv3_get(GICv3State *s)
>   {
>       uint32_t regl, regh, reg;
> @@ -882,6 +973,7 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
>       ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
>       KVMARMGICv3Class *kgc = KVM_ARM_GICV3_CLASS(klass);
>   
> +    agcc->inject_nmi = kvm_arm_gicv3_inject_nmi;
>       agcc->pre_save = kvm_arm_gicv3_get;
>       agcc->post_load = kvm_arm_gicv3_put;
>       device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 31ec9a1ae4..0ae9c45aa2 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -225,6 +225,7 @@ struct GICv3State {
>   
>       int dev_fd; /* kvm device fd if backed by kvm vgic support */
>       Error *migration_blocker;
> +    int last_nmi_index;
>   
>       /* Distributor */
>   
> @@ -291,6 +292,7 @@ typedef struct ARMGICv3CommonClass {
>       SysBusDeviceClass parent_class;
>       /*< public >*/
>   
> +    void (*inject_nmi)(DeviceState *dev, int cpu_index, Error **errp);
>       void (*pre_save)(GICv3State *s);
>       void (*post_load)(GICv3State *s);
>   } ARMGICv3CommonClass;
> 


