Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5826AC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0AF20838
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izZ0tUc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0AF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kId7i-0007UL-0h
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 15:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kId6q-0006xw-VO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:28:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kId6o-0000iI-9b
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600284529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6NN0qK4CzTUzvfb5bOCJC7NYV8hT+Y1s5tS6LNWSgw=;
 b=izZ0tUc4QDReuDZmXLdTD783qX/XpWzoIdVlc/It3ymyY2ZPcMmRii2OWa38/4Pz9Z8/kQ
 8FsQXZwowY3nf6UV8RJB+r6AHziBXid6mSmwtA476Nn+7n+PcppcLSl2DfwE9zZWJjEM5D
 vL0pFfLVh/JFDkMpEWV8+FhixhkXHD0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-soJmFHEmPJi6fsszE_oytg-1; Wed, 16 Sep 2020 15:28:47 -0400
X-MC-Unique: soJmFHEmPJi6fsszE_oytg-1
Received: by mail-yb1-f197.google.com with SMTP id r9so8054968ybd.20
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 12:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S6NN0qK4CzTUzvfb5bOCJC7NYV8hT+Y1s5tS6LNWSgw=;
 b=TccNT6wSSprwvj53Mmj4YeYZDjCKsj8bEcplXYb+jPVt2DdRPtj78cHvLQNwIUxEvW
 kbnWX0vx3Bl/rq3IzfWuYdpK8nA7cp0grcHUoo4L1himz1h16stp2fxaEeWqHgDf+vGX
 KaaQ8qcV3gOb413tf59d927K52eXY7AeCK8iKeWoeK39AafQRV3pFzJdEqiHFgYuD+dz
 Viv5GIvuihnUuHMMvR9hC8pG0IqMirGr84AA3NNOjl3SmKhPUXSJUpJUmbRM2m+yCvom
 fepp4j/x6rXdiUCdVUvJ+p1wbhbQiEHYmWlCeA3RS2v5QXFdBfgxnzLx0Wh/ENnEMLoV
 /GTQ==
X-Gm-Message-State: AOAM530VgvfQnZyajriqNrufYidaCAWDjw2Zj5E1crg10e5Rp6e51Biv
 qaI7mGC2AAviEPrXLY6rExifcI+OniozdbLBTvLkEiXcLRBzwNZVKTgC4cD+HO3ms6srbxQXY9/
 Q83t2/zUpSvxu5+eLKUmEbX/6UUnSoNE=
X-Received: by 2002:a25:198b:: with SMTP id 133mr9212973ybz.102.1600284526351; 
 Wed, 16 Sep 2020 12:28:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfyZZgnttlbMewzbCk6FLfR9SjkTt0Orn5FXNIHWyRoAqHu69bN8aHeUWMuI5970B5eAAPKzV5pJNS7hgt/Vg=
X-Received: by 2002:a25:198b:: with SMTP id 133mr9212946ybz.102.1600284526042; 
 Wed, 16 Sep 2020 12:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-5-jusual@redhat.com>
 <20200821142411.6f5bcc0e@redhat.com>
In-Reply-To: <20200821142411.6f5bcc0e@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 16 Sep 2020 21:28:34 +0200
Message-ID: <CAMDeoFXVfOQmHb23LNgi_RDMAg57R4i63Mr_P=cyDSx-CLUGOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] hw/acpi/ich9: Enable ACPI PCI hot-plug
To: Igor Mammedov <imammedo@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 11:53:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 2:24 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 18 Aug 2020 23:52:27 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
>
> > Add acpi_pcihp to ich9_pm and use ACPI PCI hot-plug by default.
>
> I don't see anything related to migrating hotplug state within series,
>
> see VMSTATE_PCI_HOTPLUG for example.

Ok, will do.

