Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB3C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D33206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWfJsCOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D33206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWQaA-0002IC-Rf
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 16:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQZL-0000vM-1F
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:23:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQZK-0000QD-0C
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588796581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/ObwQ1RFID5R7iZCyofm7qpj9fhpkONcsF9allmGd4=;
 b=EWfJsCOsuS4v8ar957tePFmFh38oZ5canxHzqFAU9Kv8Ezbh/RJ/mRqHEaX4tS56IHp2Pn
 f6WfhE5XGBMMQsC2g8jZ6zh5982W8myDn4T61HPgzSE/hIQP9WcNtAGpTaR7y+hL75/gtE
 qa6TBS8gewr0I4oPXLiosGIRMiEWfjo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-CRgiN_keOtKDcfeeaqsBCw-1; Wed, 06 May 2020 16:22:57 -0400
X-MC-Unique: CRgiN_keOtKDcfeeaqsBCw-1
Received: by mail-wr1-f72.google.com with SMTP id u4so1914797wrm.13
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 13:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+hoxZl5uTNpLSt0fv2HP1uBte8+65KVUGGnMGYBnbn8=;
 b=UVSC5MO9aIz+Whfa8gsNt9D3gt2NZnd/3mv/phSrTAVSdzvKsMZOXgwXvciuylsWll
 u7EUScYAJDWtAqMpj5joOnOvAsGui8pR7aIMAdqxghaWfO/ILNeiAhSiotpWVAzW9beu
 7/PDn5BKFHxRh6TbORKZWLNc9+oydkVm5hBMeNcYQKm848PXXeGxEkXM9f3hNSHiMkR/
 LsW+A5sqr36Vc2DhrbYSGxjr+E/qlW5dEkJnAorCWhLuUTx49Rm2xEDOemLSJ7cisdCN
 j299PZcisqihvKjWPdG/2Cv2EXnruPqwE6wIgfAHKG0gM+8pYtc8/8BWC2tQqwlFt5ac
 4XOQ==
X-Gm-Message-State: AGi0PuYc34cAzKqV/1XlDbnbCu4TzPQhpti8PPTEQRspREGkJ39hBVYA
 rwaOOJOiUXoo22X9BU0iQevjPqYzj5wuGfJOxuFdG7urthQHq1MczriUQMA74YvrWWp58m+zpIZ
 9sU21tP/uWjmgMIk=
X-Received: by 2002:a1c:1f83:: with SMTP id f125mr5986713wmf.150.1588796576726; 
 Wed, 06 May 2020 13:22:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAdZZr7TXBFoiPYDyzQjZ2JTIIKBmmZCQgHhZzn3DRvI1ks08+KZo+Z1cftAVxMFRL2pTr6A==
X-Received: by 2002:a1c:1f83:: with SMTP id f125mr5986657wmf.150.1588796576246; 
 Wed, 06 May 2020 13:22:56 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 n6sm4550205wrs.81.2020.05.06.13.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 13:22:55 -0700 (PDT)
Date: Wed, 6 May 2020 16:22:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 05/10] ACPI: Build Hardware Error Source Table
Message-ID: <20200506162246-mutt-send-email-mst@kernel.org>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <20200410114639.32844-6-gengdongjiu@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200410114639.32844-6-gengdongjiu@huawei.com>
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

