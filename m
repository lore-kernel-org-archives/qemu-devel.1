Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECA2C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA3424AF1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="N6DKOAag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA3424AF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47249 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY3ou-0006iQ-F7
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:25:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hY3nZ-00061c-Pt
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hY3nX-0005Ny-A3
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:23:57 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hY3nV-0005Ee-Ca
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:23:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id go2so7973536plb.9
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VBxluQhOIR6IGSNqO/2o9ocDF2235ALgYxz9refZWAY=;
	b=N6DKOAag5/Aojm7S9OtI9uHMBjphOkXLUE2exWkFkqYBjtDtwZuWWQB42JJBTtIUkE
	b3U4Fw/EPDa6xnBOa7Ayv0cTdOiV3K169GupkGx1jkYCnlA64nnNu0anoS/iEgSZxZLN
	fR9V4qv19otpD90L/vlUaazBj+lNDvn6lvTmtYD1EjPJYk8nTbVfXWp8EjcUXTVb4ZcD
	o4VOFsM0Z/wTMLX+nI3zx1ux9ky9ro+P8qHYG1cpuUI4zLYJQPZ2jYNJblG3PMOUqOS9
	p639f+KMe5MHmnyBr/+LVI93te0YUa37gcJz+leZIgL7zx1ziCT8HgUcOv0tipRv5KAj
	kI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=VBxluQhOIR6IGSNqO/2o9ocDF2235ALgYxz9refZWAY=;
	b=ASE2xdwyTEx6S8AUMnbMbRK8bWXrDpWQjZgOn1Ny7+WnEgrfRoffatWrzK9pdkmrcS
	ssARSHUOCccz97CSnCZYGFe5E1tsq4GN4hc5x7eDqOZ7PXUyyg6hqLY5wXhW36ZzWn2g
	71WYsFAJjPowhy6uX4P0DzmOu/v02togqapjtzVw/SVq/9MGV97nF7TtozMtI7yWOWXB
	FpsyepzBuMDGhgyKs4EuepdNqzgGj67lHH3DU9TkMoqiLKZS36cegE4MVeLaqw9Z10+d
	U5sN1A4EuC4hPBj+OJa7XYTchgmQHR/BWxeudS8fIFsB1nxEidtQ39KMKLfCnVlPY+YG
	D2bw==
X-Gm-Message-State: APjAAAWM11t1VGgvlQJoUBrYwEBjcBRDQJsKlDIWx6Ehio2hPDooqK5l
	epZrAOvublIzqLHpS9l7UOaverSJLd0=
X-Google-Smtp-Source: APXvYqz9KfyEtSZMGtWgunW5NtYg+DWeet/GqmDX87vYtxq3v/bLV5TiLHqNRn01mmssk+XKo+fE6Q==
X-Received: by 2002:a17:902:14e:: with SMTP id
	72mr35750355plb.36.1559633027439; 
	Tue, 04 Jun 2019 00:23:47 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	q13sm28713510pjc.1.2019.06.04.00.23.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 00:23:46 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
	<20190529065017.15149-27-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
	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
Message-ID: <0f0fb553-a75d-5e91-b932-a17e40b44e3f@ozlabs.ru>
Date: Tue, 4 Jun 2019 17:23:42 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529065017.15149-27-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PULL 26/44] spapr/xive: add KVM support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29/05/2019 16:49, David Gibson wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> This introduces a set of helpers when KVM is in use, which create the
> KVM XIVE device, initialize the interrupt sources at a KVM level and
> connect the interrupt presenters to the vCPU.
> 
> They also handle the initialization of the TIMA and the source ESB
> memory regions of the controller. These have a different type under
> KVM. They are 'ram device' memory mappings, similarly to VFIO, exposed
> to the guest and the associated VMAs on the host are populated
> dynamically with the appropriate pages using a fault handler.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Message-Id: <20190513084245.25755-3-clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


This one breaks my setup - it boots up to:


ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
__vio_register_driver: driver ibmvscsi registering
ibmvscsi 71000001: SRP_VERSION: 16.a
ibmvscsi 71000001: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9


and hangs. Here is the command line:


