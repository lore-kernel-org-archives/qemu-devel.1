Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28046C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58B820772
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIADu7yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Ij-0004T3-SN
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k59Hc-0003pD-Bv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:00:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57299
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k59HZ-0003Wu-99
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597071611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbH9/v2RuXftC33JyeykbD4HUXi5HgGzB5mMPQjU20c=;
 b=GIADu7yDDb61Pj1Ww/0se9GnOUy2NbYbITtXTnPjyPkK79Be11ifTgbOT84Eh2KA1TJy9n
 roTFPQ0LZ/89quFDK6oI51SlXBc9l+i16Vofou40hIn9ooqTFlXd6DrhdRmggclAZfAZ7O
 4GEFmOouQkim6Y3zwGUVBPqDqGkO+Wk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-7v96JKjDPW-7dfAQqjuTgA-1; Mon, 10 Aug 2020 11:00:08 -0400
X-MC-Unique: 7v96JKjDPW-7dfAQqjuTgA-1
Received: by mail-wr1-f72.google.com with SMTP id t3so4326376wrr.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 08:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=95mnLdmWeIVwDSHAZEZeq7LiupMexgcVT3gxsohTicA=;
 b=hMcVGsF8vlFjAX6yjYIPJsfwHVD0daWc8azbyGO1kfShSm6IDY434DKvd6BbT8P6nv
 VRLhYrcJYbg4V68k48uJ5ZEcvs/Ox2ENzM8D7bSMfaFJDvK1MGePvRthGqyKvJ0bPL0w
 9QnnT6G06SL5y5i3S79iD1LHbpMk3Ce8FXFdI8Tm7d8PDH22nNdPlLDRjUx//eDzPKBY
 xJGYcigVLbe88IFnlFj1Au54z6LwYXdVJVqj9/T6QBD0uuJRE1kQAwMZ5C+zJl3xLQK7
 JYRG83aimvgyTgUXZSLZzfjCAPBcmvftC474NIxLlbWa8ir1gVnO36pxoNW0qmcsEqFb
 +ypg==
X-Gm-Message-State: AOAM531udAwZNS511WxCbfAwnaK68KfLQWZrh06BS2tCNLjZMumSLrc2
 GPnUUpHNvYz+1IeQRbuh/2gXkYi+BKswUkf8aY8zUdxFzibhrH6jb3gIlmvkesF1lVjjH20TT4L
 QI713CPoz8RdtaKQ=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr26757066wrs.124.1597071606853; 
 Mon, 10 Aug 2020 08:00:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNSSPHIBp/SoluA22vacx338ktx5aHKT5HGB2dtGpRBHwwXbHlB7heK2EqjB6b0P4gEsuHqw==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr26757033wrs.124.1597071606569; 
 Mon, 10 Aug 2020 08:00:06 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
 by smtp.gmail.com with ESMTPSA id
 n18sm22065186wrw.45.2020.08.10.08.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 08:00:05 -0700 (PDT)
Date: Mon, 10 Aug 2020 11:00:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH] Introduce global piix flag to disable PCI hotplug
Message-ID: <20200810105634-mutt-send-email-mst@kernel.org>
References: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
 <20200810104602-mutt-send-email-mst@kernel.org>
 <CAARzgwwsuzw9rcQzu3MF7KZO8F+0PHMs3hCsiSPJCXJS-dEkhw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwwsuzw9rcQzu3MF7KZO8F+0PHMs3hCsiSPJCXJS-dEkhw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 08:24:53PM +0530, Ani Sinha wrote:
> 
> 
> On Mon, Aug 10, 2020 at 8:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Mon, Aug 10, 2020 at 04:59:41PM +0530, Ani Sinha wrote:
>     > We introduce a new global flag for PIIX with which we can
>     > turn on or off PCI device hotplug. This flag can be used
>     > to prevent all PCI devices from getting hotplugged/unplugged
>     > on the PCI bus. The new options disables all hotpluh HW
>     > initialization code as well as the ACPI AMLs.
>     >
>     > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> 
>     Well we have a flag like this for pci bridges, right?
>     So all that's left is an option to disable hotplug
>     for the pci root, right?
>     Wouldn't that be better than disabling it globally?
> 
> 
> The idea is to have just one option to disable all hotplug globally. But if you
> want to have two flags one for the bridges and one for the pci root, we can
> certainly look into it.
> 

I can certainly see the attraction of a global flag.

However, with the interface we have for bridges right now, how are we
going to resolve the conflict if hotplug is disabled globally but
enabled for a given bridge?

A reasonable way would be to change the default value for bridges,
have a user-specified value override it.
This patch doesn't do it, though.




