Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA8FC47427
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C30523741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehWBbgMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C30523741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRmQ-0002LM-My
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLRlR-0001nW-OR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLRlP-0008Cy-0b
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600955901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8/jbRuHXe++4Vg7xkGQyszi6Ui3P/210nwnmRIquNoo=;
 b=ehWBbgMeRjSbA/j1+s2UpcJRPGoP1T3puIzcFiOFDep2Gf6F8AyoAxTGC5aryNM1+ulkKp
 36m9Pi4e/uKazZY77Z8dNq+z0by5/afaOcjo4csEIWOsSiMiDrkUXS6VKDGW22rdQedNfG
 /G6XNLW6pUECzgOD0wI7kI2XqeB6Dus=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-PB1S9OBDMA20lQrI0yzmlw-1; Thu, 24 Sep 2020 09:58:20 -0400
X-MC-Unique: PB1S9OBDMA20lQrI0yzmlw-1
Received: by mail-yb1-f199.google.com with SMTP id r9so2951432ybd.20
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 06:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8/jbRuHXe++4Vg7xkGQyszi6Ui3P/210nwnmRIquNoo=;
 b=AZFUZ6nGXGLtWwUGncGqDSyazrrZ4ZQsxNQkFOEEONojIxO126pWbClvnGR+jnaUWj
 e7p0VLIzV4lcD/nzDNx4n9K4jQoFr0TfVshxHERUMBB5F1xjMhmph+fthxX0ZsHpSdIe
 wFRaVOR7s1BC+Iz/qXNaXCITZ/t4o1e0GZFg0gte0iHsAXGm6RN5TtMNaoeG8kRvowCK
 5je18wOb51c/lvyI8CCIgBKx7FKuL55v2QZgbVeom0q6xyGaU61XW6ALGDn6D6SvN51i
 oDg4e8LUyoIwPSoXoU5fTz+96C5iwcEsuQ7Y8Til3dCOgiX8SXs6BQayGjfPX6ivglRt
 RwVw==
X-Gm-Message-State: AOAM533UjkY5FCZqWbt5k9UK8PvOweiWTVGqyMEXIUNn9WqAjC5eD7WF
 kPntyC+EcY8QNoLG8Hm0mvWatsZVOh8aENMD0ravuGnXR+L0XK3vOoj5oN7c+jJz4O7FDC4CXd1
 BlFkRR8vMqBkT/+K8LDcViiIXLV5unAk=
X-Received: by 2002:a25:198b:: with SMTP id 133mr6862080ybz.102.1600955899415; 
 Thu, 24 Sep 2020 06:58:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlbaJ0UCJsvJGqFKlmWKCfkIpjijl+0Cwa4luAHnGQf8M9Dm5iYry+KVQDp4fZwmkg4bFOGXjAqlCA4sElZJc=
X-Received: by 2002:a25:198b:: with SMTP id 133mr6862030ybz.102.1600955898978; 
 Thu, 24 Sep 2020 06:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-3-jusual@redhat.com>
 <alpine.DEB.2.21.2009241831140.17687@ani-ubuntu>
In-Reply-To: <alpine.DEB.2.21.2009241831140.17687@ani-ubuntu>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 24 Sep 2020 15:58:07 +0200
Message-ID: <CAMDeoFXVBOm=Wmta4O7xD6zo+bhfK_sA7TtEHbBHhF010k8QMw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/7] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to Q35
To: Ani Sinha <ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 3:15 PM Ani Sinha <ani@anisinha.ca> wrote:
>
>
>
> On Thu, 24 Sep 2020, Julia Suvorova wrote:
>
> > Implement notifications and gpe to support q35 ACPI PCI hot-plug.
> > Use 0xcc4 - 0xcd7 range for 'acpi-pci-hotplug' io ports.
> >
>
> For this patch, I would suggest maybe you can also add a diff of the
> disassembly of the DSDT table so that we know what changes exactly we
> shall see in the table as a result of this patch.
> Add the diff to this commit message as it will be helpful for anyone
> to take a look at it when they look at this patch.

