Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C050DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A43F20578
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQoUxflJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A43F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsW9-0003wZ-OB
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxsVS-0003CD-9c
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:40:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jxsVP-0005Ux-Aj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595338825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zVEoseuv1z98vLydWXW3KoMvkahndMWN+YIihURHeM=;
 b=dQoUxflJDz2KN0qVDfcMCajgYRYIOhnJPSeQX2tdqPA2lIHUIJr9hQXa7ZGON0S/QEKzVM
 Cni9nCSkiDk+i2YDxn6lsUlfmcNAGD+BDhhUPaMc3e1xKfCHdTAnL+DBpkSL0nfZt2fY/Z
 x4RSvbsQEImEBk7P9bNvggce6GuzqHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-G3B--E-gPueZ6I8FSFMzYQ-1; Tue, 21 Jul 2020 09:40:18 -0400
X-MC-Unique: G3B--E-gPueZ6I8FSFMzYQ-1
Received: by mail-wm1-f71.google.com with SMTP id f74so1062965wmf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6zVEoseuv1z98vLydWXW3KoMvkahndMWN+YIihURHeM=;
 b=V8G98q69s6cKFNt6H0QqEdcPv3B7+oY7eM0jHSxp8k7WmLxOmsGiI5sD3+U/mRBAMT
 8fm2UsPWJs+xVqxDx0HGPKc1zI9Bh/1R7W662exhwPyzHcUL4OCcweZb5id9D0TYS2xW
 0/m4J6RPub22isGxCFFycS9BCbVEBZKR4Ac3U/aRehmQUON011xetg1Ho/XMX3ZG4uKY
 I5tv0fgVLsMm/gJTNhtZxd6JpSgs89md1YDhj1cD3XnDVdfH15GDkuI4lp4X0GQF2l/w
 jCKbqJ9lasXEgv3rIeweec67+wJ0sdBeMfHiHYd61VyW0JBSLsT2xM5F0gKx1RXOvsZt
 2Oqg==
X-Gm-Message-State: AOAM531lG6rS1O6CQbyHYNFFbSiTT1nKWkTSxYaGKc121nfYVCkbI4k7
 XzwsePwJ5b5LN9tvPu+f09i+jDNy/xG1j5sVcYybejq2Bfl13EubpzLDaTxp8VfXOgunNFmwboG
 hLtoFSlKn/aU7tbg=
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr26221420wru.418.1595338815152; 
 Tue, 21 Jul 2020 06:40:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVEmp6OO5NcZgMAg9FjC9ZFEpyljT2fDjq3m77uBB2Hd3WznGLEXXKWQu562Z7D0OlYl1BbQ==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr26221388wru.418.1595338814738; 
 Tue, 21 Jul 2020 06:40:14 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id u2sm3324067wml.16.2020.07.21.06.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 06:40:13 -0700 (PDT)
Date: Tue, 21 Jul 2020 09:40:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 2/3] libvhost-user: handle endianness as mandated by the
 spec
Message-ID: <20200721093942-mutt-send-email-mst@kernel.org>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-3-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200717092929.19453-3-mhartmay@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 11:29:28AM +0200, Marc Hartmayer wrote:
> Since virtio existed even before it got standardized, the virtio
> standard defines the following types of virtio devices:
> 
>  + legacy device (pre-virtio 1.0)
>  + non-legacy or VIRTIO 1.0 device
>  + transitional device (which can act both as legacy and non-legacy)
> 
> Virtio 1.0 defines the fields of the virtqueues as little endian,
> while legacy uses guest's native endian [1]. Currently libvhost-user
> does not handle virtio endianness at all, i.e. it works only if the
> native endianness matches with whatever is actually needed. That means
> things break spectacularly on big-endian targets. Let us handle virtio
> endianness for non-legacy as required by the virtio specification
> [1]. We will fence non-legacy virtio devices with the upcoming patch.
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> 
> ---
> Note: As we don't support legacy virtio devices

Who's "we" in this sentence? vhost user supports legacy generally ...

