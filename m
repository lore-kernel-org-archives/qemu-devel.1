Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667F8C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9B82080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvBhdt1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9B82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyUxi-0002fZ-Ad
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyUwx-0001ug-0Y
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyUwv-0001iG-PH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35772
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyUwv-0001he-Kd
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580710269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGYi4iQGyypKkwl5HdBcxH1o1c16rSX8imA3vtobyKo=;
 b=EvBhdt1ljxdsFM5oLwKLVIxZD3Lqnjyz6LVL5mEuLlTZbkprpRwFpp4tzEOZCX4PWoHTuU
 fhoQ4fb1bvkxZ8ZSp4PFQXhV7I4FHtF5bODl5lHdaHr8h4RC5pm+cC9aNZifD73PTC5ybJ
 PNS6P+25CuBuYoErtNuaSTRjpGL+go0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-Gk9qmG4bMSGuw4WnfbdgNg-1; Mon, 03 Feb 2020 01:11:07 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so7645911wrn.11
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 22:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Lw8zZl6P+1/bHZa82Tc/oS8E16nZxIUU26KAs8LQ3vc=;
 b=cv5vgoKQ45WOmmkXIfqzFiZ3s8LcII+ZL8M7ojrbkfp10h8RJG1fd/BbjTnNVzcfVk
 8BSWA5vHs2cf0IKWKXMlonxvFZHtI58VEoPB51uCDyrZbk/JxjCO7lvcDudGVJXHxlt0
 fxGuyM//dPeh7x8kvRiiqbAScv0d0qoECl6qLOWJrIPDGO0bzffNB7emodOShKR/MgCu
 mo84Q6BYdBaicGd/9jReH/QeGhDKE5VAbEMXrPdlW9LBEuZ/SSMeqHquawO8fmFEzQHA
 GiqAjCKa8fke+HVcdn3VasKGNhjYGP43Z+GrL5TaP5lMZJS5kqlJ0RlacGGlNq4UGe/e
 8zaw==
X-Gm-Message-State: APjAAAUY/RvAV/D6RjPl37gNA3jNueeBNQczVlKcvL9TVgiyQGPILCJz
 wF8vrHfs4ggzt6eZ3cZRE9cmcCEGcpgRnM5ng88b/mzKHIISTh3WMGL1Cq2j7cmfCm8vusrbMaW
 zTmWJMnyb8Sqmj/g=
X-Received: by 2002:a1c:b4d7:: with SMTP id
 d206mr26783659wmf.188.1580710266013; 
 Sun, 02 Feb 2020 22:11:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoavUdIsjoJxHLOKN2LSRgpJsKfVDj8+VQZ8fNkw+Wk7qE71b7aG56WkS+8q3rvZSrT7/NTg==
X-Received: by 2002:a1c:b4d7:: with SMTP id
 d206mr26783634wmf.188.1580710265780; 
 Sun, 02 Feb 2020 22:11:05 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id o4sm9112696wrw.15.2020.02.02.22.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 22:11:05 -0800 (PST)
Date: Mon, 3 Feb 2020 01:10:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v2 4/7] arm/acpi: fix PCI _PRT definition
Message-ID: <20200203010249-mutt-send-email-mst@kernel.org>
References: <20200203001505.52573-1-guoheyi@huawei.com>
 <20200203001505.52573-5-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200203001505.52573-5-guoheyi@huawei.com>
X-MC-Unique: Gk9qmG4bMSGuw4WnfbdgNg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 08:15:02AM +0800, Heyi Guo wrote:
> The address field in each _PRT mapping package should be constructed
> with high word for device# and low word for function#, so it is wrong
> to use bus_no as the high word. Enumerate all possible slots
> (i.e. PCI_SLOT_MAX) instead.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>


Absolutely matches the spec so

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

To add to the commit message:
The existing code adds a bunch useless entries with device #s above 31.


> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index be752c0ad8..5d157a9dd5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -151,7 +151,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>  {
>      int ecam_id =3D VIRT_ECAM_ID(highmem_ecam);
>      Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
> -    int i, bus_no;
> +    int i, slot_no;
>      hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
>      hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
>      hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
> @@ -170,12 +170,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
>      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> =20
>      /* Declare the PCI Routing Table. */
> -    Aml *rt_pkg =3D aml_varpackage(nr_pcie_buses * PCI_NUM_PINS);
> -    for (bus_no =3D 0; bus_no < nr_pcie_buses; bus_no++) {
> +    Aml *rt_pkg =3D aml_varpackage(PCI_SLOT_MAX * PCI_NUM_PINS);
> +    for (slot_no =3D 0; slot_no < PCI_SLOT_MAX; slot_no++) {
>          for (i =3D 0; i < PCI_NUM_PINS; i++) {
> -            int gsi =3D (i + bus_no) % PCI_NUM_PINS;
> +            int gsi =3D (i + slot_no) % PCI_NUM_PINS;
>              Aml *pkg =3D aml_package(4);
> -            aml_append(pkg, aml_int((bus_no << 16) | 0xFFFF));
> +            aml_append(pkg, aml_int((slot_no << 16) | 0xFFFF));
>              aml_append(pkg, aml_int(i));
>              aml_append(pkg, aml_name("GSI%d", gsi));
>              aml_append(pkg, aml_int(0));
> --=20
> 2.19.1