On Fri, Apr 10, 2020 at 07:46:34PM +0800, Dongjiu Geng wrote:
> This patch builds Hardware Error Source Table(HEST) via fw_cfg blobs.
> Now it only supports ARMv8 SEA, a type of Generic Hardware Error
> Source version 2(GHESv2) error source. Afterwards, we can extend
> the supported types if needed. For the CPER section, currently it
> is memory section because kernel mainly wants userspace to handle
> the memory errors.
>=20
> This patch follows the spec ACPI 6.2 to build the Hardware Error
> Source table. For more detailed information, please refer to
> document: docs/specs/acpi_hest_ghes.rst
>=20
> build_ghes_hw_error_notification() helper will help to add Hardware
> Error Notification to ACPI tables without using packed C structures
> and avoid endianness issues as API doesn't need explicit conversion.
>=20
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> change since v24:
> 1. Add acpi_add_table() before acpi_build_hest()
> 2. Pass NULL for oem_table_id in build_header() to build Hardware
>    Error Source Table header
> ---
>  hw/acpi/ghes.c           | 126 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/arm/virt-acpi-build.c |   2 +
>  include/hw/acpi/ghes.h   |  39 +++++++++++++++
>  3 files changed, 167 insertions(+)
>=20
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e1b3f8f..091fd87 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -23,6 +23,7 @@
>  #include "qemu/units.h"
>  #include "hw/acpi/ghes.h"
>  #include "hw/acpi/aml-build.h"
> +#include "qemu/error-report.h"
> =20
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> @@ -33,6 +34,42 @@
>  /* Now only support ARMv8 SEA notification type error source */
>  #define ACPI_GHES_ERROR_SOURCE_COUNT        1
> =20
> +/* Generic Hardware Error Source version 2 */
> +#define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> +
> +/* Address offset in Generic Address Structure(GAS) */
> +#define GAS_ADDR_OFFSET 4
> +
> +/*
> + * Hardware Error Notification
> + * ACPI 4.0: 17.3.2.7 Hardware Error Notification
> + * Composes dummy Hardware Error Notification descriptor of specified ty=
pe
> + */
> +static void build_ghes_hw_error_notification(GArray *table, const uint8_=
t type)
> +{
> +    /* Type */
> +    build_append_int_noprefix(table, type, 1);
> +    /*
> +     * Length:
> +     * Total length of the structure in bytes
> +     */
> +    build_append_int_noprefix(table, 28, 1);
> +    /* Configuration Write Enable */
> +    build_append_int_noprefix(table, 0, 2);
> +    /* Poll Interval */
> +    build_append_int_noprefix(table, 0, 4);
> +    /* Vector */
> +    build_append_int_noprefix(table, 0, 4);
> +    /* Switch To Polling Threshold Value */
> +    build_append_int_noprefix(table, 0, 4);
> +    /* Switch To Polling Threshold Window */
> +    build_append_int_noprefix(table, 0, 4);
> +    /* Error Threshold Value */
> +    build_append_int_noprefix(table, 0, 4);
> +    /* Error Threshold Window */
> +    build_append_int_noprefix(table, 0, 4);
> +}
> +
>  /*
>   * Build table for the hardware error fw_cfg blob.
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cf=
g blobs.
> @@ -87,3 +124,92 @@ void build_ghes_error_table(GArray *hardware_errors, =
BIOSLinker *linker)
>      bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_=
FILE,
>          0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
>  }
> +
> +/* Build Generic Hardware Error Source version 2 (GHESv2) */
> +static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker =
*linker)
> +{
> +    uint64_t address_offset;
> +    /*
> +     * Type:
> +     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> +     */
> +    build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR=
_V2, 2);
> +    /* Source Id */
> +    build_append_int_noprefix(table_data, source_id, 2);
> +    /* Related Source Id */
> +    build_append_int_noprefix(table_data, 0xffff, 2);
> +    /* Flags */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Enabled */
> +    build_append_int_noprefix(table_data, 1, 1);
> +
> +    /* Number of Records To Pre-allocate */
> +    build_append_int_noprefix(table_data, 1, 4);
> +    /* Max Sections Per Record */
> +    build_append_int_noprefix(table_data, 1, 4);
> +    /* Max Raw Data Length */
> +    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH,=
 4);
> +
> +    address_offset =3D table_data->len;
> +    /* Error Status Address */
> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
> +                     4 /* QWord access */, 0);
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
> +        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
> +
> +    switch (source_id) {
> +    case ACPI_HEST_SRC_ID_SEA:
> +        /*
> +         * Notification Structure
> +         * Now only enable ARMv8 SEA notification type
> +         */
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SE=
A);
> +        break;
> +    default:
> +        error_report("Not support this error source");
> +        abort();
> +    }
> +
> +    /* Error Status Block Length */
> +    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH,=
 4);
