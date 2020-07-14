Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01ABC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F17E20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfT2qpD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F17E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGiN-0007Dk-Ou
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGhc-0006b8-P6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:54:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGha-0004YU-1r
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594716852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmJ11LQsqTtWsh6HwCE4gT+R5zQrxQwAwaBMTnL8vIw=;
 b=JfT2qpD2olE0d4Ihy+iXENHirVvt/Fo1Kul93ozztp7ksB6Q5KtkuVSU4Y39/1AQkfchoa
 BAbsZbobbH2cJw/547r/GFPplkYrJmju7oMnC9lvEiDWiRhcMdn7TJHuHOkOhDkPQ0RfQX
 u5PjBRbimPMKww4GS+ri3MVSrvXm9bk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-93Zwq6DRMkuXb5Afc9qOQw-1; Tue, 14 Jul 2020 04:54:08 -0400
X-MC-Unique: 93Zwq6DRMkuXb5Afc9qOQw-1
Received: by mail-wr1-f70.google.com with SMTP id s16so20771869wrv.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 01:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gmJ11LQsqTtWsh6HwCE4gT+R5zQrxQwAwaBMTnL8vIw=;
 b=bwfBG/XHvKzbPcPJtXUy5N1Owl00Nc9bYP1LmTslDlmzMKImEsZeUDzmEmo+1YvJYX
 fJF5v41lZEXksH3HmpxecuIB7M1QaJE5yH6fHXIs6qQ1BjZPQ5flKk56eqimnDR8nKtI
 kFtW5WzBPw9L4wWJR+lVOstCn2//CteSePT07M8ZawG8iA0ak5LpRTXqGqDa1tia5KOL
 iobuFYAf4n6cEnyRFRHhdpYz75CWewP7nBUKtH7PDGkUP3dMmcYywGiDJ4uEWBaLCXzK
 R+5IsbvtRdssa8K/VT740Sqh7VwzUpJNJMdOQv+cRPWhxv59Fucf3rIvdrj5j8iPl2Ee
 8eig==
X-Gm-Message-State: AOAM533kw6iTZKRTTZLwIBtE9H9hHQ8BKCpq1tlhFJicE/PhAHJX+hg+
 YDBselI2U39H/dukNSs60Nr4KC5PkeMAuj9Q7icy8h4XEIG8ywAtfXGP93Xni2sBWwjoq8mqnS9
 JQCA4wWyzKZVIUyw=
X-Received: by 2002:a1c:e910:: with SMTP id q16mr3249703wmc.188.1594716847203; 
 Tue, 14 Jul 2020 01:54:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzubyZGDzg7K83wNgtq9/ub7TT8uFvThcFi4sHNX3y1NEAjiRuT4TTwaSohUQmQLGGZzwWNcA==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr3249689wmc.188.1594716846902; 
 Tue, 14 Jul 2020 01:54:06 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id j6sm28594203wro.25.2020.07.14.01.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 01:54:06 -0700 (PDT)
Date: Tue, 14 Jul 2020 04:54:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC PATCH 5/5] hw/acpi/ich9: Enable ACPI PCI hot-plug
Message-ID: <20200714044553-mutt-send-email-mst@kernel.org>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-6-jusual@redhat.com>
 <20200713171718.141ec85a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200713171718.141ec85a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 05:17:18PM +0200, Igor Mammedov wrote:
