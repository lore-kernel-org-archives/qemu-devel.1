Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C633C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20C32074B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="MGKWMvXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20C32074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLp0g-00073G-WC
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kLoxD-0004fW-5g; Fri, 25 Sep 2020 10:44:07 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kLox8-0007ln-9m; Fri, 25 Sep 2020 10:44:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601045000; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=qN28VKhlrgkf3TeaJNk1vklm82IFskZcnxAqzbBkX15Pfqi/tj4UDkoEZv/W/qmeuxRdHsqnolb/u7E8/8Ukws5z+5b5fCcmYJ2gzJuOxHDMek2sVbKiYl+E3HMsga+/hzEr2N3akE7IFeus9Z2KtWF2UohOftfY5IdLqcrpcgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1601045000;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=sjXskkK9xFDvpdDbRGKHrfLJXfZrRFUl5CRx/1qEXVQ=; 
 b=o6BjmqMppT8otAHnrF0biLPTnBn217ySHlJyN98fGrBzbFi0TS7GYI4pfjbUwYikeamWjyOupqwZl3YcsvmQ6z80LSToCyrZNOSRVipUITGWVLstYA22slgQw1A1b7ZPsgtLNNt1Ch9+BzFX+yTvTGiFraftk7qwTxg7zK8ePUU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1601045000; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=sjXskkK9xFDvpdDbRGKHrfLJXfZrRFUl5CRx/1qEXVQ=;
 b=MGKWMvXT1FOEVCC3m+Zb8rrLBDPANtJFnV1V50wwGkpYO1pQNjHDIXBqvF7U9/As
 Nx+MlrijhD+L3mireiei8sv/rPF/hgE8M8sAJy+X5GXZTrULltFaGQ3EaQKNDs/Hdli
 jTTiIQMAQZaTsib3LDuVbLdNKyjFdzZgg6uWCFAE=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1601044996788584.885787622021;
 Fri, 25 Sep 2020 22:43:16 +0800 (CST)
Date: Fri, 25 Sep 2020 15:43:07 +0100
From: Fam Zheng <fam@euphon.net>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 1/3] util/vfio-helpers: Collect IOVA reserved regions
Message-ID: <20200925144307.GA3809989@dev>
References: <20200925134845.21053-1-eric.auger@redhat.com>
 <20200925134845.21053-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925134845.21053-2-eric.auger@redhat.com>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 10:43:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: lvivier@redhat.com, kwolf@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, stefanha@redhat.com, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-25 15:48, Eric Auger wrote:
