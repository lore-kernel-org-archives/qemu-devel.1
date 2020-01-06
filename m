Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC4C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6FB20848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvjou1Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6FB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioOst-0007xh-2i
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 04:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ioOri-0006xu-29
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ioOrf-00082q-7T
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:40:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ioOrf-00081q-3K
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578303598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYqAVPxUxJ0pYZQs8wa7T/ak8CCWMZ7gnjMrnRcBxXs=;
 b=Pvjou1LdE+pd+y3hAyMSiDz531lrNfju9V+Q64DQ6QrqZ7TVHzEUyOGfDB6aOJj161MxCn
 PU3v1mGWLlxQTLHwMrBVHSOn+uC2WV8wY6E3LWhF3qqHv9TTSS4yj8Rk78u6Yjzg0XtqO6
 bpWQnBqR5RYAUVWjIHAf0trcSPx2KiM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-d9pu-dXgPVio6TlbFxMkdA-1; Mon, 06 Jan 2020 04:39:56 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so26827188wrn.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 01:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9fUCqkphBRJc1ecZ77d6BtO1jCfuVFgMgIpeh+trpr0=;
 b=cjkaV72kQkZUB+wys07HMOELM20xcE4ZP4moffFTtXu/jwEmQfauz29iJu+UVcI+fk
 ARR7JsAh0Dd2NS0NnfUJrclSAyywm9uMD8VJ8KX3OIhYkhQOur0jEdUHcFHvXn4iWTkZ
 gjsHUWtra3vVnL71ck3PpJeZG/0O4/ZOhJGjRIbQvqmdGCfeTC1mHclRfXrQnumoHbDm
 DYoqnDiR6JkACWCzsyCtIpiRGag5tEbRjIYzA8gT7k0evgY0bRMeccVmXliOwcyrAfT1
 vS/9leVkIKUQsMb+QBGTbc2XBSlMGTD6mWWbmn57LehHbKrHMCwCxxasJ9SPCyZ/i9fG
 edaQ==
X-Gm-Message-State: APjAAAUaRiBlEWSVCB8INll4rNWAxHsiY1Vtz/UOOn3atRMPx8BZk+pg
 e1TLh2ZW5Ain26JQ3W0tj+BbcWqTamc0M9LtN3G9qOKCXvYRiSPVI2CZlqI9MpvjuionFnXxwc2
 l8y/f7JRj7Gb8ATE=
X-Received: by 2002:a7b:c318:: with SMTP id k24mr34454730wmj.54.1578303595616; 
 Mon, 06 Jan 2020 01:39:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjqSfdsvlKxT9KDx5eDqmaaARfjjtuFpinVGYZZ1WNIaSRysyKGhm3u2AzA2FEyBkfTZloGw==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr34454713wmj.54.1578303595399; 
 Mon, 06 Jan 2020 01:39:55 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id c68sm22029361wme.13.2020.01.06.01.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 01:39:54 -0800 (PST)
Date: Mon, 6 Jan 2020 04:39:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified
 by _HID
Message-ID: <20200106043916-mutt-send-email-mst@kernel.org>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <20200105225420.GJ6497@minyard.net>
MIME-Version: 1.0
In-Reply-To: <20200105225420.GJ6497@minyard.net>
X-MC-Unique: d9pu-dXgPVio6TlbFxMkdA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jan 05, 2020 at 04:54:20PM -0600, Corey Minyard wrote:
> On Sun, Jan 05, 2020 at 07:33:55AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 19, 2019 at 02:47:59PM +0800, Heyi Guo wrote:
> > > According to ACPI spec, _ADR should be used for device which is on a
> > > bus that has a standard enumeration algorithm. It does not make sense
> > > to have a _ADR object for devices which already have _HID and will be
> > > enumerated by OSPM.
> > >=20
> > > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> >=20
> > Are you sure? I would think this depends on the ID and the device
> > really. E.g. PCI devices all are expected to have _ADR and some of them
> > have a _HID.
>=20
> That's my understanding, too.
>=20
> >=20
> > CC Corey who added a device with both HID and ADR to x86 recenly.
> >=20
> > Apropos Corey, why was HID APP0005 chosen?
>=20
> I don't remember.  I thought I had looked it up someplace, but I didn't
> document it.
>=20
> >From reading the spec, I believe you could safely delete the _HID and it
> would be fine.  However, I don't see anything that says it can't be
> there, either.  But it is extraneous.
>=20
> Searching on the web a bit, I see that the APP0005 has confused windows.

Could you post the link you found pls?

> It does look to be wrong.  Maybe deleting it would be a good idea.
>=20
> -corey
>=20
> >=20
> > > ---
> > > Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > Cc: qemu-arm@nongnu.org
> > > Cc: qemu-devel@nongnu.org
> > > ---
> > >  hw/arm/virt-acpi-build.c          |   8 --------
> > >  tests/data/acpi/virt/DSDT         | Bin 18449 -> 18426 bytes
> > >  tests/data/acpi/virt/DSDT.memhp   | Bin 19786 -> 19763 bytes
> > >  tests/data/acpi/virt/DSDT.numamem | Bin 18449 -> 18426 bytes
> > >  4 files changed, 8 deletions(-)
> > >=20
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 9f4c7d1889..be752c0ad8 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -78,11 +78,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const M=
emMapEntry *uart_memmap,
> > >                               AML_EXCLUSIVE, &uart_irq, 1));
> > >      aml_append(dev, aml_name_decl("_CRS", crs));
> > > =20
> > > -    /* The _ADR entry is used to link this device to the UART descri=
bed
> > > -     * in the SPCR table, i.e. SPCR.base_address.address =3D=3D _ADR=
.
> > > -     */
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(uart_memmap->base)=
));
> > > -
> > >      aml_append(scope, dev);
> > >  }
> > > =20
> > > @@ -170,7 +165,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const M=
emMapEntry *memmap,
> > >      aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> > >      aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> > >      aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > >      aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
> > >      aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device=
")));
> > >      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > > @@ -334,7 +328,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const =
MemMapEntry *gpio_memmap,
> > >  {
> > >      Aml *dev =3D aml_device("GPO0");
> > >      aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > >      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > > =20
> > >      Aml *crs =3D aml_resource_template();
> > > @@ -364,7 +357,6 @@ static void acpi_dsdt_add_power_button(Aml *scope=
)
> > >  {
> > >      Aml *dev =3D aml_device(ACPI_POWER_BUTTON_DEVICE);
> > >      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > >      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > >      aml_append(scope, dev);
> > >  }
> > > diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> >=20
> >=20
> > Please do not include binary changes in acpi patches.
> >=20
> > See comment at the top of tests/bios-tables-test.c for documentation
> > on how to update these.
> >=20
> > --=20
> > MST
> >=20


