Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7DEC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2013720732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITmGB4vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2013720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFaf-0005me-9k
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jFFZz-0005FH-6j
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jFFZx-0002V2-9i
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:12:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jFFZx-0002UZ-6d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584702760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ixS6QA+0MYlIcBKnC/I/SzALqrn4q5vbAOsm73DFrk=;
 b=ITmGB4vG4h8yJ47HwpGw1r7KqLlV9FPBo/wcQGg2X1DA6XwGkWyqbnMn+NfSi6rGsEyGMZ
 x18GXCHSvTPjPv5W67izCOyPa5/il7CtSpFGQrXNGsvBCn1y+ahl7pP3aBq/6S6VFyi1yv
 wjNjYx1EAOK+Yg4Eu50bmg3LXo+0Ms0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-F_LeNzCAMOqdVYjQShWC7g-1; Fri, 20 Mar 2020 07:12:37 -0400
X-MC-Unique: F_LeNzCAMOqdVYjQShWC7g-1
Received: by mail-wm1-f72.google.com with SMTP id f207so1670693wme.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ixS6QA+0MYlIcBKnC/I/SzALqrn4q5vbAOsm73DFrk=;
 b=Ivpx6GIh3Nvnaqm7u55nx7vksdqYHa1MSA2do6NhOfW4o+E1Za3Tixmj5rpJleEECq
 dNzxRZnXPoNcI4MxyniMJI+npv/68zKjdLtGO2v/VV8NTDsd7+r5rS4d5PtkferE1Drz
 2xG0OVFPwOEp4vhqGoGXRmwPZsG8hCZcqI0+KxbJ8XAxoctTnHrr3Kedn1Xb1KVzpFOg
 Z7nXCaymaFinBpb52z4aq60E+Mcj8ppNak0+cdepGhcQmVDzreGf+9AHcQpW6ex70U9k
 NYq9ONJGXZzOhjchIbw5mfxBRwwCm0Xqkldg6W74whz/a4awOguXNq/7qKUviHZOlE6v
 HDAg==
X-Gm-Message-State: ANhLgQ3kzqn+Mqi5+/vbQcLQv3D8m69fP/xbUKrO+s++PpR81n+YDtPA
 O3fGafNYVybkubCiI1KjICAtDfu3c6MNii91SJSAalRQKgRwoAkholJO/GeG9soR4nwhZ/Qv5g+
 /CDPUgdLRPJLWm1Q=
X-Received: by 2002:a1c:3105:: with SMTP id x5mr9877261wmx.51.1584702755321;
 Fri, 20 Mar 2020 04:12:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu73B//YQH0eWY1lTDg4fBT7PatQA0AE65H4RtJyQ/ssNBFVoqIMsVeyHrxf7KLVzsGBFmT2A==
X-Received: by 2002:a1c:3105:: with SMTP id x5mr9877227wmx.51.1584702754943;
 Fri, 20 Mar 2020 04:12:34 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id j11sm7679819wrt.14.2020.03.20.04.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 04:12:34 -0700 (PDT)
