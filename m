Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB92DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F472311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="prHQmD7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F472311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPXi-0002AW-4g
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLPQ4-0001Ym-17
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:28:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLPQ1-000569-G5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:28:11 -0400
Received: by mail-pl1-x643.google.com with SMTP id d19so1540085pld.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=TxPxcq8kkHtmgdvWD2HaP6rXWOl8vP5TJvxYrD7akEA=;
 b=prHQmD7YMUu5fx+bPLudVdBXwLaKy8qOP2dB5a3wgyd3MinqOdpePJ2GsFj64fA85C
 /mrqnpYnBu4+le3uxGJT9tijErpVpksLLaSZAAs13K9VBc3rlPlEghS6RWla0mSHBNnZ
 jBkqwVt4Nl9pkR90M9suXukMF2Sw3zqM9XN9Uyf67OGdVhlEkd6EVLlLryh98jE6oRK8
 joJxU10SCo77VuymQX7UQeLxFu/vragKobaItBHk3iFQobDql+mvjVqWK5SInWlR7VjX
 ztvBnrI5+FEdF5+BuyTC6tuo+39n/VdfNUzqLf+DmH44ZEI5SC5SUcnzKupbuyJEm0xs
 IPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=TxPxcq8kkHtmgdvWD2HaP6rXWOl8vP5TJvxYrD7akEA=;
 b=qENTbiMyE7GgvA03n56epiQxvTo5A5NiM1tirmVKbH1fD6vjMXcjs7tZX8Pi6dYkp6
 19t2G6xryC8rrzPpJ6sfUuFTon22mjvoHTXezVyXEMk03NBv7ag8agPadpLOWnj0fK6z
 rsvSoHPVMELok58RSw95WzIYuMug0MdHqUDIVkbyTMDLY0r3r7ngbf36KJz+eIaSS4J6
 CTIuOz+rQSCLHINcU2Jf9Ig3pXvpAiBIBShd15BogUSoUyAvHUgI8rQgMvksIogL1tFo
 GwIH6e6cQ0sor/QogOxBZ0wSLvnd+HBNAyw/RcAoZVtOdf8WCf+3W+YToJ+t+iGwMKre
 xbIA==
X-Gm-Message-State: AOAM5337az01KbDIPcLuspJXS6APhNrsF9dD8H95FjrYL5OZ4f6KLWuT
 BLhX3fBbXmBU3YDaofpQx4j3sA==
X-Google-Smtp-Source: ABdhPJy+01+B4Km70EJO1YfE2c5UsbJ04+DyvoSgu3PsnwdosWK8Ej26vye7y5OsSPPY+KuoxOX/Hw==
X-Received: by 2002:a17:90a:fb52:: with SMTP id
 iq18mr3619622pjb.162.1600946887670; 
 Thu, 24 Sep 2020 04:28:07 -0700 (PDT)
Received: from ani-ubuntu ([115.96.139.162])
 by smtp.googlemail.com with ESMTPSA id z28sm2846232pfq.81.2020.09.24.04.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:28:06 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <ani@ani-ubuntu>
Date: Thu, 24 Sep 2020 16:58:00 +0530 (IST)
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v3 4/7] hw/acpi/ich9: Enable ACPI PCI hot-plug
In-Reply-To: <20200924070013.165026-5-jusual@redhat.com>
Message-ID: <alpine.DEB.2.21.2009241644060.17687@ani-ubuntu>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-5-jusual@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 24 Sep 2020, Julia Suvorova wrote:

> Add acpi_pcihp to ich9_pm as part of
> 'acpi-pci-hotplug-with-bridge-support' option. Set default to false.
>
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
> hw/i386/acpi-build.h   |  1 +
> include/hw/acpi/ich9.h |  3 ++
> hw/acpi/ich9.c         | 67 ++++++++++++++++++++++++++++++++++++++++++
> hw/acpi/pcihp.c        |  5 +++-
> hw/i386/acpi-build.c   |  2 +-
> 5 files changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 4c5bfb3d0b..39f143830a 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -10,6 +10,7 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
> #define ACPI_PCIHP_BNMR_BASE 0x10
>
> void acpi_setup(void);
> +Object *acpi_get_i386_pci_host(void);
>
> Object *object_resolve_type_unambiguous(const char *typename);
>
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 4d19571ed7..833e62fefe 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -24,6 +24,7 @@
> #include "hw/acpi/acpi.h"
> #include "hw/acpi/cpu_hotplug.h"
> #include "hw/acpi/cpu.h"
> +#include "hw/acpi/pcihp.h"
> #include "hw/acpi/memory_hotplug.h"
> #include "hw/acpi/acpi_dev_interface.h"
> #include "hw/acpi/tco.h"
> @@ -55,6 +56,8 @@ typedef struct ICH9LPCPMRegs {
>     AcpiCpuHotplug gpe_cpu;
>     CPUHotplugState cpuhp_state;
>
> +    bool use_acpi_hotplug_bridge;
> +    AcpiPciHpState acpi_pci_hotplug;
>     MemHotplugState acpi_memory_hotplug;
>
>     uint8_t disable_s3;
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 6a19070cec..987f23e388 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -218,6 +218,26 @@ static const VMStateDescription vmstate_cpuhp_state = {
>     }
> };
>
> +static bool vmstate_test_use_pcihp(void *opaque)
> +{
> +    ICH9LPCPMRegs *s = opaque;
> +
> +    return s->use_acpi_hotplug_bridge;
> +}
> +
> +static const VMStateDescription vmstate_pcihp_state = {
> +    .name = "ich9_pm/pcihp",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_test_use_pcihp,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_PCI_HOTPLUG(acpi_pci_hotplug,
> +                            ICH9LPCPMRegs,
> +                            NULL),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> const VMStateDescription vmstate_ich9_pm = {
>     .name = "ich9_pm",
>     .version_id = 1,
> @@ -239,6 +259,7 @@ const VMStateDescription vmstate_ich9_pm = {
>         &vmstate_memhp_state,
>         &vmstate_tco_io_state,
>         &vmstate_cpuhp_state,
> +        &vmstate_pcihp_state,
>         NULL
>     }
> };
> @@ -260,6 +281,7 @@ static void pm_reset(void *opaque)
>     }
>     pm->smi_en_wmask = ~0;
>
> +    acpi_pcihp_reset(&pm->acpi_pci_hotplug, true);

