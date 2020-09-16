Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B04C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2277120838
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8XUqpyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2277120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kId4K-0005Go-1j
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 15:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kId2r-0004jn-KJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kId2p-0000AC-5N
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600284281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWJzcljMz6RvQecCqKp8sJmdQ78pfD5FhZwLf1nlYHo=;
 b=c8XUqpyCsEMk5vaWOyu+jU47R/lMpUDuZcKtlayYUXKNT0Z+8sHp9ZxhVfjZ8GKU/Ov9fi
 pgUB3v4bYN7VuYSEirYkH+Gc8OQAx85wb1WLTv+m3/Unr0W5ADX3iUYedfbmTnl8jjRQo0
 w++lu45PPdj9v+O14gTR1N0nBIrfwao=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-MS7lNm_kM2ucr8g3f6kDSA-1; Wed, 16 Sep 2020 15:24:39 -0400
X-MC-Unique: MS7lNm_kM2ucr8g3f6kDSA-1
Received: by mail-yb1-f197.google.com with SMTP id r193so8153115ybc.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 12:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CWJzcljMz6RvQecCqKp8sJmdQ78pfD5FhZwLf1nlYHo=;
 b=T0TE7+LKl1KW/H0vSiJeTIEG+9cvBbpp6+vucNJXwos5Mx8EXPGjSjgoF8zljdeet+
 N8XXtarp2LhmRR6P7ebYkQJl7Z8OadLh4ZekGFnJVmPQIuIlEAmPtF00zsL7FIAz51lG
 1oTdDFmC5PZNehvAGuGGoqY7duZ+oOnXpaYyY0zmk7enFaYSPsQIo5s6E3YCnLfBiNNc
 w7Td4b2N/iWTzH1p1QKL0CQ3Vrj0Zvn0ZgENeu0w4rQeJgg5gWuuSnB4RnObo5uGZRXz
 ikCoL8ROmKXfE8ciI9TMrHnqXt73ATLKQtg9paKqRGu5e+uZ6adV3XTxxXuIUuGd4nYl
 5J+g==
X-Gm-Message-State: AOAM533v/u2ZFJ+lx1KpcRDF/ODW0c0P6OSaZIAMTKgesbQT/TPI9Bdz
 ranTREOph6h4Q77HlHMOIfIye/2MM5ZAql4/QBwQrnTIgM8eEQ3hsAT00nlmrK+FDLr+Xbu/F/B
 9CNWvLnbkSNg5Iv9F7BxK+wDjmFz6H40=
X-Received: by 2002:a25:c54f:: with SMTP id v76mr36526642ybe.321.1600284279113; 
 Wed, 16 Sep 2020 12:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8O6beT+zjNnmJaMEVnitHYQYhdCRfV7VhV7OzYoP7KdlLd0cRyXZSSeerb4krhFSCV29yEieSPV86gVwjLeI=
X-Received: by 2002:a25:c54f:: with SMTP id v76mr36526606ybe.321.1600284278824; 
 Wed, 16 Sep 2020 12:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-3-jusual@redhat.com>
 <7f29d89e-8cdc-8067-acff-2817183f20f0@redhat.com>
In-Reply-To: <7f29d89e-8cdc-8067-acff-2817183f20f0@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 16 Sep 2020 21:24:27 +0200
Message-ID: <CAMDeoFXgyKKc7Guy-dV24zFYs6YdzFu-rxP-1H84pXDx_P6GGw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to q35
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 5:21 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Julia,
>
> On 8/18/20 11:52 PM, Julia Suvorova wrote:
> > Implement notifications and gpe to support q35 ACPI PCI hot-plug.
> > Use 0xcc4 - 0xcd7 range for 'acpi-pci-hotplug' io ports.
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
> > -                     MemoryRegion *address_space_io, bool bridges_enab=
led);
> > +                     MemoryRegion *address_space_io, bool bridges_enab=
led,
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
> > @@ -359,12 +360,13 @@ static const MemoryRegionOps acpi_pcihp_io_ops =
=3D {
> >  };
> >
> >  void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bu=
s,
> > -                     MemoryRegion *address_space_io, bool bridges_enab=
led)
> > +                     MemoryRegion *address_space_io, bool bridges_enab=
led,
> > +                     bool is_piix4)
>
> Instead of adding implementation knowledge to this generic function, can
> you instead pass it a 'io_base' argument (or 'pcihp_addr')?

Ok.