Subject: Re: [PATCH] acpi: add acpi=OnOffAuto machine property to x86 and arm
 virt
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200320100136.11717-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4df9657-7f37-ca0d-884a-b62a2109d221@redhat.com>
Date: Fri, 20 Mar 2020 12:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320100136.11717-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/03/20 11:01, Gerd Hoffmann wrote:
> Remove the global acpi_enabled bool and replace it with an
> acpi OnOffAuto machine property.
> 
> qemu throws an error now if you use -no-acpi while the machine
> type you are using doesn't support acpi in the first place.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/acpi/acpi.h   |  1 -
>  include/hw/arm/virt.h    |  2 ++
>  include/hw/i386/x86.h    |  3 +++
>  hw/arm/virt-acpi-build.c |  2 +-
>  hw/arm/virt.c            | 36 ++++++++++++++++++++++++++++++++++--
>  hw/i386/acpi-build.c     |  2 +-
>  hw/i386/pc.c             |  4 ++--
>  hw/i386/pc_piix.c        |  2 +-
>  hw/i386/x86.c            | 32 ++++++++++++++++++++++++++++++++
>  softmmu/vl.c             |  4 ++--
>  10 files changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index 1f2dafbd7db6..4bef57531229 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -181,7 +181,6 @@ void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>  void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>  
>  /* acpi.c */
> -extern int acpi_enabled;
>  extern char unsigned *acpi_tables;
>  extern size_t acpi_tables_len;
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 893796d3b06b..60b2f521eb47 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -131,6 +131,7 @@ typedef struct {
>      bool highmem_ecam;
>      bool its;
>      bool virt;
> +    OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;
>      uint16_t virtio_iommu_bdf;
> @@ -163,6 +164,7 @@ typedef struct {
>      OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
>  
>  void virt_acpi_setup(VirtMachineState *vms);
> +bool virt_is_acpi_enabled(VirtMachineState *vms);
>  
>  /* Return the number of used redistributor regions  */
>  static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 22babcb3bb8d..54af8ab5cfae 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -64,6 +64,7 @@ typedef struct {
>      unsigned smp_dies;
>  
>      OnOffAuto smm;
> +    OnOffAuto acpi;
>  
>      /*
>       * Address space used by IOAPIC device. All IOAPIC interrupts
> @@ -74,6 +75,7 @@ typedef struct {
>  
>  #define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
>  #define X86_MACHINE_SMM              "smm"
> +#define X86_MACHINE_ACPI             "acpi"
>  
>  #define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
>  #define X86_MACHINE(obj) \
> @@ -104,6 +106,7 @@ void x86_load_linux(X86MachineState *x86ms,
>                      bool linuxboot_dma_enabled);
>  
>  bool x86_machine_is_smm_enabled(X86MachineState *x86ms);
> +bool x86_machine_is_acpi_enabled(X86MachineState *x86ms);
>  
>  /* Global System Interrupts */
>  
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index fb4b166f82c7..7ef0733d7147 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -910,7 +910,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>          return;
>      }
>  
> -    if (!acpi_enabled) {
> +    if (!virt_is_acpi_enabled(vms)) {
>          trace_virt_acpi_setup();
>          return;
>      }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 94f93dda54f2..7dc96abf72cf 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -67,6 +67,7 @@
>  #include "kvm_arm.h"
>  #include "hw/firmware/smbios.h"
>  #include "qapi/visitor.h"
> +#include "qapi/qapi-visit-common.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
>  #include "hw/acpi/acpi.h"
> @@ -1844,7 +1845,7 @@ static void machvirt_init(MachineState *machine)
>  
>      create_pcie(vms);
>  
> -    if (has_ged && aarch64 && firmware_loaded && acpi_enabled) {
> +    if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
>      } else {
>          create_gpio(vms);
> @@ -1934,6 +1935,31 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>      vms->its = value;
>  }
>  
> +bool virt_is_acpi_enabled(VirtMachineState *vms)
> +{
> +    if (vms->acpi == ON_OFF_AUTO_OFF) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +    OnOffAuto acpi = vms->acpi;
> +
> +    visit_type_OnOffAuto(v, name, &acpi, errp);
> +}
> +
> +static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    visit_type_OnOffAuto(v, name, &vms->acpi, errp);
> +}
> +
>  static char *virt_get_gic_version(Object *obj, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
> @@ -2113,7 +2139,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          VirtMachineState *vms = VIRT_MACHINE(machine);
>  
> -        if (!vms->bootinfo.firmware_loaded || !acpi_enabled) {
> +        if (!vms->bootinfo.firmware_loaded || !virt_is_acpi_enabled(vms)) {
>              return HOTPLUG_HANDLER(machine);
>          }
>      }
> @@ -2184,6 +2210,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->numa_mem_supported = true;
>      mc->auto_enable_numa_with_memhp = true;
>      mc->default_ram_id = "mach-virt.ram";
> +
> +    object_class_property_add(oc, "acpi", "OnOffAuto",
> +        virt_get_acpi, virt_set_acpi,
> +        NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, "acpi",
> +        "Enable ACPI", &error_abort);
>  }
>  
>  static void virt_instance_init(Object *obj)
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9a19c14e661b..2a7e55bae765 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -3024,7 +3024,7 @@ void acpi_setup(void)
>          return;
>      }
>  
> -    if (!acpi_enabled) {
> +    if (!x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>          ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
>          return;
>      }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 98ee763f68f8..0bf0aaca5201 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1297,7 +1297,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       * but pcms->acpi_dev is still created. Check !acpi_enabled in
>       * addition to cover this case.
>       */
> -    if (!pcms->acpi_dev || !acpi_enabled) {
> +    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>          error_setg(errp,
>                     "memory hotplug is not enabled: missing acpi device or acpi disabled");
>          return;
> @@ -1351,7 +1351,7 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
>       * but pcms->acpi_dev is still created. Check !acpi_enabled in
>       * addition to cover this case.
>       */
> -    if (!pcms->acpi_dev || !acpi_enabled) {
> +    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>          error_setg(&local_err,
>                     "memory hotplug is not enabled: missing acpi device or acpi disabled");
>          goto out;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e6756216f9f4..9cceae3e2c35 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -275,7 +275,7 @@ static void pc_init1(MachineState *machine,
>          pci_create_simple(pci_bus, piix3_devfn + 2, "piix3-usb-uhci");
>      }
>  
> -    if (pcmc->pci_enabled && acpi_enabled) {
> +    if (pcmc->pci_enabled && x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>          DeviceState *piix4_pm;
>  
>          smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 87b73fe33cd2..6ca3cf936f38 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -904,11 +904,37 @@ static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
>      visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
>  }
>  
> +bool x86_machine_is_acpi_enabled(X86MachineState *x86ms)
> +{
> +    if (x86ms->acpi == ON_OFF_AUTO_OFF) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static void x86_machine_get_acpi(Object *obj, Visitor *v, const char *name,
> +                                 void *opaque, Error **errp)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(obj);
> +    OnOffAuto acpi = x86ms->acpi;
> +
> +    visit_type_OnOffAuto(v, name, &acpi, errp);
> +}
> +
> +static void x86_machine_set_acpi(Object *obj, Visitor *v, const char *name,
> +                                 void *opaque, Error **errp)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(obj);
> +
> +    visit_type_OnOffAuto(v, name, &x86ms->acpi, errp);
> +}
> +
>  static void x86_machine_initfn(Object *obj)
>  {
>      X86MachineState *x86ms = X86_MACHINE(obj);
>  
>      x86ms->smm = ON_OFF_AUTO_AUTO;
> +    x86ms->acpi = ON_OFF_AUTO_AUTO;
>      x86ms->max_ram_below_4g = 0; /* use default */
>      x86ms->smp_dies = 1;
>  }
> @@ -937,6 +963,12 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
>          NULL, NULL, &error_abort);
>      object_class_property_set_description(oc, X86_MACHINE_SMM,
>          "Enable SMM", &error_abort);
> +
> +    object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto",
> +        x86_machine_get_acpi, x86_machine_set_acpi,
> +        NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, X86_MACHINE_ACPI,
> +        "Enable ACPI", &error_abort);
>  }
>  
>  static const TypeInfo x86_machine_info = {
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 1d33a2834037..9f06bd4bf0a7 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -144,7 +144,6 @@ static Chardev **serial_hds;
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
> -int acpi_enabled = 1;
>  int no_hpet = 0;
>  int fd_bootchk = 1;
>  static int no_reboot;
> @@ -3513,7 +3512,8 @@ void qemu_init(int argc, char **argv, char **envp)
>                  vnc_parse(optarg, &error_fatal);
>                  break;
>              case QEMU_OPTION_no_acpi:
> -                acpi_enabled = 0;
> +                olist = qemu_find_opts("machine");
> +                qemu_opts_parse_noisily(olist, "acpi=off", false);
>                  break;
>              case QEMU_OPTION_no_hpet:
>                  no_hpet = 1;
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


