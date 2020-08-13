Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69CBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA9B20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6Mtq5Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA9B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Bz7-0004zn-PB
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 08:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k6ByG-00047s-40
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:04:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k6ByD-0000q9-J2
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597320272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJux2VX19AwNMwQRYmCdyCdxmnbGFqpddYotbE7ZAcM=;
 b=S6Mtq5Vl+bs462o+ZJXY12nFRc6BlTtgx4mmRMGWgO4ZSNMDsduHp1nODxzNYpsXnPIH1u
 IHdi4K4U1Iip1o6salq/Y2BP8hNl39a8mBLCDijJtTee5qWc5gCNr9RI0eJs/mFQv6UqeC
 6N930TK8Y9b+HXvhE7ln/Ni3Rhby97c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-i95Z1yVhPw28I2KlYZ3vvA-1; Thu, 13 Aug 2020 08:04:31 -0400
X-MC-Unique: i95Z1yVhPw28I2KlYZ3vvA-1
Received: by mail-wm1-f71.google.com with SMTP id f74so2139205wmf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 05:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KJux2VX19AwNMwQRYmCdyCdxmnbGFqpddYotbE7ZAcM=;
 b=CdLmZkhudSDUXwFBCTD5foek7g0dlXnwtbH8XlXNCUbFWKH7bCjM25cGJWU1TMFGQo
 +FN7gZojz1Zwy5SHE/0OEkhzk7TRihsjvzOwu892einVLMNV5V4wqmnnkwHBwQpIx20A
 HplRETUHsg1dbklLy5GJ70UibcB63rIbZic/k6pB5f0Xh4n2Lo0ipGcpCSPOE1OPMaM6
 GraUQ0+oV+1hATzffsMtYfdjsfi5FI1Fqh/b5lXLoRny3Zc+Bhn8t/754+U0GhzPqcmf
 uPaB2IcMtgFnoZtafczrP00fxb+pIzG0F7tyYonLpHzR+pnv0AggGIPFUtwQvYnQ/RgZ
 ogdg==
X-Gm-Message-State: AOAM532bjVduRPevyHXhqaeigyP4z7tdGTqnxRWUdq+N2pXzM/iS6Rpn
 zjoBjif7bUyKLwMYl6XnHx0CqyV+lDMXMMZGw12+Zbv/hOsibpVEaDYk4VmkMTBg480tx0YD6Qi
 S9ZdGOoS9+4WFA24=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3753621wrp.412.1597320270214; 
 Thu, 13 Aug 2020 05:04:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQzdVQuRijnytE0r38YKOw2Np9VEX9M55F1ZMRVbIkq8q81SyescP+2QDhKMzL/2X+Tk1NmQ==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3753592wrp.412.1597320269882; 
 Thu, 13 Aug 2020 05:04:29 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id p3sm8808681wma.44.2020.08.13.05.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 05:04:29 -0700 (PDT)
Date: Thu, 13 Aug 2020 14:04:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
 <20200813123737.25ba11d2.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813123737.25ba11d2.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 12:37:37PM +0200, Cornelia Huck wrote:
> On Thu, 13 Aug 2020 12:24:30 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Thu, Aug 13, 2020 at 11:28:20AM +0200, Cornelia Huck wrote:
> > > On Thu, 13 Aug 2020 11:16:56 +0200
> > > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >   
> > > > Hi,
> > > > 
> > > > Qinghua discovered that virtio-vsock-pci requires 'disable-legacy=on' in
> > > > QEMU 5.1:
> > > >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> > > >     qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
> > > >     device is modern-only, use disable-legacy=on
> > > > 
> > > > Bisecting I found that this behaviour starts from this commit:
> > > > 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")  
> > > 
> > > Oh, I had heard that from others already, was still trying to figure
> > > out what to do.
> > >   
> > > > 
> > > > IIUC virtio-vsock is modern-only, so I tried this patch and it works:
> > > > 
> > > > diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
> > > > index f4cf95873d..6e4cc874cd 100644
> > > > --- a/hw/virtio/vhost-user-vsock-pci.c
> > > > +++ b/hw/virtio/vhost-user-vsock-pci.c
> > > > @@ -40,6 +40,7 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > > >      VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
> > > >      DeviceState *vdev = DEVICE(&dev->vdev);
> > > > 
> > > > +    virtio_pci_force_virtio_1(vpci_dev);
> > > >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > > >  }
> > > > 
> > > > diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
> > > > index a815278e69..f641b974e9 100644
> > > > --- a/hw/virtio/vhost-vsock-pci.c
> > > > +++ b/hw/virtio/vhost-vsock-pci.c
> > > > @@ -44,6 +44,7 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > > >      VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
> > > >      DeviceState *vdev = DEVICE(&dev->vdev);
> > > > 
> > > > +    virtio_pci_force_virtio_1(vpci_dev);
> > > >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > > >  }
> > > > 
> > > > 
> > > > Do you think this is the right approach or is there a better way to
> > > > solve this issue?  
> > > 
> > > We basically have three possible ways to deal with this:
> > > 
> > > - Force it to modern (i.e., what you have been doing; would need the
> > >   equivalent changes in ccw as well.)  
> > 
> > Oo, thanks for pointing out ccw!
> > I don't know ccw well, in this case should we set dev->max_rev to 1 or 2
> > to force to modern?
> 
> No, ->max_rev is the wrong side of the limit :) You want

Well :-) Thanks!

> 
>     ccw_dev->force_revision_1 = true;
> 
> in _instance_init() (see e.g. virtio-ccw-gpu.c).
> 
> > 
> > >   Pro: looks like the cleanest approach.
> > >   Con: not sure if we would need backwards compatibility support,
> > >   which looks hairy.  
> > 
> > Not sure too.
> 
> Yes, I'm not sure at all how to handle user-specified values for
> legacy/modern.
> 
> > 
> > > - Add vsock to the list of devices with legacy support.
> > >   Pro: Existing setups continue to work.
> > >   Con: If vsock is really virtio-1-only, we still carry around
> > >   possibly broken legacy support.  
> > 
> > I'm not sure it is virtio-1-only, but virtio-vsock was introduced in
> > 2016, so I supposed it is modern-only.
> 
> Yes, I would guess so as well.
> 
> > 
> > How can I verify that? Maybe forcing legacy mode and run some tests.
> 
> Probably yes. The likeliest area with issues is probably endianness, so
> maybe with something big endian in the mix?
> 

Yeah, I'll try this setup!

> > 
> > > - Do nothing, have users force legacy off. Bad idea, as ccw has no way
> > >   to do that on the command line.
> > > 
> > > The first option is probably best.
> > >  
> > 
> > Yeah, I agree with you!
> 
> Yes, it's really a pity we only noticed this after the release; this
> was supposed to stop new devices with legacy support creeping in, not
> to break existing command lines :(
> 

Yes, I forgot to test vsock stuff before the release :-(
Maybe we should add some tests...

Thanks,
Stefano


