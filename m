Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A9C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCF5207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrujzkTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCF5207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNG7U-000448-U0
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kNG61-0003Xb-G0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:55:09 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:34102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kNG5z-0003P1-FV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:55:09 -0400
Received: by mail-io1-xd42.google.com with SMTP id m17so4887816ioo.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3cRA83Rhsba1TWiKfaiOtkGeJwZiZdakcfDaVmX+98I=;
 b=GrujzkTM14q71E41dGv9RRqLV4HT9SW+zk9mrAWIJ7yKdeZ5ZcvhUhn47FQElVpC1k
 QFPlbVd0XyT2W2taOCcy7GsfpVS8r5Szqxu3w5W12A96AV3/3zm4abyIhp1N/Kh3+rxG
 p6Dw5qEmJVMgZvmvb89/InLiHdCTK+P3TC/vJmv4qvJV3jzL1YBhIsGsJ46+hM62IMd7
 duz4cMAmM1iqqgqeZKJ5IFwtepIZLslZCIEVO+eTWWZtrSDuQEq6y66bClC+QdWKVyld
 q0FBHL9aoVx1fqx/zqOLvTZ3CDdA4cajOXXMx2+jy6WW9MaiO3erPz6y89V5U/J/E9Ur
 mHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3cRA83Rhsba1TWiKfaiOtkGeJwZiZdakcfDaVmX+98I=;
 b=Tdw3+qGiKB4MqLoiCkEA6knRCJlfVZvsNFJ12S+30WSCB1JxUdg2rVl9toHtvCimC+
 eHibqNBE+T5vQZu3Il2pglgYe+SGNLy1HqtB5m+G60/YPSEvMPStsGiPyVtEHmjFPt9D
 BY0QX1ko2jea0uW6hE8s35yj5XKydLv/Mk2RuAkkGhMXp+PTLVYrWVoby+q1UDJy8izY
 8fnek4po29diHZtRKbqFU7Mh0AeVLKZnUR02ugWz7peyVMZ1IjHSOqpS38cwkZ8T4vNo
 /zzKtnX+uIOWpGFcwu5Dj+mZZ/5yWxBk/yvZa79dfFl3E0br0YkbwQaK6WTYRHHVgK5a
 0w+w==
X-Gm-Message-State: AOAM532i0LATLRcBAyiu/Wl31Iyw4QhYejDpLjV00wkmPrT/yxXFlXWo
 xg53ev+VhQxjtWet84V/rPZJQAD/FdYoi+a77kw=
X-Google-Smtp-Source: ABdhPJxh8V17DNd/+L5medXqhTpMvWOX0z6ZgtJgI1q50VJ9qk3XsTJTUlf9bdEtjSUkC0qGQ4h3MBSKFl18iuUQ6XU=
X-Received: by 2002:a05:6638:d02:: with SMTP id
 q2mr2967149jaj.98.1601387704843; 
 Tue, 29 Sep 2020 06:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200928114909.20791-1-david@redhat.com>
 <20200928114909.20791-2-david@redhat.com>
In-Reply-To: <20200928114909.20791-2-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 29 Sep 2020 15:54:53 +0200
Message-ID: <CAM9Jb+gdf+n+Poa_kZRRTchcB8D33FDuuTyn4tB4TjWyAah9Hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] virtio-mem: Probe THP size to determine default
 block size
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd42.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Let's allow a minimum block size of 1 MiB in all configurations. Select
> the default block size based on
> - The page size of the memory backend.
> - The THP size if the memory backend size corresponds to the real hsot

s/hsot/host
>   page size.
> - The global minimum of 1 MiB.
> and warn if something smaller is configured by the user.
>
> VIRTIO_MEM only supports Linux (depends on LINUX), so we can probe the
> THP size unconditionally.
>
> For now we only support virtio-mem on x86-64 - there isn't a user-visiable

