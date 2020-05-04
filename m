Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D842FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C2420705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CalK1gRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C2420705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbiR-00026S-NY
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVbh6-0000eu-S9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:03:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25204
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVbh5-0006fa-PG
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588601018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b07kBqn65IFgXikBqRmbtRU7fYg1q3hiw3ti+bkfZPA=;
 b=CalK1gRKqiobcvVgiggDMT4XFr/aeeG9eyx8L4tGIdgJSzyhR8YO1rTytkkxGA/9Z/o0pW
 VqQGJjA0341qENNnTQGfDHQTNHTDliRpI2aF3nCy7Oz1+vkN6tHQctwF8Bs6aeREW32CbZ
 CjNMbwWuN0g7qAWgPpWoOkTNFMc6cos=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-IgNFd9_VP9edAtBoZJWTjg-1; Mon, 04 May 2020 10:03:37 -0400
X-MC-Unique: IgNFd9_VP9edAtBoZJWTjg-1
Received: by mail-wm1-f71.google.com with SMTP id w2so4942773wmc.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1ngUXtI4hGh3c4dAqDF6Rg89JFHqGpuVo8IeLr5r4Cw=;
 b=SdWn9vDlnp6I0DNbExN444weLNX1wPg2qB+72XnXHMW64MaqyuXNzFKW+ycZ7nnBiA
 0NbtzrH31jwXFxxxdf5/SctxJgwAR3OMKGZO94fX6HVkQFLAchqt8uz17p38ixayypTe
 xQpFtNcXV8b2p2/1uuun2X+Nr9AD3nPip1RUUVAb1sCykIuMNgBSuINv56DKGgr66GRM
 SFDAWL27uts89RSt7+ytB4Ez1Y6Pi4c5+dZA8tXZPrrGbpVxDlAJHpbGulibAopTb+Ey
 hazOfdaX4dV+yTbdiXqpTKYpBS2KzdZJh1UHuQFbqVcBz+PaO1WZCkrqlJ6Ep9tCOEop
 srsQ==
X-Gm-Message-State: AGi0PuZyNKiCIx2K5b4nBvy6mxKHndq/HIblAVibBmGQExXy8llAXvSN
 6zWuMaB7ChZtQROan5jIAwNO6BHNslxpiHnDwL9K3e7s1mYmV942iC+XJnrReVlDqgGxbxk69dK
 19Ci/hPYgrS7UCyk=
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr15745871wmf.31.1588601013141; 
 Mon, 04 May 2020 07:03:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJYWNa9VJWHtrOUiDfBu4O+gpp+6JkTUyNCSWe77KSg1REaVkNEONyeY1LraRRiA6iLbg4Rwg==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr15745848wmf.31.1588601012933; 
 Mon, 04 May 2020 07:03:32 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 e21sm20013578wrc.1.2020.05.04.07.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:03:32 -0700 (PDT)
Date: Mon, 4 May 2020 10:03:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [PATCH v6 5/8] acpi: Align the size to 128k
Message-ID: <20200504100317-mutt-send-email-mst@kernel.org>
References: <20200408125816.955-1-miaoyubo@huawei.com>
 <20200408125816.955-6-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200408125816.955-6-miaoyubo@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 08, 2020 at 08:58:13PM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> If table size is changed between virt_acpi_build and
> virt_acpi_build_update, the table size would not be updated to
> UEFI, therefore, just align the size to 128kb, which is enough
> and same with x86. It would warn if 64k is not enough and the
> align size should be updated.
>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>

does this affect migration in any way?

> ---
>  hw/arm/virt-acpi-build.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7bcd04dfb7..89bb768b0c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -54,6 +54,8 @@
>  #include "hw/pci/pci_bridge.h"
>  #define ARM_SPI_BASE 32
> =20
> +#define ACPI_BUILD_TABLE_SIZE             0x20000
> +
>  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
>  {
>      uint16_t i;
> @@ -883,6 +885,15 @@ struct AcpiBuildState {
>      bool patched;
>  } AcpiBuildState;
> =20
> +static void acpi_align_size(GArray *blob, unsigned align)
> +{
> +    /*
> +     * Align size to multiple of given size. This reduces the chance
> +     * we need to change size in the future (breaking cross version migr=
ation).
> +     */
> +    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> +}
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -953,6 +964,20 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
>          build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
>      }
> =20
> +    /*
> +     * The align size is 128, warn if 64k is not enough therefore
> +     * the align size could be resized.
> +     */
> +    if (tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) {
> +        warn_report("ACPI table size %u exceeds %d bytes,"
> +                    " migration may not work",
> +                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> +        error_printf("Try removing CPUs, NUMA nodes, memory slots"
> +                     " or PCI bridges.");
> +    }
> +    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> +
> +
>      /* Cleanup memory that's no longer used. */
>      g_array_free(table_offsets, true);
>  }
> --=20
> 2.19.1
>=20