/home/aik/pbuild/qemu-aikrhel74alt-ppc64/ppc64-softmmu/qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
-enable-kvm \
-device nec-usb-xhci,id=nec-usb-xhci0 -m 16G \
-netdev "user,id=USER0,hostfwd=tcp::2223-:22" \
-device "virtio-net-pci,id=vnet0,mac=C0:41:49:4b:00:00,netdev=USER0" \
img/u1804-64G-cuda10.1-418.67-swiotlb.qcow2 \
-machine pseries,cap-cfpc=broken,cap-htm=off,ic-mode=xive -snapshot \
-smp 1,threads=1 -bios ./slof.bin \
-L /home/aik/t/qemu-ppc64-bios/ \
-trace events=qemu_trace_events -d guest_errors \
-chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.user2223 \
-mon chardev=SOCKET0,mode=control


The host kernel is v5.2-rc2. The next patch - 0c575703e487 "spapr/xive:
add hcall support when under KVM" - fixes this though but the question
is now if xive emulation in qemu still works (how do I verify it?).


Any clues? Thanks,


> ---
>  hw/intc/Makefile.objs       |   1 +
>  hw/intc/spapr_xive.c        |  48 +++++++-
>  hw/intc/spapr_xive_kvm.c    | 237 ++++++++++++++++++++++++++++++++++++
>  hw/intc/xive.c              |  21 +++-
>  hw/ppc/Kconfig              |   5 +
>  hw/ppc/spapr_irq.c          |   6 +-
>  include/hw/ppc/spapr_xive.h |  10 ++
>  include/hw/ppc/xive.h       |  13 ++
>  target/ppc/kvm.c            |   7 ++
>  target/ppc/kvm_ppc.h        |   6 +
>  10 files changed, 344 insertions(+), 10 deletions(-)
>  create mode 100644 hw/intc/spapr_xive_kvm.c
> 
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index df712c3e6c..03019b9a03 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -39,6 +39,7 @@ obj-$(CONFIG_XICS_SPAPR) += xics_spapr.o
>  obj-$(CONFIG_XICS_KVM) += xics_kvm.o
>  obj-$(CONFIG_XIVE) += xive.o
>  obj-$(CONFIG_XIVE_SPAPR) += spapr_xive.o
> +obj-$(CONFIG_XIVE_KVM) += spapr_xive_kvm.o
>  obj-$(CONFIG_POWERNV) += xics_pnv.o pnv_xive.o
>  obj-$(CONFIG_ALLWINNER_A10_PIC) += allwinner-a10-pic.o
>  obj-$(CONFIG_S390_FLIC) += s390_flic.o
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 62e13ac353..27632683e6 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -174,7 +174,7 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
>      }
>  }
>  
> -static void spapr_xive_map_mmio(SpaprXive *xive)
> +void spapr_xive_map_mmio(SpaprXive *xive)
>  {
>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
> @@ -251,6 +251,9 @@ static void spapr_xive_instance_init(Object *obj)
>      object_initialize_child(obj, "end_source", &xive->end_source,
>                              sizeof(xive->end_source), TYPE_XIVE_END_SOURCE,
>                              &error_abort, NULL);
> +
> +    /* Not connected to the KVM XIVE device */
> +    xive->fd = -1;
>  }
>  
>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
> @@ -259,6 +262,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>      XiveSource *xsrc = &xive->source;
>      XiveENDSource *end_xsrc = &xive->end_source;
>      Error *local_err = NULL;
> +    MachineState *machine = MACHINE(qdev_get_machine());
>  
>      if (!xive->nr_irqs) {
>          error_setg(errp, "Number of interrupt needs to be greater 0");
> @@ -305,6 +309,32 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>      xive->eat = g_new0(XiveEAS, xive->nr_irqs);
>      xive->endt = g_new0(XiveEND, xive->nr_ends);
>  
> +    xive->nodename = g_strdup_printf("interrupt-controller@%" PRIx64,
> +                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));
> +
> +    qemu_register_reset(spapr_xive_reset, dev);
> +
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        kvmppc_xive_connect(xive, &local_err);
> +        if (local_err && machine_kernel_irqchip_required(machine)) {
> +            error_prepend(&local_err,
> +                          "kernel_irqchip requested but unavailable: ");
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +
> +        if (!local_err) {
> +            return;
> +        }
> +
> +        /*
> +         * We failed to initialize the XIVE KVM device, fallback to
> +         * emulated mode
> +         */
> +        error_prepend(&local_err, "kernel_irqchip allowed but unavailable: ");
> +        warn_report_err(local_err);
> +    }
> +
>      /* TIMA initialization */
>      memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xive,
>                            "xive.tima", 4ull << TM_SHIFT);
> @@ -316,11 +346,6 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>  
>      /* Map all regions */
>      spapr_xive_map_mmio(xive);
> -
> -    xive->nodename = g_strdup_printf("interrupt-controller@%" PRIx64,
> -                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));
> -
> -    qemu_register_reset(spapr_xive_reset, dev);
>  }
>  
>  static int spapr_xive_get_eas(XiveRouter *xrtr, uint8_t eas_blk,
> @@ -495,6 +520,17 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi)
>      if (lsi) {
>          xive_source_irq_set_lsi(xsrc, lisn);
>      }
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err = NULL;
> +
> +        kvmppc_xive_source_reset_one(xsrc, lisn, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }
>  
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> new file mode 100644
> index 0000000000..7d9e771e8a
> --- /dev/null
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -0,0 +1,237 @@
> +/*
> + * QEMU PowerPC sPAPR XIVE interrupt controller model
> + *
> + * Copyright (c) 2017-2019, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "target/ppc/cpu.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/kvm.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_xive.h"
> +#include "hw/ppc/xive.h"
> +#include "kvm_ppc.h"
> +
> +#include <sys/ioctl.h>
> +
> +/*
> + * Helpers for CPU hotplug
> + *
> + * TODO: make a common KVMEnabledCPU layer for XICS and XIVE
> + */
> +typedef struct KVMEnabledCPU {
> +    unsigned long vcpu_id;
> +    QLIST_ENTRY(KVMEnabledCPU) node;
> +} KVMEnabledCPU;
> +
> +static QLIST_HEAD(, KVMEnabledCPU)
> +    kvm_enabled_cpus = QLIST_HEAD_INITIALIZER(&kvm_enabled_cpus);
> +
> +static bool kvm_cpu_is_enabled(CPUState *cs)
> +{
> +    KVMEnabledCPU *enabled_cpu;
> +    unsigned long vcpu_id = kvm_arch_vcpu_id(cs);
> +
> +    QLIST_FOREACH(enabled_cpu, &kvm_enabled_cpus, node) {
> +        if (enabled_cpu->vcpu_id == vcpu_id) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static void kvm_cpu_enable(CPUState *cs)
> +{
> +    KVMEnabledCPU *enabled_cpu;
> +    unsigned long vcpu_id = kvm_arch_vcpu_id(cs);
> +
> +    enabled_cpu = g_malloc(sizeof(*enabled_cpu));
> +    enabled_cpu->vcpu_id = vcpu_id;
> +    QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
> +}
> +
> +/*
> + * XIVE Thread Interrupt Management context (KVM)
> + */
> +
> +void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
> +{
> +    SpaprXive *xive = SPAPR_MACHINE(qdev_get_machine())->xive;
> +    unsigned long vcpu_id;
> +    int ret;
> +
> +    /* Check if CPU was hot unplugged and replugged. */
> +    if (kvm_cpu_is_enabled(tctx->cs)) {
> +        return;
> +    }
> +
> +    vcpu_id = kvm_arch_vcpu_id(tctx->cs);
> +
> +    ret = kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive->fd,
> +                              vcpu_id, 0);
> +    if (ret < 0) {
> +        error_setg(errp, "XIVE: unable to connect CPU%ld to KVM device: %s",
> +                   vcpu_id, strerror(errno));
> +        return;
> +    }
> +
> +    kvm_cpu_enable(tctx->cs);
> +}
> +
> +/*
> + * XIVE Interrupt Source (KVM)
> + */
> +
> +/*
> + * At reset, the interrupt sources are simply created and MASKED. We
> + * only need to inform the KVM XIVE device about their type: LSI or
> + * MSI.
> + */
> +void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
> +{
> +    SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
> +    uint64_t state = 0;
> +
> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
> +        state |= KVM_XIVE_LEVEL_SENSITIVE;
> +        if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> +            state |= KVM_XIVE_LEVEL_ASSERTED;
> +        }
> +    }
> +
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, srcno, &state,
> +                      true, errp);
> +}
> +
> +void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
> +{
> +    int i;
> +
> +    for (i = 0; i < xsrc->nr_irqs; i++) {
> +        Error *local_err = NULL;
> +
> +        kvmppc_xive_source_reset_one(xsrc, i, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +}
> +
> +void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
> +{
> +    XiveSource *xsrc = opaque;
> +    struct kvm_irq_level args;
> +    int rc;
> +
> +    args.irq = srcno;
> +    if (!xive_source_irq_is_lsi(xsrc, srcno)) {
> +        if (!val) {
> +            return;
> +        }
> +        args.level = KVM_INTERRUPT_SET;
> +    } else {
> +        if (val) {
> +            xsrc->status[srcno] |= XIVE_STATUS_ASSERTED;
> +            args.level = KVM_INTERRUPT_SET_LEVEL;
> +        } else {
> +            xsrc->status[srcno] &= ~XIVE_STATUS_ASSERTED;
> +            args.level = KVM_INTERRUPT_UNSET;
> +        }
> +    }
> +    rc = kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
> +    if (rc < 0) {
> +        error_report("XIVE: kvm_irq_line() failed : %s", strerror(errno));
> +    }
> +}
> +
> +/*
> + * sPAPR XIVE interrupt controller (KVM)
> + */
> +
> +static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
> +                              Error **errp)
> +{
> +    void *addr;
> +    uint32_t page_shift = 16; /* TODO: fix page_shift */
> +
> +    addr = mmap(NULL, len, PROT_WRITE | PROT_READ, MAP_SHARED, xive->fd,
> +                pgoff << page_shift);
> +    if (addr == MAP_FAILED) {
> +        error_setg_errno(errp, errno, "XIVE: unable to set memory mapping");
> +        return NULL;
> +    }
> +
> +    return addr;
> +}
> +
> +/*
> + * All the XIVE memory regions are now backed by mappings from the KVM
> + * XIVE device.
> + */
> +void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
> +{
> +    XiveSource *xsrc = &xive->source;
> +    XiveENDSource *end_xsrc = &xive->end_source;
> +    Error *local_err = NULL;
> +    size_t esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> +    size_t tima_len = 4ull << TM_SHIFT;
> +
> +    if (!kvmppc_has_cap_xive()) {
> +        error_setg(errp, "IRQ_XIVE capability must be present for KVM");
> +        return;
> +    }
> +
> +    /* First, create the KVM XIVE device */
> +    xive->fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
> +    if (xive->fd < 0) {
> +        error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM device");
> +        return;
> +    }
> +
> +    /*
> +     * 1. Source ESB pages - KVM mapping
> +     */
> +    xsrc->esb_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
> +                                      &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
> +                                      "xive.esb", esb_len, xsrc->esb_mmap);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
> +
> +    /*
> +     * 2. END ESB pages (No KVM support yet)
> +     */
> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
> +
> +    /*
> +     * 3. TIMA pages - KVM mapping
> +     */
> +    xive->tm_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
> +                                     &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    memory_region_init_ram_device_ptr(&xive->tm_mmio, OBJECT(xive),
> +                                      "xive.tima", tima_len, xive->tm_mmap);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> +
> +    kvm_kernel_irqchip = true;
> +    kvm_msi_via_irqfd_allowed = true;
> +    kvm_gsi_direct_mapping = true;
> +
> +    /* Map all regions */
> +    spapr_xive_map_mmio(xive);
> +}
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index dcf2fcd108..78047adb11 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -555,6 +555,15 @@ static void xive_tctx_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    /* Connect the presenter to the VCPU (required for CPU hotplug) */
> +    if (kvm_irqchip_in_kernel()) {
> +        kvmppc_xive_cpu_connect(tctx, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
>      qemu_register_reset(xive_tctx_reset, dev);
>  }
>  
> @@ -957,6 +966,10 @@ static void xive_source_reset(void *dev)
>  
>      /* PQs are initialized to 0b01 (Q=1) which corresponds to "ints off" */
>      memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        kvmppc_xive_source_reset(xsrc, &error_fatal);
> +    }
>  }
>  
>  static void xive_source_realize(DeviceState *dev, Error **errp)
> @@ -990,9 +1003,11 @@ static void xive_source_realize(DeviceState *dev, Error **errp)
>      xsrc->status = g_malloc0(xsrc->nr_irqs);
>      xsrc->lsi_map = bitmap_new(xsrc->nr_irqs);
>  
> -    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> -                          &xive_source_esb_ops, xsrc, "xive.esb",
> -                          (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> +    if (!kvm_irqchip_in_kernel()) {
> +        memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> +                              &xive_source_esb_ops, xsrc, "xive.esb",
> +                              (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> +    }
>  
>      qemu_register_reset(xive_source_reset, dev);
>  }
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index a3465155f0..f927ec9c74 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -122,3 +122,8 @@ config XIVE_SPAPR
>      default y
>      depends on PSERIES
>      select XIVE
> +
> +config XIVE_KVM
> +    bool
> +    default y
> +    depends on XIVE_SPAPR && KVM
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b1f79ea9de..5c4a44855d 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -372,7 +372,11 @@ static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
>  {
>      SpaprMachineState *spapr = opaque;
>  
> -    xive_source_set_irq(&spapr->xive->source, srcno, val);
> +    if (kvm_irqchip_in_kernel()) {
> +        kvmppc_xive_source_set_irq(&spapr->xive->source, srcno, val);
> +    } else {
> +        xive_source_set_irq(&spapr->xive->source, srcno, val);
> +    }
>  }
>  
>  static const char *spapr_irq_get_nodename_xive(SpaprMachineState *spapr)
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index fc3e9652f9..0edcc762de 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -38,6 +38,10 @@ typedef struct SpaprXive {
>      /* TIMA mapping address */
>      hwaddr        tm_base;
>      MemoryRegion  tm_mmio;
> +
> +    /* KVM support */
> +    int           fd;
> +    void          *tm_mmap;
>  } SpaprXive;
>  
>  bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
> @@ -49,5 +53,11 @@ void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
>                     uint32_t phandle);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
> +void spapr_xive_map_mmio(SpaprXive *xive);
> +
> +/*
> + * KVM XIVE device helpers
> + */
> +void kvmppc_xive_connect(SpaprXive *xive, Error **errp);
>  
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index c4f27742ca..dd115da30e 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -140,6 +140,7 @@
>  #ifndef PPC_XIVE_H
>  #define PPC_XIVE_H
>  
> +#include "sysemu/kvm.h"
>  #include "hw/qdev-core.h"
>  #include "hw/sysbus.h"
>  #include "hw/ppc/xive_regs.h"
> @@ -194,6 +195,9 @@ typedef struct XiveSource {
>      uint32_t        esb_shift;
>      MemoryRegion    esb_mmio;
>  
> +    /* KVM support */
> +    void            *esb_mmap;
> +
>      XiveNotifier    *xive;
>  } XiveSource;
>  
> @@ -423,4 +427,13 @@ static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_idx)
>      return (nvt_blk << 19) | nvt_idx;
>  }
>  
> +/*
> + * KVM XIVE device helpers
> + */
> +
> +void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp);
> +void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
> +void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
> +void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
> +
>  #endif /* PPC_XIVE_H */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 1a9caf8f40..3bf0a46c33 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -75,6 +75,7 @@ static int cap_fixup_hcalls;
>  static int cap_htm;             /* Hardware transactional memory support */
>  static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
> +static int cap_xive;
>  static int cap_resize_hpt;
>  static int cap_ppc_pvr_compat;
>  static int cap_ppc_safe_cache;
> @@ -146,6 +147,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_htm = kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
>      cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
> +    cap_xive = kvm_vm_check_extension(s, KVM_CAP_PPC_IRQ_XIVE);
>      cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
> @@ -2478,6 +2480,11 @@ static int parse_cap_ppc_count_cache_flush_assist(struct kvm_ppc_cpu_char c)
>      return 0;
>  }
>  
> +bool kvmppc_has_cap_xive(void)
> +{
> +    return cap_xive;
> +}
> +
>  static void kvmppc_get_cpu_characteristics(KVMState *s)
>  {
>      struct kvm_ppc_cpu_char c;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 22385134b4..45776cad79 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -60,6 +60,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
>  bool kvmppc_has_cap_mmu_radix(void);
>  bool kvmppc_has_cap_mmu_hash_v3(void);
> +bool kvmppc_has_cap_xive(void);
>  int kvmppc_get_cap_safe_cache(void);
>  int kvmppc_get_cap_safe_bounds_check(void);
>  int kvmppc_get_cap_safe_indirect_branch(void);
> @@ -316,6 +317,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
>      return false;
>  }
>  
> +static inline bool kvmppc_has_cap_xive(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_get_cap_safe_cache(void)
>  {
>      return 0;
> 

-- 
Alexey

