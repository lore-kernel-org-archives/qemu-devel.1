Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF20BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588D020738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtxfe3Yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588D020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHzlZ-0006Ed-HV
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 21:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kHzl4-0005nd-KR
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:27:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kHzl2-00061n-LT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:27:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id e23so1692307otk.7
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 18:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X/r8kngxKPaU0pRDtkVONIrv/cBHOqW1FZEkGfqAwmg=;
 b=Mtxfe3YpPK1FXnzffWvUbXQCp7fMrmfAW5f2KQjSMfynSye9BaBgLmDF/14VlyP4i4
 lT7QbFeQUY8bBSXayI7d7PK1HWPYEB6xK/aB3tRj3RxpwUwMr7HLBSRU2EgtCs0oTOaC
 K2yeqWlTD3mlReIK5gnjYUmJAFKxE2UnQ2aaQMuK0EoCJR7c42QdZGO7wFJR8ubmkxj2
 Q1THV0dQv0k0ZgkXEKGj3Of+KaALE65B5CcvTeBG/UhkEah1rzuzLRUjUENr2+50gpoy
 jj8fk3CF7LHwJnqkhvv2Vg0f0SEE+pKqh7SGaqqB7VlKFIocJh01Ava7/rEs5L7M0L26
 QG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X/r8kngxKPaU0pRDtkVONIrv/cBHOqW1FZEkGfqAwmg=;
 b=SVHUv+moflX8aun8nPpXCMWKBZpequKU1W1UmP31AC2BPgD5e0EV9I9TYwqbvLGl2B
 FKRp4L4l2NB7AkbkWMws03qSxwoJYsMGQgyZtIU8nihawbbXTxwFh7TfSVLNJlOkL5Bb
 qazZ89UpKyPWO6DoU6lTmG+xS0BjmeUyYhbtA42hob+dHRIBduHtTeBinNDfXpiHoeP7
 3iykyJUlyaQJtHpMGXUVq3TPlU3YLAXYAQp6fttKtWNudIeiDxG8+OYahtFJ1TY2eJtu
 R9euHNY9iCU+82pljaeCgZEAqvX6aCcS0gWAJr+Z+kQMNDKmnNqa9BscMzNnGJEUIIMV
 YzgQ==
X-Gm-Message-State: AOAM532lVVM8Nm5iO7B+eb4eCoJ3wqJbE/NRuR32AW9n62wUQMpewdH2
 ZLFrJ2/hEtf4EeRRx6qHPMIfeRUShDlDxz1G73I=
X-Google-Smtp-Source: ABdhPJyskUr1IeJo+KFsknz9sPpM4pY1Yp5/b++58De5XWZpVrIM4l+PJ5BipYNrLTpcz5nXrwwP5zcrby/TnBEhiAs=
X-Received: by 2002:a9d:2384:: with SMTP id t4mr10182366otb.337.1600133263004; 
 Mon, 14 Sep 2020 18:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200908061141.90900-1-chenjiajun8@huawei.com>
In-Reply-To: <20200908061141.90900-1-chenjiajun8@huawei.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 14 Sep 2020 21:27:32 -0400
Message-ID: <CAFubqFvAUpzErC=F3WFt0Dj9+h=hNLfA0K8s-6gJSP1KXYe2rQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
To: Jiajun Chen <chenjiajun8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, QEMU <qemu-devel@nongnu.org>, xiexiangyou@huawei.com,
 imammedo@redhat.com,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A few more comments mixed in below.

Once these are addressed I'd support this change from the vhost-user
side. We should get opinions from other maintainers though,
particularly for the kernel backend and vhost-user-net changes.

