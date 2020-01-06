Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAAEC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7F12071A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="ojVjjgaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7F12071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioS7I-0002RU-BZ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 08:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1ioS6Z-0001uj-Lz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1ioS6W-0005s6-6d
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:07:35 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1ioS6V-0005qx-Sr
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:07:32 -0500
Received: by mail-oi1-x241.google.com with SMTP id l136so15822156oig.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=djuTjSz97I65e9Rdhz0iVYkKZcol8tp8cxJmmTQmsow=;
 b=ojVjjgaVktB6L4hwatHWW51Aq8aJUGwXU3j4mdXUglwDsTyP51fJOEq8XhMmaRUFX4
 RgCgV0Egn020XKoo5Ehx7Md4yaq7w137GfcBC8QAlNMhRflqSRyrIOBa+xgGWshfmH9W
 TAs9pe6J5elc4gPfg8W1nkmsCaNzSLYxnU9H7x6shG0QroE2UTL1md8ARDQyvCscwZsz
 7gzg2QUDYsCm4RkklJ9HOvSUiVFb50Gh+t31C7p+PEDNGqsyrGxPhL/XfAM2hBaMiODc
 yNPdv9yepRJ1pf9QaaDw+UFK2vuMypeG5Q1cTvWhfB01rF9HipsA2JfVeXU47pgbu675
 HLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=djuTjSz97I65e9Rdhz0iVYkKZcol8tp8cxJmmTQmsow=;
 b=tf3q84nazkFGHr7Wzi8rUdQ9a4m/ns+6ADRi+9IAx1KplZawYyPCMV8JzNi+fc6cgJ
 qDsJms4WScQj+pptvWe9Dq038bOaFEQbVhvnx83yRKlRCLuyvIhs0hCgaTxrZdNaZjRF
 KEUH3ZMUg+l+/r+imgfnsfdEfAA4FCa5b0sUHzUmpB210WE5m0LBFFuOGdEiGxx5OPO1
 twUahIKtoB2ZtrCF/fXDZEVUSshy0Ptc+1Fy+GHgWUYgJ4imXH7IfMKpbWMwEoQ4HjDZ
 +2YN+cyPIGM9Qy0zadSe4WOZT7EipDz4s6rlFlDZvhll44Hmf8htYww5E14jAMsUKdOS
 /2TQ==
X-Gm-Message-State: APjAAAWZAxW7DMgopTnB35iFzUyiKPYUn29aiaTHWCrU+iILJPIR7aVL
 Vn5NT/IpERhC+wxlsMQxXZsqPg==
X-Google-Smtp-Source: APXvYqwdms4GxGO+9C7JXMJBgCtlLK/Sry5YrMwSV1l9unfN3WQth6+W9iFFV19clG9YQpmkKMtK0g==
X-Received: by 2002:aca:6744:: with SMTP id b4mr321855oiy.99.1578316050628;
 Mon, 06 Jan 2020 05:07:30 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:adc3:7c20:81:d62b])
 by smtp.gmail.com with ESMTPSA id n7sm21185655oij.14.2020.01.06.05.07.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 06 Jan 2020 05:07:29 -0800 (PST)
Date: Mon, 6 Jan 2020 07:07:27 -0600
From: Corey Minyard <cminyard@mvista.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified
 by _HID
Message-ID: <20200106130727.GA2886@minyard.net>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <20200105225420.GJ6497@minyard.net>
 <20200106043916-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106043916-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Reply-To: cminyard@mvista.com
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 04:39:51AM -0500, Michael S. Tsirkin wrote:
> On Sun, Jan 05, 2020 at 04:54:20PM -0600, Corey Minyard wrote:
> > On Sun, Jan 05, 2020 at 07:33:55AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Dec 19, 2019 at 02:47:59PM +0800, Heyi Guo wrote:
> > > > According to ACPI spec, _ADR should be used for device which is on a
> > > > bus that has a standard enumeration algorithm. It does not make sense
> > > > to have a _ADR object for devices which already have _HID and will be
> > > > enumerated by OSPM.
> > > > 
> > > > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> > > 
> > > Are you sure? I would think this depends on the ID and the device
> > > really. E.g. PCI devices all are expected to have _ADR and some of them
> > > have a _HID.
> > 
> > That's my understanding, too.
> > 
> > > 
> > > CC Corey who added a device with both HID and ADR to x86 recenly.
> > > 
> > > Apropos Corey, why was HID APP0005 chosen?
> > 
> > I don't remember.  I thought I had looked it up someplace, but I didn't
> > document it.
> > 
> > >From reading the spec, I believe you could safely delete the _HID and it
> > would be fine.  However, I don't see anything that says it can't be
> > there, either.  But it is extraneous.
> > 
> > Searching on the web a bit, I see that the APP0005 has confused windows.
> 
> Could you post the link you found pls?

https://bugs.launchpad.net/qemu/+bug/1856724

> 
> > It does look to be wrong.  Maybe deleting it would be a good idea.
> > 
> > -corey
> > 
> > > 
> > > > ---
> > > > Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> > > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > > Cc: qemu-arm@nongnu.org
> > > > Cc: qemu-devel@nongnu.org
> > > > ---
> > > >  hw/arm/virt-acpi-build.c          |   8 --------
> > > >  tests/data/acpi/virt/DSDT         | Bin 18449 -> 18426 bytes
> > > >  tests/data/acpi/virt/DSDT.memhp   | Bin 19786 -> 19763 bytes
> > > >  tests/data/acpi/virt/DSDT.numamem | Bin 18449 -> 18426 bytes
> > > >  4 files changed, 8 deletions(-)
> > > > 
> > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > index 9f4c7d1889..be752c0ad8 100644
> > > > --- a/hw/arm/virt-acpi-build.c
> > > > +++ b/hw/arm/virt-acpi-build.c
> > > > @@ -78,11 +78,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> > > >                               AML_EXCLUSIVE, &uart_irq, 1));
> > > >      aml_append(dev, aml_name_decl("_CRS", crs));
> > > >  
> > > > -    /* The _ADR entry is used to link this device to the UART described
> > > > -     * in the SPCR table, i.e. SPCR.base_address.address == _ADR.
> > > > -     */
> > > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(uart_memmap->base)));
> > > > -
> > > >      aml_append(scope, dev);
> > > >  }
> > > >  
> > > > @@ -170,7 +165,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> > > >      aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> > > >      aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> > > >      aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
> > > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > > >      aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
> > > >      aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
> > > >      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > > > @@ -334,7 +328,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
> > > >  {
> > > >      Aml *dev = aml_device("GPO0");
> > > >      aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
> > > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > > >      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > > >  
> > > >      Aml *crs = aml_resource_template();
> > > > @@ -364,7 +357,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
> > > >  {
> > > >      Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
> > > >      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> > > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > > >      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > > >      aml_append(scope, dev);
> > > >  }
> > > > diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> > > 
> > > 
> > > Please do not include binary changes in acpi patches.
> > > 
> > > See comment at the top of tests/bios-tables-test.c for documentation
> > > on how to update these.
> > > 
> > > -- 
> > > MST
> > > 
> 