> >  {
> >      s->io_len =3D ACPI_PCIHP_SIZE;
> > -    s->io_base =3D ACPI_PCIHP_ADDR;
> > +    s->io_base =3D is_piix4 ? ACPI_PCIHP_ADDR_PIIX4 : ACPI_PCIHP_ADDR_=
Q35;
> >
> > -    s->root=3D root_bus;
> > +    s->root =3D root_bus;
> >      s->legacy_piix =3D !bridges_enabled;
> >
> >      memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index cdfa0e2998..1f27bfbd06 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -596,7 +596,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRe=
gion *parent,
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> >      acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +                    s->use_acpi_hotplug_bridge, true);
> >
> >      s->cpu_hotplug_legacy =3D true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbbb2a..f3cd52bd06 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -201,10 +201,6 @@ static void acpi_get_pm_info(MachineState *machine=
, AcpiPmInfo *pm)
> >          /* w2k requires FADT(rev1) or it won't boot, keep PC compatibl=
e */
> >          pm->fadt.rev =3D 1;
> >          pm->cpu_hp_io_base =3D PIIX4_CPU_HOTPLUG_IO_BASE;
> > -        pm->pcihp_io_base =3D
> > -            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NUL=
L);
> > -        pm->pcihp_io_len =3D
> > -            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL=
);
> >      }
> >      if (lpc) {
> >          struct AcpiGenericAddress r =3D { .space_id =3D AML_AS_SYSTEM_=
IO,
> > @@ -214,6 +210,10 @@ static void acpi_get_pm_info(MachineState *machine=
, AcpiPmInfo *pm)
> >          pm->fadt.flags |=3D 1 << ACPI_FADT_F_RESET_REG_SUP;
> >          pm->cpu_hp_io_base =3D ICH9_CPU_HOTPLUG_IO_BASE;
> >      }
> > +    pm->pcihp_io_base =3D
> > +        object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> > +    pm->pcihp_io_len =3D
> > +        object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> >
> >      /* The above need not be conditional on machine type because the r=
eset port
> >       * happens to be the same on PIIX (pc) and ICH9 (q35). */
> > @@ -472,7 +472,7 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
> >          QLIST_FOREACH(sec, &bus->child, sibling) {
> >              int32_t devfn =3D sec->parent_dev->devfn;
> >
> > -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> > +            if (pci_bus_is_root(sec)) {
>
> Different patch?

PCNT method is part of ACPI hot-plug, and we add it to q35 (pcie).

> >                  continue;
> >              }
> >
> > @@ -1368,7 +1368,7 @@ static void build_piix4_isa_bridge(Aml *table)
> >      aml_append(table, scope);
> >  }
> >
> > -static void build_piix4_pci_hotplug(Aml *table)
> > +static void build_i386_pci_hotplug(Aml *table, uint64_t pcihp_addr)
>
> Being common to 32/64-bit, I'd name that build_x86_pci_hotplug().
>
> >  {
> >      Aml *scope;
> >      Aml *field;
> > @@ -1377,20 +1377,22 @@ static void build_piix4_pci_hotplug(Aml *table)
> >      scope =3D  aml_scope("_SB.PCI0");
> >
> >      aml_append(scope,
> > -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0=
x08));
> > +        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr=
), 0x08));
> >      field =3D aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_A=
S_ZEROS);
> >      aml_append(field, aml_named_field("PCIU", 32));
> >      aml_append(field, aml_named_field("PCID", 32));
> >      aml_append(scope, field);
> >
> >      aml_append(scope,
> > -        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x=
04));
> > +    aml_operation_region("SEJ", AML_SYSTEM_IO,
> > +                         aml_int(pcihp_addr + 0x08), 0x04));
> >      field =3D aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS=
_ZEROS);
> >      aml_append(field, aml_named_field("B0EJ", 32));
> >      aml_append(scope, field);
> >
> >      aml_append(scope,
> > -        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0=
x04));
> > +        aml_operation_region("BNMR", AML_SYSTEM_IO,
> > +                             aml_int(pcihp_addr + 0x10), 0x04));
> >      field =3D aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_A=
S_ZEROS);
> >      aml_append(field, aml_named_field("BNUM", 32));
> >      aml_append(scope, field);
> > @@ -1504,7 +1506,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >          build_hpet_aml(dsdt);
> >          build_piix4_isa_bridge(dsdt);
> >          build_isa_devices_aml(dsdt);
> > -        build_piix4_pci_hotplug(dsdt);
> >          build_piix4_pci0_int(dsdt);
> >      } else {
> >          sb_scope =3D aml_scope("_SB");
> > @@ -1526,6 +1527,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >          }
> >      }
> >
> > +    build_i386_pci_hotplug(dsdt, pm->pcihp_io_base);
> > +
> >      if (pcmc->legacy_cpu_hotplug) {
> >          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base=
);
> >      } else {
> > @@ -1546,7 +1549,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >      {
> >          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")=
));
> >
> > -        if (misc->is_piix4) {
> > +        if (misc->is_piix4 || pm->pcihp_bridge_en) {
>
> Why not directly check 'if (pm->pcihp_bridge_en) {'?

GPE.1 should be implemented for pci root hotplug on piix4 even if
pcihp_bridge_en is disabled. There will be a bit different logic with
"[PATCH v5 09/11] piix4: don't reserve hw resources when hotplug is
off globally", but it's not merged yet.


> >              method =3D aml_method("_E01", 0, AML_NOTSERIALIZED);
> >              aml_append(method,
> >                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> >
>
> Regards,
>
> Phil.
>


