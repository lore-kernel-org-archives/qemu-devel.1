Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D96C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC72207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KePxMkjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC72207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6rC-0003c3-W9
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kQ6qZ-0003Aw-3L
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kQ6qW-0008St-Ix
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602067134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwIqSkXpFwMFt2x/6tbJfMrqcwigKELghFr+J2bh34M=;
 b=KePxMkjnbr6gDuBG/I4iX7Jn45KddmMArqatLZmH3oVecFgPCB02A8vxCP1hbMsU2sCsMJ
 1sZCGi/BYAlJO07jl9s+O7iaPgYn+byXW8aunRqj5hDhM43sUEb4bo1TiMK0EKusdYky74
 OVrIXzaEu0BoHZdmervHj5c+y8kf6d4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-hzOzOK6MOKWBMoDVcFAx-g-1; Wed, 07 Oct 2020 06:38:52 -0400
X-MC-Unique: hzOzOK6MOKWBMoDVcFAx-g-1
Received: by mail-oi1-f200.google.com with SMTP id k65so704122oih.9
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 03:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SwIqSkXpFwMFt2x/6tbJfMrqcwigKELghFr+J2bh34M=;
 b=DpBccIwBNO1JUWT/vk2beMksXcSNGVaRQBeDwfksaNfSOWvOqoO3vtNUJUhIlGjy9L
 4Baq1/62LUJ4wwnj834cBRyfHbl1Lq4z1Oci9MFx0dav6I5BSMb8rer7es+iE1SzzDA7
 pCXPRonuIdth43cOQi8FWSqYgKTTLJycqJ4hT5jjT5lNvyK6g5WviXvhBWY36ZUhGBN/
 DGCpJidXGdrQnk0jWamDsz4qApO/67R9/nkEuMUeXMpt8KPCPqRDkz3c0FBKvWGGykO7
 ztr4SVM0FSPaYx2J/m22euRKuw2yzPmg5vQw80aQZVVt0SVxpiuWJlyyPFYhbrto3C7h
 +3bQ==
X-Gm-Message-State: AOAM530nNQyH87i8/bIrPf3IzVSat61DnMf/u/rJfZ0+TxO9WfrT+tUu
 QKD4HBgmubWNZvVwJViDdIVW3NzXJcxghacGcgbVZgN8r3TwGAn3jSEbHyGnCBgNzIhZ9UTmqoH
 Aanw2JrRJb8emRmhTmK19Cjo4QEGbZV0=
X-Received: by 2002:a05:6830:4b5:: with SMTP id
 l21mr1535444otd.334.1602067132138; 
 Wed, 07 Oct 2020 03:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcs/bi1Tslvlgbhj8X6IQj7cSJz4IOs3hCtPve+HW4n3axGTyPXuy/9iwWkE374UzG06W/V14SzXNSWF6cEDA=
X-Received: by 2002:a05:6830:4b5:: with SMTP id
 l21mr1535429otd.334.1602067131888; 
 Wed, 07 Oct 2020 03:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201006125908.598388-1-jusual@redhat.com>
 <20201007073912.nyki6x7hy6qh6gtb@steredhat>
In-Reply-To: <20201007073912.nyki6x7hy6qh6gtb@steredhat>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 7 Oct 2020 12:38:40 +0200
Message-ID: <CAMDeoFXqqKBH=s5KLSuanTNSN97v7XCmZLKra568kZ7qCG3+kA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci/pci: Fix slot check for plugged devices
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 7, 2020 at 9:39 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, Oct 06, 2020 at 02:59:08PM +0200, Julia Suvorova wrote:
> > If devfn is assigned automatically, 'else' clauses will never be
> > executed. And if it does not matter for the reserved and available
> > devfn, because we have already checked it, the check for function0
> > needs to be done again.
> >
> > Steps to reproduce:
> > 1. Run QEMU with:
> >         -M q35 \
> >         -device pcie-root-port,id=rp,.. \
> >         -device pci-device,bus=rp
> > 2. Add a new device to the same port:
> >         device_add pci-device,bus=rp
> >
> > The last command will add the device to slot 1 instead of
> > failing with "PCI: slot 0 function 0 already occupied..."
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> > v2:
> >     * add example to the commit message [Michael]
> >
> >  hw/pci/pci.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index de0fae10ab..ae132b0b52 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1034,8 +1034,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> >                     bus->devices[devfn]->name);
> >          return NULL;
> > -    } else if (dev->hotplugged &&
> > -               pci_get_function_0(pci_dev)) {
> > +    };
>         ^
> This semicolon seems unnecessary, can we take it out?

Oops, thanks for pointing out.