There is no difference in golden DSDT, because this is an option,
which is disabled by default.
The diff is placed in the patch where it actually makes a difference.
But I agree that a list of changed registers would be a nice addition
to the commit message.

> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> > hw/i386/acpi-build.h    |  4 ++++
> > include/hw/acpi/ich9.h  |  2 ++
> > include/hw/acpi/pcihp.h |  3 ++-
> > hw/acpi/pcihp.c         |  8 ++++----
> > hw/acpi/piix4.c         |  4 +++-
> > hw/i386/acpi-build.c    | 27 ++++++++++++++++-----------
> > 6 files changed, 31 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> > index 74df5fc612..487ec7710f 100644
> > --- a/hw/i386/acpi-build.h
> > +++ b/hw/i386/acpi-build.h
> > @@ -5,6 +5,10 @@
> >
> > extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
> >
> > +/* PCI Hot-plug registers bases. See docs/spec/acpi_pci_hotplug.txt */
> > +#define ACPI_PCIHP_SEJ_BASE 0x8
> > +#define ACPI_PCIHP_BNMR_BASE 0x10
> > +
> > void acpi_setup(void);
> >
> > #endif
> > diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> > index 28a53181cb..4d19571ed7 100644
> > --- a/include/hw/acpi/ich9.h
> > +++ b/include/hw/acpi/ich9.h
> > @@ -28,6 +28,8 @@
> > #include "hw/acpi/acpi_dev_interface.h"
> > #include "hw/acpi/tco.h"
> >
> > +#define ACPI_PCIHP_ADDR_ICH9 0x0cc4
> > +
> > typedef struct ICH9LPCPMRegs {
> >     /*
> >      * In ich9 spec says that pm1_cnt register is 32bit width and
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > index 02f4665767..ce49fb03b9 100644
> > --- a/include/hw/acpi/pcihp.h
> > +++ b/include/hw/acpi/pcihp.h
> > @@ -54,7 +54,8 @@ typedef struct AcpiPciHpState {
> > } AcpiPciHpState;
> >
> > void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
> > -                     MemoryRegion *address_space_io, bool bridges_enabled);
> > +                     MemoryRegion *address_space_io, bool bridges_enabled,
> > +                     uint16_t io_base);
> >
> > void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >                                    DeviceState *dev, Error **errp);
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > index ff23104aea..bb457bc279 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -38,7 +38,6 @@
> > #include "qom/qom-qobject.h"
> > #include "trace.h"
> >
> > -#define ACPI_PCIHP_ADDR 0xae00
> > #define ACPI_PCIHP_SIZE 0x0014
> > #define PCI_UP_BASE 0x0000
> > #define PCI_DOWN_BASE 0x0004
> > @@ -381,12 +380,13 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
> > };
> >
> > void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
> > -                     MemoryRegion *address_space_io, bool bridges_enabled)
> > +                     MemoryRegion *address_space_io, bool bridges_enabled,
> > +                     uint16_t io_base)
> > {
> >     s->io_len = ACPI_PCIHP_SIZE;
> > -    s->io_base = ACPI_PCIHP_ADDR;
> > +    s->io_base = io_base;
>
> Maybe you want to remove ACPI_PCIHP_ADDR ?

It is removed (a bit higher in this patch).

> > -    s->root= root_bus;
> > +    s->root = root_bus;
> >     s->legacy_piix = !bridges_enabled;
> >
> >     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 832f8fba82..a505ab5bcf 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -50,6 +50,8 @@
> > #define GPE_BASE 0xafe0
> > #define GPE_LEN 4
> >
> > +#define ACPI_PCIHP_ADDR_PIIX4 0xae00
> > +
> > struct pci_status {
> >     uint32_t up; /* deprecated, maintained for migration compatibility */
> >     uint32_t down;
> > @@ -597,7 +599,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> >     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> >     acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +                    s->use_acpi_hotplug_bridge, ACPI_PCIHP_ADDR_PIIX4);
> >
> >     s->cpu_hotplug_legacy = true;
> >     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 0e0535d2e3..cf503b16af 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -201,10 +201,6 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> >         /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
> >         pm->fadt.rev = 1;
> >         pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
> > -        pm->pcihp_io_base =
> > -            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> > -        pm->pcihp_io_len =
> > -            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> >     }
> >     if (lpc) {
> >         struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
> > @@ -214,6 +210,10 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> >         pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
> >         pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
> >     }
> > +    pm->pcihp_io_base =
> > +        object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> > +    pm->pcihp_io_len =
> > +        object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> >
> >     /* The above need not be conditional on machine type because the reset port
> >      * happens to be the same on PIIX (pc) and ICH9 (q35). */
> > @@ -472,7 +472,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >         QLIST_FOREACH(sec, &bus->child, sibling) {
> >             int32_t devfn = sec->parent_dev->devfn;
> >
> > -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> > +            if (pci_bus_is_root(sec)) {
> >                 continue;
> >             }
> >
> > @@ -1368,7 +1368,7 @@ static void build_piix4_isa_bridge(Aml *table)
> >     aml_append(table, scope);
> > }
> >
> > -static void build_piix4_pci_hotplug(Aml *table)
> > +static void build_x86_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> > {
> >     Aml *scope;
> >     Aml *field;
> > @@ -1377,20 +1377,22 @@ static void build_piix4_pci_hotplug(Aml *table)
> >     scope =  aml_scope("_SB.PCI0");
> >
> >     aml_append(scope,
> > -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x08));
> > +        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> >     field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> >     aml_append(field, aml_named_field("PCIU", 32));
> >     aml_append(field, aml_named_field("PCID", 32));
> >     aml_append(scope, field);
> >
> >     aml_append(scope,
> > -        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04));
> > +    aml_operation_region("SEJ", AML_SYSTEM_IO,
> > +                         aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
> >     field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> >     aml_append(field, aml_named_field("B0EJ", 32));
> >     aml_append(scope, field);
> >
> >     aml_append(scope,
> > -        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x04));
> > +        aml_operation_region("BNMR", AML_SYSTEM_IO,
> > +                             aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x04));
> >     field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> >     aml_append(field, aml_named_field("BNUM", 32));
> >     aml_append(scope, field);
> > @@ -1504,7 +1506,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >         build_hpet_aml(dsdt);
> >         build_piix4_isa_bridge(dsdt);
> >         build_isa_devices_aml(dsdt);
> > -        build_piix4_pci_hotplug(dsdt);
> > +        build_x86_pci_hotplug(dsdt, pm->pcihp_io_base);
>
> This will conflict here with my patch. I think you need to do something
> like this:
>
>    if (pm->pcihp_bridge_en || pm->pcihp_root_en) {

Yes, and I change it if your patch set gets merged first. Otherwise,
you will need to rebase.



> You'll get this from my patch.
> >         build_piix4_pci0_int(dsdt);
> >     } else {
> >         sb_scope = aml_scope("_SB");
> > @@ -1520,6 +1522,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >         build_hpet_aml(dsdt);
> >         build_q35_isa_bridge(dsdt);
> >         build_isa_devices_aml(dsdt);
> > +        if (pm->pcihp_bridge_en) {
> > +            build_x86_pci_hotplug(dsdt, pm->pcihp_io_base);
> > +        }
>
> ditto as above.
>
> >         build_q35_pci0_int(dsdt);
> >         if (pcms->smbus && !pcmc->do_not_add_smb_acpi) {
> >             build_smb0(dsdt, pcms->smbus, ICH9_SMB_DEV, ICH9_SMB_FUNC);
> > @@ -1546,7 +1551,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >     {
> >         aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
> >
> > -        if (misc->is_piix4) {
> > +        if (misc->is_piix4 || pm->pcihp_bridge_en) {
> >             method = aml_method("_E01", 0, AML_NOTSERIALIZED);
> >             aml_append(method,
> >                 aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> > --
> > 2.25.4
> >
> >
>


