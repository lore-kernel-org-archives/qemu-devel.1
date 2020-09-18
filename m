Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16881C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DADC208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AffKamhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DADC208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDF3-0007Xm-8F
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJDCI-0005Wy-Nu
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJDCE-0000mg-M0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600423248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=waR5iF6dKU3BVwiJqn4s5OkzIxa9MbiNXFv1q9V644A=;
 b=AffKamhkjywUamOF/IrVM9xP1/GJUIBkulzBE+aPRlt17TBlCcdMNINYBQiS3rvHBwa7EB
 u1f3J0UaPA4aWH8mhtqTQDSO6KReHuy2Se4yUfEsJFPYywWQASgBn/2RXZgBhUgUdrkKM6
 /bgvWj/9U/RMAGJOddG8+cpl6RRUq8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ixQM0J3MOvGlDKQ6Tll0vQ-1; Fri, 18 Sep 2020 06:00:47 -0400
X-MC-Unique: ixQM0J3MOvGlDKQ6Tll0vQ-1
Received: by mail-wm1-f70.google.com with SMTP id y18so1293363wma.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 03:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=waR5iF6dKU3BVwiJqn4s5OkzIxa9MbiNXFv1q9V644A=;
 b=CS7VqfXASYL+Nmko+tdA/60l92vd73RVorgT+vCy+UZOfaSwKsNKF4YwkJwFxEuClZ
 hPXdq0+aJWSvk2EEkb7bZm0NdpnZ5ZXpKKJyWiaGNr6EdjGyIVdqVjRAxLCHfCAOXWuK
 Fgv0dqEst7QxvIB/3nHOans7Y/1aEm4lLxNJgQaNSyUvrfJWd93FaxYcRHJdyPHilAgF
 TSj6ZXjx897FEpmIClvPESXdaoZIN8PLwT+bWeZA17gJ9ILydnI2jkqHvkkeRNHotZOS
 pPeEK+zl5B58hjFIw3987KsekdYx7Xrl8cKDoGgcN4sF4FwVOqLlYs10cwp2fA0r7Dxt
 Ecpw==
X-Gm-Message-State: AOAM531wXVe64SlY/koPJIewxlmovQzH/r3F09rVPe1ko8yAghm0Uqhp
 ScWueupOnCTz+WyRs2tAMPkO77AsolIYoZ89Ry6P7FWT2goPW7uEIdBGAoUy4nfnYbgDZWGSfSg
 KkV/yoZ4JrvZ2VF4=
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr14411587wms.36.1600423245668; 
 Fri, 18 Sep 2020 03:00:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzilFvYJxYRlaN8YMont27nqhZfFbDzjCjv6ELjLeoqDfwcWpY7v1qXVRIPwDLYnJxWLw5x7A==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr14411542wms.36.1600423245303; 
 Fri, 18 Sep 2020 03:00:45 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id 92sm4484143wra.19.2020.09.18.03.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:00:44 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:00:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 2/4] vhost-vsock-pci: force virtio version 1
Message-ID: <20200918100042.5rlp6jovqct62bso@steredhat>
References: <20200918074710.27810-1-sgarzare@redhat.com>
 <20200918074710.27810-3-sgarzare@redhat.com>
 <20200918111901.7b8862b3.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918111901.7b8862b3.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Qian Cai <caiqian@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 11:19:01AM +0200, Cornelia Huck wrote:
> On Fri, 18 Sep 2020 09:47:08 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> > accidentally on") added a safety check that requires to set
> > 'disable-legacy=on' on vhost-vsock-pci device:
> > 
> >     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> >         qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
> >         device is modern-only, use disable-legacy=on
> > 
> > virtio-vsock was introduced after the release of VIRTIO 1.0
> > specifications, so it should be 'modern-only'.
> > In addition Cornelia verified that forcing a legacy mode on
> > vhost-vsock-pci device using x86-64 host and s390x guest, so with
> > different endianness, produces strange behaviours.
> > 
> > This patch forces virtio version 1 and removes the 'transitional_name'
> > property removing the need to specify 'disable-legacy=on' on
> > vhost-vsock-pci device.
> > 
> > To avoid migration issues, we force virtio version 1 only when
> > legacy check is enabled in the new machine types (>= 5.1).
> > 
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Qian Cai <caiqian@redhat.com>
> > Reported-by: Qinghua Cheng <qcheng@redhat.com>
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1868449
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3:
> >  - forced virtio version 1 only with new machine types
> > v2:
> >  - fixed commit message [Cornelia]
> > ---
> >  hw/virtio/vhost-vsock-pci.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
> > index e56067b427..205da8d1f5 100644
> > --- a/hw/virtio/vhost-vsock-pci.c
> > +++ b/hw/virtio/vhost-vsock-pci.c
> > @@ -44,6 +44,15 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >  {
> >      VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
> >      DeviceState *vdev = DEVICE(&dev->vdev);
> > +    VirtIODevice *virtio_dev = VIRTIO_DEVICE(vdev);
> > +
> > +    /*
> > +     * To avoid migration issues, we force virtio version 1 only when
> > +     * legacy check is enabled in the new machine types (>= 5.1).
> > +     */
> > +    if (!virtio_legacy_check_disabled(virtio_dev)) {
> > +        virtio_pci_force_virtio_1(vpci_dev);
> > +    }
> >  
> >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >  }
> > @@ -73,7 +82,6 @@ static void vhost_vsock_pci_instance_init(Object *obj)
> >  static const VirtioPCIDeviceTypeInfo vhost_vsock_pci_info = {
> >      .base_name             = TYPE_VHOST_VSOCK_PCI,
> >      .generic_name          = "vhost-vsock-pci",
> > -    .transitional_name     = "vhost-vsock-pci-transitional",
> 
> Hm... this means that vhost-vsock-pci-transitional won't work on compat
> machines, which could also lead to migration compatibility issues (I
> think?)
> 

Yes, I think you are right.

> Is this way of specifying the device sufficiently uncommon so that we
> can ignore that?

I think it's really uncommon and we can safetly eliminate it, since it
has never been really transitional.  But if we want to leave it for
migration compatibility, that's fine with me.

Thanks,
Stefano


