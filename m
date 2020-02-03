Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD6C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF82520661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRMSh+LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF82520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXZm-00073G-3J
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyXZ4-00069V-EY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyXZ3-0006Ui-CK
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:58:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyXZ3-0006Uc-88
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580720320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbmJUTC4XAFqMCmyaRNU+wH+xQTLLNLgLyNZIg2BkuM=;
 b=LRMSh+LLMop+y55dQnBcqauop5Q6PG4HkE7ArUERDN+L/Kc9+bV7bMtWvO3EUm5T7+nHmn
 P+svlgyZ4FQiCoFZ3jzVqUz2Z7LNh2iwJqqSjYpj6gNHB6juRaFgKnNq/2pdOjZo0dcEG3
 evrZJ5WCoOtKfEjiaZR2nxg5pTdsSDg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-0cKZJfHzMc-UR6VlYNSiNA-1; Mon, 03 Feb 2020 03:58:36 -0500
Received: by mail-qt1-f200.google.com with SMTP id e37so9478143qtk.7
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 00:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m/QbI2TZfIIGXnSfwkAZ+bgww0UF+QCsFXNp/Abjejo=;
 b=B6Jy2FeQLXSEPZ+IMYuuxQdWQxUvZNCROdtbQK8p4u3+cEtHU3GHIHsHE4li2o3gFJ
 2nA7fC7SZss5UsJ9rZEZ4BZSmrVLibEsQSh8U68P0sJWILEXHlg83Fh5lVJS8DorXLEK
 9OzxvQ14+Ip2wFxQRZEJHeaeVjSzRmfzqUTsO6o9EmfxuY2+PDxnyhMlBmLyfZDfZZJH
 pzoYMhe7GX6+aFFWi9jUqKgQuajw2/tCfFABqjHSvZidDSxIleYzafSPt1m/ueZ8f2o2
 Y7gG0PvAQSmjB4YGu1I3kiupSdiYjjI82DfU+Gofq/WUyZh3eqSsWEjmtN2jwgX8wjbz
 QzYQ==
X-Gm-Message-State: APjAAAXs0kRn42fLRYjLVVDPFgIqaoBDzEKWsJ/ZwlR8MY3qsUGet0z6
 LPIJsYNseZuXx0Wu3lLImjEAwgy9RUMQQxy4/tqkdKx6V9wsOYAWhhvA4quuKhQiZFKr6eD+5KZ
 4r5RJ7motzmSZewk=
X-Received: by 2002:aed:3022:: with SMTP id 31mr22397378qte.282.1580720316474; 
 Mon, 03 Feb 2020 00:58:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjl1lEA9Z0LnY1oollUpG5XsVV6bJo9QaVzaqvtE/tPzFXaVA2HHVfHfNXppT20Ap2dyPBDQ==
X-Received: by 2002:aed:3022:: with SMTP id 31mr22397368qte.282.1580720316243; 
 Mon, 03 Feb 2020 00:58:36 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id u12sm9944437qtj.84.2020.02.03.00.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:58:35 -0800 (PST)
Date: Mon, 3 Feb 2020 03:58:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 42/80] x86/microvm: use memdev for RAM
Message-ID: <20200203035707-mutt-send-email-mst@kernel.org>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-43-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1580483390-131164-43-git-send-email-imammedo@redhat.com>
X-MC-Unique: 0cKZJfHzMc-UR6VlYNSiNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 04:09:12PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> CC: slp@redhat.com
> CC: pbonzini@redhat.com
> CC: mst@redhat.com
> CC: rth@twiddle.net
> CC: ehabkost@redhat.com
> ---
>  hw/i386/microvm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index d234851..38d8e51 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -167,7 +167,7 @@ static void microvm_memory_init(MicrovmMachineState *=
mms)
>  {
>      MachineState *machine =3D MACHINE(mms);
>      X86MachineState *x86ms =3D X86_MACHINE(mms);
> -    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
> +    MemoryRegion *ram_below_4g, *ram_above_4g;
>      MemoryRegion *system_memory =3D get_system_memory();
>      FWCfgState *fw_cfg;
>      ram_addr_t lowmem;
> @@ -214,12 +214,8 @@ static void microvm_memory_init(MicrovmMachineState =
*mms)
>          x86ms->below_4g_mem_size =3D machine->ram_size;
>      }
> =20
> -    ram =3D g_malloc(sizeof(*ram));
> -    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
> -                                         machine->ram_size);
> -
>      ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
> -    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
> +    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine=
->ram,
>                               0, x86ms->below_4g_mem_size);
>      memory_region_add_subregion(system_memory, 0, ram_below_4g);
> =20
> @@ -227,7 +223,8 @@ static void microvm_memory_init(MicrovmMachineState *=
mms)
> =20
>      if (x86ms->above_4g_mem_size > 0) {
>          ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
> -        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram=
,
> +        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
> +                                 machine->ram,
>                                   x86ms->below_4g_mem_size,
>                                   x86ms->above_4g_mem_size);
>          memory_region_add_subregion(system_memory, 0x100000000ULL,
> @@ -502,6 +499,7 @@ static void microvm_class_init(ObjectClass *oc, void =
*data)
>      mc->auto_enable_numa_with_memhp =3D false;
>      mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported =3D false;
> +    mc->default_ram_id =3D "microvm.ram";
> =20
>      /* Avoid relying too much on kernel components */
>      mc->default_kernel_irqchip_split =3D true;
> --=20
> 2.7.4
>=20
>=20


