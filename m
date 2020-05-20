Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DEAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E464A207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0c9QEd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E464A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOtS-00011y-3g
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOp0-0008R6-0b
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:31:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOox-0002Ut-IF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589981502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=259SQf8MsHPnu7kDI97KADrK0adDLm45df22i1hlbp8=;
 b=Q0c9QEd2i6zgdFnEMq6PZ+qXpjGjvEOhQhjyiyEJAHbv8bY88E77hke+TkU75bejGgUWBn
 9r3mc93GPHbZx+s1LE1v6zH/JLdDMfH9+vdrgejk+OOA/9RGF6Q+fRJOTCw1iXVUGISbFr
 mAJKQmua/1w1Zt48yt3JwmMgaBtp51M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-HBaCKbo1NxuKgz4Z5l-2HA-1; Wed, 20 May 2020 09:31:40 -0400
X-MC-Unique: HBaCKbo1NxuKgz4Z5l-2HA-1
Received: by mail-wm1-f71.google.com with SMTP id a206so897176wmh.6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 06:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=259SQf8MsHPnu7kDI97KADrK0adDLm45df22i1hlbp8=;
 b=i+OC8e4pFSOegGcoxS5bFuvL5naYun5ktUGN5js4bQZmg09aYrN7KDC9b+WACBig+C
 niXqb71VZyUED6vfgRUfKFdLjTX1U8njxvKUChj5uPDqhsHW1vnJy5Z7kQiim5q4PT6R
 AX096TUs/O+TyIyaJQOItQZGeYQx5Lz/zbQK+YHq9Wjpv/3Dfm6rOL/S09973dX01fjZ
 xU82GAtjbiHS7Ep/+8AmMMdu5nLtTvF/ohEIujE2krgPtA6OQ6klZ44PAM6/uDA+2A8Q
 5wEAIi2eiSCbaK38zLHJkoQvQKHGxnESeZaD8Frz7XVY/drXpvfSjxpoDazWbBpARcj/
 q7VQ==
X-Gm-Message-State: AOAM5320IOKJkQDNpxpq7HBZTUYK4GyERRf/DpI5PCVghpDVXx7k+Tyb
 QM9B/+WRRbccY8WojraV17+KJRXiFo23gn4Yr2LYjhtUcQfQpk8GjQ26kLSSF6CvZAPSuoy0Q/1
 o2xVaSiBfDCBh7QE=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr4145318wrq.325.1589981499317; 
 Wed, 20 May 2020 06:31:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBKlWdSo6f6MKRiOzDOgrkGKoHANoElGg87T+7oAIr64j747R+4/ODDwdDw907/6AhBmwvJA==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr4145289wrq.325.1589981498973; 
 Wed, 20 May 2020 06:31:38 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n7sm1748446wrj.39.2020.05.20.06.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 06:31:38 -0700 (PDT)
