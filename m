Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B975020675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcKuIsyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B975020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AQg-0006RT-TO
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k6APa-0005uF-0p
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:24:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35860
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k6APX-0005hY-Dd
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597314277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vyk9DrNTLE3+W69jb4q4cYzy8nQzOxzPnW19DqKh6Kk=;
 b=EcKuIsyKCbVuy/9u5HTJgB9HR25n9dRTijjQ+3n1ldyQofqC3juwD1LiQcnttQBTdDx7oi
 YcVDa4ROMgI1ndLFNTZmoJP5YIuczr7bn8f1RxyHyR9gDmme1jMvWJZxKHnINo+y0COd4m
 CmJ8hDj9wQa+x3Bc7m72zDnthVF7Icc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-dAQNE2NLNsSibvXCEEa1Dw-1; Thu, 13 Aug 2020 06:24:35 -0400
X-MC-Unique: dAQNE2NLNsSibvXCEEa1Dw-1
Received: by mail-wr1-f72.google.com with SMTP id e14so1891105wrr.7
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 03:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Vyk9DrNTLE3+W69jb4q4cYzy8nQzOxzPnW19DqKh6Kk=;
 b=SRPp8iQBA9FXelZSpZ7UMhlNUWD/7fPNNCknkqrW0DeM8N1fG0cc85UGsDEcQwMib2
 fLTkYhHrC8VCaXifliLmNHjcQQkXh7OAUFYrFY12/BO5rStngcAUVQ/1TTGWIv3ZH4nt
 UMsj3CNyHASYOUXjCuueQd35LFS9J2XiLLcS5PfjcW/OwCG0W6zcXTVno6Fw0hV+89hH
 VA1dHKO/dKiZ4eHYTwkOo5jlqj/xt0uAzPS5DeGz1Qhw+nzKkO8XfNKyCB3O7ClpNrXU
 JPKF8AAd+eOfFt8nvUtsP5W9HErhQand7JpIW692RJ0ov2+AkvpU3qCzNYGRcVbKFGf2
 JJcg==
X-Gm-Message-State: AOAM533y80ZcXv+93q6FXf3Rsn0NLfqsWm5ObIJ/WJgNGNVdphHdcHiP
 09AClzE2J5/qVfsZoMbvtEi1tl8Op+68CS7j2iPHFJScwT4FLl8jOQKxICP9oWFd7p8z/tGQuWX
 McgiovzlO5E0wGTk=
X-Received: by 2002:a5d:6584:: with SMTP id q4mr3390217wru.21.1597314274732;
 Thu, 13 Aug 2020 03:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFqzvWoGe0sQ0s0aHEo3QF0x8ufT3IigI3yrTD0MI89u+JiF3ACpqZQl8FhLjdPl1NS8/3iA==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr3390188wru.21.1597314274425;
 Thu, 13 Aug 2020 03:24:34 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id x82sm8897026wmb.30.2020.08.13.03.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 03:24:33 -0700 (PDT)
Date: Thu, 13 Aug 2020 12:24:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813112820.62ffd63e.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 11:28:20AM +0200, Cornelia Huck wrote:
> On Thu, 13 Aug 2020 11:16:56 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Hi,
> > 
> > Qinghua discovered that virtio-vsock-pci requires 'disable-legacy=on' in
> > QEMU 5.1:
> >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> >     qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
> >     device is modern-only, use disable-legacy=on
> > 
> > Bisecting I found that this behaviour starts from this commit:
> > 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
> 
> Oh, I had heard that from others already, was still trying to figure
> out what to do.
> 
> > 
> > IIUC virtio-vsock is modern-only, so I tried this patch and it works:
> > 
> > diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
> > index f4cf95873d..6e4cc874cd 100644
> > --- a/hw/virtio/vhost-user-vsock-pci.c
> > +++ b/hw/virtio/vhost-user-vsock-pci.c
> > @@ -40,6 +40,7 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >      VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
> >      DeviceState *vdev = DEVICE(&dev->vdev);
> > 
> > +    virtio_pci_force_virtio_1(vpci_dev);
> >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >  }
> > 
> > diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
> > index a815278e69..f641b974e9 100644
> > --- a/hw/virtio/vhost-vsock-pci.c
> > +++ b/hw/virtio/vhost-vsock-pci.c
> > @@ -44,6 +44,7 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >      VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
> >      DeviceState *vdev = DEVICE(&dev->vdev);
> > 
> > +    virtio_pci_force_virtio_1(vpci_dev);
> >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >  }
> > 
> > 
> > Do you think this is the right approach or is there a better way to
> > solve this issue?
> 
> We basically have three possible ways to deal with this:
> 
> - Force it to modern (i.e., what you have been doing; would need the
>   equivalent changes in ccw as well.)

Oo, thanks for pointing out ccw!
I don't know ccw well, in this case should we set dev->max_rev to 1 or 2
to force to modern?

>   Pro: looks like the cleanest approach.
>   Con: not sure if we would need backwards compatibility support,
>   which looks hairy.

Not sure too.

> - Add vsock to the list of devices with legacy support.
>   Pro: Existing setups continue to work.
>   Con: If vsock is really virtio-1-only, we still carry around
>   possibly broken legacy support.

I'm not sure it is virtio-1-only, but virtio-vsock was introduced in
2016, so I supposed it is modern-only.

How can I verify that? Maybe forcing legacy mode and run some tests.

> - Do nothing, have users force legacy off. Bad idea, as ccw has no way
>   to do that on the command line.
> 
> The first option is probably best.
>

Yeah, I agree with you!

Thanks,
Stefano


