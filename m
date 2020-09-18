Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0151C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 06:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304A12100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 06:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="YoGnMxCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304A12100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJA2E-0006As-Vp
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 02:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJA0f-0005GP-NR
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 02:36:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJA0d-0005bx-Jn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 02:36:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so4397823wrx.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lp6v44Wg5uZ9xvExDfRHQhNbL6LYBg9EeASGIB2qC9Y=;
 b=YoGnMxCoKbdOePLXaiiqSA/7OMcLNQ0ckJXmHW6XwUzZwbesvdtBTt5Q1JbC87+esW
 qM4VML8LKexhtXHQmoBbksnsxtZczoWQRrycKiFje0F+FYYhpAzu6WnrTrYUKMh2sbLq
 pEv+zbLLxJdm5QLRu+ASmr3UdVHzhs9f0sbhPvjkpO0au0ThB0o4DGNAD5nIQ/W3QWkt
 ddPM4RZdfq9ydjCepbljimN+wITu0dlBET8A5HXUr5PNMfk5kP/QaT/qkoY48im5K5wC
 S6D0Kb4OhxwqJK5VRZQDwd4Gqem8YZ5y1noaiZ7g4B0esEAE/AYlvduFKvEvabhji9F2
 3ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lp6v44Wg5uZ9xvExDfRHQhNbL6LYBg9EeASGIB2qC9Y=;
 b=b9+ygdLQReh/WlvMgKcBh31DIcAkG1xQgFU+A4/0cvHNOFEe3mizL7LhbcPg7kkdIX
 eo5CFClFcCfh6ohrzo6zFjxyFPbcS7+/F1Jg/Ff/DY7bwKG5Bj/T99YX6dmv2VRhiHCp
 OZ50tvZiBddxM+ewVkHbEwsjQA3V35XL/4DGmuQ8t9GYTbj1oebBo8UJBeP4/3Y/sk+C
 J7H3GG8kg9GwweY0tqoaUOt1C4oxrkjgdK9NNJOd+IaVqsjf1qsdlzfGXRYld1iTmv+Q
 BlsjeDZMSbbEhokmKORScH+w2XaPeGxnDT1qSrC5gcVJYWoFQtuxybrQCSwMBy02R0k7
 cc/Q==
X-Gm-Message-State: AOAM533Er0Ua71MVyAtQxCTVJOTbj73V7MNUNe9xapanIXc+0fcTlM2M
 +19MS6USEZIX2RYgu4oxgUo4cBX+P282/X29kSHnfw==
X-Google-Smtp-Source: ABdhPJxyPaTdueLX2Xt9xl4RmOEOD3kDMmzo5BaMAL7Yy7mJpqkFGEaekSznADPBPnJ+SJ/bxe3IxexGykSuSQuxxEY=
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr34524844wru.427.1600410997925; 
 Thu, 17 Sep 2020 23:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200917150044.23159-1-ani@anisinha.ca>
 <20200917150044.23159-10-ani@anisinha.ca>
 <20200918082423.644c3a08@redhat.com>