On Tue, Sep 8, 2020 at 2:11 AM Jiajun Chen <chenjiajun8@huawei.com> wrote:
>
> Used_memslots is equal to dev->mem->nregions now, it is true for
> vhost kernel, but not for vhost user, which uses the memory regions
> that have file descriptor. In fact, not all of the memory regions
> have file descriptor.
> It is usefully in some scenarios, e.g. used_memslots is 8, and only
> 5 memory slots can be used by vhost user, it is failed to hot plug
> a new memory RAM because vhost_has_free_slot just returned false,
> but we can hot plug it safely in fact.
>
> --
> ChangeList:
> v2:
> -eliminating useless used_memslots_exceeded variable and used_memslots_is_exceeded() API
>
> v1:
> -vhost-user: add separate memslot counter for vhost-user
>
> Signed-off-by: Jiajun Chen <chenjiajun8@huawei.com>
> Signed-off-by: Jianjay Zhou <jianjay.zhou@huawei.com>
> ---
>  hw/virtio/vhost-backend.c         | 14 ++++++++++++
>  hw/virtio/vhost-user.c            | 28 +++++++++++++++++++++++
>  hw/virtio/vhost.c                 | 37 +++++++++++++++++++++++--------
>  include/hw/virtio/vhost-backend.h |  5 +++++
>  net/vhost-user.c                  |  7 ++++++
>  5 files changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 31231218dc..ec46a745fa 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -232,6 +232,7 @@ static VhostUserMsg m __attribute__ ((unused));
>
>  /* The version of the protocol we support */
>  #define VHOST_USER_VERSION    (0x1)
> +static unsigned int vhost_user_used_memslots;

I worry that using a global static value may introduce a lot of edge
cases which may be difficult to account for. Can we store this state
per vhost_user dev, either in the VhostUserState or struct vhost_user?

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
> +        int fd;
> +
> +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);

This assert is redundant - vhost_user_get_mr_data already checks this.

> +        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
> +        if (mr && fd > 0) {
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
> index 1a1384e7a6..b8d617d24c 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -45,20 +45,20 @@
>  static struct vhost_log *vhost_log;
>  static struct vhost_log *vhost_log_shm;
>
> -static unsigned int used_memslots;
>  static QLIST_HEAD(, vhost_dev) vhost_devices =
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>
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
> @@ -502,7 +502,6 @@ static void vhost_commit(MemoryListener *listener)
>                         dev->n_mem_sections * sizeof dev->mem->regions[0];
>      dev->mem = g_realloc(dev->mem, regions_size);
>      dev->mem->nregions = dev->n_mem_sections;
> -    used_memslots = dev->mem->nregions;
>      for (i = 0; i < dev->n_mem_sections; i++) {
>          struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
>          struct MemoryRegionSection *mrs = dev->mem_sections + i;
> @@ -678,6 +677,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
>          dev->tmp_sections[dev->n_tmp_sections - 1].fv = NULL;
>          memory_region_ref(section->mr);
>      }
> +    dev->vhost_ops->vhost_set_used_memslots(dev);
>  }
>
>  /* Used for both add and nop callbacks */
> @@ -693,6 +693,17 @@ static void vhost_region_addnop(MemoryListener *listener,
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
> @@ -1300,6 +1311,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      hdev->memory_listener = (MemoryListener) {
>          .begin = vhost_begin,
>          .commit = vhost_commit,
> +        .region_del = vhost_region_del,
>          .region_add = vhost_region_addnop,
>          .region_nop = vhost_region_addnop,
>          .log_start = vhost_log_start,
> @@ -1346,9 +1358,16 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memory);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>
> -    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> -        error_report("vhost backend memory slots limit is less"
> -                " than current number of present memory slots");
> +    /*
> +     * If we started a VM without any vhost device,
> +     * for the first time vhost device hot-plug
> +     * (vhost_get_used_memslots is always 0),
> +     * so it needs to double check here

NIT - There should be a period at the end of the sentence in this comment.


> +     */
> +    if (hdev->vhost_ops->vhost_get_used_memslots() >
> +        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> +        error_report("vhost backend memory slots limit is less than"
> +                     " current number of present memory slots");
>          r = -1;
>          if (busyloop_timeout) {
>              goto fail_busyloop;

