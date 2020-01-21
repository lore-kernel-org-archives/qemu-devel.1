Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E498DC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF71D22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du6hqKA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF71D22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itn8s-0000I5-Q7
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1itn86-00086f-8H
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1itn84-0007lu-VK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:35:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1itn84-0007lR-RW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579588512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OUvEKKlROGtujXMnDJksWS4Q2yXG8c0+NRjLFjnsrc=;
 b=du6hqKA6iaGxmOIF3X7rPk8smq0LthRHkZGtIX2wX/2UadVLXJc5Fywctt7hlJ10AxoNik
 S2rI30cFWfym3mtaLW3Za/VFO+8BL2qEVGsOqQsxxLfR1JTA9hyiU1j53MZMeckCC2kdLD
 rnlszLKHKbb/H9shcdVUQ9hwg8ylgyo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-yvt5ZF4lNem0HdBYJkOpvw-1; Tue, 21 Jan 2020 01:35:09 -0500
Received: by mail-qv1-f72.google.com with SMTP id l1so980116qvu.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 22:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+bCOxOtxPTd6B2o3yuNHhUE10cJLKnqqqRdS8U7GWlU=;
 b=treNJOUITvT+2n1Ng+d5aig6uSLcpm9joduqvdBbowo4C/CKT861HVO7CcLoBmvF8N
 IhlUwbxdNALwqtvZTMw1ktjM//q1jY9DqkNUqMZst/kAIAnRDsIKOy9pzMXKoLi4Uby5
 /iAaOFlvjZr7bupgtD7VbxeNWtKTQULYGWijYM/2Is1KvDXRP9yPZ5+WhMih81M2GXzO
 P4jbK/XQK79MKR6gtUwbAM2OojE+B0fZ2j1boS6kHBpYz95rnNVnNlKlDNHhjf7Z2zqe
 hIXqdAydld5jO+EXxGYoHbujXSeMjjblIcrrenpviU5c2Kgos7E+HQXFcWWmzK8fb5XM
 oV4w==
X-Gm-Message-State: APjAAAUVZMt3ufg2I/FR90tNbYQN3JJJRl3AG9XN2Tj7yvPOJQYFZJCy
 coYsPyla/nJ66UcgnnLC24GAwiqoVc68CQVNVWMVtUDReqJq8ig4AS8asNndPkfLMGiN6Kes13H
 lh8wOxaVDE6z7YUA=
X-Received: by 2002:a05:620a:910:: with SMTP id
 v16mr3222712qkv.194.1579588508770; 
 Mon, 20 Jan 2020 22:35:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbZGOkbB02PHy4i4uyyq3w0lri1W4iIRLseJTC17U89Z2zqgOzHLlW7uaqFZMVNySQJaphhg==
X-Received: by 2002:a05:620a:910:: with SMTP id
 v16mr3222704qkv.194.1579588508473; 
 Mon, 20 Jan 2020 22:35:08 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
 by smtp.gmail.com with ESMTPSA id e3sm18728863qtb.65.2020.01.20.22.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 22:35:07 -0800 (PST)
Date: Tue, 21 Jan 2020 01:35:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 1/2] arm/virt/acpi: remove meaningless sub device "PR0"
 from PCI0
Message-ID: <20200121005533-mutt-send-email-mst@kernel.org>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-2-guoheyi@huawei.com>
 <20200113133702.1dea867b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200113133702.1dea867b@redhat.com>
X-MC-Unique: yvt5ZF4lNem0HdBYJkOpvw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 13, 2020 at 01:37:02PM +0100, Igor Mammedov wrote:
> On Thu, 19 Dec 2019 14:47:58 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>=20
> > The sub device "PR0" under PCI0 in ACPI/DSDT does not make any sense,
> > so simply remote it.
> Could you make commit message more concrete so it would say
> why it doesn't make any sense.
>=20
> It seems to be there to describe root port,
> I'd rather have PCI folk ack if it's ok to remove it.

An empty device like this doesn't really do anything useful I think.
commit log needs to be fixed up though.


> >=20
> > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> >=20
> > ---
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> > Cc: qemu-arm@nongnu.org
> > Cc: qemu-devel@nongnu.org
> > ---
> >  hw/arm/virt-acpi-build.c          |   4 ----
> >  tests/data/acpi/virt/DSDT         | Bin 18462 -> 18449 bytes
> >  tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 19786 bytes
> >  tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 18449 bytes
> >  4 files changed, 4 deletions(-)
> >=20
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index bd5f771e9b..9f4c7d1889 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -317,10 +317,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const Me=
mMapEntry *memmap,
> >      aml_append(method, aml_return(buf));
> >      aml_append(dev, method);
> > =20
> > -    Aml *dev_rp0 =3D aml_device("%s", "RP0");
> > -    aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
> > -    aml_append(dev, dev_rp0);
> > -
> >      Aml *dev_res0 =3D aml_device("%s", "RES0");
> >      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")))=
;
> >      crs =3D aml_resource_template();
> > diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> > index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..b5895cb22446860a0b9be3d=
32ec856feb388be4c 100644
> > GIT binary patch
> > delta 39
> > vcmbO?fpOvlMlP3Nmk>b@1_q`B6S<_Bdg?Z+cXBfI+}XT|v(|R9jr$`2@RSW) =20
> >=20
> > delta 50
> > zcmbO@fpOjhMlP3Nmk>D*1_q{tiCof5o%I{lJ2{y;?{412S!>J19TZ>?&k^tF5;R%I =20
> > G{V4!>hYx%J =20
> >=20
> > diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSD=
T.memhp
> > index 41ccc6431b917252bcbaac86c33b340c796be5ce..69ad844f65d047973a3e551=
98beecd45a35b8fce 100644
> > GIT binary patch
> > delta 40
> > wcmcaUi}BPfMlP3Nmk=3D*s1_q}3iCof5t(P{ccXBfI+}XT|v(|RAjk`1(02g)*ivR!s
> >=20
> > delta 51
> > zcmX>#i}Cs_MlP3NmymE@1_mbiiCof5O_w*ScXBdy-rc;3v(}c2J1D>)o+IATC1|sb =20
> > HyBr$;t7;Fc
> >=20
> > diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/D=
SDT.numamem
> > index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..b5895cb22446860a0b9be3d=
32ec856feb388be4c 100644
> > GIT binary patch
> > delta 39
> > vcmbO?fpOvlMlP3Nmk>b@1_q`B6S<_Bdg?Z+cXBfI+}XT|v(|R9jr$`2@RSW) =20
> >=20
> > delta 50
> > zcmbO@fpOjhMlP3Nmk>D*1_q{tiCof5o%I{lJ2{y;?{412S!>J19TZ>?&k^tF5;R%I =20
> > G{V4!>hYx%J =20
> >=20


