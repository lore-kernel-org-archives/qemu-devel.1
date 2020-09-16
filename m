Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2852AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0635A206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0wJJj2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0635A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIcj8-0006si-Fc
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 15:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kIchi-0006LL-9d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kIchf-00065q-Tg
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600282970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OIh+TgXnC3bWytGL7kKglQeeGQJ79e9RVEiY5yofd4s=;
 b=h0wJJj2h6p227/FnhAA8NG4lZDhHzHp2rg+E2JggEOT+xoTv8Qa7cI/7B0ekAKM6dXxSCc
 ybo5+kImRnhIBoqt8b2d3/Zd7et+lFfg/0hvIUEc1oWJ53qdXY3NT977jQ5811WL6A9P8Y
 3lokKWaK6UNqPJ2rqPXepDFdrIRFBWs=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-I_eJVMfcPrSzGOcChZB-tw-1; Wed, 16 Sep 2020 15:02:48 -0400
X-MC-Unique: I_eJVMfcPrSzGOcChZB-tw-1
Received: by mail-yb1-f198.google.com with SMTP id i199so7943739ybg.22
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 12:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OIh+TgXnC3bWytGL7kKglQeeGQJ79e9RVEiY5yofd4s=;
 b=d15usQQpAAEIzGyFrUOsffdYSdOCa9b1gwmXCgcptpqOa1guxW7NNNRtGPT/E5+6fM
 TspQWhg/dkxdAwOW2vd9ilwLD6yTjCg/gPoypGZkV0/tmKO0okjJiPHHOWXjEq9nYZ9w
 C8ILM+AEkNOvEi0We3w7MeWL0EAAaCDyvQSPgtPzfLfQSzsfcrcDcb92lYaylnMgVdxL
 DSzVfZbA09opDDwtpe62obgGlmw2nJ3Ef+hc95Vo8RrqFJ85VfBpcwSV9AefTpz8cAtq
 7B28/FrhP+Dt42YFckq4udJPhgfXdnh4TrX5vGQnVReKnbV2KnVJNbY8ONWDZqDuixx6
 hcug==
X-Gm-Message-State: AOAM530E+RSGRH9DY7V/J7RIa6Xtdyc/lkthNxX4/AyB2qekhVCzaS7B
 bNhuSDmKMtYLvu7KrqzkN3uewF1EOgX+KFrsFeKIO/FaECZ1cMpU4oRfgoMaN0LQAtL+IcdLq1n
 wvy57HG4B60ADKnnWAoB1ImLqtJM4ucM=
X-Received: by 2002:a25:c54f:: with SMTP id v76mr36401446ybe.321.1600282968177; 
 Wed, 16 Sep 2020 12:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRtaGUG63YSLcFclB99FFMieahGetwKElCpz5pCEKpzCrKMNeYoeFIcwOCQnWemJFRlIineHfeGyuhYlfPRRs=
X-Received: by 2002:a25:c54f:: with SMTP id v76mr36401400ybe.321.1600282967805; 
 Wed, 16 Sep 2020 12:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-3-jusual@redhat.com>
 <20200821140815.288f14db@redhat.com>
