Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9106CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7B020874
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUo1aajj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7B020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJFeS-0001xt-3L
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJFcq-0001FM-5j
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:36:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJFcm-00049I-I9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600432582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMqOVnb1CthWeZcwXUh/YENp5loyAxRq8E8qDkVNFEo=;
 b=LUo1aajjpu0e4qQnQsJr+kZYvw9kv0Fmz8VGIJ9eX3A+lRZjJPUCIAq0V+XINNgTngHM0W
 XbrjQ/Z9XoTIcq+2+zA2aU4BrSL0TWeNnpclPBIesILjINdInHe/6V3YKMqbfl9VUENjje
 HUWSd6tpdHQMrl6W5GSnbtXb206mE5M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-_nPpfLxVOqOW3Sb4y0R8DQ-1; Fri, 18 Sep 2020 08:36:20 -0400
X-MC-Unique: _nPpfLxVOqOW3Sb4y0R8DQ-1
Received: by mail-wm1-f69.google.com with SMTP id b14so1422319wmj.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 05:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nMqOVnb1CthWeZcwXUh/YENp5loyAxRq8E8qDkVNFEo=;
 b=WQfUzhNQhVkOiNuP8LiayAhtwFXsjR5SgGTOp7jYjWGXIiI2I7FyV0RX3gZ+pEwAOV
 HXZ5yAyDFhukpD7fCdxhogEH1J7OwJ22Sx1biNZF3auYFfH7JFxsrDy0ww9WA8HbBcNn
 1b51kD+kpr1n8heFUKiyZzX//sFvzejfPPR6yiRRY4LGE+V+g6rK9YhZBmPNw/FYIMRD
 E4wMCUvQQamDeJeLmLYXb75heyauC/2hzM6ZVxRrC9mG+lb5f2VhRubmRcrOCCcryL7j
 e0UpVmBm2wQNubBfb8eCYLjEQjKw/vE46Ff7wFCxXe9tEIGmrOfugtdnlY/RtSgC9gJz
 XycQ==
X-Gm-Message-State: AOAM531HH/FoLitlU8PVcX3Z1PHAYhj584WV9clViv5n1xRvMWXL6jGJ
 UvFhIQbXHT/pd4iNB6p8cPqOAaAtkT4QIHNmwXLdNrh6W+PNYzqoDfZX87DEImoanzR7Wv3GP96
 lgdcayTalGLBm5OE=
X-Received: by 2002:a5d:4388:: with SMTP id i8mr37344055wrq.365.1600432578065; 
 Fri, 18 Sep 2020 05:36:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys1oV6cygONCJILwawwoCmYQP4w0/e99JWjHLQAuugBrGTkMyUAryOm7ooHRm82T5LDYdxAw==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr37344011wrq.365.1600432577644; 
 Fri, 18 Sep 2020 05:36:17 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id l10sm4679966wru.59.2020.09.18.05.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 05:36:16 -0700 (PDT)
Date: Fri, 18 Sep 2020 08:36:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] microvm: add pcie support
Message-ID: <20200918083533-mutt-send-email-mst@kernel.org>
References: <20200918121911.5194-1-kraxel@redhat.com>
 <20200918121911.5194-3-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918121911.5194-3-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 05:23:37
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 02:19:11PM +0200, Gerd Hoffmann wrote:
> Uses the existing gpex device which is also used as pcie host bridge on
> arm/aarch64.  For now only a 32bit mmio window and no ioport support.
> 
> It is disabled by default, use "-machine microvm,pcie=on" to enable.
> ACPI support must be enabled too because the bus is declared in the
> DSDT table.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Can we do the reverse and only support a 64 bit window?
32 bit resources are a pain, we support them on x86 for purposes
of legacy guests ...

