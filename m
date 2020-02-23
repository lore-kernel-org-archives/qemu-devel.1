Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE77C35671
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 21:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED014206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 21:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cD65hkG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED014206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5ylS-0001GN-3g
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 16:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j5yko-0000p2-0z
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 16:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j5ykm-0003hk-98
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 16:25:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j5ykm-0003hV-13
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 16:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582493131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjJBK8EO57Kkis0js0dYCK68MHLgDGJhoa4v0JLnBCE=;
 b=cD65hkG7U3EPUTKfdIPcMau3oJ5tpKQsm/dY4CAeiPMQ6ZsCs/qjhXIl5bc3ov+NeNyTuA
 9JOQAAgEgYZEq74gr6Ibsr1pyEepGYGN8AHzkZUS2Gm9104wV23jsJuRG4Ij+A6FG8pLk2
 zEi7/O5DF2TTQP8aV7PA6te8+izAJEg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-j54VEzxDOqCGt05e7ob2Yg-1; Sun, 23 Feb 2020 16:25:29 -0500
X-MC-Unique: j54VEzxDOqCGt05e7ob2Yg-1
Received: by mail-qv1-f71.google.com with SMTP id ce2so6613227qvb.23
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 13:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pDDoQQOrOYeC/NLDoSF1kjMPYpzkJ3XIoYGsRACZR0A=;
 b=R2yVmWs7e1BAEec98z5ek0fzn3afQ31VGDa8aTBy19fvwgZi0z0JWjD1VjeBmhyYmW
 uIEluWoiwGrRQe3xLDsl8IcmA5V/Bx2+ASwPlQWFTdP4SYKW2fj4uKF7SkTpoz6HKjaK
 UJs3NsRVYB/+2e3cTF7IIHIVffk9d5Fk/LfIJSfhVf7r+Pwn9GlQUdppDHuiLZN+tK72
 Zv1UcGaWEgZrJjWseSriX14HE0hkA3IOlVW6s4vbMjo6d1k2rSel3q+kYUI9+Uw9AJLy
 ukmIKbqVWr3p9Q5hjWeAFJkbyfjnIJ7/IkyGkWvIRDAKEF6tZN5eougPjDvZd3SLlfaN
 XTfw==
X-Gm-Message-State: APjAAAVxSrtzs6Wl1zDUlEvRlUQFtuDfNKAH99QHxq3FESjqV5Jk2y/W
 LQl8HLoCqgO+D4hsayOxuktMP7z7+fxQnF4MlaedjXtLL8NipwZDCnWjUxgFyt2PpMlfKjaOftF
 LU+9Fxw6e4kEhBhg=
X-Received: by 2002:ad4:48c6:: with SMTP id v6mr40085751qvx.207.1582493128649; 
 Sun, 23 Feb 2020 13:25:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOjhAJ4YJC09/n5DtyF/iGRO7seGpjNKO8TQJ8ZQv5+XgiBu7EJSuQbb7ii3Yo5cXLf39x7Q==
X-Received: by 2002:ad4:48c6:: with SMTP id v6mr40085740qvx.207.1582493128431; 
 Sun, 23 Feb 2020 13:25:28 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 s42sm5039478qtk.87.2020.02.23.13.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 13:25:27 -0800 (PST)
Date: Sun, 23 Feb 2020 16:25:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: miaoyubo <miaoyubo@huawei.com>
Subject: Re: [RFC v3 3/3] ACPI/unit-test: Add a new test for pxb-pcie for arm
Message-ID: <20200223162502-mutt-send-email-mst@kernel.org>
References: <20200221063512.1104-1-miaoyubo@huawei.com>
 <20200221063512.1104-4-miaoyubo@huawei.com>
 <20200221061811-mutt-send-email-mst@kernel.org>
 <817d9cb2699d4294a2ba4ae949079eea@huawei.com>
