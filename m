Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D10FC433EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9658206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm/SwJND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9658206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02qy-0002ix-3r
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k02qO-0002Ij-Q5
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:07:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k02qN-0004Go-0g
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595855221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3C3/OVYQH5i9J51C0r2EP2+2w68DcBmbmymvNKm5dl0=;
 b=gm/SwJNDO5qtsQAQmkQg3Kzf8GXQpoqUkdN8c+BzG7M5RflYFYaBjVb8MyFLJGZpdOf25L
 AynUxvC5H6Lqhj/0lz9x5hOFviea+fzkk9C1oAtKFBqNHRILq/iBP61ATR9gPq5gxU5kaX
 hCNq0+F0RZZefCRoB1YCCv7+hHR38jU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-tXNWu-yQMaOPIr1wOLBLQQ-1; Mon, 27 Jul 2020 09:07:00 -0400
X-MC-Unique: tXNWu-yQMaOPIr1wOLBLQQ-1
Received: by mail-wr1-f72.google.com with SMTP id j2so1279449wrr.14
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3C3/OVYQH5i9J51C0r2EP2+2w68DcBmbmymvNKm5dl0=;
 b=B6SBb8wLYD1FaQwmCYwl/guykrR3/BcYy/eQpQziuoAuxSslEW9kUEfzGojdM/5T2C
 lCdufjSfKRm5trjvdvYmpWeDbkAetip1LiXkaZRkWqoVHPuipLTAA6ezNPyaNT3pvmrW
 oLh8OQoJSZMuMIMWZgjUE+3gZLjqrVW+TzZ8MX6PKkz6+ZL4IhnjQfbFNOEKkIjRIXOd
 ew/WDTGRtPNNzsOPnRxi6tfpqZC7NNDK02bVZJteR5KbElGXfQodjCRftZ1MSyoz0SVr
 LlIv/SaoZpwXNn9prNhFzju/J54enWhzd71Feyg77+GEgiXvhk8+ssYX5VrgxdRDyoFG
 QthQ==
X-Gm-Message-State: AOAM531oAEYvAdG6TUnJzxf0SQx91cNSf8YbR1C9YMfWbqI7E0jjPcjo
 IpHyiXcNgxjnOFG1gntXTWRMNeaCQQFUeaeasdx5plZ1tlEAUnD0YfPWX+YIBo3+0O0aWHD52eP
 RGyfR/kBhRUCOVKc=
X-Received: by 2002:a5d:4144:: with SMTP id c4mr20127831wrq.200.1595855219277; 
 Mon, 27 Jul 2020 06:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS/6VuhPBRg4qoJm3gAe6yGun9pIFIp6UkHbtOgYWf3s+BZRYPCzWTe9pIOiCfx9m9ZiHGzg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr20127802wrq.200.1595855219008; 
 Mon, 27 Jul 2020 06:06:59 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id w125sm19105900wma.15.2020.07.27.06.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:06:58 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:06:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] virtio-mem-pci: force virtio version 1
Message-ID: <20200727090613-mutt-send-email-mst@kernel.org>
References: <20200727115905.129397-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727115905.129397-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 01:59:05PM +0200, David Hildenbrand wrote:
> Trying to run simple virtio-mem-pci examples currently fails with
>     qemu-system-x86_64: -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,
>     requested-size=300M: device is modern-only, use disable-legacy=on
> due to the added safety checks in 9b3a35ec8236 ("virtio: verify that legacy
> support is not accidentally on").
> 
> As noted by Conny, we have to force virtio version 1. While at it, use
> qdev_realize() to set the parent bus and realize - like most other
> virtio-*-pci implementations.
> 
> Fixes: 0b9a2443a48b ("virtio-pci: Proxy for virtio-mem")
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---


In the future, pls add a changelog here.
E.g.
changes from v1:
- rebased on master
- updated commit log to address mst's comments

Anyway, queued.

Thanks!

>  hw/virtio/virtio-mem-pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> index d375280ee1..590cec041b 100644
> --- a/hw/virtio/virtio-mem-pci.c
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -21,8 +21,8 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&mem_pci->vdev);
>  
> -    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> -    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
> +    virtio_pci_force_virtio_1(vpci_dev);
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>  }
>  
>  static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
> -- 
> 2.26.2