> ---
>  include/hw/i386/microvm.h |  16 +++-
>  hw/i386/acpi-microvm.c    | 163 ++++++++++++++++++++++++++++++++++++++
>  hw/i386/microvm.c         |  71 +++++++++++++++++
>  hw/i386/Kconfig           |   1 +
>  4 files changed, 247 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> index 27eadd6c535c..a3bb7a05d705 100644
> --- a/include/hw/i386/microvm.h
> +++ b/include/hw/i386/microvm.h
> @@ -42,10 +42,10 @@
>   *   9     |  acpi      | acpi (ged)
>   *  10     |  pci lnk   |
>   *  11     |  pci lnk   |
> - *  12     |  ps2       |
> - *  13     |  fpu       |
> - *  14     |  ide 0     |
> - *  15     |  ide 1     |
> + *  12     |  ps2       | pcie
> + *  13     |  fpu       | pcie
> + *  14     |  ide 0     | pcie
> + *  15     |  ide 1     | pcie
>   *  16-23  |  pci gsi   | virtio
>   */
>  
> @@ -59,10 +59,17 @@
>  #define GED_MMIO_BASE_REGS    (GED_MMIO_BASE + 0x200)
>  #define GED_MMIO_IRQ          9
>  
> +#define PCIE_MMIO_BASE        0xc0000000
> +#define PCIE_MMIO_SIZE        0x20000000
> +#define PCIE_ECAM_BASE        0xe0000000
> +#define PCIE_ECAM_SIZE        0x10000000
> +#define PCIE_IRQ_BASE         12
> +
>  /* Machine type options */
>  #define MICROVM_MACHINE_PIT                 "pit"
>  #define MICROVM_MACHINE_PIC                 "pic"
>  #define MICROVM_MACHINE_RTC                 "rtc"
> +#define MICROVM_MACHINE_PCIE                "pcie"
>  #define MICROVM_MACHINE_ISA_SERIAL          "isa-serial"
>  #define MICROVM_MACHINE_OPTION_ROMS         "x-option-roms"
>  #define MICROVM_MACHINE_AUTO_KERNEL_CMDLINE "auto-kernel-cmdline"
> @@ -81,6 +88,7 @@ struct MicrovmMachineState {
>      OnOffAuto pic;
>      OnOffAuto pit;
>      OnOffAuto rtc;
> +    OnOffAuto pcie;
>      bool isa_serial;
>      bool option_roms;
>      bool auto_kernel_cmdline;
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index df39c5d3bd90..2e8367a6c039 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -33,6 +33,8 @@
>  #include "hw/boards.h"
>  #include "hw/i386/fw_cfg.h"
>  #include "hw/i386/microvm.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pcie_host.h"
>  #include "hw/virtio/virtio-mmio.h"
>  
>  #include "acpi-common.h"
> @@ -87,6 +89,166 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>      }
>  }
>  
> +static void acpi_dsdt_add_pci(Aml *scope, MicrovmMachineState *mms)
> +{
> +    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
> +    int i, slot_no;
> +    hwaddr base_mmio = PCIE_MMIO_BASE;
> +    hwaddr size_mmio = PCIE_MMIO_SIZE;
> +    hwaddr base_ecam = PCIE_ECAM_BASE;
> +    hwaddr size_ecam = PCIE_ECAM_SIZE;
> +    int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
> +
> +    if (mms->pcie != ON_OFF_AUTO_ON) {
> +        return;
> +    }
> +
> +    Aml *dev = aml_device("%s", "PCI0");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> +    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> +    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
> +    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +
> +    /* Declare the PCI Routing Table. */
> +    Aml *rt_pkg = aml_varpackage(PCI_SLOT_MAX * PCI_NUM_PINS);
> +    for (slot_no = 0; slot_no < PCI_SLOT_MAX; slot_no++) {
> +        for (i = 0; i < PCI_NUM_PINS; i++) {
> +            int gsi = (i + slot_no) % PCI_NUM_PINS;
> +            Aml *pkg = aml_package(4);
> +            aml_append(pkg, aml_int((slot_no << 16) | 0xFFFF));
> +            aml_append(pkg, aml_int(i));
> +            aml_append(pkg, aml_name("GSI%d", gsi));
> +            aml_append(pkg, aml_int(0));
> +            aml_append(rt_pkg, pkg);
> +        }
> +    }
> +    aml_append(dev, aml_name_decl("_PRT", rt_pkg));
> +
> +    /* Create GSI link device */
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        uint32_t irqs =  PCIE_IRQ_BASE + i;
> +        Aml *dev_gsi = aml_device("GSI%d", i);
> +        aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F")));
> +        aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
> +        crs = aml_resource_template();
> +        aml_append(crs,
> +                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> +                                 AML_EXCLUSIVE, &irqs, 1));
> +        aml_append(dev_gsi, aml_name_decl("_PRS", crs));
> +        crs = aml_resource_template();
> +        aml_append(crs,
> +                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> +                                 AML_EXCLUSIVE, &irqs, 1));
> +        aml_append(dev_gsi, aml_name_decl("_CRS", crs));
> +        method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
> +        aml_append(dev_gsi, method);
> +        aml_append(dev, dev_gsi);
> +    }
> +
> +    method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_return(aml_int(base_ecam)));
> +    aml_append(dev, method);
> +
> +    method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
> +    Aml *rbuf = aml_resource_template();
> +    aml_append(rbuf,
> +        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
> +                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
> +                            nr_pcie_buses));
> +    aml_append(rbuf,
> +        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_mmio,
> +                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
> +
> +    aml_append(method, aml_return(rbuf));
> +    aml_append(dev, method);
> +
> +    /* Declare an _OSC (OS Control Handoff) method */
> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> +    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> +    aml_append(method,
> +        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> +
> +    /* PCI Firmware Specification 3.0
> +     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
> +     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
> +     * identified by the Universal Unique IDentifier (UUID)
> +     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
> +     */
> +    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
> +    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
> +    aml_append(ifctx,
> +        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> +    aml_append(ifctx,
> +        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> +    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
> +    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> +
> +    /*
> +     * Allow OS control for all 5 features:
> +     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
> +     */
> +    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
> +                              aml_name("CTRL")));
> +
> +    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
> +                              aml_name("CDW1")));
> +    aml_append(ifctx, ifctx1);
> +
> +    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
> +                              aml_name("CDW1")));
> +    aml_append(ifctx, ifctx1);
> +
> +    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
> +    aml_append(ifctx, aml_return(aml_arg(3)));
> +    aml_append(method, ifctx);
> +
> +    elsectx = aml_else();
> +    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
> +                               aml_name("CDW1")));
> +    aml_append(elsectx, aml_return(aml_arg(3)));
> +    aml_append(method, elsectx);
> +    aml_append(dev, method);
> +
> +    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> +
> +    /* PCI Firmware Specification 3.0
> +     * 4.6.1. _DSM for PCI Express Slot Information
> +     * The UUID in _DSM in this context is
> +     * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
> +     */
> +    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
> +    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
> +    ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
> +    uint8_t byte_list[1] = {1};
> +    buf = aml_buffer(1, byte_list);
> +    aml_append(ifctx1, aml_return(buf));
> +    aml_append(ifctx, ifctx1);
> +    aml_append(method, ifctx);
> +
> +    byte_list[0] = 0;
> +    buf = aml_buffer(1, byte_list);
> +    aml_append(method, aml_return(buf));
> +    aml_append(dev, method);
> +
> +    Aml *dev_res0 = aml_device("%s", "RES0");
> +    aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
> +    crs = aml_resource_template();
> +    aml_append(crs,
> +        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_ecam,
> +                         base_ecam + size_ecam - 1, 0x0000, size_ecam));
> +    aml_append(dev_res0, aml_name_decl("_CRS", crs));
> +    aml_append(dev, dev_res0);
> +    aml_append(scope, dev);
> +}
> +
>  static void
>  build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>                     MicrovmMachineState *mms)
> @@ -112,6 +274,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>                    GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
>      acpi_dsdt_add_power_button(sb_scope);
>      acpi_dsdt_add_virtio(sb_scope, mms);
> +    acpi_dsdt_add_pci(sb_scope, mms);
>      aml_append(dsdt, sb_scope);
>  
>      /* ACPI 5.0: Table 7-209 System State Package */
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 60d32722301f..7223f52046d1 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -46,6 +46,7 @@
>  #include "hw/virtio/virtio-mmio.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/generic_event_device.h"
> +#include "hw/pci-host/gpex.h"
>  
>  #include "cpu.h"
>  #include "elf.h"
> @@ -101,6 +102,47 @@ static void microvm_gsi_handler(void *opaque, int n, int level)
>      qemu_set_irq(s->ioapic_irq[n], level);
>  }
>  
> +static void create_pcie(MicrovmMachineState *mms)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(mms);
> +    hwaddr base_mmio = PCIE_MMIO_BASE;
> +    hwaddr size_mmio = PCIE_MMIO_SIZE;
> +    hwaddr base_ecam = PCIE_ECAM_BASE;
> +    hwaddr size_ecam = PCIE_ECAM_SIZE;
> +    MemoryRegion *mmio_alias;
> +    MemoryRegion *mmio_reg;
> +    MemoryRegion *ecam_alias;
> +    MemoryRegion *ecam_reg;
> +    DeviceState *dev;
> +    int i;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    /* Map only the first size_ecam bytes of ECAM space */
> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, size_ecam);
> +    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
> +
> +    /* Map the MMIO window into system address space so as to expose
> +     * the section of PCI MMIO space which starts at the same base address
> +     * (ie 1:1 mapping for that part of PCI MMIO space visible through
> +     * the window).
> +     */
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, base_mmio, size_mmio);
> +    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> +                           x86ms->gsi[PCIE_IRQ_BASE + i]);
> +    }
> +}
> +
>  static void microvm_devices_init(MicrovmMachineState *mms)
>  {
>      X86MachineState *x86ms = X86_MACHINE(mms);
> @@ -147,6 +189,10 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>          x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
>      }
>  
> +    if (x86_machine_is_acpi_enabled(x86ms) && mms->pcie == ON_OFF_AUTO_ON) {
> +        create_pcie(mms);
> +    }
> +
>      if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
>          qemu_irq *i8259;
>  
> @@ -446,6 +492,23 @@ static void microvm_machine_set_rtc(Object *obj, Visitor *v, const char *name,
>      visit_type_OnOffAuto(v, name, &mms->rtc, errp);
>  }
>  
> +static void microvm_machine_get_pcie(Object *obj, Visitor *v, const char *name,
> +                                     void *opaque, Error **errp)
> +{
> +    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
> +    OnOffAuto pcie = mms->pcie;
> +
> +    visit_type_OnOffAuto(v, name, &pcie, errp);
> +}
> +
> +static void microvm_machine_set_pcie(Object *obj, Visitor *v, const char *name,
> +                                     void *opaque, Error **errp)
> +{
> +    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
> +
> +    visit_type_OnOffAuto(v, name, &mms->pcie, errp);
> +}
> +
>  static bool microvm_machine_get_isa_serial(Object *obj, Error **errp)
>  {
>      MicrovmMachineState *mms = MICROVM_MACHINE(obj);
> @@ -521,6 +584,7 @@ static void microvm_machine_initfn(Object *obj)
>      mms->pic = ON_OFF_AUTO_AUTO;
>      mms->pit = ON_OFF_AUTO_AUTO;
>      mms->rtc = ON_OFF_AUTO_AUTO;
> +    mms->pcie = ON_OFF_AUTO_AUTO;
>      mms->isa_serial = true;
>      mms->option_roms = true;
>      mms->auto_kernel_cmdline = true;
> @@ -587,6 +651,13 @@ static void microvm_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
>          "Enable MC146818 RTC");
>  
> +    object_class_property_add(oc, MICROVM_MACHINE_PCIE, "OnOffAuto",
> +                              microvm_machine_get_pcie,
> +                              microvm_machine_set_pcie,
> +                              NULL, NULL);
> +    object_class_property_set_description(oc, MICROVM_MACHINE_PCIE,
> +        "Enable PCIe");
> +
>      object_class_property_add_bool(oc, MICROVM_MACHINE_ISA_SERIAL,
>                                     microvm_machine_get_isa_serial,
>                                     microvm_machine_set_isa_serial);
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index d0bd8b537d55..32aa15533bd8 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -104,6 +104,7 @@ config MICROVM
>      select MC146818RTC
>      select VIRTIO_MMIO
>      select ACPI_HW_REDUCED
> +    select PCI_EXPRESS_GENERIC_BRIDGE
>  
>  config X86_IOMMU
>      bool
> -- 
> 2.27.0


