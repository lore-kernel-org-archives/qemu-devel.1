Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5A2C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D850B208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="xqooq6Gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D850B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoja-0000xZ-TG
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHohQ-0007Ha-FJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:39:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHohO-0002Mf-D4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:39:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id s13so53880wmh.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yGmGxf8grFZjjX3TEFZ6Jg41CydbPSE7Iqt38ASlNP8=;
 b=xqooq6GznQNWfYocAFG9/hQNlAa49x+e3QupzZFfjyRBPxskHpkvhl6nWZHJT5LI1W
 M9LBWIGd0JEm9aLV1DYI/thcboEqR8wM4UmFli9TZvKc+133gTOpH7iWLDFwbIKhMFyK
 7ZUhSIk19ieWLaydbJXpXnOMlSoIIFUI5+1yV8486+quBqIwq/yYRU2KKrBT2KVvTwp1
 p8dsLR6QP1yArUcln0j20mLRSAvCNDEAoTMaHdUZ553UtdiOrLYgIiYwnQ+y0C9GPc1W
 iZU4RM7yuAT4mTx+oJ2Q0vA9WL/aKix4DKubqbJ7yxdwsqQu6kseRUg7JYDqeytq+spE
 3o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yGmGxf8grFZjjX3TEFZ6Jg41CydbPSE7Iqt38ASlNP8=;
 b=od/n7/qeqBo03ZY7wSBf+8kFuhLpv8KKchtBBKXB5k0YZVVGGBxzHYYwUFHefm7/vF
 /ttWxasfZvSaPo9yjEYSvKUOhQwvyepn5OKBfzLh8U0Z1l8EO5kNViuz9nVRIOSknh+8
 h7PryAulOzRBLqENad+z86ARDaCUksTMizQabserf8lQQ1RZJQsnv/FySq41OH7aiqjK
 /nrAz2+xds1Nev0nEjkrK5uWuDQ09J7eeXOuk2micF8Qsl8jk5Lw1bl6q6jwgmZVMVla
 JXZBqIzqq7oNUOFcsGVV6QJno10hgipmP38kjYur633d/AwWocH6C290t7TMI+O9gucw
 oOpQ==
X-Gm-Message-State: AOAM532gn2K2ENaht9I/X7VYtHL/yZGmAUISrfE/pv9MrDLxMsVyUgdv
 Itjqwc5/TJcyVgNIJis5BI0SGuEqAFXangDswXPRJQ==
X-Google-Smtp-Source: ABdhPJxHJSxs3vQF10fTa5KaYISc2W4gFGTE6LvbHsnGO7MiGK/BnVOqtfCFw7TlASMOO3r143fZsVSRrUh2+lL++AU=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr15162431wmc.35.1600090753017; 
 Mon, 14 Sep 2020 06:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-9-ani@anisinha.ca>
 <20200914150550.23a91fa2@redhat.com>
In-Reply-To: <20200914150550.23a91fa2@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 14 Sep 2020 19:09:01 +0530
Message-ID: <CAARzgwy+B4t+uo23Qea0D4rRPVJj6ptcu+PHSXYfQaqcit391A@mail.gmail.com>
Subject: Re: [PATCH 9/9] piix4: don't reserve hw resources when hotplug is off
 globally
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
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

On Mon, Sep 14, 2020 at 6:36 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri, 11 Sep 2020 23:37:55 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > When acpi hotplug is turned off for both root pci bus as well as for pci
> > bridges, we should not generate the related amls for DSDT table or initialize
> > related hw ports or reserve hw resources. This change makes sure all those
> > operations are turned off in the case acpi pci hotplug is off globally.
>
> it still leaves around pure PCI hotplug ACPI code:
>
>             Method (PCNT, 0, NotSerialized)
>             {
>             }

How about this comment?
" Add unconditionally for root since DSDT expects it."

Can this method then be removed when bsel is absent for the root bus?

> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  hw/acpi/piix4.c      |  6 ++++--
> >  hw/i386/acpi-build.c | 10 ++++++++--
> >  2 files changed, 12 insertions(+), 4 deletions(-)
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
> > index e079b686f5..7e3cf3b57b 100644
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
> > @@ -1504,7 +1508,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
> > @@ -1698,7 +1704,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >      crs_range_set_free(&crs_range_set);
> >
> >      /* reserve PCIHP resources */
> > -    if (pm->pcihp_io_len) {
> > +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> >          dev = aml_device("PHPR");
> >          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> >          aml_append(dev,
>

