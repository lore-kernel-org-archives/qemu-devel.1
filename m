Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3699C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CF42063A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyWmL6uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CF42063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWQby-0004V6-V8
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 16:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQZq-0001zX-BZ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:23:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQZo-0001MK-Dc
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588796611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urRxbaEwkHGZkBzOklJwnguPVdZpJSG/TJy7EqQZWL8=;
 b=eyWmL6uvjCUjBAMLC+okK5E3FUOHRMHflGAk0YZ4e8pDIpF/aqNT1bV4h3WElaJGtGaVDp
 8ENdLDvQStrqVknLNWZwbnqecJJ42XVaHp7xUDbLO4g5f5vtLjMyjA3F/rtZ6DLHiWQr2E
 PId0EgaQXMkRv/MC+H+jjwndA7vwXuM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-dbMd217INji_JyQ4IiPCYQ-1; Wed, 06 May 2020 16:23:30 -0400
X-MC-Unique: dbMd217INji_JyQ4IiPCYQ-1
Received: by mail-wr1-f71.google.com with SMTP id 30so1908032wrq.15
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 13:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7CHDA2MfClJT1ewMQFWsuEj5A2IA4sO3+SfzPA41XjY=;
 b=kbAuj2vD2iubMgQe2SIruPwxoXhtRzbsJY/g5yE60hdrBFpkozsTzjeL6Qgf+2FMlf
 /54cic/AH9IOyupfNlNz8bF+wZKa37aGA2L4DbJzNNa05pABlOR2eoP3f3X0Mr5dhLKH
 9X9EFrcQouNEa+pW9zHKgfdK5WQaQTz6TbeHpr1K0qd63tnCe7cRBFv3bgKNLJFRiE5P
 F3I08Aw3wQqaFkCnOfqQ5ym+AjsortlaH/vauifK3NfYfnci7g96gnfre44jNWO6n8L8
 XLXEGpjRPRwy1ilFgce7rJyIgRh4m0vdefz23ByPBNCx60dk90otRCUzPRQdZWEw/ge5
 fVKw==
X-Gm-Message-State: AGi0PubKepeYesmqARzsgutE3PpvhmnmV2DcAPJ54MJHjwk4dEywZYlp
 SDgUnaVPHGIvQf6n6PjfzQG8fNyqQ4exAvKOV9zso4htt7vNJp7Z4MBAITaL9kqX8xj3khQm+FZ
 KyMRSodDJ9uZz95A=
X-Received: by 2002:a7b:c766:: with SMTP id x6mr6527956wmk.142.1588796609017; 
 Wed, 06 May 2020 13:23:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJaps9zwx1oAMIXNTa50JuFXRc9OtfdLT5grh9KOLMkoLE5ptxgYrPc6/l2hdY3ZLd3UOd+TA==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr6527925wmk.142.1588796608706; 
 Wed, 06 May 2020 13:23:28 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 v10sm4431814wrq.45.2020.05.06.13.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 13:23:28 -0700 (PDT)
Date: Wed, 6 May 2020 16:23:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 08/10] ACPI: Record Generic Error Status Block(GESB)
 table
Message-ID: <20200506162320-mutt-send-email-mst@kernel.org>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <20200410114639.32844-9-gengdongjiu@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200410114639.32844-9-gengdongjiu@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
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
Cc: fam@euphon.net, peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, Jonathan.Cameron@huawei.com,
 pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 10, 2020 at 07:46:37PM +0800, Dongjiu Geng wrote:
> kvm_arch_on_sigbus_vcpu() error injection uses source_id as
> index in etc/hardware_errors to find out Error Status Data
> Block entry corresponding to error source. So supported source_id
> values should be assigned here and not be changed afterwards to
> make sure that guest will write error into expected Error Status
> Data Block.
>=20
> Before QEMU writes a new error to ACPI table, it will check whether
> previous error has been acknowledged. If not acknowledged, the new
> errors will be ignored and not be recorded. For the errors section
> type, QEMU simulate it to memory section error.
>=20
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> change since v24:
> 1. Using g_array_append_vals() to replace build_append_int_noprefix() to =
build FRU Text.
> 2. Remove the judgement that judge whether acpi_ged_state is NULL.
> 3. Add le64_to_cpu() to error_block_address
> ---
>  hw/acpi/ghes.c         | 219 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/acpi/ghes.h |   1 +
>  2 files changed, 220 insertions(+)
>=20
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e74af23..a3ab2e4 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -26,6 +26,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/nvram/fw_cfg.h"
> +#include "qemu/uuid.h"
> =20
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> @@ -43,6 +44,36 @@
>  #define GAS_ADDR_OFFSET 4
> =20
>  /*
> + * The total size of Generic Error Data Entry
> + * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> + * Table 18-343 Generic Error Data Entry
> + */
> +#define ACPI_GHES_DATA_LENGTH               72
> +
> +/* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
> +#define ACPI_GHES_MEM_CPER_LENGTH           80
> +
> +/* Masks for block_status flags */
> +#define ACPI_GEBS_UNCORRECTABLE         1
> +
> +/*
> + * Total size for Generic Error Status Block except Generic Error Data E=
ntries
> + * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
> + * Table 18-380 Generic Error Status Block
> + */
> +#define ACPI_GHES_GESB_SIZE                 20
> +
> +/*
> + * Values for error_severity field
> + */
> +enum AcpiGenericErrorSeverity {
> +    ACPI_CPER_SEV_RECOVERABLE =3D 0,
> +    ACPI_CPER_SEV_FATAL =3D 1,
> +    ACPI_CPER_SEV_CORRECTED =3D 2,
> +    ACPI_CPER_SEV_NONE =3D 3,
> +};
> +
> +/*
>   * Hardware Error Notification
>   * ACPI 4.0: 17.3.2.7 Hardware Error Notification
>   * Composes dummy Hardware Error Notification descriptor of specified ty=
pe
> @@ -73,6 +104,138 @@ static void build_ghes_hw_error_notification(GArray =
*table, const uint8_t type)
>  }
> =20
>  /*
> + * Generic Error Data Entry
> + * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> + */
> +static void acpi_ghes_generic_error_data(GArray *table,
> +                const uint8_t *section_type, uint32_t error_severity,
> +                uint8_t validation_bits, uint8_t flags,
> +                uint32_t error_data_length, QemuUUID fru_id,
> +                uint64_t time_stamp)
> +{
> +    const uint8_t fru_text[20] =3D {0};
> +
> +    /* Section Type */
> +    g_array_append_vals(table, section_type, 16);
> +
> +    /* Error Severity */
> +    build_append_int_noprefix(table, error_severity, 4);
> +    /* Revision */
> +    build_append_int_noprefix(table, 0x300, 2);
> +    /* Validation Bits */
> +    build_append_int_noprefix(table, validation_bits, 1);
> +    /* Flags */
> +    build_append_int_noprefix(table, flags, 1);
> +    /* Error Data Length */
> +    build_append_int_noprefix(table, error_data_length, 4);
> +
> +    /* FRU Id */
> +    g_array_append_vals(table, fru_id.data, ARRAY_SIZE(fru_id.data));
> +
> +    /* FRU Text */
> +    g_array_append_vals(table, fru_text, sizeof(fru_text));
> +
> +    /* Timestamp */
> +    build_append_int_noprefix(table, time_stamp, 8);
> +}
> +
> +/*
> + * Generic Error Status Block
> + * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> + */
> +static void acpi_ghes_generic_error_status(GArray *table, uint32_t block=
_status,
> +                uint32_t raw_data_offset, uint32_t raw_data_length,
> +                uint32_t data_length, uint32_t error_severity)
> +{
> +    /* Block Status */
> +    build_append_int_noprefix(table, block_status, 4);
> +    /* Raw Data Offset */
> +    build_append_int_noprefix(table, raw_data_offset, 4);
> +    /* Raw Data Length */
> +    build_append_int_noprefix(table, raw_data_length, 4);
> +    /* Data Length */
> +    build_append_int_noprefix(table, data_length, 4);
> +    /* Error Severity */
> +    build_append_int_noprefix(table, error_severity, 4);
> +}
> +
> +/* UEFI 2.6: N.2.5 Memory Error Section */
> +static void acpi_ghes_build_append_mem_cper(GArray *table,
> +                                            uint64_t error_physical_addr=
)
> +{
> +    /*
> +     * Memory Error Record
> +     */
> +
> +    /* Validation Bits */
> +    build_append_int_noprefix(table,
> +                              (1ULL << 14) | /* Type Valid */
> +                              (1ULL << 1) /* Physical Address Valid */,
> +                              8);
> +    /* Error Status */
> +    build_append_int_noprefix(table, 0, 8);
> +    /* Physical Address */
> +    build_append_int_noprefix(table, error_physical_addr, 8);
> +    /* Skip all the detailed information normally found in such a record=
 */
> +    build_append_int_noprefix(table, 0, 48);
> +    /* Memory Error Type */
> +    build_append_int_noprefix(table, 0 /* Unknown error */, 1);
> +    /* Skip all the detailed information normally found in such a record=
 */
> +    build_append_int_noprefix(table, 0, 7);
> +}
> +
> +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> +                                      uint64_t error_physical_addr)
> +{
> +    GArray *block;
> +
> +    /* Memory Error Section Type */
> +    const uint8_t uefi_cper_mem_sec[] =3D
> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +                  0xED, 0x7C, 0x83, 0xB1);
> +
> +    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> +     * Table 17-13 Generic Error Data Entry
> +     */
> +    QemuUUID fru_id =3D {};
> +    uint32_t data_length;
> +
> +    block =3D g_array_new(false, true /* clear */, 1);
> +
> +    /* This is the length if adding a new generic error data entry*/
> +    data_length =3D ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> +
> +    /*
> +     * Check whether it will run out of the preallocated memory if addin=
g a new
> +     * generic error data entry
> +     */
> +    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LEN=
GTH) {
> +        error_report("Not enough memory to record new CPER!!!");
> +        g_array_free(block, true);
> +        return -1;
> +    }
> +
> +    /* Build the new generic error status block header */
> +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> +        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> +
> +    /* Build this new generic error data entry header */
> +    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
> +        ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> +        ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
> +
> +    /* Build the memory section CPER for above new generic error data en=
try */
> +    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_address, block->data, block->l=
en);
> +
> +    g_array_free(block, true);
> +
> +    return 0;
> +}
> +
> +/*
>   * Build table for the hardware error fw_cfg blob.
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cf=
g blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
> @@ -227,3 +390,59 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgS=
tate *s,
>      fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, N=
ULL,
>          NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>  }
> +
> +int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address=
)
> +{
> +    uint64_t error_block_addr, read_ack_register_addr, read_ack_register=
 =3D 0;
> +    uint64_t start_addr;
> +    bool ret =3D -1;
> +    AcpiGedState *acpi_ged_state;
> +    AcpiGhesState *ags;
> +
> +    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +
> +    acpi_ged_state =3D ACPI_GED(object_resolve_path_type("", TYPE_ACPI_G=
ED,
> +                                                       NULL));
> +    g_assert(acpi_ged_state);
> +    ags =3D &acpi_ged_state->ghes_state;
> +
> +    start_addr =3D le64_to_cpu(ags->ghes_addr_le);
> +
> +    if (physical_address) {
> +
> +        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> +            start_addr +=3D source_id * sizeof(uint64_t);
> +        }
> +
> +        cpu_physical_memory_read(start_addr, &error_block_addr,
> +                                 sizeof(error_block_addr));
> +
> +        error_block_addr =3D le64_to_cpu(error_block_addr);
> +
> +        read_ack_register_addr =3D start_addr +
> +            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +
> +        cpu_physical_memory_read(read_ack_register_addr,
> +                                 &read_ack_register, sizeof(read_ack_reg=
ister));
> +
> +        /* zero means OSPM does not acknowledge the error */
> +        if (!read_ack_register) {
> +                error_report("OSPM does not acknowledge previous error,"
> +                    " so can not record CPER for current error anymore")=
;
> +        } else if (error_block_addr) {
> +                read_ack_register =3D cpu_to_le64(0);
> +                /*
> +                 * Clear the Read Ack Register, OSPM will write it to 1 =
when
> +                 * it acknowledges this error.
> +                 */
> +                cpu_physical_memory_write(read_ack_register_addr,
> +                    &read_ack_register, sizeof(uint64_t));
> +
> +                ret =3D acpi_ghes_record_mem_error(error_block_addr,
> +                                                 physical_address);
> +        } else
> +                error_report("can not find Generic Error Status Block");
> +    }
> +
> +    return ret;
> +}
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index a3420fc..4ad025e 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -70,4 +70,5 @@ void build_ghes_error_table(GArray *hardware_errors, BI=
OSLinker *linker);
>  void acpi_build_hest(GArray *table_data, BIOSLinker *linker);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr=
);
>  #endif
> --=20
> 1.8.3.1


