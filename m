Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF65C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497342074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjnnowBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497342074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k160c-00032I-J4
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k1601-0002cp-UB
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:41:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39938
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k15zz-00079R-Ok
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 06:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596105677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6XOeW9XhNvYjnl7+yk45G9J0e5ufBAbxQ7CKl/UHAY=;
 b=TjnnowBbDqxUk+PEcOmxSiJj+vD6OWcxkIabkZkT0AXjDWc0/XR3EZQZmra0JB2lIuoheo
 6Pvvla8ywQJWmoExzrR9ippZEji/hxcyADJfn+1GEMEcoyRWFPIcZcz6pM9FmSBiFhPUtS
 Ze9zc1m1QtAVaArZIfiJJo4vrrctis0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-W5EGYOPhMzWRbZw29Xtm1Q-1; Thu, 30 Jul 2020 06:41:15 -0400
X-MC-Unique: W5EGYOPhMzWRbZw29Xtm1Q-1
Received: by mail-wr1-f70.google.com with SMTP id r29so3436961wrr.10
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 03:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D6XOeW9XhNvYjnl7+yk45G9J0e5ufBAbxQ7CKl/UHAY=;
 b=ECtsAUMZ3yyHr8hy/z/ewKJ1+NeDx5vQ2f1pzC5F2CGJyM1w/7wqCdmfVqpX1KETOp
 3svqLJM4wRJCQWu33mSDicG9UlXNAKLT3XMrbkU6pr81k9d5ks86Ds3Ja9BauGtKDqOF
 d2+61Z/GBptWYNnsp1HD1GjX3IJ0mSq1mNlYiv2XP/qyhlvKla9/AonIG2CGJ032LwkQ
 h+RY+85fTXTUbb/I3qcKZ3qN5dt7wgfAOlzn0EmDRCkh+48jfAcn8C376UiL8q3SrmWP
 U+gr0/+o4EOZ1Wf9tZ+vvjh0beDVwlZnNRoIYCjsKVG9iUigfdw9QmzBcRgZgDZMDKTE
 XmEg==
X-Gm-Message-State: AOAM531wSuAPM9TF3PSw0E6zzWectmkNxurs8WtoRYqDoPyp4+XpfUY4
 dRVujh/bolMJxwrgX5RlDGWH34xcsLPSZCVufOd9Z3aHSyLAhlhHIDNYyPeeLmEdSSuBay5yGsB
 xhoFF7O+iqR24B58=
X-Received: by 2002:a05:6000:4e:: with SMTP id
 k14mr33086324wrx.303.1596105674675; 
 Thu, 30 Jul 2020 03:41:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxECebGXgOsQhbsbG9fsCw2CsZG5O7tcZ6H8WRdcJ1azZk79yWX/Y5Tbd6guRcX0feneD/wyA==
X-Received: by 2002:a05:6000:4e:: with SMTP id
 k14mr33086270wrx.303.1596105673890; 
 Thu, 30 Jul 2020 03:41:13 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id k1sm9568057wrw.91.2020.07.30.03.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 03:41:13 -0700 (PDT)
Date: Thu, 30 Jul 2020 12:41:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Subject: Re: [PATCH] pci_dma_rw: return correct value instead of 0
Message-ID: <20200730104110.cyx6k36nismtiyor@steredhat.lan>
References: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
 <20200730074146.b66tur2v7tx4uo3d@steredhat.lan>
 <68b64151-6c5f-64e2-f9cb-baa460b6b985@gmail.com>
MIME-Version: 1.0
In-Reply-To: <68b64151-6c5f-64e2-f9cb-baa460b6b985@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 10:50:43AM +0200, Emanuele Giuseppe Esposito wrote:
> 
> 
> On 30/07/2020 09:41, Stefano Garzarella wrote:
> > On Thu, Jul 30, 2020 at 12:17:32AM +0200, Emanuele Giuseppe Esposito wrote:
> > > pci_dma_rw currently always returns 0, regardless
> > > of the result of dma_memory_rw. Adjusted to return
> > > the correct value.
> > > 
> > > Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> > > ---
> > >   include/hw/pci/pci.h | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > index c1bf7d5356..41c4ab5932 100644
> > > --- a/include/hw/pci/pci.h
> > > +++ b/include/hw/pci/pci.h
> > > @@ -787,8 +787,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
> > >   static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
> > >                                void *buf, dma_addr_t len, DMADirection dir)
> > >   {
> > > -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> > > -    return 0;
> > > +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> > >   }
> > 
> > I think it's a left over from when we used "void cpu_physical_memory_rw()".
> > 
> > I agree that it is better to return the dma_memory_rw() return value, but
> > at first look, no one seems to check the return value of pci_dma_rw(),
> > pci_dma_read(), andpci_dma_write().
> > 
> > Should we make them void?
> 
> I noticed that nobody checks the return of those functions, but I think
> checking for possible error is always useful. I am using the edu device and
> clearly doing something wrong since with this fix I discovered that the
> pci_dma_read call returns nonzero.
> 
> Keeping the function as it is or void would make it harder to spot such
> errors in future.

I agree, I was just worried that no one checks the return value.

Thanks,
Stefano


