Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFCDC33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EBD207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzLg+BzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EBD207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir0Mp-0000TX-Rv
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ir0Lq-0007Vd-Kb
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ir0Lp-0001tE-BB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:05:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ir0Lp-0001sa-6x
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578924352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UADAgYS3Boq1UYjCv47Nn6Q5wKWruCLWeWsDnelbl0=;
 b=hzLg+BzOPYnU05imkf+YHhZFll+981KWUhiSM7raXnkk+rfANQvE68+BJQ9er0rNALr4bB
 rQZfXEuTNGoxV29Jm8zEVK/aDIWGJ+50vW+b8VYiqNah8OF+C5Wp8dzwrr00Npc3ge1k0e
 II4Kg1E3svuXVFWpkx+4hrV1jpGcpWQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-ACWDer21NQCjLfatqYo7jQ-1; Mon, 13 Jan 2020 09:05:44 -0500
Received: by mail-qk1-f198.google.com with SMTP id f22so5934921qka.10
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 06:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cwQagRCkQc2vpB7kf8MWyCu+Fl188WS4abNeYwHcBZw=;
 b=lBdVdbkKxLUDUqYvf5We3ZMqSEKwd6q+l/d4GyYVUkgksnkI+gQEEfMZ2TKhQkHy2z
 2cBNOIGgRRFzwRMjI/XbwDizDNg4ZdqC0+NDNsiWmR2w2cRTRiUq4Wmwedw2XeoKuaKy
 4kMiG81TXgWKdDWfzpYXFpKD28+Bgg4mWuzd0QM3ix0olGJ5UJMzdzJ58nCAcf5a2Sp0
 iqUG36hStJpVinkjIhf/q2/WxcHr834GHVY9h11JDT0vHMskIo1zQZMVkXos8uDXB6tD
 thVanueW1wjTIxJyCrF64GBLH49p9qWUlLHcT5q16mESYqcP8a3QCOXj/MMv1TvSdoxT
 /Qsw==
X-Gm-Message-State: APjAAAXsNHhX3bxy01g8c7oJ3ikcDtgMbKkKg99Kf+4zWtlI1b0VpNnF
 BwHd/ga5Bbmd668O8EMID76Wuy1CehybC30iqXJVMNg42I4qa+Gf+wiA6S8eRKyYa8rByaUUK0r
 peI9SmumxBijYcmg=
X-Received: by 2002:a05:620a:1327:: with SMTP id
 p7mr16278812qkj.148.1578924344316; 
 Mon, 13 Jan 2020 06:05:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4Q7S2y16MvzoyPX0MRTHUrP6Fs3GJTlamZZ7ycCKqEuT/J/+yfqJntSh78r9Uuy+XzFMXLQ==
X-Received: by 2002:a05:620a:1327:: with SMTP id
 p7mr16278776qkj.148.1578924344079; 
 Mon, 13 Jan 2020 06:05:44 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id c24sm5809863qtk.40.2020.01.13.06.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:05:42 -0800 (PST)
Date: Mon, 13 Jan 2020 09:05:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <20200113090515-mutt-send-email-mst@kernel.org>
References: <20200106152705.8258-1-minyard@acm.org>
 <20200107175821.72556c39@redhat.com>
 <20200107201106.GA2874@minyard.net>
MIME-Version: 1.0
In-Reply-To: <20200107201106.GA2874@minyard.net>
X-MC-Unique: ACWDer21NQCjLfatqYo7jQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, wanghaibin.wang@huawei.com,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 02:11:06PM -0600, Corey Minyard wrote:
> On Tue, Jan 07, 2020 at 05:58:21PM +0100, Igor Mammedov wrote:
> > On Mon,  6 Jan 2020 09:27:05 -0600
> > minyard@acm.org wrote:
> >=20
> > > From: Corey Minyard <cminyard@mvista.com>
> > >=20
> > > Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not require=
d
> > > on enumerated buses (like PCI in this case), _ADR is required (and is
> > > already there).  And the _HID value is wrong.  Linux appears to ignor=
e
> > > the _HID entry, but it confuses Windows.
> >=20
> > Corey,
> >=20
> > Could you clarify as what "confuses Windows" means?
> > s/confuses Windows/description of the observed problem and on what wind=
ows version/
>=20
> Yeah, I should have done that.  The error is not given, but the report
> says" "It is detected by Windows 10 as 'Unknown Device' and there is no
> driver available."  Link is https://bugs.launchpad.net/qemu/+bug/1856724
>=20
> I'll add that to the text, along with the link.
>=20
> -corey


ok so you will repost with igor's ack and tweaked commit log?

> >=20
> > >=20
> > > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/i386/acpi-build.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 7b8da62d41..ab73a8f4c8 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -1815,7 +1815,6 @@ static void build_smb0(Aml *table, I2CBus *smbu=
s, int devnr, int func)
> > >      Aml *scope =3D aml_scope("_SB.PCI0");
> > >      Aml *dev =3D aml_device("SMB0");
> > > =20
> > > -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
> > >      aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func=
)));
> > >      build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
> > >      aml_append(scope, dev);
> >=20


