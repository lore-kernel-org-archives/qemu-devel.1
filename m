Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A30C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B7D2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO5EHkaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B7D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisBR-0005FN-Rc
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisAQ-0004na-DC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisAP-0006Oc-FL
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591762604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMs82gWaxpHQvdXU7LbVJd5iZXqN/oz6JBgpgIiO/+A=;
 b=MO5EHkaWPmroGTh9QU572mFbBh/rVaCdPheK4D6Pyt16fvdd4WKTDWou4tsn8SPGro+w0w
 ehBI+CVYWZrlGoa3aVEZTEcGN6PA+VojvOyhI5kI0xOwR+z7MMRCJqQX3uS1sr40eiqli+
 aF4yQoFytQeWz6e0xda60SmMEfAhejw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-jtvi169ONW6XGNN-0VgGyQ-1; Wed, 10 Jun 2020 00:16:43 -0400
X-MC-Unique: jtvi169ONW6XGNN-0VgGyQ-1
Received: by mail-wm1-f71.google.com with SMTP id h6so70617wmb.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=tMs82gWaxpHQvdXU7LbVJd5iZXqN/oz6JBgpgIiO/+A=;
 b=Wm8HPmMOBHIuT2Xq7nYThb67jzewxDFQVSz030aickAcTrYIZDRAhvCPPx+mrCeLOI
 OFYToOLz6OFkjcgkZa7lgf7maXMbfd9jD6V62I+uKkylWPiad2+I+dtT2FvzFjSTRm8P
 xQ7h0W7Xo2JXJIvxvZVp2eTCL+P3tTnncFkUUnHjiCas++jNEPdNvCUKmvX6nEFJUxyx
 HMjLC/P/ZD9IAn5bQzroNU4Cfs4BpMGKFdRcm99cwLobaov9nNptoayIrRJxa9FMQDeo
 8pnQMXWuPsLp53BDMkbwR87+frLxWr5CNSrF6hNVLke35LYZuxctOMD71FOzkjFWeCd7
 XGmw==
X-Gm-Message-State: AOAM5302z4tyR7glbilG7cE9vJbIZxFwqDCAyLZBxeulxJJGJJi0JOSR
 7hbOqhwhzBJWP629zHksMkVe9KTq9egdi7erWqrwK5A84HTaWc/17hmLuS+tYWlEgAJZpsPKz/s
 vjXL1QgQeaCl78jM=
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr1129066wme.14.1591762592164;
 Tue, 09 Jun 2020 21:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxArIph1pCSbAjchnzJAoeZlCbOTj91exekjPHpbqsk2wvH9/0rIVh0xjJmGkIy9DmUN8twWg==
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr1129043wme.14.1591762591906;
 Tue, 09 Jun 2020 21:16:31 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id a15sm6345026wra.86.2020.06.09.21.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:16:31 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:16:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-pci: fix queue_enable write
Message-ID: <20200610001608-mutt-send-email-mst@kernel.org>
References: <20200529030728.7687-1-jasowang@redhat.com>
 <20200609114213-mutt-send-email-mst@kernel.org>
 <a6ad8f9d-8613-16f8-f811-7ef2824c5f35@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a6ad8f9d-8613-16f8-f811-7ef2824c5f35@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 10:03:28AM +0800, Jason Wang wrote:
> 
> On 2020/6/9 下午11:43, Michael S. Tsirkin wrote:
> > On Fri, May 29, 2020 at 11:07:28AM +0800, Jason Wang wrote:
> > > Spec said: The driver uses this to selectively prevent the device from
> > > executing requests from this virtqueue. 1 - enabled; 0 - disabled.
> > > 
> > > Though write 0 to queue_enable is forbidden by the sepc, we should not
> > spec?
> 
> 
> Chapter 4.1.4.3.2 said:
> 
> "
> 
> The driver MUST NOT write a 0 to queue_enable.
> 
> "
> 


I mean you misspelled spec as sepc :)

> > 
> > > assume that the value is 1.
> > > 
> > > Fix this by ignoring the write value other than 1.
> > > 
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > Do we want to call virtio_error here so we can figure out something's wrong?
> 
> 
> That looks better. Will do.
> 
> Thanks
> 
> 
> > 
> > 
> > 
> > > ---
> > >   hw/virtio/virtio-pci.c | 10 ++++++----
> > >   1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index d028c17c24..b3558eeaee 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -1273,16 +1273,18 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
> > >           virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > >           break;
> > >       case VIRTIO_PCI_COMMON_Q_ENABLE:
> > > -        virtio_queue_set_num(vdev, vdev->queue_sel,
> > > -                             proxy->vqs[vdev->queue_sel].num);
> > > -        virtio_queue_set_rings(vdev, vdev->queue_sel,
> > > +        if (val == 1) {
> > > +            virtio_queue_set_num(vdev, vdev->queue_sel,
> > > +                                 proxy->vqs[vdev->queue_sel].num);
> > > +            virtio_queue_set_rings(vdev, vdev->queue_sel,
> > >                          ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
> > >                          proxy->vqs[vdev->queue_sel].desc[0],
> > >                          ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
> > >                          proxy->vqs[vdev->queue_sel].avail[0],
> > >                          ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
> > >                          proxy->vqs[vdev->queue_sel].used[0]);
> > > -        proxy->vqs[vdev->queue_sel].enabled = 1;
> > > +            proxy->vqs[vdev->queue_sel].enabled = 1;
> > > +        }
> > >           break;
> > >       case VIRTIO_PCI_COMMON_Q_DESCLO:
> > >           proxy->vqs[vdev->queue_sel].desc[0] = val;
> > > -- 
> > > 2.20.1
> > 