> there is dead code in
> libvhost-access.h that could be removed. But for the sake of
> completeness, I left it in the code.
> ---
>  contrib/libvhost-user/libvhost-access.h |  61 ++++++++++++
>  contrib/libvhost-user/libvhost-user.c   | 119 ++++++++++++------------
>  2 files changed, 121 insertions(+), 59 deletions(-)
>  create mode 100644 contrib/libvhost-user/libvhost-access.h
> 
> diff --git a/contrib/libvhost-user/libvhost-access.h b/contrib/libvhost-user/libvhost-access.h
> new file mode 100644
> index 000000000000..868ba3e7bfb8
> --- /dev/null
> +++ b/contrib/libvhost-user/libvhost-access.h
> @@ -0,0 +1,61 @@
> +#ifndef LIBVHOST_ACCESS_H
> +
> +#include "qemu/bswap.h"
> +
> +#include "libvhost-user.h"
> +
> +static inline bool vu_access_is_big_endian(VuDev *dev)
> +{
> +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +    return false;
> +}
> +
> +static inline void vu_stw_p(VuDev *vdev, void *ptr, uint16_t v)
> +{
> +    if (vu_access_is_big_endian(vdev)) {
> +        stw_be_p(ptr, v);
> +    } else {
> +        stw_le_p(ptr, v);
> +    }
> +}
> +
> +static inline void vu_stl_p(VuDev *vdev, void *ptr, uint32_t v)
> +{
> +    if (vu_access_is_big_endian(vdev)) {
> +        stl_be_p(ptr, v);
> +    } else {
> +        stl_le_p(ptr, v);
> +    }
> +}
> +
> +static inline void vu_stq_p(VuDev *vdev, void *ptr, uint64_t v)
> +{
> +    if (vu_access_is_big_endian(vdev)) {
> +        stq_be_p(ptr, v);
> +    } else {
> +        stq_le_p(ptr, v);
> +    }
> +}
> +
> +static inline int vu_lduw_p(VuDev *vdev, const void *ptr)
> +{
> +    if (vu_access_is_big_endian(vdev))
> +        return lduw_be_p(ptr);
> +    return lduw_le_p(ptr);
> +}
> +
> +static inline int vu_ldl_p(VuDev *vdev, const void *ptr)
> +{
> +    if (vu_access_is_big_endian(vdev))
> +        return ldl_be_p(ptr);
> +    return ldl_le_p(ptr);
> +}
> +
> +static inline uint64_t vu_ldq_p(VuDev *vdev, const void *ptr)
> +{
> +    if (vu_access_is_big_endian(vdev))
> +        return ldq_be_p(ptr);
> +    return ldq_le_p(ptr);
> +}
> +
> +#endif /* LIBVHOST_ACCESS_H */
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index d315db139606..0214b04c5291 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -45,6 +45,7 @@
>  #include "qemu/memfd.h"
>  
>  #include "libvhost-user.h"
> +#include "libvhost-access.h"
>  
>  /* usually provided by GLib */
>  #ifndef MIN
> @@ -1074,7 +1075,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
>          return false;
>      }
>  
> -    vq->used_idx = vq->vring.used->idx;
> +    vq->used_idx = vu_lduw_p(dev, &vq->vring.used->idx);
>  
>      if (vq->last_avail_idx != vq->used_idx) {
>          bool resume = dev->iface->queue_is_processed_in_order &&
> @@ -1191,7 +1192,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
>          return 0;
>      }
>  
> -    vq->used_idx = vq->vring.used->idx;
> +    vq->used_idx = vu_lduw_p(dev, &vq->vring.used->idx);
>      vq->resubmit_num = 0;
>      vq->resubmit_list = NULL;
>      vq->counter = 0;
> @@ -2019,35 +2020,35 @@ vu_queue_started(const VuDev *dev, const VuVirtq *vq)
>  }
>  
>  static inline uint16_t
> -vring_avail_flags(VuVirtq *vq)
> +vring_avail_flags(VuDev *dev, VuVirtq *vq)
>  {
> -    return vq->vring.avail->flags;
> +    return vu_lduw_p(dev, &vq->vring.avail->flags);
>  }
>  
>  static inline uint16_t
> -vring_avail_idx(VuVirtq *vq)
> +vring_avail_idx(VuDev *dev, VuVirtq *vq)
>  {
> -    vq->shadow_avail_idx = vq->vring.avail->idx;
> +    vq->shadow_avail_idx = vu_lduw_p(dev, &vq->vring.avail->idx);
>  
>      return vq->shadow_avail_idx;
>  }
>  
>  static inline uint16_t
> -vring_avail_ring(VuVirtq *vq, int i)
> +vring_avail_ring(VuDev *dev, VuVirtq *vq, int i)
>  {
> -    return vq->vring.avail->ring[i];
> +    return vu_lduw_p(dev, &vq->vring.avail->ring[i]);
>  }
>  
>  static inline uint16_t
> -vring_get_used_event(VuVirtq *vq)
> +vring_get_used_event(VuDev *dev, VuVirtq *vq)
>  {
> -    return vring_avail_ring(vq, vq->vring.num);
> +    return vring_avail_ring(dev, vq, vq->vring.num);
>  }
>  
>  static int
>  virtqueue_num_heads(VuDev *dev, VuVirtq *vq, unsigned int idx)
>  {
> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> +    uint16_t num_heads = vring_avail_idx(dev, vq) - idx;
>  
>      /* Check it isn't doing very strange things with descriptor numbers. */
>      if (num_heads > vq->vring.num) {
> @@ -2070,7 +2071,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
>  {
>      /* Grab the next descriptor number they're advertising, and increment
>       * the index we've seen. */
> -    *head = vring_avail_ring(vq, idx % vq->vring.num);
> +    *head = vring_avail_ring(dev, vq, idx % vq->vring.num);
>  
>      /* If their number is silly, that's a fatal mistake. */
>      if (*head >= vq->vring.num) {
> @@ -2123,12 +2124,12 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
>                           int i, unsigned int max, unsigned int *next)
>  {
>      /* If this descriptor says it doesn't chain, we're done. */
> -    if (!(desc[i].flags & VRING_DESC_F_NEXT)) {
> +    if (!(vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_NEXT)) {
>          return VIRTQUEUE_READ_DESC_DONE;
>      }
>  
>      /* Check they're not leading us off end of descriptors. */
> -    *next = desc[i].next;
> +    *next = vu_lduw_p(dev, &desc[i].next);
>      /* Make sure compiler knows to grab that: we don't want it changing! */
>      smp_wmb();
>  
> @@ -2171,8 +2172,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>          }
>          desc = vq->vring.desc;
>  
> -        if (desc[i].flags & VRING_DESC_F_INDIRECT) {
> -            if (desc[i].len % sizeof(struct vring_desc)) {
> +        if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_INDIRECT) {
> +            if (vu_ldl_p(dev, &desc[i].len) % sizeof(struct vring_desc)) {
>                  vu_panic(dev, "Invalid size for indirect buffer table");
>                  goto err;
>              }
> @@ -2185,8 +2186,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>  
>              /* loop over the indirect descriptor table */
>              indirect = 1;
> -            desc_addr = desc[i].addr;
> -            desc_len = desc[i].len;
> +            desc_addr = vu_ldq_p(dev, &desc[i].addr);
> +            desc_len = vu_ldl_p(dev, &desc[i].len);
>              max = desc_len / sizeof(struct vring_desc);
>              read_len = desc_len;
>              desc = vu_gpa_to_va(dev, &read_len, desc_addr);
> @@ -2213,10 +2214,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>                  goto err;
>              }
>  
> -            if (desc[i].flags & VRING_DESC_F_WRITE) {
> -                in_total += desc[i].len;
> +            if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_WRITE) {
> +                in_total += vu_ldl_p(dev, &desc[i].len);
>              } else {
> -                out_total += desc[i].len;
> +                out_total += vu_ldl_p(dev, &desc[i].len);
>              }
>              if (in_total >= max_in_bytes && out_total >= max_out_bytes) {
>                  goto done;
> @@ -2277,7 +2278,7 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
>          return false;
>      }
>  
> -    return vring_avail_idx(vq) == vq->last_avail_idx;
> +    return vring_avail_idx(dev, vq) == vq->last_avail_idx;
>  }
>  
>  static bool
> @@ -2296,14 +2297,14 @@ vring_notify(VuDev *dev, VuVirtq *vq)
>      }
>  
>      if (!vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
> -        return !(vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT);
> +        return !(vring_avail_flags(dev, vq) & VRING_AVAIL_F_NO_INTERRUPT);
>      }
>  
>      v = vq->signalled_used_valid;
>      vq->signalled_used_valid = true;
>      old = vq->signalled_used;
>      new = vq->signalled_used = vq->used_idx;
> -    return !v || vring_need_event(vring_get_used_event(vq), new, old);
> +    return !v || vring_need_event(vring_get_used_event(dev, vq), new, old);
>  }
>  
>  static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
> @@ -2361,33 +2362,33 @@ void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq)
>  }
>  
>  static inline void
> -vring_used_flags_set_bit(VuVirtq *vq, int mask)
> +vring_used_flags_set_bit(VuDev *dev, VuVirtq *vq, int mask)
> +{
> +    uint16_t *flags;
> +
> +    flags = (uint16_t *)(char*)vq->vring.used +
> +        offsetof(struct vring_used, flags);
> +    vu_stw_p(dev, flags, vu_lduw_p(dev, flags) | mask);
> +}
> +
> +static inline void
> +vring_used_flags_unset_bit(VuDev *dev, VuVirtq *vq, int mask)
>  {
>      uint16_t *flags;
>  
>      flags = (uint16_t *)((char*)vq->vring.used +
>                           offsetof(struct vring_used, flags));
> -    *flags |= mask;
> +    vu_stw_p(dev, flags, vu_lduw_p(dev, flags) & ~mask);
>  }
>  
>  static inline void
> -vring_used_flags_unset_bit(VuVirtq *vq, int mask)
> -{
> -    uint16_t *flags;
> -
> -    flags = (uint16_t *)((char*)vq->vring.used +
> -                         offsetof(struct vring_used, flags));
> -    *flags &= ~mask;
> -}
> -
> -static inline void
> -vring_set_avail_event(VuVirtq *vq, uint16_t val)
> +vring_set_avail_event(VuDev *dev, VuVirtq *vq, uint16_t val)
>  {
>      if (!vq->notification) {
>          return;
>      }
>  
> -    *((uint16_t *) &vq->vring.used->ring[vq->vring.num]) = val;
> +    vu_stw_p(dev, &vq->vring.used->ring[vq->vring.num], val);
>  }
>  
>  void
> @@ -2395,11 +2396,11 @@ vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable)
>  {
>      vq->notification = enable;
>      if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
> -        vring_set_avail_event(vq, vring_avail_idx(vq));
> +        vring_set_avail_event(dev, vq, vring_avail_idx(dev, vq));
>      } else if (enable) {
> -        vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
> +        vring_used_flags_unset_bit(dev, vq, VRING_USED_F_NO_NOTIFY);
>      } else {
> -        vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
> +        vring_used_flags_set_bit(dev, vq, VRING_USED_F_NO_NOTIFY);
>      }
>      if (enable) {
>          /* Expose avail event/used flags before caller checks the avail idx. */
> @@ -2476,14 +2477,14 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>      struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
>      int rc;
>  
> -    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
> -        if (desc[i].len % sizeof(struct vring_desc)) {
> +    if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_INDIRECT) {
> +        if (vu_ldl_p(dev, &desc[i].len) % sizeof(struct vring_desc)) {
>              vu_panic(dev, "Invalid size for indirect buffer table");
>          }
>  
>          /* loop over the indirect descriptor table */
> -        desc_addr = desc[i].addr;
> -        desc_len = desc[i].len;
> +        desc_addr = vu_ldq_p(dev, &desc[i].addr);
> +        desc_len = vu_ldl_p(dev, &desc[i].len);
>          max = desc_len / sizeof(struct vring_desc);
>          read_len = desc_len;
>          desc = vu_gpa_to_va(dev, &read_len, desc_addr);
> @@ -2505,10 +2506,10 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>  
>      /* Collect all the descriptors */
>      do {
> -        if (desc[i].flags & VRING_DESC_F_WRITE) {
> +        if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_WRITE) {
>              virtqueue_map_desc(dev, &in_num, iov + out_num,
>                                 VIRTQUEUE_MAX_SIZE - out_num, true,
> -                               desc[i].addr, desc[i].len);
> +                               vu_ldq_p(dev, &desc[i].addr), vu_ldl_p(dev, &desc[i].len));
>          } else {
>              if (in_num) {
>                  vu_panic(dev, "Incorrect order for descriptors");
> @@ -2516,7 +2517,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>              }
>              virtqueue_map_desc(dev, &out_num, iov,
>                                 VIRTQUEUE_MAX_SIZE, false,
> -                               desc[i].addr, desc[i].len);
> +                               vu_ldq_p(dev, &desc[i].addr), vu_ldl_p(dev, &desc[i].len));
>          }
>  
>          /* If we've got too many, that implies a descriptor loop. */
> @@ -2642,7 +2643,7 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>      }
>  
>      if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
> -        vring_set_avail_event(vq, vq->last_avail_idx);
> +        vring_set_avail_event(dev, vq, vq->last_avail_idx);
>      }
>  
>      elem = vu_queue_map_desc(dev, vq, head, sz);
> @@ -2712,14 +2713,14 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
>      max = vq->vring.num;
>      i = elem->index;
>  
> -    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
> -        if (desc[i].len % sizeof(struct vring_desc)) {
> +    if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_INDIRECT) {
> +        if (vu_ldl_p(dev, &desc[i].len) % sizeof(struct vring_desc)) {
>              vu_panic(dev, "Invalid size for indirect buffer table");
>          }
>  
>          /* loop over the indirect descriptor table */
> -        desc_addr = desc[i].addr;
> -        desc_len = desc[i].len;
> +        desc_addr = vu_ldq_p(dev, &desc[i].addr);
> +        desc_len = vu_ldl_p(dev, &desc[i].len);
>          max = desc_len / sizeof(struct vring_desc);
>          read_len = desc_len;
>          desc = vu_gpa_to_va(dev, &read_len, desc_addr);
> @@ -2745,9 +2746,9 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
>              return;
>          }
>  
> -        if (desc[i].flags & VRING_DESC_F_WRITE) {
> -            min = MIN(desc[i].len, len);
> -            vu_log_write(dev, desc[i].addr, min);
> +        if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_WRITE) {
> +            min = MIN(vu_ldl_p(dev, &desc[i].len), len);
> +            vu_log_write(dev, vu_ldq_p(dev, &desc[i].addr), min);
>              len -= min;
>          }
>  
> @@ -2772,15 +2773,15 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
>  
>      idx = (idx + vq->used_idx) % vq->vring.num;
>  
> -    uelem.id = elem->index;
> -    uelem.len = len;
> +    vu_stl_p(dev, &uelem.id, elem->index);
> +    vu_stl_p(dev, &uelem.len, len);
>      vring_used_write(dev, vq, &uelem, idx);
>  }
>  
>  static inline
>  void vring_used_idx_set(VuDev *dev, VuVirtq *vq, uint16_t val)
>  {
> -    vq->vring.used->idx = val;
> +    vu_stw_p(dev, &vq->vring.used->idx, val);
>      vu_log_write(dev,
>                   vq->vring.log_guest_addr + offsetof(struct vring_used, idx),
>                   sizeof(vq->vring.used->idx));
> -- 
> 2.25.4


