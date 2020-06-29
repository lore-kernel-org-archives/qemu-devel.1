Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4215255A5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkgnrSTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4215255A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpxEl-0002UX-Qp
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpxDs-0001jA-Rs
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 13:05:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33206
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpxDq-0003IB-8D
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 13:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593450332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UDDMCnqTV30z6QPivwS8VQyKr17DzN4HDVxw//U6UM=;
 b=UkgnrSTGrs+5XgXN0MhDQWJX95z9pnfsmMFzDN5LkhGSaY15ng3U0SahKWiiycOxk1ZIXs
 Rf2ZFM5ZWnxw/lDRxLyEskVKR2BmJ/df4I3dNPoryFV9b7c5Homk9qYgmqdXvJmSj/qC5i
 5PnLY8Nqbu79ckTe8rrrY8uc20eZ88o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-_aBoKONuNoy4E7FzIl_CbQ-1; Mon, 29 Jun 2020 13:05:29 -0400
X-MC-Unique: _aBoKONuNoy4E7FzIl_CbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A53B618B6388
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 17:05:28 +0000 (UTC)
Received: from work-vm (ovpn-114-210.ams2.redhat.com [10.36.114.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFA0E5D9DA;
 Mon, 29 Jun 2020 17:05:22 +0000 (UTC)
Date: Mon, 29 Jun 2020 18:05:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200629170519.GM2908@work-vm>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200629104948-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200629104948-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
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

Yes, I think I'm OK with that - although you could add the compat
flag in the machine type I guess.

Dave

> 
> > Whatever we do here, we should make sure that the ccw incarnation of
> > this device indeed forces virtio-1.
> 
> I agree. I notice that the API virtio_pci_force_virtio_1 turned out
> to be too fragile. I propose that instead we have a whitelist of
> devices which can be legacy or transitional. Force rest to modern.
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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