MIME-Version: 1.0
In-Reply-To: <817d9cb2699d4294a2ba4ae949079eea@huawei.com>
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 22, 2020 at 09:40:07AM +0000, miaoyubo wrote:
>=20
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Friday, February 21, 2020 7:19 PM
> > To: miaoyubo <miaoyubo@huawei.com>
> > Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; imammedo@redhat.com;
> > qemu-devel@nongnu.org
> > Subject: Re: [RFC v3 3/3] ACPI/unit-test: Add a new test for pxb-pcie f=
or arm
> >=20
> > On Fri, Feb 21, 2020 at 02:35:12PM +0800, Yubo Miao wrote:
> > > From: miaoyubo <miaoyubo@huawei.com>
> > >
> > > Currently, pxb-pcie could be defined by the cmdline like
> > >     --device pxb-pcie,id=3Dpci.9,bus_nr=3D128 However pxb-pcie is not
> > > described in acpi tables for arm.
> > >
> > > The formal two patches support pxb-pcie for arm, escpcially the
> > > specification for pxb-pcie in DSDT table.
> > >
> > > Add a testcase to make sure the ACPI table is correct for guest.
> > >
> > > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> >=20
> >=20
> > Please look at the top of tests/qtest/bios-tables-test.c for how to add=
 or
> > update tests.
> >=20
>=20
> Thanks for replying, I didn't notice that, I would follow the steps to re=
build this patch.
>=20
> > > ---
> > >  tests/data/acpi/virt/DSDT.pxb  | Bin 0 -> 34209 bytes
> > > tests/qtest/bios-tables-test.c |  54 +++++++++++++++++++++++++++++---=
-
> > >  2 files changed, 48 insertions(+), 6 deletions(-)  create mode 10064=
4
> > > tests/data/acpi/virt/DSDT.pxb
> > >
> > > diff --git a/tests/data/acpi/virt/DSDT.pxb
> > > b/tests/data/acpi/virt/DSDT.pxb new file mode 100644 index
> > >
> > 0000000000000000000000000000000000000000..4eea3192c75ff28f7054d626
> > a936
> > > 3ca025b6c0ad
> > > GIT binary patch
> >=20
> > I can't read this.
> >=20
>=20
> I just have a question that is:=20
> I just rebuild this aml with tests/data/acpi/rebuild-expected-aml.sh
> and git send it or send the aml with attachment?

git send it pls


> > > literal 34209
> > >
> > zcmeI*cXU+szJ~D)1PGxe5PG+us9-{<Do8R35G4>YGz}UAMT!L#ks?x*Dx!d5hoIP
> > d
> > >
> > z?}}o>iWL;GW5HgrlKbvVM&HM??^)~qbMIProvd|8p2_U*%qO!m?AgcPkRQ(<w
> > r)WX
> > >
> > zR3DKyBsMVKK5tZUEMJ#Z3xXj0I{cizY-H-_vUpxu>HL<ltgNimvVn#9^>bszg^Hd*
> > >
> > zYT59@{GfDxK}u{$QSzH5MFX?4va_qcnOYVriD$G-YqqdX5KgQUqzA#0T0ymH9a
> > J-P
> > > zt=3D#;Qdf_)p=3DV$jH6t9{xXmH68P3ev)8EFlwrs(=3DX$_(9dxJh>6UU8FZi5vcVla=
%Bp
> > >
> > zz50)g^-pXvw4i9XAYFAU@nN}Xb+t___n%u<uhU$chBua*GNL5;Gf3Q8mfgX>w)`
> > 8L
> > >
> > z7F4goX88!*;pB+$X8&bG_2BOj*;OO*!h6xx&B+mI)uU#l*o>||BPVi3ji?#5Y(|dH
> > >
> > z=3DoUF6C2B^h&FJPcx<}5a88su#W_0%%JtAk+ikeZ+X7unGJtJq-j+)WHX7uzKy&`9
> > %
> >=20
> > ...
>=20
> Regards,
> Miao


