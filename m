Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4015C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E67F20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpmjFdOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E67F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIZQ-0001h1-SS
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtI1z-00006m-46
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44480
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtI1v-0005Tx-F1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PxYInzwCH3z7l0MfmFCa4fVlTxXU9LDk0GNP18L/1Y=;
 b=QpmjFdOgkrDBtzZCUwSzv5ioTIL5XbXYtx5WCEq8mlLWNzsFcB5FXmNnYWBmbSS4sIfPbp
 Iigr1N/iXLOboc2OywEfNM6D4mWXCsbgsPgIhbvlvl7xb+F9vz7WQ/U8Rv3rh1aJez7HuM
 em+Eew1FdFC+yp2HjRgBwEPugkM49g0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-w8vyI6RyORmHqM9bwU5mtw-1; Wed, 08 Jul 2020 12:52:30 -0400
X-MC-Unique: w8vyI6RyORmHqM9bwU5mtw-1
Received: by mail-wm1-f71.google.com with SMTP id 65so3525776wmd.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/PxYInzwCH3z7l0MfmFCa4fVlTxXU9LDk0GNP18L/1Y=;
 b=sk0gpueWwLpAwxuZk2wRI8S0WOv1zdlY+rKM9sjIPnkdxK+JhFFcg0DrGwZHjaAntQ
 NMbtrhaKikv0Jy3UdIrDXojKItAMkOvo+S9eO3PFMA46NZyvxsQSh2aVclmpZIdzgrxr
 FRmdVThE/9QL44fgb8R5eeFhULGnmCL7LKjRcNAOMu8CCGZZ8exFQTBy8NDKcmv9oYev
 Mmxb0hurlv6NSDImnROL0oSPXtoerdGqUGOCvkxmtCtwmpiwR6C6GFPL8cHTNdQwucHg
 su/ip/UsYyx3mjer7NO/kiOmYKlPXEZpO3a9+LAZySTLXgQe6DKR/IcaF7QDMDVe3WDP
 3+4g==
X-Gm-Message-State: AOAM5339J5jx3hEyT5Auy1cSXMU97xz0gRJSFHR4sUu7gVMt9nL5hLIF
 /M6cglK2TRylf8dIsQsNsbaCmr64P/E3/Wkhe/idjYAb7QXYTc4DBdNGxTn2tssEZcCOGQFwmjf
 Qwy0BPl91TgJK3v8=
X-Received: by 2002:a1c:e383:: with SMTP id a125mr8688091wmh.11.1594227145694; 
 Wed, 08 Jul 2020 09:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb2PtIp+8ZJo47D7MX02i/QjtRg59/xxlMw2l1pha4e19Ubp6e/z03qTzZfgZhqxviQrVSDg==
X-Received: by 2002:a1c:e383:: with SMTP id a125mr8688053wmh.11.1594227145335; 
 Wed, 08 Jul 2020 09:52:25 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id t4sm616803wmf.4.2020.07.08.09.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 09:52:24 -0700 (PDT)
Date: Wed, 8 Jul 2020 12:52:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 08/20] microvm/acpi: add minimal acpi support
Message-ID: <20200708121614-mutt-send-email-mst@kernel.org>
References: <20200707125356.32450-1-kraxel@redhat.com>
 <20200707125356.32450-9-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200707125356.32450-9-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 07, 2020 at 02:53:44PM +0200, Gerd Hoffmann wrote:
