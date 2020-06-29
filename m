Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A54C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6098025474
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOE+JtWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6098025474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvwg-0005q3-NE
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jpvss-0001s3-Tt
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:39:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jpvsr-0004H8-5a
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593445188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1s/ZBhKXJh67z7lchcB4ai9mNvXXYMeQ9p8+kLlmwng=;
 b=LOE+JtWksFsk9v3Lt7xVapKvMHGl2YPhYXOWyXmyoxEOi+rx2r7nkOox9odfwAfm7jJdQ+
 pVd6yBKMJdh/fTAu++ixlmkiBntzJ/7NUT+TbvNdBX9gBG53H7CIexQhWeaPrRo3RZfm2E
 JAhDSy5l+omAmzWq7lBF91WcHyEjzCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-MhVxIeLNOWyBwGuZyOFbQQ-1; Mon, 29 Jun 2020 11:39:46 -0400
X-MC-Unique: MhVxIeLNOWyBwGuZyOFbQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86BB510059D0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 15:39:45 +0000 (UTC)
Received: from gondolin (ovpn-113-61.ams2.redhat.com [10.36.113.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A34CD5D9E7;
 Mon, 29 Jun 2020 15:39:35 +0000 (UTC)
Date: Mon, 29 Jun 2020 17:39:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200629173933.35cea40f.cohuck@redhat.com>
In-Reply-To: <20200629104948-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200629104948-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 10:53:23 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jun 29, 2020 at 12:27:58PM +0200, Cornelia Huck wrote:
> > virtio-fs devices are only specified for virtio-1, so it is unclear
> > how a legacy or transitional device should behave.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > Forcing off legacy now (after the virtio-fs device has already been
> > available) may have unintended consequences, therefore RFC.
> > 
> > By default, a virtio-pci device uses 'AUTO' for disable_legacy, which
> > will resolve to different values based upon which bus the device has
> > been plugged. Therefore, forcing disable_legacy may result in the same
> > device or a quite different one.
> > 
> > Even though pre-virtio-1 behaviour of virtio-fs devices is simply not
> > specified, toggling disable_legacy will have implications for the BAR
> > layout, IIRC, and therefore a guest might end up getting a different
> > device, even if it always used it with virtio-1 anyway.
> > 
> > Not sure what the best way to solve this problem is. Adding a compat
> > property for disable_legacy=AUTO may be the right thing to do, but I'm
> > not quite clear if there are any further implications here.  
> 
> Well I notice that this device is not migrateable.
> So I think that we can just switch it over and be done with it.

Oh, that makes things easier. (I'm wondering if libvirt already
configures this correctly?)

> 
> 
> > Whatever we do here, we should make sure that the ccw incarnation of
> > this device indeed forces virtio-1.  
> 
> I agree. I notice that the API virtio_pci_force_virtio_1 turned out
> to be too fragile. I propose that instead we have a whitelist of
> devices which can be legacy or transitional. Force rest to modern.

Also, there are further complications because the mechanism is per
transport, and therefore easy to miss.

bool virtio_legacy_allowed(VirtIODevice *vdev)
{
    switch (vdev->device_id) {
    case <...>:
    <list of legacy-capable devices>
        return true;
    default:
        return false;
}

Seems straightforward enough.

> 
> 
> > ---
> >  hw/virtio/vhost-user-fs-pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
> > index e11c889d82b3..244205edf765 100644
> > --- a/hw/virtio/vhost-user-fs-pci.c
> > +++ b/hw/virtio/vhost-user-fs-pci.c
> > @@ -44,6 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >          vpci_dev->nvectors = dev->vdev.conf.num_request_queues + 2;
> >      }
> >  
> > +    virtio_pci_force_virtio_1(vpci_dev);
> >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >  }
> >  
> > -- 
> > 2.25.4  
> 