> +
> +    /*
> +     * Read Ack Register
> +     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
> +     * version 2 (GHESv2 - Type 10)
> +     */
> +    address_offset =3D table_data->len;
> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
> +                     4 /* QWord access */, 0);
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +        address_offset + GAS_ADDR_OFFSET,
> +        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> +        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
> +
> +    /*
> +     * Read Ack Preserve field
> +     * We only provide the first bit in Read Ack Register to OSPM to wri=
te
> +     * while the other bits are preserved.
> +     */
> +    build_append_int_noprefix(table_data, ~0x1ULL, 8);
> +    /* Read Ack Write */
> +    build_append_int_noprefix(table_data, 0x1, 8);
> +}
> +
> +/* Build Hardware Error Source Table */
> +void acpi_build_hest(GArray *table_data, BIOSLinker *linker)
> +{
> +    uint64_t hest_start =3D table_data->len;
> +
> +    /* Hardware Error Source Table header*/
> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    /* Error Source Count */
> +    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, =
4);
> +
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +
> +    build_header(linker, table_data, (void *)(table_data->data + hest_st=
art),
> +        "HEST", table_data->len - hest_start, 1, NULL, NULL);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index cc6ffcd..f611bce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -820,6 +820,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuild=
Tables *tables)
> =20
>      if (vms->ras) {
>          build_ghes_error_table(tables->hardware_errors, tables->linker);
> +        acpi_add_table(table_offsets, tables_blob);
> +        acpi_build_hest(tables_blob, tables->linker);
>      }
> =20
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 50379b0..18debd8 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -24,5 +24,44 @@
> =20
>  #include "hw/acpi/bios-linker-loader.h"
> =20
> +/*
> + * Values for Hardware Error Notification Type field
> + */
> +enum AcpiGhesNotifyType {
> +    /* Polled */
> +    ACPI_GHES_NOTIFY_POLLED =3D 0,
> +    /* External Interrupt */
> +    ACPI_GHES_NOTIFY_EXTERNAL =3D 1,
> +    /* Local Interrupt */
> +    ACPI_GHES_NOTIFY_LOCAL =3D 2,
> +    /* SCI */
> +    ACPI_GHES_NOTIFY_SCI =3D 3,
> +    /* NMI */
> +    ACPI_GHES_NOTIFY_NMI =3D 4,
> +    /* CMCI, ACPI 5.0: 18.3.2.7, Table 18-290 */
> +    ACPI_GHES_NOTIFY_CMCI =3D 5,
> +    /* MCE, ACPI 5.0: 18.3.2.7, Table 18-290 */
> +    ACPI_GHES_NOTIFY_MCE =3D 6,
> +    /* GPIO-Signal, ACPI 6.0: 18.3.2.7, Table 18-332 */
> +    ACPI_GHES_NOTIFY_GPIO =3D 7,
> +    /* ARMv8 SEA, ACPI 6.1: 18.3.2.9, Table 18-345 */
> +    ACPI_GHES_NOTIFY_SEA =3D 8,
> +    /* ARMv8 SEI, ACPI 6.1: 18.3.2.9, Table 18-345 */
> +    ACPI_GHES_NOTIFY_SEI =3D 9,
> +    /* External Interrupt - GSIV, ACPI 6.1: 18.3.2.9, Table 18-345 */
> +    ACPI_GHES_NOTIFY_GSIV =3D 10,
> +    /* Software Delegated Exception, ACPI 6.2: 18.3.2.9, Table 18-383 */
> +    ACPI_GHES_NOTIFY_SDEI =3D 11,
> +    /* 12 and greater are reserved */
> +    ACPI_GHES_NOTIFY_RESERVED =3D 12
> +};
> +
> +enum {
> +    ACPI_HEST_SRC_ID_SEA =3D 0,
> +    /* future ids go here */
> +    ACPI_HEST_SRC_ID_RESERVED,
> +};
> +
>  void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)=
;
> +void acpi_build_hest(GArray *table_data, BIOSLinker *linker);
>  #endif
> --=20
> 1.8.3.1