> $subject says all.  Can be controlled using -M microvm,acpi=on/off.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Overall I don't see bugs here. Some comments are bit confusing
and I point that out below. With that addressed:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  hw/i386/acpi-microvm.h    |   8 ++
>  include/hw/i386/microvm.h |   9 ++
>  hw/i386/acpi-microvm.c    | 195 ++++++++++++++++++++++++++++++++++++++
>  hw/i386/microvm.c         |  40 ++++++++
>  hw/i386/Kconfig           |   1 +
>  hw/i386/Makefile.objs     |   1 +
>  6 files changed, 254 insertions(+)
>  create mode 100644 hw/i386/acpi-microvm.h
>  create mode 100644 hw/i386/acpi-microvm.c
> 
> diff --git a/hw/i386/acpi-microvm.h b/hw/i386/acpi-microvm.h
> new file mode 100644
> index 000000000000..dfe853690e15
> --- /dev/null
> +++ b/hw/i386/acpi-microvm.h
> @@ -0,0 +1,8 @@
> +#ifndef HW_I386_ACPI_MICROVM_H
> +#define HW_I386_ACPI_MICROVM_H
> +
> +#include "hw/i386/microvm.h"
> +
> +void acpi_setup_microvm(MicrovmMachineState *mms);
> +
> +#endif
> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> index 03e735723726..b6e0d4395af7 100644
> --- a/include/hw/i386/microvm.h
> +++ b/include/hw/i386/microvm.h
> @@ -24,12 +24,18 @@
>  
>  #include "hw/boards.h"
>  #include "hw/i386/x86.h"
> +#include "hw/acpi/acpi_dev_interface.h"
>  
>  /* Platform virtio definitions */
>  #define VIRTIO_MMIO_BASE      0xfeb00000
>  #define VIRTIO_NUM_TRANSPORTS 8
>  #define VIRTIO_CMDLINE_MAXLEN 64
>  
> +#define GED_MMIO_BASE         0xfea00000
> +#define GED_MMIO_BASE_MEMHP   (GED_MMIO_BASE + 0x100)
> +#define GED_MMIO_BASE_REGS    (GED_MMIO_BASE + 0x200)
> +#define GED_MMIO_IRQ          9
> +
>  /* Machine type options */
>  #define MICROVM_MACHINE_PIT                 "pit"
>  #define MICROVM_MACHINE_PIC                 "pic"
> @@ -58,6 +64,9 @@ typedef struct {
>      /* Machine state */
>      uint32_t virtio_irq_base;
>      bool kernel_cmdline_fixed;
> +    Notifier machine_done;
> +    Notifier powerdown_req;
> +    AcpiDeviceIf *acpi_dev;
>  } MicrovmMachineState;
>  
>  #define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> new file mode 100644
> index 000000000000..6c4178caefee
> --- /dev/null
> +++ b/hw/i386/acpi-microvm.c
> @@ -0,0 +1,195 @@
> +/* Support for generating ACPI tables and passing them to Guests
> + *
> + * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
> + * Copyright (C) 2006 Fabrice Bellard
> + * Copyright (C) 2013 Red Hat Inc
> + *
> + * Author: Michael S. Tsirkin <mst@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +
> +#include "exec/memory.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/acpi/utils.h"
> +#include "hw/boards.h"
> +#include "hw/i386/fw_cfg.h"
> +#include "hw/i386/microvm.h"
> +
> +#include "acpi-common.h"
> +#include "acpi-microvm.h"
> +
> +static void
> +build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
> +                   MicrovmMachineState *mms)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(mms);
> +    Aml *dsdt, *sb_scope, *scope, *pkg;
> +    bool ambiguous;
> +    Object *isabus;
> +
> +    isabus = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
> +    assert(isabus);
> +    assert(!ambiguous);
> +
> +    dsdt = init_aml_allocator();
> +
> +    /* Reserve space for header */
> +    acpi_data_push(dsdt->buf, sizeof(AcpiTableHeader));
> +
> +    sb_scope = aml_scope("_SB");
> +    fw_cfg_add_acpi_dsdt(sb_scope, x86ms->fw_cfg);
> +    isa_build_aml(ISA_BUS(isabus), sb_scope);
> +    build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
> +                  GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
> +    acpi_dsdt_add_power_button(sb_scope);
> +    aml_append(dsdt, sb_scope);
> +
> +    scope = aml_scope("\\");
> +    pkg = aml_package(4);
> +    aml_append(pkg, aml_int(5)); /* SLEEP_CONTROL_REG.SLP_TYP */

I'm not sure what does the comment refer to here.
Does this 5 match
the value IO handler tests against? A macro might make sense then ...

Below is from "7.3.4 System \_Sx states" right?


> +    aml_append(pkg, aml_int(0)); /* ignored */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(scope, aml_name_decl("_S5", pkg));
> +    aml_append(dsdt, scope);
> +
> +    /* copy AML table into ACPI tables blob and patch header there */
> +    g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
> +    build_header(linker, table_data,
> +        (void *)(table_data->data + table_data->len - dsdt->buf->len),
> +        "DSDT", dsdt->buf->len, 2, NULL, NULL);

/* DSDT always uses revision 2 */.