Maybe add a comment here that acpi based hotplug is disabled both for 
PCIE.0 and for the bridges.


>     acpi_update_sci(&pm->acpi_regs, pm->irq);
> }
>
> @@ -298,6 +320,18 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>     pm->enable_tco = true;
>     acpi_pm_tco_init(&pm->tco_regs, &pm->io);
>
> +    if (pm->use_acpi_hotplug_bridge) {
> +        acpi_pcihp_init(OBJECT(lpc_pci),
> +                        &pm->acpi_pci_hotplug,
> +                        pci_get_bus(lpc_pci),
> +                        pci_address_space_io(lpc_pci),
> +                        true,
> +                        ACPI_PCIHP_ADDR_ICH9);
> +
> +        qbus_set_hotplug_handler(BUS(pci_get_bus(lpc_pci)),
> +                                 OBJECT(lpc_pci));
> +    }
> +
>     pm->irq = sci_irq;
>     qemu_register_reset(pm_reset, pm);
>     pm->powerdown_notifier.notify = pm_powerdown_req;
> @@ -369,6 +403,20 @@ static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
>     s->pm.enable_tco = value;
> }
>
> +static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
> +{
> +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> +
> +    return s->pm.use_acpi_hotplug_bridge;
> +}
> +
> +static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value,
> +                                               Error **errp)
> +{
> +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> +
> +    s->pm.use_acpi_hotplug_bridge = value;
> +}
> void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> {
>     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
> @@ -377,6 +425,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>     pm->disable_s3 = 0;
>     pm->disable_s4 = 0;
>     pm->s4_val = 2;
> +    pm->use_acpi_hotplug_bridge = false;

Ditto regarding the comment as above.

>
>     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
>                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
> @@ -400,6 +449,9 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>     object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
>                              ich9_pm_get_enable_tco,
>                              ich9_pm_set_enable_tco);
> +    object_property_add_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> +                             ich9_pm_get_acpi_pci_hotplug,
> +                             ich9_pm_set_acpi_pci_hotplug);
> }
>
> void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> @@ -407,6 +459,11 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> {
>     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
>
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
> +        return;
> +    }
> +
>     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>         !lpc->pm.acpi_memory_hotplug.is_enabled)
>         error_setg(errp,
> @@ -432,6 +489,9 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>         } else {
>             acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
>         }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> +                                  dev, errp);
>     } else {
>         error_setg(errp, "acpi: device plug request for not supported device"
>                    " type: %s", object_get_typename(OBJECT(dev)));
> @@ -452,6 +512,10 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                !lpc->pm.cpu_hotplug_legacy) {
>         acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
>                                    dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_request_cb(hotplug_dev,
> +                                            &lpc->pm.acpi_pci_hotplug,
> +                                            dev, errp);
>     } else {
>         error_setg(errp, "acpi: device unplug request for not supported device"
>                    " type: %s", object_get_typename(OBJECT(dev)));
> @@ -469,6 +533,9 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                !lpc->pm.cpu_hotplug_legacy) {
>         acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> +                                    dev, errp);
>     } else {
>         error_setg(errp, "acpi: device unplug for not supported device"
>                    " type: %s", object_get_typename(OBJECT(dev)));
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index bb457bc279..8ab65502ce 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -30,6 +30,8 @@
> #include "hw/pci-host/i440fx.h"
> #include "hw/pci/pci.h"
> #include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/i386/acpi-build.h"
> #include "hw/acpi/acpi.h"
> #include "exec/address-spaces.h"
> #include "hw/pci/pci_bus.h"
> @@ -88,6 +90,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
> static void acpi_set_pci_info(void)
> {
>     static bool bsel_is_set;
> +    Object *host = acpi_get_i386_pci_host();
>     PCIBus *bus;
>     unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
>
> @@ -96,7 +99,7 @@ static void acpi_set_pci_info(void)
>     }
>     bsel_is_set = true;
>
> -    bus = find_i440fx(); /* TODO: Q35 support */
> +    bus = PCI_HOST_BRIDGE(host)->bus;

Isn't this part of a differnet patch?

>     if (bus) {
>         /* Scan all PCI buses. Set property to enable acpi based hotplug. */
>         pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7811a8912..8787b6fb33 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -270,7 +270,7 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
>  * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
>  * On i386 arch we only have two pci hosts, so we can look only for them.
>  */
> -static Object *acpi_get_i386_pci_host(void)
> +Object *acpi_get_i386_pci_host(void)
> {
>     PCIHostState *host;
>

This is also part of the above change, so part of a diffent patch.

> -- 
> 2.25.4
>
>

