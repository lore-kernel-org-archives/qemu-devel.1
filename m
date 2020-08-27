Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC919C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75D9207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dyeuk6fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75D9207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGld-0000x5-T7
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGkf-0000DG-Dp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:11:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21978
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGkd-0002Ov-4L
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598530290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hXHdZE897zbysGYlqKTIk8w3OS0oHNUgRlarmGehde8=;
 b=Dyeuk6fZzM7qCFwZngTVh46OAv2HFoHdR+qGSScMph/9AkjN/ej+lS/isFP8+ndn0A8foK
 tIeQYQ2Wrm1zw4tl2l9ILmssLomtjz3kp9V7ZYr4O7tkZOFmhL312yAF2ySTPI2InWzNQ6
 Jj9tp6HoqQPPVRMY5ORnNhjsxw8uAOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-hJoosnvOPCeLDSWiJdwYVA-1; Thu, 27 Aug 2020 08:11:28 -0400
X-MC-Unique: hJoosnvOPCeLDSWiJdwYVA-1
Received: by mail-wm1-f72.google.com with SMTP id a5so1983422wmj.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hXHdZE897zbysGYlqKTIk8w3OS0oHNUgRlarmGehde8=;
 b=pAjSmdmKOjYAC7bloHGlMb23e5YYchrGTI7pFpqCplk0Qs0QkviSDiRzqSZDVEugGu
 GMTLnjRqNBJfnXslxAUTwMo2mcVdnQnV38xknJNREyWXJGtMm7HZek3IOgcTu2SnMoxc
 oI+4On2Htt4rdQ/rhaKiLERMfWCrxlqjkPawddEsda6GxIXo4ap4R0zUmp5KTzfVQSzV
 YFVEs4PE5hsJX7SaokEMCYaiBNLg80Ynyg1DIb3ha/C0BuYccWEDPwPpGRQmnFwz8Z2O
 QPMsYjUYEqOGStPAqpY9iVNfyVbFmoLcypw7TAGNQIpTjftYZj19jmHis3Mpuxu/3jMj
 upcg==
X-Gm-Message-State: AOAM533Hen3/j/bQLckrBk2OMNrLfyICbHde476HyxwZrZB9ni275Um9
 ub8EvohNAVlsiaycd9r9zz5MrnV+zOEKtIF2tPSXkbGB1hVQd8H2RJDFiPOOgmpQ20eKfhdUB22
 LD6DIRqwGAzQItH8=
X-Received: by 2002:a1c:a70c:: with SMTP id q12mr11668923wme.89.1598530286682; 
 Thu, 27 Aug 2020 05:11:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEUiojX4Bkf4wT/SK0HSkqo4H8jkeMcVpT9ftOKGIc66BXMDsTB/LxfItjAc9ud8GEJxcJrg==
X-Received: by 2002:a1c:a70c:: with SMTP id q12mr11668892wme.89.1598530286376; 
 Thu, 27 Aug 2020 05:11:26 -0700 (PDT)
Received: from redhat.com (bzq-79-180-15-82.red.bezeqint.net. [79.180.15.82])
 by smtp.gmail.com with ESMTPSA id
 b14sm5268940wrj.93.2020.08.27.05.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 05:11:25 -0700 (PDT)
Date: Thu, 27 Aug 2020 08:11:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiajun Chen <chenjiajun8@huawei.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
Message-ID: <20200827081005-mutt-send-email-mst@kernel.org>
References: <20200811014343.17140-1-chenjiajun8@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200811014343.17140-1-chenjiajun8@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, raphael.norwitz@nutanix.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 09:43:43AM +0800, Jiajun Chen wrote:
> Used_memslots is equal to dev->mem->nregions now, it is true for
> vhost kernel, but not for vhost user, which uses the memory regions
> that have file descriptor. In fact, not all of the memory regions
> have file descriptor.
> It is usefully in some scenarios, e.g. used_memslots is 8, and only
> 5 memory slots can be used by vhost user, it is failed to hot plug
> a new memory RAM because vhost_has_free_slot just returned false,
> but we can hot plug it safely in fact.
> 
> Signed-off-by: Jiajun Chen <chenjiajun8@huawei.com>
> Signed-off-by: Jianjay Zhou <jianjay.zhou@huawei.com>

cc a bunch more people

