Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BBA221E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="2HNi8rk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BBA221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mnI-0003Eq-GJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8mh5-000548-9E
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:41:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8mh2-0002II-Nt
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:41:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id a15so2437087wrh.10
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NMI+aM0XRIys8uIHg6ircyxE0zxa2wkxhkeLXafi3Es=;
 b=2HNi8rk0iVrWmkgWVIz3j97xg4jao5vDaj2VA3LJ0r4CuHi3rI3i4rOuA/n726j+9l
 z5PYLAtpbJojPPDVRkzxI1K3Yw6W5/j6J5Qep8Uc3XLNVHi9fEeR+XVHDu2cYbN3SEkt
 b/nhh8YvEkuFFP2AGVIgiE2tiw3QUTDQxapKvH3lbdl5k4Q0OJ8BhvrQ1AKvGy0zpNhV
 2YHqSL6tnExo2NJvjrfG1uXaJFTj2AzxrhK/P9e0KgBklKrZiyZasU3l/+NmBLRfBwOA
 XDPGNXWNNDgR6WV/DloLkjGknbQ4ZNCsICYknL1Fe2EQM3vkyRwlsQcutwYmnboIsOKR
 fVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NMI+aM0XRIys8uIHg6ircyxE0zxa2wkxhkeLXafi3Es=;
 b=OHuDpVubcTvL1wIZekKRNxTDROHxKeiiFBTpYnBIqbV6djJqSKA9ztG3D3EnzNIVoB
 g5vRh1iFEZg9eHyOIZwyp0GSSEb1+jgt+ahZf30DnWMtr0hqkGlnQ2Bs+Z6w45v+w+MX
 KkgBTJvUWTBDyl5JujW0enbfBPu1BUNzSLcyxnYMeDnb8j/xJxWcpoc9CPeiXmiu+1Zl
 xaoFz+IwvQS/qTrjoBI7gJffmh/OZFqFeVnLEjC08cnQwhaYQeiGHVNofPFN03ZusQM+
 BIx2lFLPdiqY2wKKuuJHG9/e4OsUJtv/hrTf/906kswPJBW3/Uotcrb2acOk3aLjR8wg
 BCig==
X-Gm-Message-State: AOAM53133WkqywHYqXLcwtmLeUw9V4QA65NpmM6XRD4j0TZ74J4wPbzb
 hbSti9L69Tm/pygPA0a5zkelX8fl6KoMVBjX8+M22w==
X-Google-Smtp-Source: ABdhPJyMCAfxlPdNq53tyFhRQ5DZpizgg0Y6GqmZb+A1eTR4IpEGSTR/pol4EB8Oxme25EeXVKVM9jCnhJIRuDwCt8E=
X-Received: by 2002:adf:97dc:: with SMTP id t28mr3520863wrb.291.1597938090095; 
 Thu, 20 Aug 2020 08:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200820092157.17792-1-ani@anisinha.ca>
 <20200820160706.22dd1f9e@redhat.com>
In-Reply-To: <20200820160706.22dd1f9e@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 20 Aug 2020 21:11:18 +0530
Message-ID: <CAARzgwyuL_joY_4wq8=WY7U=E67F2roPJ36kaQLJFRVqLgpGXg@mail.gmail.com>
Subject: Re: [PATCH V6] Introduce a new flag for i440fx to disable PCI hotplug
 on the root bus
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 7:37 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 20 Aug 2020 14:51:56 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
> > we can turn on or off PCI device hotplug on the root bus. This flag can be
> > used to prevent all PCI devices from getting hotplugged or unplugged from the
> > root PCI bus.
> > This feature is targetted mostly towards Windows VMs. It is useful in cases
> > where some hypervisor admins want to deploy guest VMs in a way so that the
> > users of the guest OSes are not able to hot-eject certain PCI devices from
> > the Windows system tray. Laine has explained the use case here in detail:
> > https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> >
> > Julia has resolved this issue for PCIE buses with the following commit:
> > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> >
> > This commit attempts to introduce similar behavior for PCI root buses used in
> > i440fx machine types (although in this case, we do not have a per-slot
> > capability to turn hotplug on or off).
> >
> > Usage:
> >    -global PIIX4_PM.acpi-root-pci-hotplug=off
> >
> > By default, this option is enabled which means that hotplug is turned on for
> > the PCI root bus.
> >
> > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
> > bridges remain as is and can be used along with this new flag to control PCI
> > hotplug on PCI bridges.
> >
> > This change has been tested using a Windows 2012R2 server guest image and also
> > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
> > master qemu from upstream (v5.1.0 tag).
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  hw/acpi/piix4.c      |  8 ++++++--
> >  hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> >
> > Change Log:
> > V5..V6: specified upstream master tag information off which this patch is
> > based off of.
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 26bac4f16c..4f436e5bf3 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >
> >      AcpiPciHpState acpi_pci_hotplug;
> >      bool use_acpi_hotplug_bridge;
> > +    bool use_acpi_root_pci_hotplug;
> >
> >      uint8_t disable_s3;
> >      uint8_t disable_s4;
>
> > @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> >                            "acpi-gpe0", GPE_LEN);
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug)
> > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > +                        s->use_acpi_hotplug_bridge);
> If intent was to disable hardware part of ACPI hotplug,
> then this hunk is not enough. I'd say it introduces bug since you are leaving
> device_add/del route open and "_E01" AML code around trying to access no longer
> described/present io ports.
>
> Without this hunk patch is fine, as a means to hide hotplug from Windows.
>
> If you'd like to disable hw part, you will need to consider case where hotplug is
> disabled completly and block all related AML and block device_add|del.
> So it would be a bit more than above hunk.

