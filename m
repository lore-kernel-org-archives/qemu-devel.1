Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B42C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F06820661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEvHH6vY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F06820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyFX-000115-Cx
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVy8I-0001yz-LL
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:01:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVy8D-0003Ky-Hw
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588687268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1s0r4SR6wcmENpppBztkVy4Z3DaKBeeEgvOm2Z8Ir3s=;
 b=AEvHH6vYvQ+7o7kabFUhReWKfI6L6N1NaMqFL1QI3yDxCsZYnES8uxAz3AHAJrUSB3J8/S
 u/tOLWewvtIT682NuxKhdKoZCb5TOvNOpuxuKZelzWQlSPniwVoVIk7Zj/N8Oa12aCjhYS
 53j7tPJO0o4fwNy0xh6M7Nsp8MqUq4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-87p_v0agPZig9YccwlzNtw-1; Tue, 05 May 2020 10:01:06 -0400
X-MC-Unique: 87p_v0agPZig9YccwlzNtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4F9A83DB79;
 Tue,  5 May 2020 14:01:01 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F47260BEC;
 Tue,  5 May 2020 14:00:56 +0000 (UTC)
Date: Tue, 5 May 2020 16:00:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 02/13] acpi: create acpi-common.c and move madt code
Message-ID: <20200505160054.41df87dc@redhat.com>
In-Reply-To: <20200505134305.22666-3-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-3-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 15:42:54 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

maybe add here that's it's going to be reused by microvm, hence the movement

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-common.h |  14 ++++
>  hw/i386/acpi-build.c  | 126 +---------------------------------
>  hw/i386/acpi-common.c | 152 ++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/Makefile.objs |   1 +
>  4 files changed, 170 insertions(+), 123 deletions(-)
>  create mode 100644 hw/i386/acpi-common.h
>  create mode 100644 hw/i386/acpi-common.c
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
> index fe60c10201ad..eb530e5cd56d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -24,6 +24,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qnum.h"
>  #include "acpi-build.h"
> +#include "acpi-common.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci/pci.h"
> @@ -89,9 +90,6 @@
>  #define ACPI_BUILD_DPRINTF(fmt, ...)
>  #endif
>  
> -/* Default IOAPIC ID */
> -#define ACPI_BUILD_IOAPIC_ID 0x0
> -
>  typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
> @@ -327,124 +325,6 @@ build_facs(GArray *table_data)
>      facs->length = cpu_to_le32(sizeof(*facs));
>  }
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
>  static void build_append_pcihp_notify_entry(Aml *method, int slot)
>  {
>      Aml *if_ctx;
> @@ -2560,8 +2440,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      aml_len += tables_blob->len - fadt;
>  
>      acpi_add_table(table_offsets, tables_blob);
> -    build_madt(tables_blob, tables->linker, x86ms,
> -               ACPI_DEVICE_IF(pcms->acpi_dev));
> +    acpi_build_madt(tables_blob, tables->linker, x86ms,
> +                    ACPI_DEVICE_IF(pcms->acpi_dev));
>  
>      vmgenid_dev = find_vmgenid_dev();
>      if (vmgenid_dev) {
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
>  obj-$(CONFIG_PC) += port92.o
>  
>  obj-y += kvmvapic.o
> +obj-$(CONFIG_ACPI) += acpi-common.o
>  obj-$(CONFIG_PC) += acpi-build.o