>
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> > Note: New pc_compats are usually added shortly after release.
> >       I will switch to pc_compat_5_1 when it becomes available.
> >
> >  hw/i386/acpi-build.h   |  1 +
> >  include/hw/acpi/ich9.h |  3 +++
> >  hw/acpi/ich9.c         | 45 ++++++++++++++++++++++++++++++++++++++++++
> >  hw/acpi/pcihp.c        |  5 ++++-
> >  hw/i386/acpi-build.c   |  2 +-
> >  hw/i386/pc.c           |  1 +
> >  6 files changed, 55 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> > index 6f94312c39..f0bb080018 100644
> > --- a/hw/i386/acpi-build.h
> > +++ b/hw/i386/acpi-build.h
> > @@ -17,5 +17,6 @@ typedef enum {
> >  } AcpiOSCField;
> >
> >  void acpi_setup(void);
> > +Object *acpi_get_i386_pci_host(void);
> >
> >  #endif
> > diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> > index 28a53181cb..9947085e9c 100644
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
> > +    bool use_acpi_hotplug_bridge;
> > +    AcpiPciHpState acpi_pci_hotplug;
> >      MemHotplugState acpi_memory_hotplug;
> >
> >      uint8_t disable_s3;
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index a2a1742aa6..fde86d12ae 100644
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
> > +    if (pm->use_acpi_hotplug_bridge) {
> > +        acpi_pcihp_init(OBJECT(lpc_pci),
> > +                        &pm->acpi_pci_hotplug,
> > +                        pci_get_bus(lpc_pci),
> > +                        pci_address_space_io(lpc_pci),
> > +                        true, false);
> > +
> > +        qbus_set_hotplug_handler(BUS(pci_get_bus(lpc_pci)),
> > +                                 OBJECT(lpc_pci));
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
> > +    return s->pm.use_acpi_hotplug_bridge;
> > +}
> > +
> > +static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value,
> > +                                               Error **errp)
> > +{
> > +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> > +
> > +    s->pm.use_acpi_hotplug_bridge = value;
> > +}
> >  void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> >  {
> >      static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
> > @@ -382,6 +408,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
> >      pm->disable_s3 = 0;
> >      pm->disable_s4 = 0;
> >      pm->s4_val = 2;
> > +    pm->use_acpi_hotplug_bridge = true;
>
> I'd prefer default to be false, and managment turn it on when creating
> config for Windows.
>
> i.e. if users need it, they should enable it explicitly so overhead it produces
> won't affect other configs.
>
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
> > index 9a35ed6c83..46ebd1bb15 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -30,6 +30,8 @@
> >  #include "hw/pci-host/i440fx.h"
> >  #include "hw/pci/pci.h"
> >  #include "hw/pci/pci_bridge.h"
> > +#include "hw/pci/pci_host.h"
> > +#include "hw/i386/acpi-build.h"
> >  #include "hw/acpi/acpi.h"
> >  #include "exec/address-spaces.h"
> >  #include "hw/pci/pci_bus.h"
> > @@ -90,6 +92,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
> >  static void acpi_set_pci_info(void)
> >  {
> >      static bool bsel_is_set;
> > +    Object *host = acpi_get_i386_pci_host();
> >      PCIBus *bus;
> >      unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
> >
> > @@ -98,7 +101,7 @@ static void acpi_set_pci_info(void)
> >      }
> >      bsel_is_set = true;
> >
> > -    bus = find_i440fx(); /* TODO: Q35 support */
> > +    bus = PCI_HOST_BRIDGE(host)->bus;
> >      if (bus) {
> >          /* Scan all PCI buses. Set property to enable acpi based hotplug. */
> >          pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index c5f4802b8c..8cecdf722f 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -270,7 +270,7 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
> >   * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
> >   * On i386 arch we only have two pci hosts, so we can look only for them.
> >   */
> > -static Object *acpi_get_i386_pci_host(void)
> > +Object *acpi_get_i386_pci_host(void)
> >  {
> >      PCIHostState *host;
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 47c5ca3e34..175e6911a1 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -98,6 +98,7 @@
> >  #include "trace.h"
> >
> >  GlobalProperty pc_compat_5_0[] = {
> > +    { "ICH9-LPC", "acpi-pci-hotplug-with-bridge-support", "off" },
> >  };
> >  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
> >
>


