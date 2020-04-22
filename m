Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B710C55181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 06:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E807C206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 06:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMXCJStp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E807C206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR8WG-0003Iw-2Z
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 02:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jR8V6-0002PG-Hg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jR8V4-0005l8-HF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:04:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53420
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jR8V3-0005Jj-Uu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587535482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K6d1FYGHs8H44Hb9rVmBZrpo1157wRtphKikMXYyOM=;
 b=EMXCJStpVVgruw9K6ldhkQUSkMdSpI4hoDsq3G+Y76DFuavRt1lTAa59x9RhrLQSLbutCC
 3FttFRcGClPfd/drzjxl+/N3VkWUIj9wTrYj/bm2PbDHLK+vX+ndnaERJkdKElmLFwKx85
 BfFlqBDpEPGW1+J6vn5SOu9SeFT61SQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-r3NE3_naPKOpU8OyvuotTw-1; Wed, 22 Apr 2020 02:04:40 -0400
X-MC-Unique: r3NE3_naPKOpU8OyvuotTw-1
Received: by mail-wm1-f72.google.com with SMTP id n127so369710wme.4
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 23:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m3iDCbLLjLpI6YWlJ0gOpT3anldWmwgoyjNXJHGkV70=;
 b=e7yFS8LFWsFNlKOOr9T5kB9V3qT1PZLmYb7Ps84KeCrQfI8q5CD8lNx7GCt7n46Uh2
 G8FxWtUHkdJNbJdUcWoy/bzbKQ3iKeGKcXMgxyowhhUjCB+FZ36xxUYkzNxifv5vj+rJ
 4JKCeJPY5t0jl4nJjFMwQFMlEk0uAPJf8y7R9rIUjXlwaS4cLA1hXsjK6//QaMub3yln
 gqCg5HLJc9J/YXC7S9QhRxgzp2gY3oRpk+ExgG9RPICHDRmjTEXosB8JVh+06X0sSSf8
 mTpB5A8Bnu+9i6Ez3PHXtgS6NGDvmNwXv9V2ODXmqrVhBd7p1t595KPclg7DWkkTsOZg
 Wu6g==
X-Gm-Message-State: AGi0Pub4jf/7a/5JQI3wufFFMvRHRJuQla9Cbt22WqWjl6F67ycfluO/
 wDCm5jf3mK5cdZW+7SgzDdIkMjaDLlQpHS2bkEt9R1JLZSJ9zKLqlH+EpISpRVXdtbNLtthRljb
 4LiaLF7GteT3YJfw=
X-Received: by 2002:a1c:5446:: with SMTP id p6mr8539645wmi.172.1587535479702; 
 Tue, 21 Apr 2020 23:04:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyV1RHM6/XFWZtDz3cpOWjDDQ/0NYh96vp3WKd+rVBugES2VOl1nt0yaQQGzSqyTrmmCihQA==
X-Received: by 2002:a1c:5446:: with SMTP id p6mr8539627wmi.172.1587535479428; 
 Tue, 21 Apr 2020 23:04:39 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id v10sm6890957wrq.45.2020.04.21.23.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 23:04:38 -0700 (PDT)
Date: Wed, 22 Apr 2020 02:04:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: Re: [PATCH] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200422020354-mutt-send-email-mst@kernel.org>
References: <20200421214853.14412-1-anthoine.bourgeois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200421214853.14412-1-anthoine.bourgeois@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:04:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 11:48:53PM +0200, Anthoine Bourgeois wrote:
> With virtio-vga, pci bar are reordered. Bar #2 is used for compatibility
> with stdvga. By default, bar #2 is used by virtio modern io bar.
> This bar is the last one introduce in the virtio pci bar layout and it's
> crushed by the virtio-vga reordering. So virtio-vga and
> modern-pio-notify are incompatible because virtio-vga failed to
> initialize with this option.
>=20
> This fix exchange the modern io bar with the modern memory bar,
> replacing the msix bar that is never impacted anyway.
>=20
> Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

Such changes generally need to be tied to machine version.


> ---
>  hw/display/virtio-vga.c | 2 +-
>  hw/virtio/virtio-pci.c  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index 2b4c2aa126..f5f8737c60 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -113,7 +113,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
>       * the stdvga mmio registers at the start of bar #2.
>       */
>      vpci_dev->modern_mem_bar_idx =3D 2;
> -    vpci_dev->msix_bar_idx =3D 4;
> +    vpci_dev->modern_io_bar_idx =3D 4;
> =20
>      if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
>          /*
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 4cb784389c..9c5efaa06e 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1705,6 +1705,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, =
Error **errp)
>       *
>       *   region 0   --  virtio legacy io bar
>       *   region 1   --  msi-x bar
> +     *   region 2   --  virtio modern io bar
>       *   region 4+5 --  virtio modern memory (64bit) bar
>       *
>       */
> --=20
> 2.20.1


