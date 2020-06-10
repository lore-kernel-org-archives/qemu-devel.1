Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87169C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C65520760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0gdiCYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C65520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixQG-0003m9-Cx
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jixPN-0002w5-7E
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:52:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jixPL-0003d5-SN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591782750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JSV9RVfGO/uoS7hO2N5rRU8BhFjAaGOOlFr48ueYxvU=;
 b=J0gdiCYSAJCsUl6+pQdbQlhfo7MlVs4jphaPacUvvEpv2n6JeDfu0obpurvsIngXkx6P1v
 sE2I9Wwj154OVlUNcROl2U4s6AJ+OzAMzpkjb8qqwHhg07RwlXOJ+6jU9KdXVAXsev3bNK
 aSMSU/Bp2kBf6hmh/09ol88rBrFdvuU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-R6NamUBIPaeDl_Dgdx8VrQ-1; Wed, 10 Jun 2020 05:52:29 -0400
X-MC-Unique: R6NamUBIPaeDl_Dgdx8VrQ-1
Received: by mail-wm1-f70.google.com with SMTP id u15so269023wmm.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 02:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JSV9RVfGO/uoS7hO2N5rRU8BhFjAaGOOlFr48ueYxvU=;
 b=m9NMqDihxNeMJRSBGq4Uds5++sfRqGkGtJ5vVvJE8Unetf107djJyLfPSid8OWON2h
 syYep2Zuvsk2apENjnn4EblSkJr3s1IoCTfv9XNvS0limzh1Rc2QXBAFQK8zfmf03Nju
 zx6iwfmLoCEL3IY0+LWhFc00gpkZSWYrpQ+9/Pn7UnhxXjU+QJmsbZhmbUWmbEiv9RF7
 PruB6NcdtDRiP6nwsXFW9WugtmIYbbqEzQu2IKPiIpPK7SE+Vda6C3KI61X+kuPGG9qn
 rRvzxMC94gNzJOazVaP97U+h0egJmYH7WkHUug8e/v/S1f/kAqP5xuyEQNkWu04z3SEz
 XyXg==
X-Gm-Message-State: AOAM532xI/ZianEhnpC1R0F67AS19lTo3qfo4oB17BXb2ehvDoJwqijJ
 Ftv2ordU8+FQCKGAGIM+mMGKBjJci1+ebLENMS6FeEP8FLLWnjJnSdCk06y2Keuf4SJEiOgD7eo
 Bektb6XiJzQM3Z44=
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr2773504wrt.104.1591782748135; 
 Wed, 10 Jun 2020 02:52:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1Yh4YOmy5V0u7GcUN7iMAIWleTqHjlTE0f58tsU5Qw+ARBQH/MAzBIAzCJjaupkvrtL98sg==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr2773468wrt.104.1591782747721; 
 Wed, 10 Jun 2020 02:52:27 -0700 (PDT)
Received: from steredhat (host-79-49-207-108.retail.telecomitalia.it.
 [79.49.207.108])
 by smtp.gmail.com with ESMTPSA id f185sm6315071wmf.43.2020.06.10.02.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 02:52:27 -0700 (PDT)
Date: Wed, 10 Jun 2020 11:52:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] virtio-pci: fix queue_enable write
Message-ID: <20200610095224.2q4ivledb42ubsz4@steredhat>
References: <20200610054351.15811-1-jasowang@redhat.com>
 <20200610085726.jerorykxbycoesyu@steredhat>
 <20200610054248-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200610054248-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
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

On Wed, Jun 10, 2020 at 05:42:54AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2020 at 10:57:26AM +0200, Stefano Garzarella wrote:
> > On Wed, Jun 10, 2020 at 01:43:51PM +0800, Jason Wang wrote:
> > > Spec said: The driver uses this to selectively prevent the device from
> > > executing requests from this virtqueue. 1 - enabled; 0 - disabled.
> > > 
> > > Though write 0 to queue_enable is forbidden by the spec, we should not
> > > assume that the value is 1.
> > > 
> > > Fix this by ignore the write value other than 1.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes from V1:
> > > - fix typo
> > > - warn wrong value through virtio_error
> > > ---
> > >  hw/virtio/virtio-pci.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index d028c17c24..7bc8c1c056 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -1273,16 +1273,20 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
> > >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > >          break;
> > >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> > > -        virtio_queue_set_num(vdev, vdev->queue_sel,
> > > -                             proxy->vqs[vdev->queue_sel].num);
> > > -        virtio_queue_set_rings(vdev, vdev->queue_sel,
> > > +        if (val == 1) {
> > 
> > Does it have to be 1 or can it be any value other than 0?
> > 
> > Thanks,
> > Stefano
> 
> spec says 1

I was confused by "The driver MUST NOT write a 0 to queue_enable.",
interpreting it as "can write anything other than 0".

But as Jason also wrote in the commit message, the driver should write
1 to enable, so

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


