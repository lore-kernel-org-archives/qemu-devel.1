Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C87C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BBA20728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul89oCHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BBA20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMFD-0002ao-AF
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isMDw-0001R7-O0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isMDv-0001Rx-Ba
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:39:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58497)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isMDv-0001RM-8M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579246758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nh7yv0mjswrLZeLywZrBbXl5YC5cViXMUU6z3ixDojA=;
 b=Ul89oCHrM4CM8CEqkZzLZC2s/jpppsrx6efgA9A7DpYotMspApkU5s/d18JX4biIfq8bkX
 t4jdZwn3kzP6xEBg9NuuZh04fwhGigtiwEg/b9Xzu3wSAdL2qFZU5S9xZqOrrRHH4kEiXU
 +6eSQF8j3t5J7EcmjTioycV6gax7HUI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-HT-RauaOPCudrjwXNgKRHA-1; Fri, 17 Jan 2020 02:39:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id m133so946168wmf.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 23:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nh7yv0mjswrLZeLywZrBbXl5YC5cViXMUU6z3ixDojA=;
 b=L/o66ZfISTk2NeH3YBLmc5iRfHrHgGIRIOVUujDHNmPZ/Q0gpI798CgpUn3i2Lpg1A
 QCtudL9H/pLMxD1S7gqd6wBdE8f5mWIZ/dFpre2VwfB9Z2dkoEljVulc9SDJcnhnqrTa
 2k68fiay/jKcpr1QQyXhhctZcYEoAZA3C85Ofz0Qd5xOpi12cUOmBfRmthpA7wa12lmZ
 StarB8bqPorUVCpf8+wlzPSjWX6pO60mQU0E6vdeNRwmDVC7UHEpbVBeN76RleQLlVd2
 nbWDubFemg7GL0BP3G8fF1R/RnkmuSD0lTa6CjiSGMez5cIt2oeruDJaoqeZrjV/cQHt
 exQA==
X-Gm-Message-State: APjAAAX8pNAeCjmEZMMUoDcZJumVKpz8u+O0FhZVws5zx5lndaRTNeTP
 Yg3d7p+F9Vo4826A9gYgSqXDn1mqG8RuXjWLrkVwwE4fCxQAwiTgsLwFTZxF9ZPUWyHlGh+USUE
 Z9OTailb0dYOwEhM=
X-Received: by 2002:a05:600c:507:: with SMTP id
 i7mr3170095wmc.135.1579246755592; 
 Thu, 16 Jan 2020 23:39:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRVFnR13Fkw0BE1sDnOhJiDJN/oCQphmpWIBvF0NM2QbH26ylIP418+RxRX4md8J07H6jY0Q==
X-Received: by 2002:a05:600c:507:: with SMTP id
 i7mr3170057wmc.135.1579246755221; 
 Thu, 16 Jan 2020 23:39:15 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c2sm32946759wrp.46.2020.01.16.23.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 23:39:14 -0800 (PST)
Subject: Re: [PATCH v22 5/9] ACPI: Record the Generic Error Status Block
 address
To: Dongjiu Geng <gengdongjiu@huawei.com>, pbonzini@redhat.com,
 mst@redhat.com, imammedo@redhat.com, shannon.zhaosl@gmail.com,
 peter.maydell@linaro.org, fam@euphon.net, rth@twiddle.net,
 ehabkost@redhat.com, mtosatti@redhat.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, james.morse@arm.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11c62b51-7a94-5e34-39c6-60c5e989a63b@redhat.com>