s/visiable/visible
> change (x86-64 only supports 2 MiB THP on the PMD level) - the default
> was, and will be 2 MiB.
>
> If we ever have THP on the PUD level (e.g., 1 GiB THP on x86-64), we
> expect to have a trigger to explicitly opt-in for the new THP granularity.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 105 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 8fbec77ccc..9b1461cf9d 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -33,10 +33,83 @@
>  #include "trace.h"
>
>  /*
> - * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
> - * memory (e.g., 2MB on x86_64).
> + * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
> + * bitmap small.
>   */
> -#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)QEMU_VMALLOC_ALIGN)
> +#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)(1 * MiB))
> +
> +#if defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) || \
> +    defined(__powerpc64__)
> +#define VIRTIO_MEM_DEFAULT_THP_SIZE ((uint32_t)(2 * MiB))
> +#else
> +        /* fallback to 1 MiB (e.g., the THP size on s390x) */
> +#define VIRTIO_MEM_DEFAULT_THP_SIZE VIRTIO_MEM_MIN_BLOCK_SIZE
> +#endif
> +
> +/*
> + * We want to have a reasonable default block size such that
> + * 1. We avoid splitting THPs when unplugging memory, which degrades
> + *    performance.
> + * 2. We avoid placing THPs for plugged blocks that also cover unplugged
> + *    blocks.
> + *
> + * The actual THP size might differ between Linux kernels, so we try to probe
> + * it. In the future (if we ever run into issues regarding 2.), we might want
> + * to disable THP in case we fail to properly probe the THP size, or if the
> + * block size is configured smaller than the THP size.
> + */
> +static uint32_t thp_size;
> +
> +#define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> +static uint32_t virtio_mem_thp_size(void)
> +{
> +    gchar *content = NULL;
> +    const char *endptr;
> +    uint64_t tmp;
> +
> +    if (thp_size) {
> +        return thp_size;
> +    }
> +
> +    /*
> +     * Try to probe the actual THP size, fallback to (sane but eventually
> +     * incorrect) default sizes.
> +     */
> +    if (g_file_get_contents(HPAGE_PMD_SIZE_PATH, &content, NULL, NULL) &&
> +        !qemu_strtou64(content, &endptr, 0, &tmp) &&
> +        (!endptr || *endptr == '\n')) {
> +        /*
> +         * Sanity-check the value, if it's too big (e.g., aarch64 with 64k base
> +         * pages) or weird, fallback to something smaller.
> +         */
> +        if (!tmp || !is_power_of_2(tmp) || tmp > 16 * MiB) {
> +            warn_report("Read unsupported THP size: %" PRIx64, tmp);
> +        } else {
> +            thp_size = tmp;
> +        }
> +    }
> +
> +    if (!thp_size) {
> +        thp_size = VIRTIO_MEM_DEFAULT_THP_SIZE;
> +        warn_report("Could not detect THP size, falling back to %" PRIx64
> +                    "  MiB.", thp_size / MiB);
> +    }
> +
> +    g_free(content);
> +    return thp_size;
> +}
> +
> +static uint64_t virtio_mem_default_block_size(RAMBlock *rb)
> +{
> +    const uint64_t page_size = qemu_ram_pagesize(rb);
> +
> +    /* We can have hugetlbfs with a page size smaller than the THP size. */
> +    if (page_size == qemu_real_host_page_size) {
> +        return MAX(page_size, virtio_mem_thp_size());
> +    }

This condition is special, can think of hugetlbfs smaller in size than THP size
configured.
> +    return MAX(page_size, VIRTIO_MEM_MIN_BLOCK_SIZE);

Do we still need this? Or we can have only one return for both the cases?
Probably, I am missing something here.
> +}
> +
>  /*
>   * Size the usable region bigger than the requested size if possible. Esp.
>   * Linux guests will only add (aligned) memory blocks in case they fully
> @@ -437,10 +510,23 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>      rb = vmem->memdev->mr.ram_block;
>      page_size = qemu_ram_pagesize(rb);
>
> +    /*
> +     * If the block size wasn't configured by the user, use a sane default. This
> +     * allows using hugetlbfs backends of any page size without manual
> +     * intervention.
> +     */
> +    if (!vmem->block_size) {
> +        vmem->block_size = virtio_mem_default_block_size(rb);
> +    }
> +
>      if (vmem->block_size < page_size) {
>          error_setg(errp, "'%s' property has to be at least the page size (0x%"
>                     PRIx64 ")", VIRTIO_MEM_BLOCK_SIZE_PROP, page_size);
>          return;
> +    } else if (vmem->block_size < virtio_mem_default_block_size(rb)) {
> +        warn_report("'%s' property is smaller than the default block size (%"
> +                    PRIx64 " MiB)", VIRTIO_MEM_BLOCK_SIZE_PROP,
> +                    virtio_mem_default_block_size(rb) / MiB);
>      } else if (!QEMU_IS_ALIGNED(vmem->requested_size, vmem->block_size)) {
>          error_setg(errp, "'%s' property has to be multiples of '%s' (0x%" PRIx64
>                     ")", VIRTIO_MEM_REQUESTED_SIZE_PROP,
> @@ -731,6 +817,18 @@ static void virtio_mem_get_block_size(Object *obj, Visitor *v, const char *name,
>      const VirtIOMEM *vmem = VIRTIO_MEM(obj);
>      uint64_t value = vmem->block_size;
>
> +    /*
> +     * If not configured by the user (and we're not realized yet), use the
> +     * default block size we would use with the current memory backend.
> +     */
> +    if (!value) {
> +        if (vmem->memdev && memory_region_is_ram(&vmem->memdev->mr)) {
> +            value = virtio_mem_default_block_size(vmem->memdev->mr.ram_block);
> +        } else {
> +            value = virtio_mem_thp_size();
> +        }
> +    }
> +
>      visit_type_size(v, name, &value, errp);
>  }
>
> @@ -810,7 +908,6 @@ static void virtio_mem_instance_init(Object *obj)
>  {
>      VirtIOMEM *vmem = VIRTIO_MEM(obj);
>
> -    vmem->block_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
>      notifier_list_init(&vmem->size_change_notifiers);
>      vmem->precopy_notifier.notify = virtio_mem_precopy_notify;