Subject: Re: [PATCH v3 06/22] acpi: create acpi-common.c and move madt code
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4aac4bfc-1701-d181-ba21-ba0cafd12adb@redhat.com>
Date: Wed, 20 May 2020 15:31:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520132003.9492-7-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:19 PM, Gerd Hoffmann wrote:
> We'll need madt support for microvm.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/i386/acpi-common.h |  14 ++++
>   hw/i386/acpi-build.c  | 126 +---------------------------------
>   hw/i386/acpi-common.c | 152 ++++++++++++++++++++++++++++++++++++++++++
>   hw/i386/Makefile.objs |   1 +
>   4 files changed, 170 insertions(+), 123 deletions(-)
>   create mode 100644 hw/i386/acpi-common.h
>   create mode 100644 hw/i386/acpi-common.c
> 
> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
> new file mode 100644
> index 000000000000..c30e461f1854
> --- /dev/null
> +++ b/hw/i386/acpi-common.h
> @@ -0,0 +1,14 @@
> +#ifndef HW_I386_ACPI_COMMON_H
> +#define HW_I386_ACPI_COMMON_H
> +#include "include/hw/acpi/acpi_dev_interface.h"
> +
> +#include "include/hw/acpi/bios-linker-loader.h"
> +#include "include/hw/i386/x86.h"
> +
> +/* Default IOAPIC ID */
> +#define ACPI_BUILD_IOAPIC_ID 0x0
> +
> +void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> +                     X86MachineState *x86ms, AcpiDeviceIf *adev);
> +
> +#endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4f6418d60b05..c0fdd539a640 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -24,6 +24,7 @@
>   #include "qapi/error.h"
>   #include "qapi/qmp/qnum.h"
>   #include "acpi-build.h"
> +#include "acpi-common.h"
>   #include "qemu/bitmap.h"
>   #include "qemu/error-report.h"
>   #include "hw/pci/pci.h"
> @@ -89,9 +90,6 @@
>   #define ACPI_BUILD_DPRINTF(fmt, ...)
>   #endif
>   
> -/* Default IOAPIC ID */
> -#define ACPI_BUILD_IOAPIC_ID 0x0
> -
>   typedef struct AcpiPmInfo {
>       bool s3_disabled;
>       bool s4_disabled;
> @@ -327,124 +325,6 @@ build_facs(GArray *table_data)
>       facs->length = cpu_to_le32(sizeof(*facs));
>   }
>   
> -void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
> -                       const CPUArchIdList *apic_ids, GArray *entry)
> -{
> -    uint32_t apic_id = apic_ids->cpus[uid].arch_id;
> -
> -    /* ACPI spec says that LAPIC entry for non present
> -     * CPU may be omitted from MADT or it must be marked
> -     * as disabled. However omitting non present CPU from
> -     * MADT breaks hotplug on linux. So possible CPUs
> -     * should be put in MADT but kept disabled.
> -     */
> -    if (apic_id < 255) {
> -        AcpiMadtProcessorApic *apic = acpi_data_push(entry, sizeof *apic);
> -
> -        apic->type = ACPI_APIC_PROCESSOR;
> -        apic->length = sizeof(*apic);
> -        apic->processor_id = uid;
> -        apic->local_apic_id = apic_id;
> -        if (apic_ids->cpus[uid].cpu != NULL) {
> -            apic->flags = cpu_to_le32(1);
> -        } else {
> -            apic->flags = cpu_to_le32(0);
> -        }
> -    } else {
> -        AcpiMadtProcessorX2Apic *apic = acpi_data_push(entry, sizeof *apic);
> -
> -        apic->type = ACPI_APIC_LOCAL_X2APIC;
> -        apic->length = sizeof(*apic);
> -        apic->uid = cpu_to_le32(uid);
> -        apic->x2apic_id = cpu_to_le32(apic_id);
> -        if (apic_ids->cpus[uid].cpu != NULL) {
> -            apic->flags = cpu_to_le32(1);
> -        } else {
> -            apic->flags = cpu_to_le32(0);
> -        }
> -    }
> -}
> -
> -static void
> -build_madt(GArray *table_data, BIOSLinker *linker,
> -           X86MachineState *x86ms, AcpiDeviceIf *adev)
> -{
> -    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
> -    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
> -    int madt_start = table_data->len;
> -    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
> -    bool x2apic_mode = false;
> -
> -    AcpiMultipleApicTable *madt;
> -    AcpiMadtIoApic *io_apic;
> -    AcpiMadtIntsrcovr *intsrcovr;
> -    int i;
> -
> -    madt = acpi_data_push(table_data, sizeof *madt);
> -    madt->local_apic_address = cpu_to_le32(APIC_DEFAULT_ADDRESS);
> -    madt->flags = cpu_to_le32(1);
> -
> -    for (i = 0; i < apic_ids->len; i++) {
> -        adevc->madt_cpu(adev, i, apic_ids, table_data);
> -        if (apic_ids->cpus[i].arch_id > 254) {
> -            x2apic_mode = true;
> -        }
> -    }
> -
> -    io_apic = acpi_data_push(table_data, sizeof *io_apic);
> -    io_apic->type = ACPI_APIC_IO;
> -    io_apic->length = sizeof(*io_apic);
> -    io_apic->io_apic_id = ACPI_BUILD_IOAPIC_ID;
> -    io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
> -    io_apic->interrupt = cpu_to_le32(0);
> -
> -    if (x86ms->apic_xrupt_override) {
> -        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
> -        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
> -        intsrcovr->length = sizeof(*intsrcovr);
> -        intsrcovr->source = 0;
> -        intsrcovr->gsi    = cpu_to_le32(2);
> -        intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
> -    }
> -    for (i = 1; i < 16; i++) {
> -#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
> -        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> -            /* No need for a INT source override structure. */
> -            continue;
> -        }
> -        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
> -        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
> -        intsrcovr->length = sizeof(*intsrcovr);
> -        intsrcovr->source = i;
> -        intsrcovr->gsi    = cpu_to_le32(i);
> -        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
> -    }
> -
> -    if (x2apic_mode) {
> -        AcpiMadtLocalX2ApicNmi *local_nmi;
> -
> -        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
> -        local_nmi->type   = ACPI_APIC_LOCAL_X2APIC_NMI;
> -        local_nmi->length = sizeof(*local_nmi);
> -        local_nmi->uid    = 0xFFFFFFFF; /* all processors */
> -        local_nmi->flags  = cpu_to_le16(0);
> -        local_nmi->lint   = 1; /* ACPI_LINT1 */
> -    } else {
> -        AcpiMadtLocalNmi *local_nmi;
> -
> -        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
> -        local_nmi->type         = ACPI_APIC_LOCAL_NMI;
> -        local_nmi->length       = sizeof(*local_nmi);
> -        local_nmi->processor_id = 0xff; /* all processors */
> -        local_nmi->flags        = cpu_to_le16(0);
> -        local_nmi->lint         = 1; /* ACPI_LINT1 */
> -    }
> -
> -    build_header(linker, table_data,
> -                 (void *)(table_data->data + madt_start), "APIC",
> -                 table_data->len - madt_start, 1, NULL, NULL);
> -}
> -
>   static void build_append_pcihp_notify_entry(Aml *method, int slot)
>   {
>       Aml *if_ctx;
> @@ -2533,8 +2413,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       aml_len += tables_blob->len - fadt;
>   
>       acpi_add_table(table_offsets, tables_blob);
> -    build_madt(tables_blob, tables->linker, x86ms,
> -               ACPI_DEVICE_IF(pcms->acpi_dev));
> +    acpi_build_madt(tables_blob, tables->linker, x86ms,
> +                    ACPI_DEVICE_IF(pcms->acpi_dev));
>   
>       vmgenid_dev = find_vmgenid_dev();
>       if (vmgenid_dev) {
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> new file mode 100644
> index 000000000000..5caca16a0b59
> --- /dev/null
> +++ b/hw/i386/acpi-common.c
> @@ -0,0 +1,152 @@
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
> +#include "hw/acpi/utils.h"
> +#include "hw/i386/pc.h"
> +#include "target/i386/cpu.h"
> +
> +#include "acpi-build.h"
> +#include "acpi-common.h"
> +
> +void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
> +                       const CPUArchIdList *apic_ids, GArray *entry)
> +{
> +    uint32_t apic_id = apic_ids->cpus[uid].arch_id;
> +
> +    /* ACPI spec says that LAPIC entry for non present
> +     * CPU may be omitted from MADT or it must be marked
> +     * as disabled. However omitting non present CPU from
> +     * MADT breaks hotplug on linux. So possible CPUs
> +     * should be put in MADT but kept disabled.
> +     */
> +    if (apic_id < 255) {
> +        AcpiMadtProcessorApic *apic = acpi_data_push(entry, sizeof *apic);
> +
> +        apic->type = ACPI_APIC_PROCESSOR;
> +        apic->length = sizeof(*apic);
> +        apic->processor_id = uid;
> +        apic->local_apic_id = apic_id;
> +        if (apic_ids->cpus[uid].cpu != NULL) {
> +            apic->flags = cpu_to_le32(1);
> +        } else {
> +            apic->flags = cpu_to_le32(0);
> +        }
> +    } else {
> +        AcpiMadtProcessorX2Apic *apic = acpi_data_push(entry, sizeof *apic);
> +
> +        apic->type = ACPI_APIC_LOCAL_X2APIC;
> +        apic->length = sizeof(*apic);
> +        apic->uid = cpu_to_le32(uid);
> +        apic->x2apic_id = cpu_to_le32(apic_id);
> +        if (apic_ids->cpus[uid].cpu != NULL) {
> +            apic->flags = cpu_to_le32(1);
> +        } else {
> +            apic->flags = cpu_to_le32(0);
> +        }
> +    }
> +}
> +
> +void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> +                     X86MachineState *x86ms, AcpiDeviceIf *adev)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
> +    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
> +    int madt_start = table_data->len;
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
> +    bool x2apic_mode = false;
> +
> +    AcpiMultipleApicTable *madt;
> +    AcpiMadtIoApic *io_apic;
> +    AcpiMadtIntsrcovr *intsrcovr;
> +    int i;
> +
> +    madt = acpi_data_push(table_data, sizeof *madt);
> +    madt->local_apic_address = cpu_to_le32(APIC_DEFAULT_ADDRESS);
> +    madt->flags = cpu_to_le32(1);
> +
> +    for (i = 0; i < apic_ids->len; i++) {
> +        adevc->madt_cpu(adev, i, apic_ids, table_data);
> +        if (apic_ids->cpus[i].arch_id > 254) {
> +            x2apic_mode = true;
> +        }
> +    }
> +
> +    io_apic = acpi_data_push(table_data, sizeof *io_apic);
> +    io_apic->type = ACPI_APIC_IO;
> +    io_apic->length = sizeof(*io_apic);
> +    io_apic->io_apic_id = ACPI_BUILD_IOAPIC_ID;
> +    io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
> +    io_apic->interrupt = cpu_to_le32(0);
> +
> +    if (x86ms->apic_xrupt_override) {
> +        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
> +        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
> +        intsrcovr->length = sizeof(*intsrcovr);
> +        intsrcovr->source = 0;
> +        intsrcovr->gsi    = cpu_to_le32(2);
> +        intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
> +    }
> +    for (i = 1; i < 16; i++) {
> +#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
> +        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> +            /* No need for a INT source override structure. */
> +            continue;
> +        }
> +        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
> +        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
> +        intsrcovr->length = sizeof(*intsrcovr);
> +        intsrcovr->source = i;
> +        intsrcovr->gsi    = cpu_to_le32(i);
> +        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
> +    }
> +
> +    if (x2apic_mode) {
> +        AcpiMadtLocalX2ApicNmi *local_nmi;
> +
> +        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
> +        local_nmi->type   = ACPI_APIC_LOCAL_X2APIC_NMI;
> +        local_nmi->length = sizeof(*local_nmi);
> +        local_nmi->uid    = 0xFFFFFFFF; /* all processors */
> +        local_nmi->flags  = cpu_to_le16(0);
> +        local_nmi->lint   = 1; /* ACPI_LINT1 */
> +    } else {
> +        AcpiMadtLocalNmi *local_nmi;
> +
> +        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
> +        local_nmi->type         = ACPI_APIC_LOCAL_NMI;
> +        local_nmi->length       = sizeof(*local_nmi);
> +        local_nmi->processor_id = 0xff; /* all processors */
> +        local_nmi->flags        = cpu_to_le16(0);
> +        local_nmi->lint         = 1; /* ACPI_LINT1 */
> +    }
> +
> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + madt_start), "APIC",
> +                 table_data->len - madt_start, 1, NULL, NULL);
> +}
> +
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 8ce1b265335b..6abc74551a72 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -16,4 +16,5 @@ obj-$(CONFIG_VMMOUSE) += vmmouse.o
>   obj-$(CONFIG_PC) += port92.o
>   
>   obj-y += kvmvapic.o
> +obj-$(CONFIG_ACPI) += acpi-common.o
>   obj-$(CONFIG_PC) += acpi-build.o
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