Ok maybe I will just remove it.

>
>
> >      s->cpu_hotplug_legacy = true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> >                       use_acpi_hotplug_bridge, true),
> > +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > +                     use_acpi_root_pci_hotplug, true),
> >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >                       acpi_memory_hotplug.is_enabled, true),
> >      DEFINE_PROP_END_OF_LIST(),
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbbb2a..19a1702ad1 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> >      bool s3_disabled;
> >      bool s4_disabled;
> >      bool pcihp_bridge_en;
> > +    bool pcihp_root_en;
> >      uint8_t s4_val;
> >      AcpiFadtData fadt;
> >      uint16_t cpu_hp_io_base;
> > @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> >      pm->pcihp_bridge_en =
> >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> >                                   NULL);
> > +    pm->pcihp_root_en =
> > +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
> > +
> >  }
> >
> >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > @@ -337,15 +341,18 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
> >  }
> >
> >  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> > -                                         bool pcihp_bridge_en)
> > +                                         bool pcihp_bridge_en,
> > +                                         bool pcihp_root_en)
> >  {
> >      Aml *dev, *notify_method = NULL, *method;
> >      QObject *bsel;
> >      PCIBus *sec;
> >      int i;
> > +    bool root_bus = pci_bus_is_root(bus);
> > +    bool root_pcihp_disabled = (root_bus && !pcihp_root_en);
> >
> >      bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
> > -    if (bsel) {
> > +    if (bsel && !root_pcihp_disabled) {
>
> have you considered to make bus not hotpluggable,
> which should make it not to have bsel, and hence skip this branch without
> root_pcihp_disabled?
>
> see: acpi_set_bsel()
>
>
> maybe you can drop pcihp_root_en and use bsel instead of it then.
>
> it also should block device_add/del route.

This is a good idea. Therefore, I tried this:

--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/acpi/acpi.h"
+#include "hw/pci/pci_bus.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/xen.h"
@@ -507,7 +508,9 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)

     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
+    if (s->use_acpi_root_pci_hotplug ||
+        !pci_bus_is_root(pci_get_bus(dev)))
+        qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));

     piix4_pm_add_propeties(s);
 }


but this does not seem to be working. I am out of ideas as to why it
wouldn't work :(

>
>
> >          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> >
> >          aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
> > @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >          bool bridge_in_acpi;
> >
> >          if (!pdev) {
> > +            /* skip if pci hotplug for the root bus is disabled */
> > +            if (root_pcihp_disabled)
> > +                continue;
> >              if (bsel) { /* add hotplug slots for non present devices */
> >                  dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
> >                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> > @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >              method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
> >              aml_append(method, aml_return(aml_int(s3d)));
> >              aml_append(dev, method);
> > -        } else if (hotplug_enabled_dev) {
> > +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
> >              /* add _SUN/_EJ0 to make slot hotpluggable  */
> >              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> >
> > @@ -439,13 +449,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >               */
> >              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> >
> > -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> > +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> > +                                         pcihp_root_en);
> >          }
> >          /* slot descriptor has been composed, add it into parent context */
> >          aml_append(parent_scope, dev);
> >      }
> >
> > -    if (bsel) {
> > +    if (bsel && !root_pcihp_disabled) {
> >          aml_append(parent_scope, notify_method);
> >      }
> >
> > @@ -455,7 +466,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >      method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> >
> >      /* If bus supports hotplug select it and notify about local events */
> > -    if (bsel) {
> > +    if (bsel && !root_pcihp_disabled) {
> >          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> >
> >          aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> > @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          if (bus) {
> >              Aml *scope = aml_scope("PCI0");
> >              /* Scan all PCI buses. Generate tables to support hotplug. */
> > -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> > +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
> > +                                         pm->pcihp_root_en);
> >
> >              if (TPM_IS_TIS_ISA(tpm)) {
> >                  if (misc->tpm_version == TPM_VERSION_2_0) {
>

