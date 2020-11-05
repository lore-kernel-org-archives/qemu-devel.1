Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD8AC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D07120709
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctjDdocJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D07120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajRx-00056Q-MS
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajPt-0003jt-U7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajPf-0004kZ-2c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604598665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCHM9lsROgWZzvmvDgRT2KhgomWd0Ggq5X7K8imG90k=;
 b=ctjDdocJIhvtpmBQB6sUG9XlRsGmhRt5EJQ2XQwNuGpdtGOAx0dB2qmqKIdtagfPosnyaB
 JczUAUpXm4D1y+nZq2qJEdx6qXszbSP+X4Q/yk7M40WMjXvyq/QNThNZyWzpTqInrc5qJG
 IWx8lYl6M8ico4pmSGzrzouhQMm8A94=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-CoKOXeYMMBaZxK4G9Xpezg-1; Thu, 05 Nov 2020 12:51:03 -0500
X-MC-Unique: CoKOXeYMMBaZxK4G9Xpezg-1
Received: by mail-wr1-f69.google.com with SMTP id j15so1010230wrd.16
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KCHM9lsROgWZzvmvDgRT2KhgomWd0Ggq5X7K8imG90k=;
 b=H0fDblJ7zQslvrfTeIO+o0UjUcO+aITNrwRLGoJq9RnHn8zsLkJLD7S4on2qNK4z14
 Na3oC6xrhu/u54nhalyXTeG2GmwSkohiXJJhRfQnEZwmCYAXLPm3TRbtx7tHFRG6vPRf
 ehYOVyoC8yjWqYKVHWIbqLPmrM2iKC5wRL+1EFnttvLep++1nZ4OB2vFtQvOXmCkIZcj
 Me95nGdWb8Nb0xC9UAyhNp6skG5wwYDI32QZMFZ7Fc1cB5nX+UjKf7TTRRx86t7rcZRV
 iE8SZO8ekuEYAE9v8gi+D5OLRX9M1+9tpY8sNX6sKywBazEj27JKdx8QPEcYio1ULCv1
 RFyw==
X-Gm-Message-State: AOAM530hRWXcHb0MTXBy1ADBa87zhfEza15hJAQPjfLmp1wt/MGlOfKA
 NRDSXhm9zjwQwUuWQdi0KUNeTtBv4/FV4fJ3023lursrbB7HxHW5f/ZMLG1qeQti7U4Ct1Dac7U
 fCFjFtg3AbK0TenI=
X-Received: by 2002:a5d:67ca:: with SMTP id n10mr4220585wrw.209.1604598662185; 
 Thu, 05 Nov 2020 09:51:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3pGL/zjb/wpjryR78Iu7wqTEEMOo23qqFzsuUGEWhIXKKI1MzjyMVgwR6PLfdli77ZGMlTg==
X-Received: by 2002:a5d:67ca:: with SMTP id n10mr4220556wrw.209.1604598661867; 
 Thu, 05 Nov 2020 09:51:01 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f20sm3142198wmc.26.2020.11.05.09.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 09:51:01 -0800 (PST)
Subject: Re: [PATCH v2] hw/arm/virt enable support for virtio-mem
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
References: <20201105174311.566751-1-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a995b504-2ce5-1930-86df-077674cc2754@redhat.com>
Date: Thu, 5 Nov 2020 18:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105174311.566751-1-Jonathan.Cameron@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, linuxarm@huawei.com,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Igor.