In-Reply-To: <20200918082423.644c3a08@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 18 Sep 2020 12:06:26 +0530
Message-ID: <CAARzgww5Mpu8U73xKzeZKKpZp09ZVgnx2EMDHig1X4UKuaeDUQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] piix4: don't reserve hw resources when hotplug
 is off globally
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x443.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 11:54 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 17 Sep 2020 20:30:41 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > When acpi hotplug is turned off for both root pci bus as well as for pci
> > bridges, we should not generate the related ACPI code for DSDT table or
> > initialize related hw ports or reserve hw resources. This change makes
> > sure all those operations are turned off in the case ACPI pci hotplug is
> > off globally.
> >
> > In this change, we also make sure ACPI code for the PCNT method are only
> > added when bsel is enabled for the corresponding pci bus or bridge hotplug
> > is turned on.
> >
> > As q35 machines do not use bsel for it's pci buses at this point in time, this
> > change affects DSDT acpi table for q35 machines as well. Therefore, we will
> > also need to commit the updated golden master DSDT table acpi binary blobs as
> > well. Follwoing is the list of blobs which needs updating:
> >
> >  tests/data/acpi/q35/DSDT
> >  tests/data/acpi/q35/DSDT.acpihmat
> >  tests/data/acpi/q35/DSDT.bridge
> >  tests/data/acpi/q35/DSDT.cphp
> >  tests/data/acpi/q35/DSDT.dimmpxm
> >  tests/data/acpi/q35/DSDT.ipmibt
> >  tests/data/acpi/q35/DSDT.memhp
> >  tests/data/acpi/q35/DSDT.mmio64
> >  tests/data/acpi/q35/DSDT.numamem
> >  tests/data/acpi/q35/DSDT.tis
> >
> > These tables are updated in the following commit. Without the updated table
> > blobs, the unit tests would fail with this patch.
>
> adding this to commit description doesn't help,
> 'make check' still fails if we apply patches till this point.
> which leads to broken bisection.
>
> I'm curious, what is not clear in process description at
> the start of tests/qtest/bios-tables-test.c.
> You did that for new tests, but so some reason you are avoiding
> to  follow the same rules with this patch.

Yes because I assumed the instructions were for tests only not for
patches which modify tables. It starts with the lines:
" How to add or update the tests:"

>
>
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  hw/acpi/piix4.c      |  6 ++++--
> >  hw/i386/acpi-build.c | 25 ++++++++++++++++++-------
> >  2 files changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index e6163bb6ce..b70b1f98af 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> >                            "acpi-gpe0", GPE_LEN);
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
> > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > +                        s->use_acpi_hotplug_bridge);
> > +    }
> >
> >      s->cpu_hotplug_legacy = true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index e079b686f5..e41bb0992b 100644
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
> > +        object_property_get_bool(obj, "acpi-root-pci-hotplug",
> > +                                 NULL);
> >  }
> >
> >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > @@ -450,10 +454,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >      }
> >
> >      /* Append PCNT method to notify about events on local and child buses.
> > -     * Add unconditionally for root since DSDT expects it.
> > +     * Add this method for root bus only when hotplug is enabled since DSDT
> > +     * expects it.
> >       */
> > -    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> > -
> > +    if (bsel || pcihp_bridge_en) {
> > +        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> > +    }
> >      /* If bus supports hotplug select it and notify about local events */
> >      if (bsel) {
> >          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> > @@ -479,7 +485,10 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >              aml_append(method, aml_name("^S%.02X.PCNT", devfn));
> >          }
> >      }
> > -    aml_append(parent_scope, method);
> > +
> > +    if (bsel || pcihp_bridge_en) {
> > +        aml_append(parent_scope, method);
> > +    }
> >      qobject_unref(bsel);
> >  }
> >
> > @@ -1504,7 +1513,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          build_hpet_aml(dsdt);
> >          build_piix4_isa_bridge(dsdt);
> >          build_isa_devices_aml(dsdt);
> > -        build_piix4_pci_hotplug(dsdt);
> > +        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> > +            build_piix4_pci_hotplug(dsdt);
> > +        }
> >          build_piix4_pci0_int(dsdt);
> >      } else {
> >          sb_scope = aml_scope("_SB");
> > @@ -1546,7 +1557,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >      {
> >          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
> >
> > -        if (misc->is_piix4) {
> > +        if (misc->is_piix4 && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> >              method = aml_method("_E01", 0, AML_NOTSERIALIZED);
> >              aml_append(method,
> >                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> > @@ -1698,7 +1709,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >      crs_range_set_free(&crs_range_set);
> >
> >      /* reserve PCIHP resources */
> > -    if (pm->pcihp_io_len) {
> > +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> >          dev = aml_device("PHPR");
> >          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> >          aml_append(dev,
>

