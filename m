Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB95C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C802465A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhPl+o4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C802465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irPY7-00053C-Ud
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 12:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1irPXH-0004cW-PE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1irPXC-0007yN-LH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:59:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1irPXC-0007xI-H8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579021157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXlY3gHUmJYuiDoQ0MSojUBcvgBO+I+ZRUC0YZUH9+E=;
 b=LhPl+o4+rH9aq+tUIiohqy1cbhRs7fByioJwpRHEN3tV5W6fIuKSEpQhpGRY2gywf9WPuw
 E8t82MmI4C6pqgn68wD/3dN+c4+dH2F59H5h9I0s6kToP+35PkkhGz+baUJqegrssQUNKN
 iu69ZMzXV82ENzln39sS7HyotXmKSVU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-0xgQMVcaPTagvRCbfckJGg-1; Tue, 14 Jan 2020 11:59:16 -0500
Received: by mail-wr1-f69.google.com with SMTP id y7so6762583wrm.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 08:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jdvbxBQ3kz+lj+aQ5q0tPggE6Y32e0HUlP51Dj57VgU=;
 b=kS2F5WkH7AmCRbwmuHyrV/QL1TQSnIeGKYCxjy+O1olerbVqtYO90j4b/T4kBGQCDO
 nlg17sAv3tXSLxU8k5/hF+egYu/gmPjuA5mzU4CgeDgbjeaqZfrVQ40HBpseq5aPM2Ph
 mQ8CzTzAP3LngHwBk/E1hg7tmj2uTmfn1wL7slqqkhAxMhygWYPsIeImnb7h8d5zmGqm
 R6wDMODoQcvnxN/SVYoLp/LXUDQx0L2BB+wua3ltJUHhZ71O1puSzpkfUuENHALaVq7N
 vidsP54AQ0+42qUU1STvx+mg9YpKJYr6fV4/+tj+7ODC7Zj5kROHGwDDCF1dg9iKyAFl
 lZTg==
X-Gm-Message-State: APjAAAXBRMrcER0TmMFSIj6eD1DjNlZJyd7pzbe5n3e2WbLcFjkwrsiI
 aPHNg9Z5/AvdBhfYlyWhaqmcYyAYwkG7Bssa/DrnfWNetDBQ/YVaFP5ceMWJhtC8fG1iTKgx5MI
 AC7ftyXgBwF90lF4=
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr28798489wml.157.1579021154739; 
 Tue, 14 Jan 2020 08:59:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqNOEOcfGo5OKofSmDehGmNg9Z4rQvE/6QmQnKPxLJTh9vxpprfxmZonwHXPiRw2KyRjIg7g==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr28798450wml.157.1579021154473; 
 Tue, 14 Jan 2020 08:59:14 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it.
 [79.31.49.84])
 by smtp.gmail.com with ESMTPSA id n3sm19403980wrs.8.2020.01.14.08.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:59:13 -0800 (PST)
Date: Tue, 14 Jan 2020 17:59:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan <pannengyuan@huawei.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] vhost-vsock: delete vqs in vhost_vsock_unrealize to
 avoid memleaks
Message-ID: <CAGxU2F7CC2bjUg=6P0UDYehKqyCq+kHc=hoyvSV8rPSj8oFAZg@mail.gmail.com>
References: <20200114075229.40520-1-pannengyuan@huawei.com>
 <20200114164441.GG132666@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200114164441.GG132666@stefanha-x1.localdomain>
X-MC-Unique: 0xgQMVcaPTagvRCbfckJGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu devel list <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 5:45 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, Jan 14, 2020 at 03:52:29PM +0800, pannengyuan@huawei.com wrote:
> > From: Pan Nengyuan <pannengyuan@huawei.com>
> >
> > Receive/transmit/event vqs forgot to cleanup in vhost_vsock_unrealize. =
This
> > patch save receive/transmit vq pointer in realize() and cleanup vqs
> > through those vq pointers in unrealize(). The leak stack is as follow:
> >
> > Direct leak of 21504 byte(s) in 3 object(s) allocated from:
> >   #0 0x7f86a1356970 (/lib64/libasan.so.5+0xef970)  ??:?
> >   #1 0x7f86a09aa49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
> >   #2 0x5604852f85ca (./x86_64-softmmu/qemu-system-x86_64+0x2c3e5ca)  /m=
nt/sdb/qemu/hw/virtio/virtio.c:2333
> >   #3 0x560485356208 (./x86_64-softmmu/qemu-system-x86_64+0x2c9c208)  /m=
nt/sdb/qemu/hw/virtio/vhost-vsock.c:339
> >   #4 0x560485305a17 (./x86_64-softmmu/qemu-system-x86_64+0x2c4ba17)  /m=
nt/sdb/qemu/hw/virtio/virtio.c:3531
> >   #5 0x5604858e6b65 (./x86_64-softmmu/qemu-system-x86_64+0x322cb65)  /m=
nt/sdb/qemu/hw/core/qdev.c:865
> >   #6 0x5604861e6c41 (./x86_64-softmmu/qemu-system-x86_64+0x3b2cc41)  /m=
nt/sdb/qemu/qom/object.c:2102
> >
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> > ---
> >  hw/virtio/vhost-vsock.c         | 9 +++++++--
> >  include/hw/virtio/vhost-vsock.h | 2 ++
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> > index f5744363a8..896c0174c1 100644
> > --- a/hw/virtio/vhost-vsock.c
> > +++ b/hw/virtio/vhost-vsock.c
> > @@ -335,8 +335,10 @@ static void vhost_vsock_device_realize(DeviceState=
 *dev, Error **errp)
> >                  sizeof(struct virtio_vsock_config));
> >
> >      /* Receive and transmit queues belong to vhost */
> > -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_=
output);
> > -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_=
output);
> > +    vsock->recv_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> > +                                      vhost_vsock_handle_output);
> > +    vsock->trans_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> > +                                       vhost_vsock_handle_output);
> >
> >      /* The event queue belongs to QEMU */
> >      vsock->event_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> > @@ -378,6 +380,9 @@ static void vhost_vsock_device_unrealize(DeviceStat=
e *dev, Error **errp)
> >      /* This will stop vhost backend if appropriate. */
> >      vhost_vsock_set_status(vdev, 0);
> >
> > +    virtio_delete_queue(vsock->recv_vq);
> > +    virtio_delete_queue(vsock->trans_vq);
> > +    virtio_delete_queue(vsock->event_vq);
> >      vhost_dev_cleanup(&vsock->vhost_dev);
> >      virtio_cleanup(vdev);
> >  }
>
> Please delete the virtqueues after vhost cleanup (the reverse
> initialization order).  There is currently no reason why it has to be
> done in reverse initialization order, your patch should work too, but
> it's a good default for avoiding user-after-free bugs.
>

Agree!

Since we are here, should we delete the queues also in the error path
of vhost_vsock_device_realize()?

Thanks,
Stefano