> +    free_aml_allocator();
> +}
> +
> +static void acpi_build_microvm(AcpiBuildTables *tables,
> +                               MicrovmMachineState *mms)
> +{
> +    MachineState *machine = MACHINE(mms);
> +    GArray *table_offsets;
> +    GArray *tables_blob = tables->table_data;
> +    unsigned dsdt, xsdt;
> +    AcpiFadtData pmfadt = {
> +        /*
> +         * minimum version for ACPI_FADT_F_HW_REDUCED_ACPI,
> +         * see acpi spec "4.1 Hardware-Reduced ACPI"

Spec version - I'm guessing ACPI spec 5.0.
And I think here is where you refer to
	Table 5-34 Fixed ACPI Description Table (FADT) Format

> +         */
> +        .rev = 5,
> +        .minor_ver = 1,

So 5.1 I am guessing just copied from virt/arm?
Or do you know why?
If not all we can say is     /* ACPI v5.1 */
like ARM does, rest is guesswork ...

> +
> +        .flags = ((1 << ACPI_FADT_F_HW_REDUCED_ACPI) |
> +                  (1 << ACPI_FADT_F_RESET_REG_SUP)),
> +
> +        /* Table 5-33 FADT Format -- SLEEP_CONTROL_REG */

You need to use the earliest spec version that includes
a specific feature - and document which one it is.
In version 5 table 5-33 is XSDT.

Generally it took me a while to understand this comment.
It makes it look like
one needs to find SLEEP_CONTROL_REG in Table 5-33 
You mean the address refers to SLEEP_CONTROL_REG.
So put the comment near the address pls.


But the main poit is AcpiFadtData actually has nothing to do with
FADT format. It's an abstracted API 


> +        .sleep_ctl = {
> +            .space_id = AML_AS_SYSTEM_MEMORY,
> +            .bit_width = 8,
> +            .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_SLEEP_CTL,
> +        },
> +
> +        /* Table 5-33 FADT Format -- SLEEP_STATUS_REG */
> +        .sleep_sts = {
> +            .space_id = AML_AS_SYSTEM_MEMORY,
> +            .bit_width = 8,
> +            .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_SLEEP_STS,
> +        },
> +
> +        /* Table 5-33 FADT Format -- RESET_REG */
> +        .reset_reg = {
> +            .space_id = AML_AS_SYSTEM_MEMORY,
> +            .bit_width = 8,
> +            .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_RESET,
> +        },
> +
> +        /* Table 5-33 FADT Format -- RESET_VALUE */
> +        .reset_val = ACPI_GED_RESET_VALUE,
> +    };
> +
> +    table_offsets = g_array_new(false, true /* clear */,
> +                                        sizeof(uint32_t));
> +    bios_linker_loader_alloc(tables->linker,
> +                             ACPI_BUILD_TABLE_FILE, tables_blob,
> +                             64 /* Ensure FACS is aligned */,
> +                             false /* high memory */);
> +
> +    dsdt = tables_blob->len;
> +    build_dsdt_microvm(tables_blob, tables->linker, mms);
> +
> +    pmfadt.dsdt_tbl_offset = &dsdt;
> +    pmfadt.xdsdt_tbl_offset = &dsdt;
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_fadt(tables_blob, tables->linker, &pmfadt, NULL, NULL);
> +
> +    acpi_add_table(table_offsets, tables_blob);
> +    acpi_build_madt(tables_blob, tables->linker, X86_MACHINE(machine),
> +                    mms->acpi_dev, false);
> +
> +    xsdt = tables_blob->len;
> +    build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
> +
> +    /* RSDP is in FSEG memory, so allocate it separately */
> +    {
> +        AcpiRsdpData rsdp_data = {
> +            /* Table 5-27 RSDP Structure */

RSDP is since ACPI 2.0, table number there is different.

> +            .revision = 2, /* rev2 needed for xsdt support */
> +            .oem_id = ACPI_BUILD_APPNAME6,
> +            .xsdt_tbl_offset = &xsdt,
> +            .rsdt_tbl_offset = NULL,
> +        };
> +        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
> +    }
> +
> +    /* Cleanup memory that's no longer used. */
> +    g_array_free(table_offsets, true);
> +}
> +
> +static void acpi_build_no_update(void *build_opaque)
> +{
> +    /* nothing, microvm tables don't change at runtime */
> +}
> +
> +void acpi_setup_microvm(MicrovmMachineState *mms)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(mms);
> +    AcpiBuildTables tables;
> +
> +    assert(x86ms->fw_cfg);
> +
> +    if (!x86_machine_is_acpi_enabled(x86ms)) {
> +        return;
> +    }
> +
> +    acpi_build_tables_init(&tables);
> +    acpi_build_microvm(&tables, mms);
> +
> +    /* Now expose it all to Guest */
> +    acpi_add_rom_blob(acpi_build_no_update, NULL,
> +                      tables.table_data,
> +                      ACPI_BUILD_TABLE_FILE,
> +                      ACPI_BUILD_TABLE_MAX_SIZE);
> +    acpi_add_rom_blob(acpi_build_no_update, NULL,
> +                      tables.linker->cmd_blob,
> +                      "etc/table-loader", 0);
> +    acpi_add_rom_blob(acpi_build_no_update, NULL,
> +                      tables.rsdp,
> +                      ACPI_BUILD_RSDP_FILE, 0);
> +
> +    acpi_build_tables_cleanup(&tables, false);
> +}
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index ab6ee6c67b1a..75eca7306b11 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -26,6 +26,8 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
> +#include "acpi-microvm.h"
>  
>  #include "hw/loader.h"
>  #include "hw/irq.h"
> @@ -41,6 +43,8 @@
>  #include "hw/i386/e820_memory_layout.h"
>  #include "hw/i386/fw_cfg.h"
>  #include "hw/virtio/virtio-mmio.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/generic_event_device.h"
>  
>  #include "cpu.h"
>  #include "elf.h"
> @@ -129,6 +133,17 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>      }
>  
>      /* Optional and legacy devices */
> +    if (x86_machine_is_acpi_enabled(x86ms)) {
> +        DeviceState *dev = qdev_new(TYPE_ACPI_GED_X86);
> +        qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
> +        /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, GED_MMIO_BASE_REGS);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                           x86ms->gsi[GED_MMIO_IRQ]);
> +        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +        mms->acpi_dev = ACPI_DEVICE_IF(dev);
> +    }
>  
>      if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
>          qemu_irq *i8259;
> @@ -438,6 +453,26 @@ static void microvm_machine_set_auto_kernel_cmdline(Object *obj, bool value,
>      mms->auto_kernel_cmdline = value;
>  }
>  
> +static void microvm_machine_done(Notifier *notifier, void *data)
> +{
> +    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
> +                                            machine_done);
> +
> +    acpi_setup_microvm(mms);
> +}
> +
> +static void microvm_powerdown_req(Notifier *notifier, void *data)
> +{
> +    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
> +                                            powerdown_req);
> +
> +    if (mms->acpi_dev) {
> +        Object *obj = OBJECT(mms->acpi_dev);
> +        AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
> +        adevc->send_event(mms->acpi_dev, ACPI_POWER_DOWN_STATUS);
> +    }
> +}
> +
>  static void microvm_machine_initfn(Object *obj)
>  {
>      MicrovmMachineState *mms = MICROVM_MACHINE(obj);
> @@ -452,6 +487,11 @@ static void microvm_machine_initfn(Object *obj)
>  
>      /* State */
>      mms->kernel_cmdline_fixed = false;
> +
> +    mms->machine_done.notify = microvm_machine_done;
> +    qemu_add_machine_init_done_notifier(&mms->machine_done);
> +    mms->powerdown_req.notify = microvm_powerdown_req;
> +    qemu_register_powerdown_notifier(&mms->powerdown_req);
>  }
>  
>  static void microvm_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index c93f32f6579d..be746bcb49eb 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -102,6 +102,7 @@ config MICROVM
>      select I8259
>      select MC146818RTC
>      select VIRTIO_MMIO
> +    select ACPI_HW_REDUCED
>  
>  config X86_IOMMU
>      bool
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 622739305882..bbb2fe78f3cd 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -19,3 +19,4 @@ obj-y += kvmvapic.o
>  obj-$(CONFIG_ACPI) += acpi-common.o
>  obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device_x86.o
>  obj-$(CONFIG_PC) += acpi-build.o
> +obj-$(CONFIG_MICROVM) += acpi-microvm.o
> -- 
> 2.18.4


