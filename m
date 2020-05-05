Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D010C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B38120675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFCtTeBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B38120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyIn-0004kC-8B
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyHt-0003t7-Qi
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:11:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyHs-00006O-I3
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588687867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igkRKPkkd72l4sVaeCoFyUbvzHaBcOYxkSzVBeNoFmg=;
 b=IFCtTeBqLvLK2UIy+2HRF26AqKDWOfJXY4iZG638j3Acv4GCzPTR0KQb9Ypq4kdFtdczYi
 1+wRZ0uBuL7arcxvnzE0t4Ua3LhMnZMxjQC1lSA+b2p7uTZYJ6IqtT8IKzzgLPQ12cl28m
 XrxlEClOS2vbZC+0MICoj9USHyXeYMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-OIqXLlHXPTKNIis_7vUaYw-1; Tue, 05 May 2020 10:11:03 -0400
X-MC-Unique: OIqXLlHXPTKNIis_7vUaYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44215835B41;
 Tue,  5 May 2020 14:11:02 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B2ED19C4F;
 Tue,  5 May 2020 14:10:51 +0000 (UTC)
Date: Tue, 5 May 2020 16:10:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 03/13] acpi: madt: skip pci override on pci-less
 systems (microvm)
Message-ID: <20200505161050.54da27a0@redhat.com>
In-Reply-To: <20200505134305.22666-4-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-4-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 15:42:55 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-common.h |  3 ++-
>  hw/i386/acpi-build.c  |  2 +-
>  hw/i386/acpi-common.c | 26 +++++++++++++++-----------
>  3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
> index c30e461f1854..9cac18dddf5b 100644
> --- a/hw/i386/acpi-common.h
> +++ b/hw/i386/acpi-common.h
> @@ -9,6 +9,7 @@
>  #define ACPI_BUILD_IOAPIC_ID 0x0
>  
>  void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> -                     X86MachineState *x86ms, AcpiDeviceIf *adev);
> +                     X86MachineState *x86ms, AcpiDeviceIf *adev,
> +                     bool has_pci);
>  
>  #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index eb530e5cd56d..4cce2192eeb0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2441,7 +2441,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>  
>      acpi_add_table(table_offsets, tables_blob);
>      acpi_build_madt(tables_blob, tables->linker, x86ms,
> -                    ACPI_DEVICE_IF(pcms->acpi_dev));
> +                    ACPI_DEVICE_IF(pcms->acpi_dev), true);
>  
>      vmgenid_dev = find_vmgenid_dev();
>      if (vmgenid_dev) {
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 5caca16a0b59..ab9b00581a15 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -72,7 +72,8 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>  }
>  
>  void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> -                     X86MachineState *x86ms, AcpiDeviceIf *adev)
> +                     X86MachineState *x86ms, AcpiDeviceIf *adev,
> +                     bool has_pci)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>      const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
> @@ -111,18 +112,21 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>          intsrcovr->gsi    = cpu_to_le32(2);
>          intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
>      }
> -    for (i = 1; i < 16; i++) {
> +
> +    if (has_pci) {
> +        for (i = 1; i < 16; i++) {
>  #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
> -        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> -            /* No need for a INT source override structure. */
> -            continue;
> +            if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> +                /* No need for a INT source override structure. */
> +                continue;
> +            }
> +            intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
> +            intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
> +            intsrcovr->length = sizeof(*intsrcovr);
> +            intsrcovr->source = i;
> +            intsrcovr->gsi    = cpu_to_le32(i);
> +            intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
>          }
> -        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
> -        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
> -        intsrcovr->length = sizeof(*intsrcovr);
> -        intsrcovr->source = i;
> -        intsrcovr->gsi    = cpu_to_le32(i);
> -        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
>      }
>  
>      if (x2apic_mode) {