On 11/5/20 6:43 PM, Jonathan Cameron wrote:
> Basically a cut and paste job from the x86 support with the exception of
> needing a larger block size as the Memory Block Size (MIN_SECTION_SIZE)
> on ARM64 in Linux is 1G.
> 
> Tested:
> * In full emulation and with KVM on an arm64 server.
> * cold and hotplug for the virtio-mem-pci device.
> * Wide range of memory sizes, added at creation and later.
> * Fairly basic memory usage of memory added.  Seems to function as normal.
> * NUMA setup with virtio-mem-pci devices on each node.
> * Simple migration test.
> 
> Related kernel patch just enables the Kconfig item for ARM64 as an
> alternative to x86 in drivers/virtio/Kconfig
> 
> The original patches from David Hildenbrand stated that he thought it should
> work for ARM64 but it wasn't enabled in the kernel [1]
> It appears he was correct and everything 'just works'.
> 
> The build system related stuff is intended to ensure virtio-mem support is
> not built for arm32 (build will fail due no defined block size).
> If there is a more elegant way to do this, please point me in the right
> direction.
> 
> [1] https://lore.kernel.org/linux-mm/20191212171137.13872-1-david@redhat.com/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  default-configs/devices/aarch64-softmmu.mak |  1 +
>  hw/arm/Kconfig                              |  1 +
>  hw/arm/virt.c                               | 64 ++++++++++++++++++++-
>  hw/virtio/Kconfig                           |  4 ++
>  hw/virtio/virtio-mem.c                      |  2 +
>  5 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/devices/aarch64-softmmu.mak b/default-configs/devices/aarch64-softmmu.mak
> index 958b1e08e4..31d6128a29 100644
> --- a/default-configs/devices/aarch64-softmmu.mak
> +++ b/default-configs/devices/aarch64-softmmu.mak
> @@ -6,3 +6,4 @@ include arm-softmmu.mak
>  CONFIG_XLNX_ZYNQMP_ARM=y
>  CONFIG_XLNX_VERSAL=y
>  CONFIG_SBSA_REF=y
> +CONFIG_ARCH_VIRTIO_MEM_SUPPORTED=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index fdf4464b94..eeae77eee9 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -20,6 +20,7 @@ config ARM_VIRT
>      select PLATFORM_BUS
>      select SMBIOS
>      select VIRTIO_MMIO
> +    select VIRTIO_MEM_SUPPORTED if ARCH_VIRTIO_MEM_SUPPORTED
>      select ACPI_PCI
>      select MEM_DEVICE
>      select DIMM
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8abb385d4e..6c96d71106 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -73,9 +73,11 @@
>  #include "hw/acpi/acpi.h"
>  #include "target/arm/internals.h"
>  #include "hw/mem/pc-dimm.h"
> +#include "hw/mem/memory-device.h"
>  #include "hw/mem/nvdimm.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/virtio/virtio-mem-pci.h"
>  #include "hw/char/pl011.h"
>  #include "qemu/guest-random.h"
>  
> @@ -2286,6 +2288,34 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                           dev, &error_abort);
>  }
>  
> +static void virt_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +    Error *local_err = NULL;
> +
> +    if (!hotplug_dev2 && dev->hotplugged) {
> +        /*
> +         * Without a bus hotplug handler, we cannot control the plug/unplug
> +         * order. We should never reach this point when hotplugging,
> +         * however, better add a safety net.
> +         */
> +        error_setg(errp, "hotplug of virtio-mem based memory devices not"
> +                   " supported on this bus.");
> +        return;
> +    }
> +    /*
> +     * First, see if we can plug this memory device at all. If that
> +     * succeeds, branch of to the actual hotplug handler.
> +     */
> +    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
> +                           &local_err);
> +    if (!local_err && hotplug_dev2) {
> +        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
> +    }
> +    error_propagate(errp, local_err);
> +}
> +
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **errp)
>  {
> @@ -2293,6 +2323,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        virt_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          hwaddr db_start = 0, db_end = 0;
>          char *resv_prop_str;
> @@ -2322,6 +2354,27 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>      }
>  }
>  
> +static void virt_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
> +                                  DeviceState *dev, Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +    Error *local_err = NULL;
> +
> +    /*
> +     * Plug the memory device first and then branch off to the actual
> +     * hotplug handler. If that one fails, we can easily undo the memory
> +     * device bits.
> +     */
> +    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +    if (hotplug_dev2) {
> +        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
> +        if (local_err) {
> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +        }
> +    }
> +    error_propagate(errp, local_err);
> +}
> +
>  static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
> @@ -2336,6 +2389,9 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_plug(hotplug_dev, dev, errp);
>      }
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
> +    }
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          PCIDevice *pdev = PCI_DEVICE(dev);
>  
> @@ -2363,6 +2419,11 @@ static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
>          goto out;
>      }
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        error_setg(&local_err,
> +                   "virtio-mem based memory devices cannot be unplugged.");
> +        goto out;
> +    }
>      hotplug_handler_unplug_request(HOTPLUG_HANDLER(vms->acpi_dev), dev,
>                                     &local_err);
>  out:
> @@ -2413,7 +2474,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>                                                          DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
> -       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 0eda25c4e1..00dbf2939e 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -48,6 +48,10 @@ config VIRTIO_PMEM
>      depends on VIRTIO_PMEM_SUPPORTED
>      select MEM_DEVICE
>  
> +config ARCH_VIRTIO_MEM_SUPPORTED
> +    bool
> +    default n
> +
>  config VIRTIO_MEM_SUPPORTED
>      bool
>  
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 7c8ca9f28b..16f9de6ab6 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -53,6 +53,8 @@
>   */
>  #if defined(TARGET_X86_64) || defined(TARGET_I386)
>  #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
> +#elif defined(TARGET_AARCH64)
> +#define VIRTIO_MEM_USABLE_EXTENT (2 * (1024 * MiB))
>  #else
>  #error VIRTIO_MEM_USABLE_EXTENT not defined
>  #endif
> 