In-Reply-To: <20200821140815.288f14db@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 16 Sep 2020 21:02:36 +0200
Message-ID: <CAMDeoFUqf41OZEhpQJQ=o5087DV3bazxJMJNpw=dsAHA-+Od1A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to q35
To: Igor Mammedov <imammedo@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 2:08 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 18 Aug 2020 23:52:25 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
>
> > Implement notifications and gpe to support q35 ACPI PCI hot-plug.
> > Use 0xcc4 - 0xcd7 range for 'acpi-pci-hotplug' io ports.
>
> in addition to comment from Philippe
>
>
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  include/hw/acpi/pcihp.h |  3 ++-
> >  hw/acpi/pcihp.c         | 10 ++++++----
> >  hw/acpi/piix4.c         |  2 +-
> >  hw/i386/acpi-build.c    | 25 ++++++++++++++-----------
> >  4 files changed, 23 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > index 8bc4a4c01d..1e9d246f57 100644
> > --- a/include/hw/acpi/pcihp.h
> > +++ b/include/hw/acpi/pcihp.h
> > @@ -54,7 +54,8 @@ typedef struct AcpiPciHpState {
> >  } AcpiPciHpState;
> >
> >  void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
> > -                     MemoryRegion *address_space_io, bool bridges_enabled);
> > +                     MemoryRegion *address_space_io, bool bridges_enabled,
> > +                     bool is_piix4);
> >
> >  void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >                                     DeviceState *dev, Error **errp);
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > index 9e31ab2da4..9a35ed6c83 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -38,7 +38,8 @@
> >  #include "qom/qom-qobject.h"
> >  #include "trace.h"
> >
> > -#define ACPI_PCIHP_ADDR 0xae00
> > +#define ACPI_PCIHP_ADDR_PIIX4 0xae00
> > +#define ACPI_PCIHP_ADDR_Q35 0x0cc4
> >  #define ACPI_PCIHP_SIZE 0x0014
> >  #define PCI_UP_BASE 0x0000
> >  #define PCI_DOWN_BASE 0x0004
> > @@ -359,12 +360,13 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
> >  };
> >
> >  void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
> > -                     MemoryRegion *address_space_io, bool bridges_enabled)
> > +                     MemoryRegion *address_space_io, bool bridges_enabled,
> > +                     bool is_piix4)
> >  {
> >      s->io_len = ACPI_PCIHP_SIZE;
> > -    s->io_base = ACPI_PCIHP_ADDR;
> > +    s->io_base = is_piix4 ? ACPI_PCIHP_ADDR_PIIX4 : ACPI_PCIHP_ADDR_Q35;
> >
> > -    s->root= root_bus;
> > +    s->root = root_bus;
> >      s->legacy_piix = !bridges_enabled;
> >
> >      memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index cdfa0e2998..1f27bfbd06 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -596,7 +596,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> >      acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +                    s->use_acpi_hotplug_bridge, true);
> >
> >      s->cpu_hotplug_legacy = true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbbb2a..f3cd52bd06 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -201,10 +201,6 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> >          /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
> >          pm->fadt.rev = 1;
> >          pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
> > -        pm->pcihp_io_base =
> > -            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> > -        pm->pcihp_io_len =
> > -            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> >      }
> >      if (lpc) {
> >          struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
> > @@ -214,6 +210,10 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> >          pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
> >          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
> >      }
> > +    pm->pcihp_io_base =
> > +        object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> > +    pm->pcihp_io_len =
> > +        object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> >
> >      /* The above need not be conditional on machine type because the reset port
> >       * happens to be the same on PIIX (pc) and ICH9 (q35). */
> > @@ -472,7 +472,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >          QLIST_FOREACH(sec, &bus->child, sibling) {
> >              int32_t devfn = sec->parent_dev->devfn;
> >
> > -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> > +            if (pci_bus_is_root(sec)) {
> Does pcie bus on hostbridge fall into pci_bus_is_express() categiry or not?

I don't understand why it's there in the first place.
pci_bus_is_root() check is for pxb, but pci_bus_is_express() is
useless because everything is under 'if (pcihp_bridge_en) {', which
means that no pcie bus will get there (before this patch).

> >                  continue;
> >              }
> >
> > @@ -1368,7 +1368,7 @@ static void build_piix4_isa_bridge(Aml *table)
> >      aml_append(table, scope);
> >  }
> >
> > -static void build_piix4_pci_hotplug(Aml *table)
> > +static void build_i386_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> >  {
> >      Aml *scope;
> >      Aml *field;
> > @@ -1377,20 +1377,22 @@ static void build_piix4_pci_hotplug(Aml *table)
> >      scope =  aml_scope("_SB.PCI0");
> >
> >      aml_append(scope,
> > -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x08));
> > +        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> >      field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> >      aml_append(field, aml_named_field("PCIU", 32));
> >      aml_append(field, aml_named_field("PCID", 32));
> >      aml_append(scope, field);
> >
> >      aml_append(scope,
> > -        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04));
> > +    aml_operation_region("SEJ", AML_SYSTEM_IO,
> > +                         aml_int(pcihp_addr + 0x08), 0x04));
>                                                  ^^^^
> how about turning this offset into macro?
>
> >      field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> >      aml_append(field, aml_named_field("B0EJ", 32));
> >      aml_append(scope, field);
> >
> >      aml_append(scope,
> > -        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x04));
> > +        aml_operation_region("BNMR", AML_SYSTEM_IO,
> > +                             aml_int(pcihp_addr + 0x10), 0x04));
> ditto
>
> >      field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> >      aml_append(field, aml_named_field("BNUM", 32));
> >      aml_append(scope, field);
> > @@ -1504,7 +1506,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          build_hpet_aml(dsdt);
> >          build_piix4_isa_bridge(dsdt);
> >          build_isa_devices_aml(dsdt);
> > -        build_piix4_pci_hotplug(dsdt);
> >          build_piix4_pci0_int(dsdt);
> >      } else {
> >          sb_scope = aml_scope("_SB");
> > @@ -1526,6 +1527,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          }
> >      }
> >
> > +    build_i386_pci_hotplug(dsdt, pm->pcihp_io_base);
> > +
> >      if (pcmc->legacy_cpu_hotplug) {
> >          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
> >      } else {
> > @@ -1546,7 +1549,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >      {
> >          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
> >
> > -        if (misc->is_piix4) {
> > +        if (misc->is_piix4 || pm->pcihp_bridge_en) {
> >              method = aml_method("_E01", 0, AML_NOTSERIALIZED);
> >              aml_append(method,
> >                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
>


