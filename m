Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71F6C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4673320684
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="am/NWs+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4673320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAhT-0001vM-41
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIAVL-0002hg-6a
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:56:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIAVG-0005Gs-2r
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:56:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id s13so3258771wmh.4
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tPi5X6ZaflWW893hRbxAkR4y4K2Q9jtc4BeLXm3WP+k=;
 b=am/NWs+hOa08XwGN5wCD87BSfGSpXjFZhDNxGA5okTydz/SMy/Rubk5bn55DgRaWf2
 qCt1biQsGmlPFPwSLTEfan9jUwR9NHXGPlMBAS5FjdvNwiq0j74g25LQjD6njv8p5pBr
 EJ675KheVOS3ZDKsss7FolrgShK3Bzd05+tsF8YTqSIvjnCbMyMg7WYK4n5BQJ8WBkmF
 S4qM8gFBhkR97d2tqpMI3XZ6trK6BjbNZbc+3F9IGPQSQO2QA36FNdPWuk8gzaPUW/7D
 AKtwPdwOgX7TihmeEYc5t39rbctl+nNZxomeHBkm2VeOOD39til1ib697eLbGz6O2mbb
 Lgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tPi5X6ZaflWW893hRbxAkR4y4K2Q9jtc4BeLXm3WP+k=;
 b=Dac6eE6VM9rx/vNSZ+20pmlYBExjjpUpskWnBtVSAVOOq1yrufH1S050Y1ZbDweANR
 WgOexCacJb1xFRocwxcJW2a/YeibKvGataIjP8Si0atMyc/WGD2wmBQ13snE7U5aatFz
 eSSc3JacmHEI+lGmz/zdokwQbNsoVhjWR053CoVwrSCxfM3ADpWTQ7o2ZR6tNcPiVyse
 lgielZNQkcrGBNrjQ3ULu3U3FkRTEWejL78V/Li5mjq3aLTN3fV0LoB3Dzt8+2957KpF
 kZ4rqDafh5DY9OkMmyuik/7ANp+3E2zoLvDqt+SvHbBg2IFtSdXQrxQ5BYTsrjxhABca
 CGFA==
X-Gm-Message-State: AOAM5305SfuGNtVH4ASQSEYRCnt4JYOIblXz2kL5X/AYvdF0rPs9PZlr
 23cDSXprYgIcIaTOTGXlSS+esKYR72URaIWnwnh94A==
X-Google-Smtp-Source: ABdhPJz4AP68gj+Ztfgky+z7erHJol8QapvYcSWBb05SnSXjTPU0XYJH569WfxPsH7hAdp/L0QVa7zJvN2mSgrczSyY=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr4610667wmf.20.1600174567009; 
 Tue, 15 Sep 2020 05:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-9-ani@anisinha.ca>
 <20200914150550.23a91fa2@redhat.com>
 <CAARzgwyrSW4jjrPCc1SJkDZUV9C-e_96RNGytZ8VjpPzzrWfXg@mail.gmail.com>
 <CAARzgwx4T0MXtFTMe-b8DbAQCi7xq231kjOv8wRcRxwE5HPCyw@mail.gmail.com>
 <20200914160910.66785da8@redhat.com>
 <CAARzgwzSg7zCk_jaQ7iriC4_L+9oTykv0RhPdkTroP9pNtiMCg@mail.gmail.com>
 <20200915135141.585c767d@redhat.com>
 <CAARzgwzF4nwb8=ZQq5mhmDPQdgaen4Dy+_gXQVkW+Gw-_feMgw@mail.gmail.com>
 <20200915144859.4f929784@redhat.com>
