Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E0EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364D72063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsQD1mNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364D72063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDHq-000857-I7
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jhDGv-0007Cx-Sy
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:24:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jhDGu-0000Uh-Og
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591367075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIoeKzcvR1ihbrU9BSAyQRwVMeqNeuleWlAOknvpIKA=;
 b=TsQD1mNHbPuyUveB/u2PeVJh7vtUdzI62BcKmjtfGjTOYmy92C8yLKV+VCerFl0iQa3VwT
 b7hGUomTe1YMWQhTaqAbNoDPIRNFFacuUWlU8iutyl/ZcpN8kaUAQuFej7oTIi0OP3Q3h7
 12ms4hbliKnL7bi4ikJEYU2BDs4PLFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-pS6mNctmMwqjmMAc1ScyDA-1; Fri, 05 Jun 2020 10:24:32 -0400
X-MC-Unique: pS6mNctmMwqjmMAc1ScyDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AF61100CCD6;
 Fri,  5 Jun 2020 14:24:13 +0000 (UTC)
Received: from localhost (unknown [10.40.208.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD1A5FC1B;
 Fri,  5 Jun 2020 14:24:00 +0000 (UTC)
Date: Fri, 5 Jun 2020 16:23:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/4] acpi: Convert build_tpm2() to build_append* API
Message-ID: <20200605162357.407dff93@redhat.com>
In-Reply-To: <20200601095737.32671-2-eric.auger@redhat.com>
References: <20200601095737.32671-1-eric.auger@redhat.com>
 <20200601095737.32671-2-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 eric.auger.pro@gmail.com, lersek@redhat.com, ardb@kernel.org,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  1 Jun 2020 11:57:34 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> In preparation of its move to the generic acpi code,
> let's convert build_tpm2() to use build_append API. This
> latter now is prefered in place of direct ACPI struct field
> settings with manual endianness conversion.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/i386/acpi-build.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b5669d6c65..f0d35d7b17 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2298,30 +2298,40 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>  static void
>  build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>  {
> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
> +    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));

>      unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
>      unsigned log_addr_offset =
>          (char *)&tpm2_ptr->log_area_start_address - table_data->data;

Is this the reason why you've kept Acpi20TPM2 around?


> +    uint8_t start_method_params[12] = {};
>  
> -    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> +    /* platform class */
pls verbatim filed names from spec in comments

> +    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
> +    /* reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
>      if (TPM_IS_TIS_ISA(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(0);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
> +        /* address of control area */
> +        build_append_int_noprefix(table_data, 0, 8);
> +        /* start method */
> +        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
>      } else if (TPM_IS_CRB(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);

missing field name comments

> +        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
> +        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
>      } else {
>          g_warn_if_reached();
>      }

considering fields are the same I'd also restructure above as
    if () {
       control_area_address = 
       start_method =
    ...
    }
    /* address of control area */
    build_append_int_noprefix(table_data, control_area_address, 8);
    /* start method */
    build_append_int_noprefix(table_data, start_method, 4); 

which is bit easier to read 
    
>  
> -    tpm2_ptr->log_area_minimum_length =
> -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> +    /* platform specific parameters */
> +    g_array_append_vals(table_data, &start_method_params, 12);
>  
> -    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
> +    /* log area minimum length */
> +    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
> +
> +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
>      bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
>                               false);

I suggest to drop Acpi20TPM2 with pointer math above and use approach similar
to build_ghes_v2/address_offset, i.e. get actual offest here:

      log_addr_offset = table_data->len

and s/log_addr_size/8/

>      /* log area start address to be filled by Guest linker */
> +    build_append_int_noprefix(table_data, 0, 8);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     log_addr_offset, log_addr_size,
>                                     ACPI_BUILD_TPMLOG_FILE, 0);


