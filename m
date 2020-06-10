Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99076C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603B0204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge7p+VSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603B0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixMj-00014S-Fs
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 05:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jixGA-00085h-3l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:43:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jixG9-0001pT-7B
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591782180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K3OqkjSCSx2AqWC2UvCLIuFq6DeGhjAJNDe0sRipJkM=;
 b=Ge7p+VSbCasKujLajR5eKijxYwi7CbY1P453B218t8G7il7PcTivQqyxBW8jC8noPTFbzz
 mrwcJrUCtwPzI8JNLDU0n28XUbytqudC3HMyjsmmpv5rgBjXAjQWHrqfpzUIDU+ziYQAbH
 0tyrwgo0p3+rjqLrGgXUy2PnbAIHi3w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-FcgYB-T5OKakRz-COOKliA-1; Wed, 10 Jun 2020 05:42:59 -0400
X-MC-Unique: FcgYB-T5OKakRz-COOKliA-1
Received: by mail-wr1-f69.google.com with SMTP id r5so845297wrt.9
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 02:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K3OqkjSCSx2AqWC2UvCLIuFq6DeGhjAJNDe0sRipJkM=;
 b=WSAmo/4D+jB8q8kS3uky/RZtjfOFOLsoxxelUJtg9kLv1+LSlyPZ9Rdbgvd//y/aQa
 MlDvSi8mT5hfMMyfLxk+y1TQihXarkIpkNcJxBUeL3BPJeo9INftjKipE8rxQFqdmdWx
 yngFM4+TF5wHZHDkoI3tfcnv548Pk6KJPSK5VIZQZqedmJR9oWLacSvArsK+zFbzxmyZ
 /jhtM+YdwdqhIxbBLuaTJU0hZKdosSwzuWcLn9v9nhBPnT+cxdhdqKWQf1FtFwT6dlio
 8Fa8gRWgKUPepwrhE9crmzC56Z0gJvGCVrCgEOMgP9saaiK5+UhKLwTSEqqKz/TzdvBL
 c+CA==
X-Gm-Message-State: AOAM532kDfYnH8GvrXnQOHNbd6cVDj4QTfNEZXeDyNJ1ttidfP59QAtU
 bfRxNMicEk6Y0VA2VyINB2WQ2GBLxIRglLPkbzl49D1AHPkGuB8Y06pwX+KcdqNxTvekLafy8G+
 XCjFekrMqAOuuZH8=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2627222wrv.162.1591782177932; 
 Wed, 10 Jun 2020 02:42:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/fdvt7VzC0CG9RVGuIFHZlEwAtZT23VEyWq8BH+V5Lsl1R7+lDQPeuiiU4O16LVis89Ulyg==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2627188wrv.162.1591782177564; 
 Wed, 10 Jun 2020 02:42:57 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
 by smtp.gmail.com with ESMTPSA id z12sm7845963wrg.9.2020.06.10.02.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 02:42:57 -0700 (PDT)
Date: Wed, 10 Jun 2020 05:42:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2] virtio-pci: fix queue_enable write
Message-ID: <20200610054248-mutt-send-email-mst@kernel.org>
References: <20200610054351.15811-1-jasowang@redhat.com>
 <20200610085726.jerorykxbycoesyu@steredhat>
MIME-Version: 1.0
In-Reply-To: <20200610085726.jerorykxbycoesyu@steredhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 10:57:26AM +0200, Stefano Garzarella wrote:
> On Wed, Jun 10, 2020 at 01:43:51PM +0800, Jason Wang wrote:
> > Spec said: The driver uses this to selectively prevent the device from
> > executing requests from this virtqueue. 1 - enabled; 0 - disabled.
> > 
> > Though write 0 to queue_enable is forbidden by the spec, we should not
> > assume that the value is 1.
> > 
> > Fix this by ignore the write value other than 1.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes from V1:
> > - fix typo
> > - warn wrong value through virtio_error
> > ---
> >  hw/virtio/virtio-pci.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index d028c17c24..7bc8c1c056 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1273,16 +1273,20 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
> >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> > -        virtio_queue_set_num(vdev, vdev->queue_sel,
> > -                             proxy->vqs[vdev->queue_sel].num);
> > -        virtio_queue_set_rings(vdev, vdev->queue_sel,
> > +        if (val == 1) {
> 
> Does it have to be 1 or can it be any value other than 0?
> 
> Thanks,
> Stefano

spec says 1

> > +            virtio_queue_set_num(vdev, vdev->queue_sel,
> > +                                 proxy->vqs[vdev->queue_sel].num);
> > +            virtio_queue_set_rings(vdev, vdev->queue_sel,
> >                         ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
> >                         proxy->vqs[vdev->queue_sel].desc[0],
> >                         ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
> >                         proxy->vqs[vdev->queue_sel].avail[0],
> >                         ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
> >                         proxy->vqs[vdev->queue_sel].used[0]);
> > -        proxy->vqs[vdev->queue_sel].enabled = 1;
> > +            proxy->vqs[vdev->queue_sel].enabled = 1;
> > +        } else {
> > +            virtio_error(vdev, "wrong value for queue_enable %"PRIx64, val);
> > +        }
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_DESCLO:
> >          proxy->vqs[vdev->queue_sel].desc[0] = val;
> > -- 
> > 2.20.1
> > 
> > 