> 
> 
>     > ---
>     >  hw/acpi/piix4.c      |  8 ++++++--
>     >  hw/i386/acpi-build.c | 20 ++++++++++++++------
>     >  2 files changed, 20 insertions(+), 8 deletions(-)
>     >
>     > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>     > index 26bac4f..8b13e86 100644
>     > --- a/hw/acpi/piix4.c
>     > +++ b/hw/acpi/piix4.c
>     > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>     > 
>     >      AcpiPciHpState acpi_pci_hotplug;
>     >      bool use_acpi_hotplug_bridge;
>     > +    bool use_acpi_pci_hotplug;
>     > 
>     >      uint8_t disable_s3;
>     >      uint8_t disable_s4;
>     > @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init
>     (MemoryRegion *parent,
>     >                            "acpi-gpe0", GPE_LEN);
>     >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>     > 
>     > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
>     > -                    s->use_acpi_hotplug_bridge);
>     > +    if (s->use_acpi_pci_hotplug)
>     > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
>     > +                        s->use_acpi_hotplug_bridge);
>     > 
>     >      s->cpu_hotplug_legacy = true;
>     >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
>     > @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
>     >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>     >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support",
>     PIIX4PMState,
>     >                       use_acpi_hotplug_bridge, true),
>     > +    DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
>     > +                     use_acpi_pci_hotplug, true),
>     >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>     >                       acpi_memory_hotplug.is_enabled, true),
>     >      DEFINE_PROP_END_OF_LIST(),
>     > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>     > index b7bcbbb..343b9b6 100644
>     > --- a/hw/i386/acpi-build.c
>     > +++ b/hw/i386/acpi-build.c
>     > @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>     >      bool s3_disabled;
>     >      bool s4_disabled;
>     >      bool pcihp_bridge_en;
>     > +    bool pcihp_en;
>     >      uint8_t s4_val;
>     >      AcpiFadtData fadt;
>     >      uint16_t cpu_hp_io_base;
>     > @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine,
>     AcpiPmInfo *pm)
>     >      pm->pcihp_bridge_en =
>     >          object_property_get_bool(obj,
>     "acpi-pci-hotplug-with-bridge-support",
>     >                                   NULL);
>     > +    pm->pcihp_en =
>     > +        object_property_get_bool(obj, "acpi-pci-hotplug", NULL);
>     > +
>     >  }
>     > 
>     >  static void acpi_get_misc_info(AcpiMiscInfo *info)
>     > @@ -337,14 +341,16 @@ static void build_append_pcihp_notify_entry(Aml
>     *method, int slot)
>     >  }
>     > 
>     >  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>     > -                                         bool pcihp_bridge_en)
>     > +                                         bool pcihp_bridge_en, bool
>     pcihp_en)
>     >  {
>     >      Aml *dev, *notify_method = NULL, *method;
>     > -    QObject *bsel;
>     > +    QObject *bsel = NULL;
>     >      PCIBus *sec;
>     >      int i;
>     > 
>     > -    bsel = object_property_get_qobject(OBJECT(bus),
>     ACPI_PCIHP_PROP_BSEL, NULL);
>     > +    if (pcihp_en)
>     > +        bsel = object_property_get_qobject(OBJECT(bus),
>     > +                                           ACPI_PCIHP_PROP_BSEL, NULL);
>     >      if (bsel) {
>     >          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>     > 
>     > @@ -439,7 +445,8 @@ static void build_append_pci_bus_devices(Aml
>     *parent_scope, PCIBus *bus,
>     >               */
>     >              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>     > 
>     > -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
>     > +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
>     > +                                         pcihp_en);
>     >          }
>     >          /* slot descriptor has been composed, add it into parent context
>     */
>     >          aml_append(parent_scope, dev);
>     > @@ -468,7 +475,7 @@ static void build_append_pci_bus_devices(Aml
>     *parent_scope, PCIBus *bus,
>     >      }
>     > 
>     >      /* Notify about child bus events in any case */
>     > -    if (pcihp_bridge_en) {
>     > +    if (pcihp_bridge_en && pcihp_en) {
>     >          QLIST_FOREACH(sec, &bus->child, sibling) {
>     >              int32_t devfn = sec->parent_dev->devfn;
>     > 
>     > @@ -1818,7 +1825,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>     >          if (bus) {
>     >              Aml *scope = aml_scope("PCI0");
>     >              /* Scan all PCI buses. Generate tables to support hotplug. *
>     /
>     > -            build_append_pci_bus_devices(scope, bus, pm->
>     pcihp_bridge_en);
>     > +            build_append_pci_bus_devices(scope, bus, pm->
>     pcihp_bridge_en,
>     > +                                         pm->pcihp_en);
>     > 
>     >              if (TPM_IS_TIS_ISA(tpm)) {
>     >                  if (misc->tpm_version == TPM_VERSION_2_0) {
>     > --
>     > 2.7.4
> 
> 