> The IOVA allocator currently ignores host reserved regions.
> As a result some chosen IOVAs may collide with some of them,
> resulting in VFIO MAP_DMA errors later on. This happens on ARM
> where the MSI reserved window quickly is encountered:
> [0x8000000, 0x8100000]. since 5.4 kernel, VFIO returns the usable
> IOVA regions. So let's enumerate them in the prospect to avoid
> them, later on.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  util/vfio-helpers.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 583bdfb36f..8e91beba95 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -40,6 +40,11 @@ typedef struct {
>      uint64_t iova;
>  } IOVAMapping;
>  
> +struct IOVARange {
> +    uint64_t start;
> +    uint64_t end;
> +};
> +
>  struct QEMUVFIOState {
>      QemuMutex lock;
>  
> @@ -49,6 +54,8 @@ struct QEMUVFIOState {
>      int device;
>      RAMBlockNotifier ram_notifier;
>      struct vfio_region_info config_region_info, bar_region_info[6];
> +    struct IOVARange *usable_iova_ranges;
> +    uint8_t nb_iova_ranges;
>  
>      /* These fields are protected by @lock */
>      /* VFIO's IO virtual address space is managed by splitting into a few
> @@ -236,6 +243,36 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int
>      return ret == size ? 0 : -errno;
>  }
>  
> +static void collect_usable_iova_ranges(QEMUVFIOState *s, void *first_cap)
> +{
> +    struct vfio_iommu_type1_info_cap_iova_range *cap_iova_range;
> +    struct vfio_info_cap_header *cap = first_cap;
> +    void *offset = first_cap;
> +    int i;
> +
> +    while (cap->id != VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE) {
> +        if (cap->next) {

This check looks reversed.

> +            return;
> +        }
> +        offset += cap->next;

@offset is unused.

> +        cap = (struct vfio_info_cap_header *)cap;

This assignment is nop.

> +    }
> +
> +    cap_iova_range = (struct vfio_iommu_type1_info_cap_iova_range *)cap;
> +
> +    s->nb_iova_ranges = cap_iova_range->nr_iovas;
> +    if (s->nb_iova_ranges > 1) {
> +        s->usable_iova_ranges =
> +            g_realloc(s->usable_iova_ranges,
> +                      s->nb_iova_ranges * sizeof(struct IOVARange));
> +    }
> +
> +    for (i = 0; i <  s->nb_iova_ranges; i++) {

s/  / /

> +        s->usable_iova_ranges[i].start = cap_iova_range->iova_ranges[i].start;
> +        s->usable_iova_ranges[i].end = cap_iova_range->iova_ranges[i].end;
> +    }
> +}
> +
>  static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>                                Error **errp)
>  {
> @@ -243,10 +280,13 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>      int i;
>      uint16_t pci_cmd;
>      struct vfio_group_status group_status = { .argsz = sizeof(group_status) };
> -    struct vfio_iommu_type1_info iommu_info = { .argsz = sizeof(iommu_info) };
> +    struct vfio_iommu_type1_info *iommu_info = NULL;
> +    size_t iommu_info_size = sizeof(*iommu_info);
>      struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
>      char *group_file = NULL;
>  
> +    s->usable_iova_ranges = NULL;
> +
>      /* Create a new container */
>      s->container = open("/dev/vfio/vfio", O_RDWR);
>  
> @@ -310,13 +350,38 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>          goto fail;
>      }
>  
> +    iommu_info = g_malloc0(iommu_info_size);
> +    iommu_info->argsz = iommu_info_size;
> +
>      /* Get additional IOMMU info */
> -    if (ioctl(s->container, VFIO_IOMMU_GET_INFO, &iommu_info)) {
> +    if (ioctl(s->container, VFIO_IOMMU_GET_INFO, iommu_info)) {
>          error_setg_errno(errp, errno, "Failed to get IOMMU info");
>          ret = -errno;
>          goto fail;
>      }
>  
> +    /*
> +     * if the kernel does not report usable IOVA regions, choose
> +     * the legacy [QEMU_VFIO_IOVA_MIN, QEMU_VFIO_IOVA_MAX -1] region
> +     */
> +    s->nb_iova_ranges = 1;
> +    s->usable_iova_ranges = g_new0(struct IOVARange, 1);
> +    s->usable_iova_ranges[0].start = QEMU_VFIO_IOVA_MIN;
> +    s->usable_iova_ranges[0].end = QEMU_VFIO_IOVA_MAX - 1;
> +
> +    if (iommu_info->argsz > iommu_info_size) {
> +        void *first_cap;
> +
> +        iommu_info_size = iommu_info->argsz;
> +        iommu_info = g_realloc(iommu_info, iommu_info_size);
> +        if (ioctl(s->container, VFIO_IOMMU_GET_INFO, iommu_info)) {
> +            ret = -errno;
> +            goto fail;
> +        }
> +        first_cap = (void *)iommu_info + iommu_info->cap_offset;
> +        collect_usable_iova_ranges(s, first_cap);
> +    }
> +
>      s->device = ioctl(s->group, VFIO_GROUP_GET_DEVICE_FD, device);
>  
>      if (s->device < 0) {
> @@ -365,8 +430,12 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>      if (ret) {
>          goto fail;
>      }
> +    g_free(iommu_info);
>      return 0;
>  fail:
> +    g_free(s->usable_iova_ranges);

Set s->usable_iova_ranges to NULL to avoid double free?

> +    s->nb_iova_ranges = 0;
> +    g_free(iommu_info);
>      close(s->group);
>  fail_container:
>      close(s->container);
> @@ -716,6 +785,8 @@ void qemu_vfio_close(QEMUVFIOState *s)
>          qemu_vfio_undo_mapping(s, &s->mappings[i], NULL);
>      }
>      ram_block_notifier_remove(&s->ram_notifier);
> +    g_free(s->usable_iova_ranges);
> +    s->nb_iova_ranges = 0;
>      qemu_vfio_reset(s);
>      close(s->device);
>      close(s->group);
> -- 
> 2.21.3
> 
> 

Fam

