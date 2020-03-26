Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC67C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D2620737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhZwuQpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D2620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSce-0006Cw-1A
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHSbP-00056s-ID
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHSbN-0006I6-1z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:31:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHSbM-0006Hw-TQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9wvyXm/NiqMxOfQgjl+Dn0251GrufGeTCkcH+UFLrU=;
 b=ZhZwuQpcrGE20pMt0iMQM3nQGYfMIYMH4w+aubOLiIA8FBRy/BihhGLaznYld4p4no9TIH
 3oUDffiPviylch3v9FESA3N/KL7PV65xnTKcO28qkC65JBDw+7JR2D/IpkRtLRCB8NBCI8
 kz3tXRq6MaWvh675axXyd6VEVmdxTF4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-AqhxTTRMNi2Ksg0p8x-Z9w-1; Thu, 26 Mar 2020 09:31:14 -0400
X-MC-Unique: AqhxTTRMNi2Ksg0p8x-Z9w-1
Received: by mail-wr1-f72.google.com with SMTP id w12so3024324wrl.23
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IYk+1YATkj0Us4enXSB7D3aGcb6w+ELDdxAg6BAj7Yk=;
 b=T4NolO1/zE9A6SsK7qiDWQhSJHpckyWyewodGG77sM7a+eKWcA3izgdmdCAdhXOPLg
 ijNsAAAh2Z3C+DGjNfMOp67gUyFOIH+8xAteSt00UJxmXn+jt8g9cKT60rEIz4eNZhMM
 6DL7G7xMSKuawZPfpg+43uNUHj1qyS7PrNWSrwDNOEEyOPxbqPNXq4nMAGJkFLtywS2V
 fdLlwwKAxuDQmZQe4iC/adDtopUQtnwE2WzJrmlzXHoj//0MEKk5i6I1E0w5/e2luy64
 NmGr+4k3rFnJklCYNU8iS/kriUuUObc/BJiqF7H9dNHneJY/bvBQYK8Vte5XWuzbb590
 tTsQ==
X-Gm-Message-State: ANhLgQ1TfX6WNXGoH1mmD6sQuFJpyFhsze5uXs2MA4C++yK36nDUO1lh
 GFBwLo7cTA4+bsAGK3Ghf3M1kj4gir7iX6PG1MrfGQyr+vt752zL4qb7saVp2moEKHohlmcYnvW
 awPpyR9EFKEQ8J4c=
X-Received: by 2002:a1c:988d:: with SMTP id a135mr20853wme.16.1585229472954;
 Thu, 26 Mar 2020 06:31:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vufUty0FRpTfVa4gkgajSnaNXGFnRF4Rof6RAjYuOedSjwxxa3X1q74OtKY+ZeaMX2NWdEUVA==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr20831wme.16.1585229472698;
 Thu, 26 Mar 2020 06:31:12 -0700 (PDT)
Received: from redhat.com (bzq-109-67-62-195.red.bezeqint.net. [109.67.62.195])
 by smtp.gmail.com with ESMTPSA id g186sm3693908wmg.36.2020.03.26.06.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:31:12 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:31:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: acpi_pcihp_eject_slot() bug if passed 'slots == 0'
Message-ID: <20200326092955-mutt-send-email-mst@kernel.org>
References: <CAFEAcA-oWBjOXWmnLvPww9wrty_QbSc+Xv3BY3sQAnEXFkfQbA@mail.gmail.com>
 <20200326142317.018c13e1@redhat.com>
 <20200326092535-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200326092535-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 09:28:27AM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 26, 2020 at 02:23:17PM +0100, Igor Mammedov wrote:
> > On Thu, 26 Mar 2020 11:52:36 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >=20
> > > Hi; Coverity spots that if hw/acpi/pcihp.c:acpi_pcihp_eject_slot()
> > > is passed a zero 'slots' argument then ctz32(slots) will return 32,
> > > and then the code that does '1U << slot' is C undefined behaviour
> > > because it's an oversized shift. (This is CID 1421896.)
> > >=20
> > > Since the pci_write() function in this file can call
> > > acpi_pcihp_eject_slot() with an arbitrary value from the guest,
> > > I think we need to handle 'slots =3D=3D 0' safely. But what should
> > > the behaviour be?
> >=20
> > it also uncovers a bug, where we are not able to eject slot 0 on bridge=
,
>=20
>=20
> And that is by design. A standard PCI SHPC register can support up to 31
> hotpluggable slots. So we chose slot 0 as non hotpluggable.
> It's consistent across SHPC, PCI-E, so I made ACPI match.

Sorry I was confused. It's a PCI thing, PCI-E does not have
slot numbers for downstream ports at all.

> You can't hot-add it either.
>=20
> > can be reproduced with:
> >=20
> >  -enable-kvm -m 4G -device pci-bridge,chassis_nr=3D1 -global PIIX4_PM.a=
cpi-pci-hotplug-with-bridge-support=3Don -device virtio-net-pci,bus=3Dpci.1=
,addr=3D0,id=3Dnetdev12
> >=20
> > (monitor) device_del netdev12
> > (monitor) qtree # still shows the device
> >=20
> > reason is that acpi_pcihp_eject_slot()
> >    if (PCI_SLOT(dev->devfn) =3D=3D slot) { # doesn't  match (0 !=3D 32)
> >=20
> > so device is not deleted
>=20
> We should probably teach QEMU that some slots aren't hotpluggable
> even if device in it is hotpluggable in theory. But that is
> a separate issue.
>=20
> > > thanks
> > > -- PMM
> > >=20