In-Reply-To: <20200915144859.4f929784@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 15 Sep 2020 18:25:55 +0530
Message-ID: <CAARzgwyi2K_VS-dw2aoqy0tVy_VmGH+fM33BKB0q3-spCGgf+Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] piix4: don't reserve hw resources when hotplug is off
 globally
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x344.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 6:19 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 15 Sep 2020 17:40:25 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > On Tue, Sep 15, 2020 at 5:21 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > On Mon, 14 Sep 2020 20:20:21 +0530
> > > Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > > > On Mon, Sep 14, 2020 at 7:39 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > > > >
> > > > > On Mon, 14 Sep 2020 18:58:19 +0530
> > > > > Ani Sinha <ani@anisinha.ca> wrote:
> > > > >
> > > > > > On Mon, Sep 14, 2020 at 6:40 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 14, 2020 at 6:36 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 11 Sep 2020 23:37:55 +0530
> > > > > > > > Ani Sinha <ani@anisinha.ca> wrote:
> > > > > > > >
> > > > > > > > > When acpi hotplug is turned off for both root pci bus as well as for pci
> > > > > > > > > bridges, we should not generate the related amls for DSDT table or initialize
> > > > > > > > > related hw ports or reserve hw resources. This change makes sure all those
> > > > > > > > > operations are turned off in the case acpi pci hotplug is off globally.
> > > > > > > >
> > > > > > > > it still leaves around pure PCI hotplug ACPI code:
> > > > > > > >
> > > > > > > >             Method (PCNT, 0, NotSerialized)
> > > > > > > >             {
> > > > > > > >             }
> > > > > > >
> > > > > > > How do you suggest we fix this?
> > > > > >
> > > > > > One way to fix this would be to do this:
> > > > > >
> > > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > > index 7e3cf3b57b..2bd0c37143 100644
> > > > > > --- a/hw/i386/acpi-build.c
> > > > > > +++ b/hw/i386/acpi-build.c
> > > > > > @@ -483,7 +483,8 @@ static void build_append_pci_bus_devices(Aml
> > > > > > *parent_scope, PCIBus *bus,
> > > > > >              aml_append(method, aml_name("^S%.02X.PCNT", devfn));
> > > > > >          }
> > > > > >      }
> > > > > > -    aml_append(parent_scope, method);
> > > > > > +    if (bsel)
> > > > > > +        aml_append(parent_scope, method);
> > >
> > > and this also introduces mem leak
> > >
> > >
> > > > > >      qobject_unref(bsel);
> > > > > >  }
> > > > > >
> > > > > > This means that if the hotplug on the root bus is disabled, we also
> > > > > > disable PCNT. This will also need the unit test update as the unit
> > > > > Does bridge hot-plug still work if we disable it only on root bus?
> > > >
> > > > Just did a quick test. Windows seems to eject devices on the bridge
> > > > even when the root bus hot plug is off.
> > >
> > > well I'm not sure it works using ACPI hotplug,
> > >
> > > with
> > > -global PIIX4_PM.acpi-root-pci-hotplug=off
> > > -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on
> > >
> > > DSDT ins't what I'd expect when bridge hp is on:
> > >
> > >     Scope (\_SB)
> > >     {
> > >         Scope (PCI0)
> > >         {
> > >             Device (S00)
> > >             {
> > >                 Name (_ADR, Zero)  // _ADR: Address
> > >             }
> > >
> > >             Device (S08)
> >
> > I think you should look for AMLs for Device (S18) because the bridge
> > goes into slot 3.
>
> as you see, there weren't any here. so maybe something else gone wrong
> in earlier patches

Can you send the full command line you are passing? You need to attach
a bridge, then the function will recurse into it.

>
> >
> > >             {
> > >                 Name (_ADR, 0x00010000)  // _ADR: Address
> > >                 Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
> > >                 {
> > >                     Return (Zero)
> > >                 }
> > >
> > >                 Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
> > >                 {
> > >                     Return (Zero)
> > >                 }
> > >
> > >                 Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
> > >                 {
> > >                     Return (Zero)
> > >                 }
> > >             }
> > >         }
> > >     }
> > >
> > >
> > > >
> > > > >
> > > > > > test
> > > > > > will fail with :
> > > > > >
> > > > > > @@ -3113,24 +3113,20 @@
> > > > > >                  Name (_ADR, 0x00010000)  // _ADR: Address
> > > > > >                  Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
> > > > > >                  {
> > > > > >                      Return (Zero)
> > > > > >                  }
> > > > > >
> > > > > >                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
> > > > > >                  {
> > > > > >                      Return (Zero)
> > > > > >                  }
> > > > > >
> > > > > >                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
> > > > > >                  {
> > > > > >                      Return (Zero)
> > > > > >                  }
> > > > > >              }
> > > > > > -
> > > > > > -            Method (PCNT, 0, NotSerialized)
> > > > > > -            {
> > > > > > -            }
> > > > > >          }
> > > > > >      }
> > > > > >  }
> > > > > >
> > > > > > Let's fix this as a separate patch.
> > > > >
> > > > > I'd rather fix up this patch, so it would do what it claims.
> > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > > > > > > > ---
> > > > > > > > >  hw/acpi/piix4.c      |  6 ++++--
> > > > > > > > >  hw/i386/acpi-build.c | 10 ++++++++--
> > > > > > > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > > > > > > > index e6163bb6ce..b70b1f98af 100644
> > > > > > > > > --- a/hw/acpi/piix4.c
> > > > > > > > > +++ b/hw/acpi/piix4.c
> > > > > > > > > @@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> > > > > > > > >                            "acpi-gpe0", GPE_LEN);
> > > > > > > > >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> > > > > > > > >
> > > > > > > > > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > > > > > > > > -                    s->use_acpi_hotplug_bridge);
> > > > > > > > > +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
> > > > > > > > > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > > > > > > > > +                        s->use_acpi_hotplug_bridge);
> > > > > > > > > +    }
> > > > > > > > >
> > > > > > > > >      s->cpu_hotplug_legacy = true;
> > > > > > > > >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > > > > > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > > > > > index e079b686f5..7e3cf3b57b 100644
> > > > > > > > > --- a/hw/i386/acpi-build.c
> > > > > > > > > +++ b/hw/i386/acpi-build.c
> > > > > > > > > @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> > > > > > > > >      bool s3_disabled;
> > > > > > > > >      bool s4_disabled;
> > > > > > > > >      bool pcihp_bridge_en;
> > > > > > > > > +    bool pcihp_root_en;
> > > > > > > > >      uint8_t s4_val;
> > > > > > > > >      AcpiFadtData fadt;
> > > > > > > > >      uint16_t cpu_hp_io_base;
> > > > > > > > > @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> > > > > > > > >      pm->pcihp_bridge_en =
> > > > > > > > >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> > > > > > > > >                                   NULL);
> > > > > > > > > +    pm->pcihp_root_en =
> > > > > > > > > +        object_property_get_bool(obj, "acpi-root-pci-hotplug",
> > > > > > > > > +                                 NULL);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > > > > > > > > @@ -1504,7 +1508,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > > > > > > > >          build_hpet_aml(dsdt);
> > > > > > > > >          build_piix4_isa_bridge(dsdt);
> > > > > > > > >          build_isa_devices_aml(dsdt);
> > > > > > > > > -        build_piix4_pci_hotplug(dsdt);
> > > > > > > > > +        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> > > > > > > > > +            build_piix4_pci_hotplug(dsdt);
> > > > > > > > > +        }
> > > > > > > > >          build_piix4_pci0_int(dsdt);
> > > > > > > > >      } else {
> > > > > > > > >          sb_scope = aml_scope("_SB");
> > > > > > > > > @@ -1698,7 +1704,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > > > > > > > >      crs_range_set_free(&crs_range_set);
> > > > > > > > >
> > > > > > > > >      /* reserve PCIHP resources */
> > > > > > > > > -    if (pm->pcihp_io_len) {
> > > > > > > > > +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> > > > > > > > >          dev = aml_device("PHPR");
> > > > > > > > >          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> > > > > > > > >          aml_append(dev,
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