Date: Fri, 17 Jan 2020 08:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
Content-Language: en-US
X-MC-Unique: HT-RauaOPCudrjwXNgKRHA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: zhengxiang9@huawei.com, linuxarm@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 12:32 PM, Dongjiu Geng wrote:
> Record the GHEB address via fw_cfg file, when recording
> a error to CPER, it will use this address to find out
> Generic Error Data Entries and write the error.
> 
> Make the HEST GHES to a GED device.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>   hw/acpi/generic_event_device.c         | 15 ++++++++++++++-
>   hw/acpi/ghes.c                         | 16 ++++++++++++++++
>   hw/arm/virt-acpi-build.c               | 13 ++++++++++++-
>   include/hw/acpi/generic_event_device.h |  2 ++
>   include/hw/acpi/ghes.h                 |  6 ++++++
>   5 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 9cee90c..9bf37e4 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -234,12 +234,25 @@ static const VMStateDescription vmstate_ged_state = {
>       }
>   };
>   
> +static const VMStateDescription vmstate_ghes_state = {
> +    .name = "acpi-ghes-state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_acpi_ged = {
>       .name = "acpi-ged",
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .fields = (VMStateField[]) {
> -        VMSTATE_STRUCT(ged_state, AcpiGedState, 1, vmstate_ged_state, GEDState),
> +        VMSTATE_STRUCT(ged_state, AcpiGedState, 1,
> +                       vmstate_ged_state, GEDState),
> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> +                       vmstate_ghes_state, AcpiGhesState),
>           VMSTATE_END_OF_LIST(),
>       },
>       .subsections = (const VMStateDescription * []) {
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 9d37798..68f4abf 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -23,6 +23,7 @@
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/ghes.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "sysemu/sysemu.h"
>   #include "qemu/error-report.h"
> @@ -208,3 +209,18 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>       build_header(linker, table_data, (void *)(table_data->data + hest_start),
>           "HEST", table_data->len - hest_start, 1, NULL, "");
>   }
> +
> +void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> +                            GArray *hardware_error)
> +{
> +    size_t size = 2 * sizeof(uint64_t) + ACPI_GHES_MAX_RAW_DATA_LENGTH;
> +    size_t request_block_size = ACPI_GHES_ERROR_SOURCE_COUNT * size;
> +
> +    /* Create a read-only fw_cfg file for GHES */
> +    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
> +                    request_block_size);
> +
> +    /* Create a read-write fw_cfg file for Address */
> +    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 837bbf9..c8aa94d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -797,6 +797,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       unsigned dsdt, xsdt;
>       GArray *tables_blob = tables->table_data;
>       MachineState *ms = MACHINE(vms);
> +    AcpiGedState *acpi_ged_state;
>   
>       table_offsets = g_array_new(false, true /* clear */,
>                                           sizeof(uint32_t));
> @@ -831,7 +832,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       acpi_add_table(table_offsets, tables_blob);
>       build_spcr(tables_blob, tables->linker, vms);
>   
> -    if (vms->ras) {
> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));

Testing vms->ras first is cheaper than calling 
object_resolve_path_type(). Since some people are spending lot of time 
to reduce VM boot time, it might be worth considering.

> +    if (acpi_ged_state &&  vms->ras) {
>           acpi_add_table(table_offsets, tables_blob);
>           build_ghes_error_table(tables->hardware_errors, tables->linker);
>           acpi_build_hest(tables_blob, tables->hardware_errors,
> @@ -925,6 +928,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>   {
>       AcpiBuildTables tables;
>       AcpiBuildState *build_state;
> +    AcpiGedState *acpi_ged_state;
>   
>       if (!vms->fw_cfg) {
>           trace_virt_acpi_setup();
> @@ -955,6 +959,13 @@ void virt_acpi_setup(VirtMachineState *vms)
>       fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
>                       acpi_data_len(tables.tcpalog));
>   
> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +    if (acpi_ged_state && vms->ras) {
> +        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
> +                             vms->fw_cfg, tables.hardware_errors);
> +    }
> +
>       build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
>                                                build_state, tables.rsdp,
>                                                ACPI_BUILD_RSDP_FILE, 0);
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d157eac..037d2b5 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -61,6 +61,7 @@
>   
>   #include "hw/sysbus.h"
>   #include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/ghes.h"
>   
>   #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>   
> @@ -95,6 +96,7 @@ typedef struct AcpiGedState {
>       GEDState ged_state;
>       uint32_t ged_event_bitmap;
>       qemu_irq irq;
> +    AcpiGhesState ghes_state;
>   } AcpiGedState;
>   
>   void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 09a7f86..a6761e6 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -60,7 +60,13 @@ enum {
>       ACPI_HEST_SRC_ID_RESERVED,
>   };
>   
> +typedef struct AcpiGhesState {
> +    uint64_t ghes_addr_le;
> +} AcpiGhesState;
> +
>   void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
>   void acpi_build_hest(GArray *table_data, GArray *hardware_error,
>                             BIOSLinker *linker);
> +void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
> +                          GArray *hardware_errors);
>   #endif
> 


