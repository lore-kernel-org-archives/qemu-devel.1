Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F07DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABDF2083E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIq6sk6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABDF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mb4-0001zT-J5
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0maE-0000kY-9H
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:57:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0maC-0005D3-3l
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596031042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZocSggpCTpaws8s2WQg/H1HltxCui1aAGjSbBGl7bgE=;
 b=YIq6sk6r76B8CHWqsc0l87/njwV6LoNzL5FMg9Fpbyxo7TBdkdoNKZHwxck1LFx83GGJjW
 Zwr0WK/ymxqCpUnNCTJKeGEn+4WMGdoKmg+280LvrtXvp5daTtwjmkADFio46Swns1Xzp7
 lRxwahq3RFX7K0/DIozNEN0RFnNEUnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-AnSrR0aTMrunYW0cowjm2g-1; Wed, 29 Jul 2020 09:57:21 -0400
X-MC-Unique: AnSrR0aTMrunYW0cowjm2g-1
Received: by mail-wm1-f72.google.com with SMTP id v8so622226wma.6
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 06:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZocSggpCTpaws8s2WQg/H1HltxCui1aAGjSbBGl7bgE=;
 b=lrFR9QySzw4BwMXvNJ/YdBq0XK9NRAeNU4tRDEzwR+x/w9b1T30uIGH+MlXXDN9dqC
 1Kpj9dTERTXnzWsp4HE4jXD37EPNWBPoxh54l2j7mNwoEJMyxE7c088VTlVmUDQ7g6KU
 CijT0/suN6SkZWzGUxYX6414FDfUVqTqonC44mICCBVK7WZ4jLemVBpd3m31BUdKIE1T
 ZdXt9WtDWavevuha/vreVwNacCp4JdTeGwht2HX+LFyZwF0032h6SfuaHafO+rdfFAVj
 kgV388Ux04spPERAr7QMqe5aBvLbxc6LvQDgDfEOw9HWK4+qOI3fwFLZTw7lW0dAaGjV
 6xkg==
X-Gm-Message-State: AOAM532hSvNqcva0gwh6fPiSEdNa5OYz2XNp8C0APVV4vlDhXbb02Exh
 coRVsBCD5tgnzbZDy6eV79FfcWAEsEp0rXe2OhuhdSKwfuzcQ8gxG/Ow7tXAu3ZDVHS/Eaf9r5X
 /Ge511Kl/iPb/XXk=
X-Received: by 2002:adf:de09:: with SMTP id b9mr17368159wrm.409.1596031039184; 
 Wed, 29 Jul 2020 06:57:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycr4x7OBSup7CSlx3H0CG4EbZ8oEjTX8sxQ4bqWBfDRXtJx2CMnZUbQYeDMVGgrovEEUobSA==
X-Received: by 2002:adf:de09:: with SMTP id b9mr17368145wrm.409.1596031038971; 
 Wed, 29 Jul 2020 06:57:18 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id g3sm6636644wrb.59.2020.07.29.06.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 06:57:18 -0700 (PDT)
Date: Wed, 29 Jul 2020 09:57:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-pci: fix virtio_pci_queue_enabled()
Message-ID: <20200729095637-mutt-send-email-mst@kernel.org>
References: <20200727153319.43716-1-lvivier@redhat.com>
 <f208ec76-56b7-cd65-c20b-2d7bb1b665dc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f208ec76-56b7-cd65-c20b-2d7bb1b665dc@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 11:55:16AM +0800, Jason Wang wrote:
> 
> On 2020/7/27 下午11:33, Laurent Vivier wrote:
> > In legacy mode, virtio_pci_queue_enabled() falls back to
> > virtio_queue_enabled() to know if the queue is enabled.
> > 
> > But virtio_queue_enabled() calls again virtio_pci_queue_enabled()
> > if k->queue_enabled is set. This ends in a crash after a stack
> > overflow.
> > 
> > The problem can be reproduced with
> > "-device virtio-net-pci,disable-legacy=off,disable-modern=true
> >   -net tap,vhost=on"
> > 
> > And a look to the backtrace is very explicit:
> > 
> >      ...
> >      #4  0x000000010029a438 in virtio_queue_enabled ()
> >      #5  0x0000000100497a9c in virtio_pci_queue_enabled ()
> >      ...
> >      #130902 0x000000010029a460 in virtio_queue_enabled ()
> >      #130903 0x0000000100497a9c in virtio_pci_queue_enabled ()
> >      #130904 0x000000010029a460 in virtio_queue_enabled ()
> >      #130905 0x0000000100454a20 in vhost_net_start ()
> >      ...
> > 
> > This patch fixes the problem by introducing a new function
> > for the legacy case and calls it from virtio_pci_queue_enabled().
> > It also calls it from virtio_queue_enabled() to avoid code duplication.
> > 
> > Fixes: f19bcdfedd53 ("virtio-pci: implement queue_enabled method")
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Cindy Lu <lulu@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> 
> Queued for rc2.
> 
> Thanks

Oh I didn't realise you are merging virtio patches.
If you do, pls include this tag:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> 
> > ---
> >   hw/virtio/virtio-pci.c     | 2 +-
> >   hw/virtio/virtio.c         | 7 ++++++-
> >   include/hw/virtio/virtio.h | 1 +
> >   3 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index ada1101d07bf..4ad3ad81a2cf 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1116,7 +1116,7 @@ static bool virtio_pci_queue_enabled(DeviceState *d, int n)
> >           return proxy->vqs[vdev->queue_sel].enabled;
> >       }
> > -    return virtio_queue_enabled(vdev, n);
> > +    return virtio_queue_enabled_legacy(vdev, n);
> >   }
> >   static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 546a198e79b0..e98302521769 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3309,6 +3309,11 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
> >       return vdev->vq[n].vring.desc;
> >   }
> > +bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n)
> > +{
> > +    return virtio_queue_get_desc_addr(vdev, n) != 0;
> > +}
> > +
> >   bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> >   {
> >       BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> > @@ -3317,7 +3322,7 @@ bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> >       if (k->queue_enabled) {
> >           return k->queue_enabled(qbus->parent, n);
> >       }
> > -    return virtio_queue_get_desc_addr(vdev, n) != 0;
> > +    return virtio_queue_enabled_legacy(vdev, n);
> >   }
> >   hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n)
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 198ffc762678..e424df12cf6d 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -295,6 +295,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> >                         VIRTIO_F_RING_PACKED, false)
> >   hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> > +bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> >   bool virtio_queue_enabled(VirtIODevice *vdev, int n);
> >   hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
> >   hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);


