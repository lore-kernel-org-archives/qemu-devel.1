Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED222C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B926220771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/QQHCDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B926220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Afn-0005qu-Vd
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k6AcG-0000f6-5v
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:37:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k6AcD-0007RV-Bh
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597315064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5jhfmE78Ank/M8YTF7hOoOkIT3ARZ6eZkmx0dqwLpY=;
 b=E/QQHCDXqYddVRFrzvLjvQKrcP4c8Q9pFYYBPBAv2/E3aAk1gvkx1/Y08i3bz4+zEf86qP
 BKt5OVMi3aeDq9a0OKK/o6wOO3B1njpSGza2ThREndxA+FDGeojt1hocfP7yVF0wKuFX2q
 b62ytB4fPVw7LreWtcfEEL8KqQh6K/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-9K5J73HaP2CUSh8JV8A2jg-1; Thu, 13 Aug 2020 06:37:42 -0400
X-MC-Unique: 9K5J73HaP2CUSh8JV8A2jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16204800465;
 Thu, 13 Aug 2020 10:37:41 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC8E754596;
 Thu, 13 Aug 2020 10:37:39 +0000 (UTC)
Date: Thu, 13 Aug 2020 12:37:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200813123737.25ba11d2.cohuck@redhat.com>
In-Reply-To: <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
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

On Thu, 13 Aug 2020 12:24:30 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Thu, Aug 13, 2020 at 11:28:20AM +0200, Cornelia Huck wrote:
> > On Thu, 13 Aug 2020 11:16:56 +0200
> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> >   
> > > Hi,
> > > 
> > > Qinghua discovered that virtio-vsock-pci requires 'disable-legacy=on' in
> > > QEMU 5.1:
> > >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> > >     qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
> > >     device is modern-only, use disable-legacy=on
> > > 
> > > Bisecting I found that this behaviour starts from this commit:
> > > 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")  
> > 
> > Oh, I had heard that from others already, was still trying to figure
> > out what to do.
> >   
> > > 
> > > IIUC virtio-vsock is modern-only, so I tried this patch and it works:
> > > 
> > > diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
> > > index f4cf95873d..6e4cc874cd 100644
> > > --- a/hw/virtio/vhost-user-vsock-pci.c
> > > +++ b/hw/virtio/vhost-user-vsock-pci.c
> > > @@ -40,6 +40,7 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > >      VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
> > >      DeviceState *vdev = DEVICE(&dev->vdev);
> > > 
> > > +    virtio_pci_force_virtio_1(vpci_dev);
> > >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > >  }
> > > 
> > > diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
> > > index a815278e69..f641b974e9 100644
> > > --- a/hw/virtio/vhost-vsock-pci.c
> > > +++ b/hw/virtio/vhost-vsock-pci.c
> > > @@ -44,6 +44,7 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > >      VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
> > >      DeviceState *vdev = DEVICE(&dev->vdev);
> > > 
> > > +    virtio_pci_force_virtio_1(vpci_dev);
> > >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > >  }
> > > 
> > > 
> > > Do you think this is the right approach or is there a better way to
> > > solve this issue?  
> > 
> > We basically have three possible ways to deal with this:
> > 
> > - Force it to modern (i.e., what you have been doing; would need the
> >   equivalent changes in ccw as well.)  
> 
> Oo, thanks for pointing out ccw!
> I don't know ccw well, in this case should we set dev->max_rev to 1 or 2
> to force to modern?

No, ->max_rev is the wrong side of the limit :) You want

    ccw_dev->force_revision_1 = true;

in _instance_init() (see e.g. virtio-ccw-gpu.c).

> 
> >   Pro: looks like the cleanest approach.
> >   Con: not sure if we would need backwards compatibility support,
> >   which looks hairy.  
> 
> Not sure too.

Yes, I'm not sure at all how to handle user-specified values for
legacy/modern.

> 
> > - Add vsock to the list of devices with legacy support.
> >   Pro: Existing setups continue to work.
> >   Con: If vsock is really virtio-1-only, we still carry around
> >   possibly broken legacy support.  
> 
> I'm not sure it is virtio-1-only, but virtio-vsock was introduced in
> 2016, so I supposed it is modern-only.

Yes, I would guess so as well.

> 
> How can I verify that? Maybe forcing legacy mode and run some tests.

Probably yes. The likeliest area with issues is probably endianness, so
maybe with something big endian in the mix?

> 
> > - Do nothing, have users force legacy off. Bad idea, as ccw has no way
> >   to do that on the command line.
> > 
> > The first option is probably best.
> >  
> 
> Yeah, I agree with you!

Yes, it's really a pity we only noticed this after the release; this
was supposed to stop new devices with legacy support creeping in, not
to break existing command lines :(


