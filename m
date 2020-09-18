Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA9C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD0121D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8z0bv5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD0121D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDFm-0007yO-G0
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJDD8-0006BR-N6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:01:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJDD6-0000xl-Vs
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600423304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Lm0bYkEsCUwbKg/YLr24YzVsRxeOshS64tNP6MCIaU=;
 b=E8z0bv5XwF3YycB5DNwS+PDwEQtizSGGqDKJtQKI+h6towZE/mwluU9Dm2RGVxnnDED8WR
 GbX0V19pWozXSJTlekbWGJTaOX+uhSF5RTpTRAbr/qgMEW3Rkf9E+NAOqk8SCfB7tBE5Wn
 TsERDo/zNpxX4u57R6d0Na0h0H10hTo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-TkNK4bYXPg27gqRWZHsgoA-1; Fri, 18 Sep 2020 06:01:40 -0400
X-MC-Unique: TkNK4bYXPg27gqRWZHsgoA-1
Received: by mail-wm1-f71.google.com with SMTP id s24so1297763wmh.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 03:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Lm0bYkEsCUwbKg/YLr24YzVsRxeOshS64tNP6MCIaU=;
 b=ujbgXJyQxX0P5ThD3aD97CRa+QeI8cz2USzxCAcMLCU69iaIbCwI70RoB82hjLKuuw
 L6TQj7/3sBIKuOI/ZicyBmHkO5/d/9WpeMuvzX4H9YuscjIouRw8neXowdAWW/1HxxnK
 N7Zl+qElXQ9Mq7CuQdOljH6SATlWZbAZK7B+eZHvpmpc19Yu7uOKxgBtZgAyNSW8wZTx
 krzLW4bDgEcYSlfm+58gkRGvkUpflYq5iXi5UQqtpxn5xuJWFVQCcQmwdC+7QRr29yjf
 5E79/Si2ApoCZy6oKs9HsTssAEJLqKbEof1Uogq1ey+xBGsEr/7TF1TI5weo5H83LMDL
 K+wA==
X-Gm-Message-State: AOAM530IKyDAIfL6DzyCcbnwHT1US/fpcUoFRPqw51GjKWMRpiL0OusF
 kKPCVSoQIhx3beeP8nV3p103buw30gwTqKjcoOp0iUL3QDDEzt0hGtdz3vBq/c9aCHhQZl9fb0s
 2NVWEH0HJ7sy7ikI=
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr37089823wrn.68.1600423299188; 
 Fri, 18 Sep 2020 03:01:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKW6UqljbW7iqYg6GWIOYQEVd88/Kib2jM1o7NhkZfsU+/IM2BWBHqCHzRiYTieRlkv0foQA==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr37089793wrn.68.1600423298947; 
 Fri, 18 Sep 2020 03:01:38 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id k6sm3863822wmf.30.2020.09.18.03.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:01:38 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:01:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 3/4] vhost-user-vsock-pci: force virtio version 1
Message-ID: <20200918100135.ue73nl5c5ky5pmv4@steredhat>
References: <20200918074710.27810-1-sgarzare@redhat.com>
 <20200918074710.27810-4-sgarzare@redhat.com>
 <20200918112316.3987fe77.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918112316.3987fe77.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 05:23:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 18, 2020 at 11:23:16AM +0200, Cornelia Huck wrote:
> On Fri, 18 Sep 2020 09:47:09 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> > accidentally on") added a safety check that requires to set
> > 'disable-legacy=on' on vhost-user-vsock-pci device:
> > 
> >     $ ./qemu-system-x86_64 ... \
> >     -chardev socket,id=char0,reconnect=0,path=/tmp/vhost4.socket \
> >     -device vhost-user-vsock-pci,chardev=char0
> >         qemu-system-x86_64: -device vhost-user-vsock-pci,chardev=char0:
> >         device is modern-only, use disable-legacy=on
> > 
> > virtio-vsock was introduced after the release of VIRTIO 1.0
> > specifications, so it should be 'modern-only'.
> > 
> > This patch forces virtio version 1 and removes the 'transitional_name'
> > property, as done for vhost-vsock-pci, removing the need to specify
> > 'disable-legacy=on' on vhost-user-vsock-pci device.
> > 
> > Cc: qemu-stable@nongnu.org
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2:
> >  - fixed commit message [Cornelia]
> > ---
> >  hw/virtio/vhost-user-vsock-pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
> > index 763f89984e..14109121e2 100644
> > --- a/hw/virtio/vhost-user-vsock-pci.c
> > +++ b/hw/virtio/vhost-user-vsock-pci.c
> > @@ -41,6 +41,7 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >      VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
> >      DeviceState *vdev = DEVICE(&dev->vdev);
> >  
> > +    virtio_pci_force_virtio_1(vpci_dev);
> 
> Maybe add a comment
> 
> /* unlike vhost-vsock, we do not need to care about pre-5.1 compat */
> 
> 
> to help when we look at this in the future?

Sure, I'll add in v4.

> 
> >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >  }
> >  
> > @@ -69,7 +70,6 @@ static void vhost_user_vsock_pci_instance_init(Object *obj)
> >  static const VirtioPCIDeviceTypeInfo vhost_user_vsock_pci_info = {
> >      .base_name             = TYPE_VHOST_USER_VSOCK_PCI,
> >      .generic_name          = "vhost-user-vsock-pci",
> > -    .transitional_name     = "vhost-user-vsock-pci-transitional",
> >      .non_transitional_name = "vhost-user-vsock-pci-non-transitional",
> >      .instance_size = sizeof(VHostUserVSockPCI),
> >      .instance_init = vhost_user_vsock_pci_instance_init,
> 
> Otherwise,
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Stefano