> ---
>  hw/virtio/vhost-backend.c         | 14 ++++++++
>  hw/virtio/vhost-user.c            | 28 ++++++++++++++++
>  hw/virtio/vhost.c                 | 54 +++++++++++++++++++++++++------
>  include/hw/virtio/vhost-backend.h |  5 +++
>  include/hw/virtio/vhost.h         |  1 +
>  net/vhost-user.c                  |  7 ++++
>  6 files changed, 100 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 782b1d67d9..35eec7e166 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -20,6 +20,8 @@
>  #include <linux/vhost.h>
>  #include <sys/ioctl.h>
>  
> +static unsigned int vhost_kernel_used_memslots;
> +
>  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
>                               void *arg)
>  {
> @@ -238,6 +240,16 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
>          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
>  }
>  
> +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev)
> +{
> +    vhost_kernel_used_memslots = dev->mem->nregions;
> +}
> +
> +static unsigned int vhost_kernel_get_used_memslots(void)
> +{
> +    return vhost_kernel_used_memslots;
> +}
> +
>  static const VhostOps kernel_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_KERNEL,
>          .vhost_backend_init = vhost_kernel_init,
> @@ -269,6 +281,8 @@ static const VhostOps kernel_ops = {
>  #endif /* CONFIG_VHOST_VSOCK */
>          .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
>          .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
> +        .vhost_set_used_memslots = vhost_kernel_set_used_memslots,
> +        .vhost_get_used_memslots = vhost_kernel_get_used_memslots,
>  };
>  #endif
>  
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 31231218dc..04d20fc3ee 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -232,6 +232,7 @@ static VhostUserMsg m __attribute__ ((unused));
>  
>  /* The version of the protocol we support */
>  #define VHOST_USER_VERSION    (0x1)
> +static unsigned int vhost_user_used_memslots;
>  
>  struct vhost_user {
>      struct vhost_dev *dev;
> @@ -2354,6 +2355,31 @@ void vhost_user_cleanup(VhostUserState *user)
>      user->chr = NULL;
>  }
>  
> +static void vhost_user_set_used_memslots(struct vhost_dev *dev)
> +{
> +    unsigned int counter = 0;
> +    int i;
> +
> +    for (i = 0; i < dev->mem->nregions; ++i) {
> +        struct vhost_memory_region *reg = dev->mem->regions + i;
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> +        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> +                                    &offset);
> +        if (mr && memory_region_get_fd(mr) > 0) {
> +            counter++;
> +        }
> +    }
> +    vhost_user_used_memslots = counter;
> +}
> +
> +static unsigned int vhost_user_get_used_memslots(void)
> +{
> +    return vhost_user_used_memslots;
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init = vhost_user_backend_init,
> @@ -2387,4 +2413,6 @@ const VhostOps user_ops = {
>          .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
>          .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
>          .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
> +        .vhost_set_used_memslots = vhost_user_set_used_memslots,
> +        .vhost_get_used_memslots = vhost_user_get_used_memslots,
>  };
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e7a6..7f36d7af25 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -45,20 +45,22 @@
>  static struct vhost_log *vhost_log;
>  static struct vhost_log *vhost_log_shm;
>  
> -static unsigned int used_memslots;
>  static QLIST_HEAD(, vhost_dev) vhost_devices =
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>  
> +bool used_memslots_exceeded;
> +
>  bool vhost_has_free_slot(void)
>  {
> -    unsigned int slots_limit = ~0U;
>      struct vhost_dev *hdev;
>  
>      QLIST_FOREACH(hdev, &vhost_devices, entry) {
> -        unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> -        slots_limit = MIN(slots_limit, r);
> +        if (hdev->vhost_ops->vhost_get_used_memslots() >=
> +            hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> +            return false;
> +        }
>      }
> -    return slots_limit > used_memslots;
> +    return true;
>  }
>  
>  static void vhost_dev_sync_region(struct vhost_dev *dev,
> @@ -502,7 +504,6 @@ static void vhost_commit(MemoryListener *listener)
>                         dev->n_mem_sections * sizeof dev->mem->regions[0];
>      dev->mem = g_realloc(dev->mem, regions_size);
>      dev->mem->nregions = dev->n_mem_sections;
> -    used_memslots = dev->mem->nregions;
>      for (i = 0; i < dev->n_mem_sections; i++) {
>          struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
>          struct MemoryRegionSection *mrs = dev->mem_sections + i;
> @@ -678,6 +679,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
>          dev->tmp_sections[dev->n_tmp_sections - 1].fv = NULL;
>          memory_region_ref(section->mr);
>      }
> +    dev->vhost_ops->vhost_set_used_memslots(dev);
>  }
>  
>  /* Used for both add and nop callbacks */
> @@ -693,6 +695,17 @@ static void vhost_region_addnop(MemoryListener *listener,
>      vhost_region_add_section(dev, section);
>  }
>  
> +static void vhost_region_del(MemoryListener *listener,
> +                             MemoryRegionSection *section)
> +{
> +    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> +                                         memory_listener);
> +    if (!vhost_section(dev, section)) {
> +        return;
> +    }
> +    dev->vhost_ops->vhost_set_used_memslots(dev);
> +}
> +
>  static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>  {
>      struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
> @@ -1248,6 +1261,19 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
>      event_notifier_cleanup(&vq->masked_notifier);
>  }
>  
> +static bool vhost_dev_used_memslots_is_exceeded(struct vhost_dev *hdev)
> +{
> +    if (hdev->vhost_ops->vhost_get_used_memslots() >
> +        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> +        error_report("vhost backend memory slots limit is less"
> +                " than current number of present memory slots");
> +        used_memslots_exceeded = true;
> +        return true;
> +    }
> +    used_memslots_exceeded = false;
> +    return false;
> +}
> +
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                     VhostBackendType backend_type, uint32_t busyloop_timeout)
>  {
> @@ -1300,6 +1326,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      hdev->memory_listener = (MemoryListener) {
>          .begin = vhost_begin,
>          .commit = vhost_commit,
> +        .region_del = vhost_region_del,
>          .region_add = vhost_region_addnop,
>          .region_nop = vhost_region_addnop,
>          .log_start = vhost_log_start,
> @@ -1346,9 +1373,13 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memory);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>  
> -    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> -        error_report("vhost backend memory slots limit is less"
> -                " than current number of present memory slots");
> +    /*
> +     * If we started a VM without any vhost device,
> +     * vhost_dev_used_memslots_is_exceeded will always return false for the
> +     * first time vhost device hot-plug(vhost_get_used_memslots is always 0),
> +     * so it needs to double check here
> +     */
> +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
>          r = -1;
>          if (busyloop_timeout) {
>              goto fail_busyloop;
> @@ -1773,3 +1804,8 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
>  
>      return -1;
>  }
> +
> +bool used_memslots_is_exceeded(void)
> +{
> +    return used_memslots_exceeded;
> +}
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
> index 8825bd278f..ed43a93692 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -124,6 +124,9 @@ typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
>  
>  typedef bool (*vhost_force_iommu_op)(struct vhost_dev *dev);
>  
> +typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
> +typedef unsigned int (*vhost_get_used_memslots_op)(void);
> +
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
>      vhost_backend_init vhost_backend_init;
> @@ -168,6 +171,8 @@ typedef struct VhostOps {
>      vhost_vq_get_addr_op  vhost_vq_get_addr;
>      vhost_get_device_id_op vhost_get_device_id;
>      vhost_force_iommu_op vhost_force_iommu;
> +    vhost_set_used_memslots_op vhost_set_used_memslots;
> +    vhost_get_used_memslots_op vhost_get_used_memslots;
>  } VhostOps;
>  
>  extern const VhostOps user_ops;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 767a95ec0b..bf7cec445f 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -144,4 +144,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
>                             struct vhost_inflight *inflight);
>  int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
>                             struct vhost_inflight *inflight);
> +bool used_memslots_is_exceeded(void);
>  #endif
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 17532daaf3..2f0216b518 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -20,6 +20,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "trace.h"
> +#include "include/hw/virtio/vhost.h"
>  
>  typedef struct NetVhostUserState {
>      NetClientState nc;
> @@ -347,6 +348,12 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>                                   net_vhost_user_event, NULL, nc0->name, NULL,
>                                   true);
> +
> +        if (used_memslots_is_exceeded()) {
> +            error_report("used memslots exceeded the backend limit, quit "
> +                            "loop");
> +            goto err;
> +        }
>      } while (!s->started);
>  
>      assert(s->vhost_net);
> -- 
> 2.27.0.dirty


