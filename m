Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F3C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 05:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3772075A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 05:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmABQoZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3772075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k26Ll-00076O-GY
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 01:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k26Kw-0006aU-Bx
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 01:15:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60517
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k26Kt-0004q1-Jr
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 01:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596345302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t940nU9dWew1+U6Rir6rGT42NaRg3ivb+22ham5KRS8=;
 b=PmABQoZ68l11MPLgL8QnuDpai9Ul0Kmxfk2+oHScqTyMgfFl+6HoPLSjKVRrQ+VTnCZ/cQ
 nIMlsInhYGdNfGhlMOtx9OoyPu0l1J8BPqhvNN91xlGm6PMls0wgutfc9f6TcYPBZH+eLn
 WroZId115cGF+WQam5226hPWhigs0GE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-iE5cLXnYNOK_WeNSxgdYBQ-1; Sun, 02 Aug 2020 01:13:33 -0400
X-MC-Unique: iE5cLXnYNOK_WeNSxgdYBQ-1
Received: by mail-wr1-f72.google.com with SMTP id e12so10307486wra.13
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2020 22:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t940nU9dWew1+U6Rir6rGT42NaRg3ivb+22ham5KRS8=;
 b=EWFOmKyaT02duM617izP8BSKcr1GzyfMHmSVl6EVRxBPP5a3pva4Rkmx7S+kSrzB+D
 gmyV9PJe52zaypTXZThTuQEATh4fEefq+LYXipkaBbyH96PLtLi52B82G0ZmpRZRAuFi
 X6xo6StcaTZ95rCdrhC7zAQi4ZJr5YTuLqwC8eUHg3x2Loq92wFYfDnrwBaIGoyBZTYT
 KWWpeJ46a5m22YvPRNTJyl7RP/FgqAkIOv0kSsD+ioUxJ8shsqFkbrQdT2/YhpzFY6sr
 k+1HkqOyh+nnif6izqrOi4KsI3p9ZclPWTE59MFudiT/EPtRJbs2kxc4LfPKKfFMFEnR
 NiIg==
X-Gm-Message-State: AOAM531hulVt5j8gCCuw5rImaVnAxl6J85eF7bnchB1LH25GYpObkY9U
 xVmJV9bCJiyvlv29Ul3Eo8LIoaLi+ih7dm523slffhSgq2DE2X0OBr+jEYYGH8o+i7f99XBe99O
 LqvQBcYiIIV1bLRI=
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr10047439wmc.24.1596345212417; 
 Sat, 01 Aug 2020 22:13:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8iBWtD3/QVTR8Zr6z5TLLO1rmX5vXKgDH9pQfJU1yK4WmB+/jR9+fIS5FC2p1A71R0ni3Jw==
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr10047421wmc.24.1596345212112; 
 Sat, 01 Aug 2020 22:13:32 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id 62sm19033040wrq.31.2020.08.01.22.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 22:13:31 -0700 (PDT)
Date: Sun, 2 Aug 2020 01:13:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 2/2] libvhost-user: handle endianness as mandated by the
 spec
