Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF6C2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+7edevE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF6C2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLM7v-0006b2-QJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLM7C-0006Ar-9s
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLM78-0003Lb-Vj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600934185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=04ZfXu+36pP3cJKwCp5rrCGp2bm0gK5QBA+jc7xjy3U=;
 b=M+7edevE9hGFtHBFH06O0M2jwe8pvex19WFZff3ULoP1mQTgbLr+6Oghzg2cH7Go7qWS66
 wbbwvpXt8IxSrxKdy/kB6q+cdePorWwnlAmFrgM7V5LViMyecOLqvV3WA2dK2Xk3OFQ8lp
 whYIaxwUwWH3T1GfOZdOoDO+L5ycg9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-QqeDXK0OPsKkEOb7buBvIg-1; Thu, 24 Sep 2020 03:56:24 -0400
X-MC-Unique: QqeDXK0OPsKkEOb7buBvIg-1
Received: by mail-wm1-f72.google.com with SMTP id x6so924581wmi.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 00:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=04ZfXu+36pP3cJKwCp5rrCGp2bm0gK5QBA+jc7xjy3U=;
 b=Qz1lfbG7ExOysQpLwcUvL5WkKcz4l8nK3OsQWA107t7eZzDt7jxKhs9rNjP2vRMcXG
 QF2El7W4PBLiQDjmUGOVAOM9Ng41Lv6Y4NNgJ5ZlDcZV0idLiaX3xjwONXVFbqfwFzgT
 0spClQguL8Nqa7uFtPg2zLz0HRHsyig8U8YySZZNOtXEnJM07uQBEyyUYNrig4axtuSP
 8+3ZvSnC5tDL0XEbZaN9w7S/hefExDUl/Yxgku3lcfrGkBdHU1YgvCynW2gtrHx2+2TC
 NR5eS8JJqzpFn8gx+wEiteGsEEsSaDYM+eYgcTi8buZ8NwC2zPGgHj6Taz1TLQId3YHQ
 Nd8g==
X-Gm-Message-State: AOAM530G1PYqRgeeVoFbXLf1c9bVuo1AdwTjHxbm87/AOCiOLWOQgWfF
 LmnrBJSo71Oi9ZNIvrjdIZqNlkuT3QUnEK3G+kt2vZTPzQlILjxvtBmpQt1kqEqhZf0SjWWNxTG
 mCxSc5BRhBP5rrqk=
X-Received: by 2002:adf:9c93:: with SMTP id d19mr3657482wre.275.1600934182825; 
 Thu, 24 Sep 2020 00:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye26bVuDZkQzhT2/ms5qQkCLWvsty5PonclsiwPcTGEPc/XgPwgyPJQldTYtuuHTi3khz/Pw==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr3657454wre.275.1600934182557; 
 Thu, 24 Sep 2020 00:56:22 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id i3sm2572313wrs.4.2020.09.24.00.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 00:56:21 -0700 (PDT)
Date: Thu, 24 Sep 2020 03:56:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/pci/pci: Fix slot check for plugged devices
Message-ID: <20200924035355-mutt-send-email-mst@kernel.org>
References: <20200923092636.118676-1-jusual@redhat.com>
 <20200923110141-mutt-send-email-mst@kernel.org>
 <CAMDeoFUaUNPvGJ1ohADdiptH0PGK8rBBRKQUUwhKEFMxqu0Crg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDeoFUaUNPvGJ1ohADdiptH0PGK8rBBRKQUUwhKEFMxqu0Crg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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

On Wed, Sep 23, 2020 at 05:57:19PM +0200, Julia Suvorova wrote:
> On Wed, Sep 23, 2020 at 5:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 11:26:36AM +0200, Julia Suvorova wrote:
> > > If devfn is assigned automatically, 'else' clauses will never be
> > > executed. And if it does not matter for the reserved and available
> > > devfn, because we have already checked it, the check for function0
> > > needs to be done again.
> > >
> > > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> >
> > This is just cosmetics right? I wouldn't describe this as
> > a "fix" then - "simplify" would be clearer.
> 
> No, this is a bug fix. For example, if you had a root port with a
> device on it already, and you do
> 'device_add new_device,bus=the_same_root_port', then it will miss the
> last 'if' and will be added to slot 1.

OK and I think that is the only example - if devfn is not supplied
and is auto-assigned. Can you add this to commit log pls?


> > > ---
> > >  hw/pci/pci.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index de0fae10ab..ae132b0b52 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -1034,8 +1034,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> > >                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> > >                     bus->devices[devfn]->name);
> > >          return NULL;
> > > -    } else if (dev->hotplugged &&
> > > -               pci_get_function_0(pci_dev)) {
> > > +    };
> > > +
> > > +    if (dev->hotplugged && pci_get_function_0(pci_dev)) {
> > >          error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
> > >                     " new func %s cannot be exposed to guest.",
> > >                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> > > --
> > > 2.25.4
> >


