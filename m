Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6150C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B40C20897
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fV/SmvVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B40C20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7AR-0008MP-3Y
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kL79D-0007Hm-G8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kL79B-0003Fi-PH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600876652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NAeE5WCTF+/VqlEOdbW/VE65ZlxE0/+/Y+hXM5K2Ifs=;
 b=fV/SmvVA8eeGDfI+7ephbYAaVZemMZEz1wYEDUeJLnfNpO6XDpfK7FBcl5amouBL1AdKhu
 uD+NfO55oX+kj5MwjPqYpmeiNtiQdjhOURhK93cvbtV3JDcRg7z16k3FTdasjrDdOyJ6RW
 +7FGBTCwDsIgJlrbnPEbpRZpg98Tac4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-6509nZT4OT23yq01O9wabQ-1; Wed, 23 Sep 2020 11:57:30 -0400
X-MC-Unique: 6509nZT4OT23yq01O9wabQ-1
Received: by mail-yb1-f197.google.com with SMTP id l67so148052ybb.7
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NAeE5WCTF+/VqlEOdbW/VE65ZlxE0/+/Y+hXM5K2Ifs=;
 b=uaPmZUKIGfIpG9TaoNvDYegjZjIELzcFJI7ol6wdcQP/hpsXkYZVVVEdyPDe0uzfuj
 Zvr3LO6jCqNTb7QupsQ3saype9lu1obLjgqbE567rRmou+dvHz5HGrGXOoAWJyCy3tm+
 E3wtVSPAi3lI2jdnXsiOVODC8Ym8i0QQ3d3Glctx8tzeR7gESpSvLvKqqRdYUVWl3T59
 B//Fx3qZq1srrJMGP7GAKXVNrm7Xl2q5Fq2eYLEFJU32sNqZRePeQB87fSU2/0ya8pk+
 CwWN6Uz1tOey3wp3GQE5YyHhclHY2kEv4UEvqbAIhKwukCrHcz7/dKfos9AaKodM8xWe
 /v1Q==
X-Gm-Message-State: AOAM531IVPx88qaFynOfEHgoLwiVfZ9J4YFaaa6KRGeevC4Hwy6zOvrc
 Lz46cbi4Vvl9CfJAPfKBK1Te6IT0+UEjFWoNatDZonyUXv4eKPxozKv6V5ni3G3F+uRn1UMg+un
 51sIxUZK9uq2ky4eSfVH3Ryu4CYBAFR4=
X-Received: by 2002:a25:4ac2:: with SMTP id x185mr944544yba.81.1600876650434; 
 Wed, 23 Sep 2020 08:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvvLWt3d1wl+O0qL2Qa7Z5x5zpx8hgaMgaP49A4WTtUJGiyjFv0tewJghrtYpGX1T8lBnf6FbTl9Uy/ce/VR8=
X-Received: by 2002:a25:4ac2:: with SMTP id x185mr944518yba.81.1600876650183; 
 Wed, 23 Sep 2020 08:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200923092636.118676-1-jusual@redhat.com>
 <20200923110141-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200923110141-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 23 Sep 2020 17:57:19 +0200
Message-ID: <CAMDeoFUaUNPvGJ1ohADdiptH0PGK8rBBRKQUUwhKEFMxqu0Crg@mail.gmail.com>
Subject: Re: [PATCH] hw/pci/pci: Fix slot check for plugged devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 5:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 23, 2020 at 11:26:36AM +0200, Julia Suvorova wrote:
> > If devfn is assigned automatically, 'else' clauses will never be
> > executed. And if it does not matter for the reserved and available
> > devfn, because we have already checked it, the check for function0
> > needs to be done again.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
>
> This is just cosmetics right? I wouldn't describe this as
> a "fix" then - "simplify" would be clearer.

No, this is a bug fix. For example, if you had a root port with a
device on it already, and you do
'device_add new_device,bus=the_same_root_port', then it will miss the
last 'if' and will be added to slot 1.

> > ---
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
> > +
> > +    if (dev->hotplugged && pci_get_function_0(pci_dev)) {
> >          error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
> >                     " new func %s cannot be exposed to guest.",
> >                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> > --
> > 2.25.4
>