Message-ID: <20200802011240-mutt-send-email-mst@kernel.org>
References: <20200730140731.32912-1-mhartmay@linux.ibm.com>
 <20200730140731.32912-3-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200730140731.32912-3-mhartmay@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 01:15:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 30, 2020 at 04:07:31PM +0200, Marc Hartmayer wrote:
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
> [1]. The fencing of legacy virtio devices is done in
> `vu_set_features_exec`.
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 77 +++++++++++++++------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 53f16bdf082c..e2238a0400c9 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -42,6 +42,7 @@
>  
>  #include "qemu/atomic.h"
>  #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>  #include "qemu/memfd.h"
>  
>  #include "libvhost-user.h"
> @@ -539,6 +540,14 @@ vu_set_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>      DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
>  
>      dev->features = vmsg->payload.u64;
> +    if (!vu_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +        /*
> +         * We only support devices conforming to VIRTIO 1.0 or
> +         * later
> +         */
> +        vu_panic(dev, "virtio legacy devices aren't supported by libvhost-user");
> +        return false;
> +    }
>  
>      if (!(dev->features & VHOST_USER_F_PROTOCOL_FEATURES)) {
>          vu_set_enable_all_rings(dev, true);
> @@ -1074,7 +1083,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
>          return false;
>      }
>  
> -    vq->used_idx = vq->vring.used->idx;
> +    vq->used_idx = lduw_le_p(&vq->vring.used->idx);
>  
>      if (vq->last_avail_idx != vq->used_idx) {
>          bool resume = dev->iface->queue_is_processed_in_order &&
> @@ -1191,7 +1200,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
>          return 0;
>      }
>  
> -    vq->used_idx = vq->vring.used->idx;
> +    vq->used_idx = lduw_le_p(&vq->vring.used->idx);
>      vq->resubmit_num = 0;
>      vq->resubmit_list = NULL;
>      vq->counter = 0;
> @@ -2021,13 +2030,13 @@ vu_queue_started(const VuDev *dev, const VuVirtq *vq)
>  static inline uint16_t
>  vring_avail_flags(VuVirtq *vq)
>  {
> -    return vq->vring.avail->flags;
> +    return lduw_le_p(&vq->vring.avail->flags);
>  }
>  
>  static inline uint16_t
>  vring_avail_idx(VuVirtq *vq)
>  {
> -    vq->shadow_avail_idx = vq->vring.avail->idx;
> +    vq->shadow_avail_idx = lduw_le_p(&vq->vring.avail->idx);
>  
>      return vq->shadow_avail_idx;
>  }
> @@ -2035,7 +2044,7 @@ vring_avail_idx(VuVirtq *vq)
>  static inline uint16_t
>  vring_avail_ring(VuVirtq *vq, int i)
>  {
> -    return vq->vring.avail->ring[i];
> +    return lduw_le_p(&vq->vring.avail->ring[i]);
>  }
>  
>  static inline uint16_t
> @@ -2123,12 +2132,12 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
>                           int i, unsigned int max, unsigned int *next)
>  {
>      /* If this descriptor says it doesn't chain, we're done. */
> -    if (!(desc[i].flags & VRING_DESC_F_NEXT)) {
> +    if (!(lduw_le_p(&desc[i].flags) & VRING_DESC_F_NEXT)) {
>          return VIRTQUEUE_READ_DESC_DONE;
>      }
>  
>      /* Check they're not leading us off end of descriptors. */
> -    *next = desc[i].next;
> +    *next = lduw_le_p(&desc[i].next);
>      /* Make sure compiler knows to grab that: we don't want it changing! */
>      smp_wmb();
>  
> @@ -2171,8 +2180,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>          }
>          desc = vq->vring.desc;
>  
> -        if (desc[i].flags & VRING_DESC_F_INDIRECT) {
> -            if (desc[i].len % sizeof(struct vring_desc)) {
> +        if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
> +            if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
>                  vu_panic(dev, "Invalid size for indirect buffer table");
>                  goto err;
>              }
> @@ -2185,8 +2194,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>  
>              /* loop over the indirect descriptor table */
>              indirect = 1;
> -            desc_addr = desc[i].addr;
> -            desc_len = desc[i].len;
> +            desc_addr = ldq_le_p(&desc[i].addr);
> +            desc_len = ldl_le_p(&desc[i].len);
>              max = desc_len / sizeof(struct vring_desc);
>              read_len = desc_len;
>              desc = vu_gpa_to_va(dev, &read_len, desc_addr);
> @@ -2213,10 +2222,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>                  goto err;
>              }
>  
> -            if (desc[i].flags & VRING_DESC_F_WRITE) {
> -                in_total += desc[i].len;
> +            if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_WRITE) {
> +                in_total += ldl_le_p(&desc[i].len);
>              } else {
> -                out_total += desc[i].len;
> +                out_total += ldl_le_p(&desc[i].len);
>              }
>              if (in_total >= max_in_bytes && out_total >= max_out_bytes) {
>                  goto done;
> @@ -2367,7 +2376,7 @@ vring_used_flags_set_bit(VuVirtq *vq, int mask)
>  
>      flags = (uint16_t *)((char*)vq->vring.used +
>                           offsetof(struct vring_used, flags));
> -    *flags |= mask;
> +    stw_le_p(flags, lduw_le_p(flags) | mask);
>  }
>  
>  static inline void
> @@ -2377,7 +2386,7 @@ vring_used_flags_unset_bit(VuVirtq *vq, int mask)
>  
>      flags = (uint16_t *)((char*)vq->vring.used +
>                           offsetof(struct vring_used, flags));
> -    *flags &= ~mask;
> +    stw_le_p(flags, lduw_le_p(flags) & ~mask);
>  }
>  
>  static inline void
> @@ -2387,7 +2396,7 @@ vring_set_avail_event(VuVirtq *vq, uint16_t val)
>          return;
>      }
>  
> -    *((uint16_t *) &vq->vring.used->ring[vq->vring.num]) = val;
> +    stw_le_p(&vq->vring.used->ring[vq->vring.num], val);
>  }
>  
>  void
> @@ -2476,14 +2485,14 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>      struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
>      int rc;
>  
> -    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
> -        if (desc[i].len % sizeof(struct vring_desc)) {
> +    if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
> +        if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
>              vu_panic(dev, "Invalid size for indirect buffer table");
>          }
>  
>          /* loop over the indirect descriptor table */
> -        desc_addr = desc[i].addr;
> -        desc_len = desc[i].len;
> +        desc_addr = ldq_le_p(&desc[i].addr);
> +        desc_len = ldl_le_p(&desc[i].len);
>          max = desc_len / sizeof(struct vring_desc);
>          read_len = desc_len;
>          desc = vu_gpa_to_va(dev, &read_len, desc_addr);
> @@ -2505,10 +2514,10 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>  
>      /* Collect all the descriptors */
>      do {
> -        if (desc[i].flags & VRING_DESC_F_WRITE) {
> +        if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_WRITE) {
>              virtqueue_map_desc(dev, &in_num, iov + out_num,
>                                 VIRTQUEUE_MAX_SIZE - out_num, true,
> -                               desc[i].addr, desc[i].len);
> +                               ldq_le_p(&desc[i].addr), ldl_le_p(&desc[i].len));
>          } else {
>              if (in_num) {
>                  vu_panic(dev, "Incorrect order for descriptors");
> @@ -2516,7 +2525,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>              }
>              virtqueue_map_desc(dev, &out_num, iov,
>                                 VIRTQUEUE_MAX_SIZE, false,
> -                               desc[i].addr, desc[i].len);
> +                               ldq_le_p(&desc[i].addr), ldl_le_p(&desc[i].len));
>          }
>  
>          /* If we've got too many, that implies a descriptor loop. */
> @@ -2712,14 +2721,14 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
>      max = vq->vring.num;
>      i = elem->index;
>  
> -    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
> -        if (desc[i].len % sizeof(struct vring_desc)) {
> +    if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
> +        if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
>              vu_panic(dev, "Invalid size for indirect buffer table");
>          }
>  
>          /* loop over the indirect descriptor table */
> -        desc_addr = desc[i].addr;
> -        desc_len = desc[i].len;
> +        desc_addr = ldq_le_p(&desc[i].addr);
> +        desc_len = ldl_le_p(&desc[i].len);
>          max = desc_len / sizeof(struct vring_desc);
>          read_len = desc_len;
>          desc = vu_gpa_to_va(dev, &read_len, desc_addr);
> @@ -2745,9 +2754,9 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
>              return;
>          }
>  
> -        if (desc[i].flags & VRING_DESC_F_WRITE) {
> -            min = MIN(desc[i].len, len);
> -            vu_log_write(dev, desc[i].addr, min);
> +        if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_WRITE) {
> +            min = MIN(ldl_le_p(&desc[i].len), len);
> +            vu_log_write(dev, ldq_le_p(&desc[i].addr), min);
>              len -= min;
>          }
>  
> @@ -2772,15 +2781,15 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
>  
>      idx = (idx + vq->used_idx) % vq->vring.num;
>  
> -    uelem.id = elem->index;
> -    uelem.len = len;
> +    stl_le_p(&uelem.id, elem->index);
> +    stl_le_p(&uelem.len, len);
>      vring_used_write(dev, vq, &uelem, idx);
>  }
>  
>  static inline
>  void vring_used_idx_set(VuDev *dev, VuVirtq *vq, uint16_t val)
>  {
> -    vq->vring.used->idx = val;
> +    stw_le_p(&vq->vring.used->idx, val);
>      vu_log_write(dev,
>                   vq->vring.log_guest_addr + offsetof(struct vring_used, idx),
>                   sizeof(vq->vring.used->idx));
> -- 
> 2.25.4


