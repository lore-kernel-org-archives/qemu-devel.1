Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580FAC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8572077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiRCrQSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8572077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomKf-0002M7-EF
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iolEo-0000jL-3J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iolEm-0006Sz-ME
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:33:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44800
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iolEm-0006SY-IN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578389600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rV4AdtV6fpiPzPLrFUgrzsHrBxOJEDqTcY7DhA1rJnY=;
 b=AiRCrQSHB8QOP2qUJV060pqweVanSv24j3dEq8FwAcMnxaJl3WQvujY8NTotAia5xeHT6H
 uYpqB4c5V49OqPrgOULsNugslox7HQV5vFKa0ha1SmGf1ZaCp0Ryvc0RlCqiOPLNfBPklG
 7BR3XDMT4FguQ2lZUJH+1V3JLE/iFqM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-9jX-dkKrNNG3Tk10EMnz7Q-1; Tue, 07 Jan 2020 04:33:16 -0500
Received: by mail-qk1-f199.google.com with SMTP id 65so7448708qkl.23
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 01:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ohifn2DS3HJRYsyyct+ZrgDyh93/8Y0awwWQNx1/1jY=;
 b=PujotR8AfM4gcK3czjaiUonME9vVg7/tnu+L8kuGSz7mz2/0Q872fZuhAGqUGjTWWG
 7vPgaxFw0VcLGkOuRKMteyLr1Gx6V6KWPjIN9CaZToItwSA0R8NqLFxVmM+7z0SlwkHJ
 /kFq7j47IQrpqm/ElD6VXZYxYm1dnGi/X/xdFusof+iOilLpDlq+nqGCgptmkQNtO2Bn
 M8eaFf27JUYFz8Ih5dTsjXsgI2LW9Ujs35x+aaaJ1PePMI0a10w1FKLYsw72aqs0Vngv
 CXcanLYJfKa8p6hCDZhZuT7HRgCnRytmhTpt9PRcwWSrxCs+xXiF6p2uQsnRdc1yEBpD
 2qZQ==
X-Gm-Message-State: APjAAAXRQuVG5w3a7Dinx6CgjIj6mmuC0IiYkf4MFLhEkqZ7yUOQ1Jwf
 GiVqCrPJQSH81fwpHl6YI+onFBPqcvlZPdUWKOCzSSzTR2t8tWfpi4KB9gFbQ1q26VyaRXNNe68
 t492QThlTpzI68h4=
X-Received: by 2002:ae9:c112:: with SMTP id z18mr85848443qki.145.1578389596434; 
 Tue, 07 Jan 2020 01:33:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHY0PZh8Y4O5aIkVgVdtBJKAFwFFbuwYsxD3dYruwAypabO3DUWnEUYzHwjzsKxNefEKWRGw==
X-Received: by 2002:ae9:c112:: with SMTP id z18mr85848421qki.145.1578389596085; 
 Tue, 07 Jan 2020 01:33:16 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id q73sm22021675qka.56.2020.01.07.01.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 01:33:15 -0800 (PST)
Date: Tue, 7 Jan 2020 04:33:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zeng Tao <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by
 node_id ascending order
Message-ID: <20200107042918-mutt-send-email-mst@kernel.org>
References: <1578388729-55540-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1578388729-55540-1-git-send-email-prime.zeng@hisilicon.com>
X-MC-Unique: 9jX-dkKrNNG3Tk10EMnz7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 05:18:49PM +0800, Zeng Tao wrote:
> When booting the guest linux with the following numa configuration:
> -numa node,node_id=3D1,cpus=3D0-3
> -numa node,node_id=3D0,cpus=3D4-7
> We can get the following numa topology in the guest system:
> Architecture:          aarch64
> Byte Order:            Little Endian
> CPU(s):                8
> On-line CPU(s) list:   0-7
> Thread(s) per core:    1
> Core(s) per socket:    8
> Socket(s):             1
> NUMA node(s):          2
> L1d cache:             unknown size
> L1i cache:             unknown size
> L2 cache:              unknown size
> NUMA node0 CPU(s):     0-3
> NUMA node1 CPU(s):     4-7
> The Cpus 0-3 is assigned with NUMA node 1 in QEMU while it get NUMA node
> 0 in the guest.
>=20
> In fact, In the linux kernel, numa_node_id is allocated per the ACPI
> SRAT processors structure order,so the cpu 0 will be the first one to
> allocate its NUMA node id, so it gets the NUMA node 0.
>=20
> To fix this issue, we pack the SRAT processors structure in numa node id
> order but not the default cpu number order.
>=20
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>


Does this matter? If yes fixing linux to take node id from proximity
field in ACPI seems cleaner ...

> ---
>  hw/arm/virt-acpi-build.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bd5f771..497192b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -520,7 +520,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>      AcpiSystemResourceAffinityTable *srat;
>      AcpiSratProcessorGiccAffinity *core;
>      AcpiSratMemoryAffinity *numamem;
> -    int i, srat_start;
> +    int i, j, srat_start;
> +    uint32_t node_id;
>      uint64_t mem_base;
>      MachineClass *mc =3D MACHINE_GET_CLASS(vms);
>      MachineState *ms =3D MACHINE(vms);
> @@ -530,13 +531,19 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
>      srat =3D acpi_data_push(table_data, sizeof(*srat));
>      srat->reserved1 =3D cpu_to_le32(1);
> =20
> -    for (i =3D 0; i < cpu_list->len; ++i) {
> -        core =3D acpi_data_push(table_data, sizeof(*core));
> -        core->type =3D ACPI_SRAT_PROCESSOR_GICC;
> -        core->length =3D sizeof(*core);
> -        core->proximity =3D cpu_to_le32(cpu_list->cpus[i].props.node_id)=
;
> -        core->acpi_processor_uid =3D cpu_to_le32(i);
> -        core->flags =3D cpu_to_le32(1);
> +    for (i =3D 0; i < ms->numa_state->num_nodes; ++i) {
> +        for (j =3D 0; j < cpu_list->len; ++j) {

Hmm O(n ^2) isn't great ...

> +            node_id =3D cpu_to_le32(cpu_list->cpus[j].props.node_id);
> +            if (node_id !=3D i) {
> +                continue;
> +            }
> +            core =3D acpi_data_push(table_data, sizeof(*core));
> +            core->type =3D ACPI_SRAT_PROCESSOR_GICC;
> +            core->length =3D sizeof(*core);
> +            core->proximity =3D node_id;
> +            core->acpi_processor_uid =3D cpu_to_le32(j);
> +            core->flags =3D cpu_to_le32(1);
> +        }
>      }

is the issue arm specific? wouldn't it affect x86 too?

>      mem_base =3D vms->memmap[VIRT_MEM].base;
> --=20
> 2.8.1