> On Thu,  9 Jul 2020 00:46:15 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
> 
> > Add acpi_pcihp to ich9_pm and use ACPI PCI hot-plug by default.
> > 
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  include/hw/acpi/ich9.h |  3 +++
> >  hw/acpi/ich9.c         | 45 ++++++++++++++++++++++++++++++++++++++++++
> >  hw/acpi/pcihp.c        |  3 ++-
> >  hw/i386/pc.c           |  4 +++-
> >  4 files changed, 53 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> > index 28a53181cb..d345da6b74 100644
> > --- a/include/hw/acpi/ich9.h
> > +++ b/include/hw/acpi/ich9.h
> > @@ -24,6 +24,7 @@
> >  #include "hw/acpi/acpi.h"
> >  #include "hw/acpi/cpu_hotplug.h"
> >  #include "hw/acpi/cpu.h"
> > +#include "hw/acpi/pcihp.h"
> >  #include "hw/acpi/memory_hotplug.h"
> >  #include "hw/acpi/acpi_dev_interface.h"
> >  #include "hw/acpi/tco.h"
> > @@ -53,6 +54,8 @@ typedef struct ICH9LPCPMRegs {
> >      AcpiCpuHotplug gpe_cpu;
> >      CPUHotplugState cpuhp_state;
> >  
> > +    bool use_acpi_pci_hotplug;
> a bit outdated naming,
> see 0affda043675c7619248a924a89bfd3781759f63, and rename it to match piix4
> 
> > +    AcpiPciHpState acpi_pci_hotplug;
> >      MemHotplugState acpi_memory_hotplug;
> >  
> >      uint8_t disable_s3;
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index 0fdd736da4..e0291373f2 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -265,6 +265,7 @@ static void pm_reset(void *opaque)
> >      }
> >      pm->smi_en_wmask = ~0;
> >  
> > +    acpi_pcihp_reset(&pm->acpi_pci_hotplug);
> >      acpi_update_sci(&pm->acpi_regs, pm->irq);
> >  }
> >  
> > @@ -303,6 +304,17 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
> >      pm->enable_tco = true;
> >      acpi_pm_tco_init(&pm->tco_regs, &pm->io);
> >  
> > +    if (pm->use_acpi_pci_hotplug) {
> > +        acpi_pcihp_init(OBJECT(lpc_pci),
> > +                        &pm->acpi_pci_hotplug,
> > +                        pci_get_bus(lpc_pci),
> > +                        pci_address_space_io(lpc_pci),
> > +                        true);
> > +        qbus_set_hotplug_handler(BUS(pci_get_bus(lpc_pci)),
> > +                                 OBJECT(lpc_pci),
> > +                                 &error_abort);
> > +    }
> > +
> >      pm->irq = sci_irq;
> >      qemu_register_reset(pm_reset, pm);
> >      pm->powerdown_notifier.notify = pm_powerdown_req;
> > @@ -374,6 +386,20 @@ static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
> >      s->pm.enable_tco = value;
> >  }
> >  
> > +static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
> > +{
> > +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> > +
> > +    return s->pm.use_acpi_pci_hotplug;
> > +}
> > +
> > +static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value,
> > +                                               Error **errp)
> > +{
> > +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> > +
> > +    s->pm.use_acpi_pci_hotplug = value;
> > +}
> >  void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> >  {
> >      static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
> > @@ -382,6 +408,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> >      pm->disable_s3 = 0;
> >      pm->disable_s4 = 0;
> >      pm->s4_val = 2;
> > +    pm->use_acpi_pci_hotplug = true;
> 
> I'm not sure about making crutch on by default though.
> 
> Does linux guests work fine with native hotplug or
> does it have the same issues as Windows?
> 
> Also you had an idea how to workaround native hotplug issues
> on QEMU side.
> Can you dump here a quick summary why it didn't work out
> in the end?

To help out with that a bit:

I think native hotplug just does not match what management needs from
QEMU. QEMU wants what ACPI calls a "VCR-style" ejection where
eject happens automatically after software allows it.

Native hotplug is designed with a human in the loop.

Things like multi-second delay after an eject request,
inability to differentiate between power down and eject,
ability to power device back up after power down
are all architectural in hative hotplug.

Interface is also designed such that there are subtle races making it
hard not to loose hotplug events are also harmless on bare-metal since a
human can just press the eject button again, but with causes no end of
issues for us.

I agree it's a good idea to include the motivation here or in the commit
log, though.

> 
> >  
> >      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
> >                                     &pm->pm_io_base, OBJ_PROP_FLAG_READ);
> > @@ -405,6 +432,9 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> >      object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
> >                               ich9_pm_get_enable_tco,
> >                               ich9_pm_set_enable_tco);
> > +    object_property_add_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> > +                             ich9_pm_get_acpi_pci_hotplug,
> > +                             ich9_pm_set_acpi_pci_hotplug);
> >  }
> >  
> >  void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> > @@ -412,6 +442,11 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  {
> >      ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
> >  
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > +        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
> > +        return;
> > +    }
> > +
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> >          !lpc->pm.acpi_memory_hotplug.is_enabled)
> >          error_setg(errp,
> > @@ -437,6 +472,9 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >          } else {
> >              acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
> >          }
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > +        acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> > +                                  dev, errp);
> >      } else {
> >          error_setg(errp, "acpi: device plug request for not supported device"
> >                     " type: %s", object_get_typename(OBJECT(dev)));
> > @@ -457,6 +495,10 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> >                 !lpc->pm.cpu_hotplug_legacy) {
> >          acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
> >                                     dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > +        acpi_pcihp_device_unplug_request_cb(hotplug_dev,
> > +                                            &lpc->pm.acpi_pci_hotplug,
> > +                                            dev, errp);
> >      } else {
> >          error_setg(errp, "acpi: device unplug request for not supported device"
> >                     " type: %s", object_get_typename(OBJECT(dev)));
> > @@ -474,6 +516,9 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
> >                 !lpc->pm.cpu_hotplug_legacy) {
> >          acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> > +        acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> > +                                    dev, errp);
> >      } else {
> >          error_setg(errp, "acpi: device unplug for not supported device"
> >                     " type: %s", object_get_typename(OBJECT(dev)));
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > index 3d4ee3af72..d905d1b8f2 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -110,7 +110,8 @@ static void acpi_set_pci_info(void)
> >      }
> >      bsel_is_set = true;
> >  
> > -    bus = find_i440fx(); /* TODO: Q35 support */
> > +    bus = find_host();
> > +
> >      if (bus) {
> >          /* Scan all PCI buses. Set property to enable acpi based hotplug. */
> >          pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 143ac1c354..21c6eb779e 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -96,7 +96,9 @@
> >  #include "fw_cfg.h"
> >  #include "trace.h"
> >  
> > -GlobalProperty pc_compat_5_0[] = {};
> > +GlobalProperty pc_compat_5_0[] = {
> > +    { "ICH9-LPC", "acpi-pci-hotplug-with-bridge-support", "off" },
> > +};
> >  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
> >  
> >  GlobalProperty pc_compat_4_2[] = {


