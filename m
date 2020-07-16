Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C68C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE66206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF15XlEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE66206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxZG-0006rV-PQ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxYd-0006SO-BD
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:39:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60735
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxYb-0007Re-0I
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594881588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LpP0mH47EUa4gYHjkk/BxjQD6yumtpgpcOHSj9loGxE=;
 b=HF15XlECGAJ9jMqad6NFpgrJf/KR+hIzCNZeF9GzsdKrsfcod1vfeWQCVI6un1l3XPsDk0
 beYxKzbF3Wkf8UnOB+oLNgpQKaPaNeaQySE1wuyQ7pjW1oUklsxj+ZYGtlguXJmGy+tFRY
 aFmldnTk33EQxtwxrx0nKQ8y4PDKs+U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-dbnzAFhDMZyKveCHT23nbQ-1; Thu, 16 Jul 2020 02:39:45 -0400
X-MC-Unique: dbnzAFhDMZyKveCHT23nbQ-1
Received: by mail-wr1-f70.google.com with SMTP id a18so4730822wrm.14
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 23:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LpP0mH47EUa4gYHjkk/BxjQD6yumtpgpcOHSj9loGxE=;
 b=tzwbyMNbcc3sK5MxHpRebU+Taw+9H4SC579wg4VnRzkppF45D+m3ndYkXUiBrn+Y9P
 QPRIwGVWIfn2Ea0Wlo3ys0u8oTQhzHGnrt3uSVqwNktGBsB6T1R5WiOxZwzwVxoDvoT4
 vI8H2eloIqFSl5HvfgEC35VUHpQPX3GjgrvJfk82o5UI9O5wBS2zBT/YCqoG2upAH/xE
 Guy1+rJvW6V+bQW4Nhh9Kw1N4BXjgSR0v2z7b26pLAB43VEV/bJ/2n1YT9J6EhAC9Beu
 n9tBGwE0WQsuXs2y1ednGJFwf+TFzDqquY5weqYATtvsByNrUBWy1tWLUpSoTNfsP80t
 GKcQ==
X-Gm-Message-State: AOAM531BSvosB6LtVZ/Ow31m5fDLQitClYABeuzjr66lzYsQ6bO7B+kN
 D9KLu3ObxZf38+ntoPgMUsuxHDdYBZybhARmI2c3Ci5X5E4eCUJd7dPIvJWDr6DW4RdBfFpV9Sw
 jKAK4y9sWQGa7L6I=
X-Received: by 2002:a5d:4591:: with SMTP id p17mr3460243wrq.343.1594881583717; 
 Wed, 15 Jul 2020 23:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3VgldvMJ2su+01++hUBPJJNqM48adq88ynHNwf0eV6ZBA8mXoC0Vsx4p+YmzOHAxQ/sH+3w==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr3460225wrq.343.1594881583537; 
 Wed, 15 Jul 2020 23:39:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 b23sm7588607wmd.37.2020.07.15.23.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 23:39:42 -0700 (PDT)
Date: Thu, 16 Jul 2020 02:39:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hui Zhu <teawater@gmail.com>
Subject: Re: [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to deflate
 continuous pages
Message-ID: <20200716023910-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-6-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1594867315-8626-6-git-send-email-teawater@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
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
Cc: virtio-dev@lists.oasis-open.org, david@redhat.com, qemu-devel@nongnu.org,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 10:41:55AM +0800, Hui Zhu wrote:
> This commit adds a vq dcvq to deflate continuous pages.
> When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
> from icvq and use madvise MADV_WILLNEED with the pages.
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

This is arguably something to benchmark. Does guest benefit
from MADV_WILLNEED or loose performance?

> ---
>  hw/virtio/virtio-balloon.c         | 14 +++++++++-----
>  include/hw/virtio/virtio-balloon.h |  2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d36a5c8..165adf7 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>  }
>  
>  static void balloon_deflate_page(VirtIOBalloon *balloon,
> -                                 MemoryRegion *mr, hwaddr mr_offset)
> +                                 MemoryRegion *mr, hwaddr mr_offset,
> +                                 size_t size)
>  {
>      void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
>      ram_addr_t rb_offset;
> @@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>      rb_page_size = qemu_ram_pagesize(rb);
>  
>      host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
> +    size &= ~(rb_page_size - 1);
>  
>      /* When a page is deflated, we hint the whole host page it lives
>       * on, since we can't do anything smaller */
> -    ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
> +    ret = qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
>      if (ret != 0) {
>          warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
>                      strerror(errno));
> @@ -354,7 +356,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>              pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset += 4;
>  
> -            if (vq == s->icvq) {
> +            if (vq == s->icvq || vq == s->dcvq) {
>                  uint32_t psize_ptr;
>                  if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
>                      break;
> @@ -383,8 +385,9 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>                      balloon_inflate_page(s, section.mr,
>                                           section.offset_within_region,
>                                           psize, &pbp);
> -                } else if (vq == s->dvq) {
> -                    balloon_deflate_page(s, section.mr, section.offset_within_region);
> +                } else if (vq == s->dvq || vq == s->dcvq) {
> +                    balloon_deflate_page(s, section.mr, section.offset_within_region,
> +                                         psize);
>                  } else {
>                      g_assert_not_reached();
>                  }
> @@ -838,6 +841,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>  
>      if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
>          s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
> +        s->dcvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      }
>  
>      reset_stats(s);
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 6a2514d..848a7fb 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>  
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
>      uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> -- 
> 2.7.4


