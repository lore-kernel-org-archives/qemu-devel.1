Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4CFC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6160F20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXxjd38p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6160F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BZU-0006F0-I6
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j2BYh-0005LQ-KE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j2BYg-0003XM-Hj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j2BYg-0003XE-Bg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581589042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jW5fWa6fnZoWMRjfFhM6BnCZv71wfaUmabRKtA0/EQ=;
 b=EXxjd38pAJ4yUEtuv0twieifZQfgngxLmIhGVYOX2dsaFZUI9vlQOnVROYzqEjwgMXiOJD
 3nhD+Buyo+/6PWGB8Rr23ynjb0d14i44YPnGmMSKiGJvcy0YeHf6HyI6dd61uVOyrKWo82
 YtHRpJt8DMpPDv/h9IbUiwCrq+brXlk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-YsVjjW1cNWuwAhP4zi1I8g-1; Thu, 13 Feb 2020 05:17:20 -0500
Received: by mail-qt1-f199.google.com with SMTP id k20so3333616qtm.11
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 02:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=13OC0+yHHV6knK5CLZOvXkPPdKW7FWJnsnaZw8oWMVY=;
 b=QdOZo3eqyAwpEpMpa+I2xU9+GZrrhoRWDdo834wrSXhZz/Gx3Q59GsUUz98S9C6iLK
 OmYBDohqS27zINQCk6eiojOn+ahTrGK5EQVLyYX19SCFKs5ta813CCx75Uq4yEgPwCMz
 zZe0Tw+19ZkyQFjaPyEnB90RTIdJsXzkbD4VmPXoE6BzeAqmQC89Ia4L2IluuQ0Q2u8l
 JY32D9IOmESeS1QOp7Se7yjgcwyXAq0qwjXddjs1Ae3fOTusdXpdKYcLAwc+98Sd2VsH
 0+To7bwvYvar93fAHoOz9F7+d3+Wqd870lRU5oromZ0ioGkHTz9HHYlPTrVZjof50XlP
 UKPQ==
X-Gm-Message-State: APjAAAXbxTvBuApMc+tKPBtJmUOCt6n7864wLM+C5H7XYhv008P8NzGD
 Shi9gzT2dx5JcSDzrOTsnirrxvoFa9D3VnG1rQPUR/Kw3Z95jf9nxqTYwO4LJDNuhywHIhMW4MI
 iJm4YvoUANgHvk2A=
X-Received: by 2002:ac8:1194:: with SMTP id d20mr10907860qtj.243.1581589039709; 
 Thu, 13 Feb 2020 02:17:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTpkZeKghUblpA7kFgmHZtG/TX/D7tSWfLLgL/sX+R49LEH/gVAloCjAxgEH7hK7wknGkXEQ==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr10907843qtj.243.1581589039454; 
 Thu, 13 Feb 2020 02:17:19 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 y27sm1300746qta.50.2020.02.13.02.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 02:17:18 -0800 (PST)
Date: Thu, 13 Feb 2020 05:17:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Message-ID: <20200213051310-mutt-send-email-mst@kernel.org>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200213074952.544-3-miaoyubo@huawei.com>
X-MC-Unique: YsVjjW1cNWuwAhP4zi1I8g-1
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 03:49:52PM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> Since devices could not directly plugged into pxb-pcie,

Hmm is this different from the root port? intergrated devices
do exist for that actually.

> under arm,

how is arm special?

> one
> pcie-root port is plugged into pxb-pcie. Due to the bus for each pxb-pcie
> is defined as 2 in acpi dsdt tables(one for pxb-pcie, one for pcie-root-p=
ort),
> only one device could be plugged into one pxb-pcie.

So why can't we have users specify any number of root ports using
-device? then make acpi tables match the # of ports created?


>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 9 +++++++++
>  include/hw/pci/pcie_port.h          | 1 +
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
> index 47aaaf8fd1..3d896dd452 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -15,6 +15,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "qemu/range.h"
> @@ -233,7 +234,15 @@ static void pxb_dev_realize_common(PCIDevice *dev, b=
ool pcie, Error **errp)
> =20
>      ds =3D qdev_create(NULL, TYPE_PXB_HOST);
>      if (pcie) {
> +#ifdef __aarch64__
> +        bus =3D pci_root_bus_new(ds, "pxb-pcie-internal",
> +                               NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
> +        bds =3D qdev_create(BUS(bus), "pcie-root-port");
> +        bds->id =3D dev_name;
> +        qdev_prop_set_uint8(bds, PCIE_ROOT_PORT_PROP_CHASSIS, pxb->bus_n=
r);
> +#else
>          bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_P=
CIE_BUS);
> +#endif

What does all this have to do with building on aarch64?

>      } else {
>          bus =3D pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE=
_PXB_BUS);
>          bds =3D qdev_create(BUS(bus), "pci-bridge");
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 4b3d254b08..b41d473220 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -64,6 +64,7 @@ int pcie_chassis_add_slot(struct PCIESlot *slot);
>  void pcie_chassis_del_slot(PCIESlot *s);
> =20
>  #define TYPE_PCIE_ROOT_PORT         "pcie-root-port-base"
> +#define PCIE_ROOT_PORT_PROP_CHASSIS "chassis"

If you are going to do this, replace other instances of "chassis"
with the macro.

>  #define PCIE_ROOT_PORT_CLASS(klass) \
>       OBJECT_CLASS_CHECK(PCIERootPortClass, (klass), TYPE_PCIE_ROOT_PORT)
>  #define PCIE_ROOT_PORT_GET_CLASS(obj) \
> --=20
> 2.19.1
>=20


