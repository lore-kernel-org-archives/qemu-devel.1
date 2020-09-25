Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D773BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DAB62086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2tky5zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAB62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoA6-0007Gm-KD
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLo3O-00081e-Uy
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:46:27 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLo3K-0000Qq-Pj
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:46:26 -0400
Received: by mail-io1-xd43.google.com with SMTP id y13so2762982iow.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qsJFz9ZZQHN3NtmfxBoCNhND12L6eT8AG7JY+9MDvSY=;
 b=f2tky5zkMeRO7gO/eYJ54yvvNG+W+3YXtoUVuXiwZTrKn7zBduW0aEDIjhX0Vuhoji
 oj7n9VTuftwGB493G6iz1ARTvNEqZUJTYzY3pT0DJTM3dpysrFqSJvkOM2ffxef6FuBe
 qdmVK4vVpzX3D7ZsF82u2G5gqTiqldxpaNC0ehbjmM4dIhKnqEiCBRF7kb4pl17hpmE1
 LppKYD7N9T3x82ueuhepKUEbnRWvAdy1oMi82IQli4q121V7RBHgnPPerCMitTGcZwyx
 tUVY0KDJgPZZe57YWyIaKUwTU0e9h7NRnWx5/R1X0PPYGrXQoIvImnPbpNb8OdS0kZAE
 orbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qsJFz9ZZQHN3NtmfxBoCNhND12L6eT8AG7JY+9MDvSY=;
 b=ew56laSNYu1SciOsO4B0NuL0nDk88NXYb+lBxmNS7ZUUKiIfpQnfMuwVEv1nfyYHwY
 aVrsMBIc+W4PNG8Z8MOXCswlv4cgqjzTcJTje4RmWjN7HGR3H/cXqurZPY/2EBJprG4k
 TljmVs5IexOtBiWAzvMyJALfF/L8Shs/2uY5sBT/gXueKBOVuAkrK/DmfdTeKTggMGrq
 rA1Ki9wNe9zZLtxk+hFhAY3TdcTDoIN1DcDrWgW0E2SzaKjvlfJaaAq7FI31xnFtegRN
 N0ZHGIV4UgQ8ov5E3MENvpxnn08iDGq1NzFqGTteNvBU6qwzJYkSpN2p0Wf4haI2PvrO
 CXvg==
X-Gm-Message-State: AOAM531Xr4lDgkFYKLaXpfFCyM0UBV/S2A5WBhqTUcskEl4a6gSv/Gbu
 LNHByQtNlW4wGfrCqs/K0ID24A/UGnuMMskOMbI=
X-Google-Smtp-Source: ABdhPJw+8CXvNGB9Hyv2pTHwUCtN0E23aUCmL+Kxzf2rGBAPbOd9ICGL5o6OGdxLo2U18GQkUDf84f4usFjNkPMlFd8=
X-Received: by 2002:a6b:7909:: with SMTP id i9mr270536iop.98.1601041581479;
 Fri, 25 Sep 2020 06:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200923113900.72718-1-david@redhat.com>
 <20200923113900.72718-2-david@redhat.com>
In-Reply-To: <20200923113900.72718-2-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 25 Sep 2020 15:46:10 +0200
Message-ID: <CAM9Jb+gJkzW3_d-JxG+o6eYttSXHPGxCGDhzLgpyb_okOG+xXA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] virtio-mem: Probe THP size to determine default
 block size
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd43.google.com
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

> Let's allow a minimum block size of 1 MiB in all configurations. Use
> a default block size based on the THP size, and warn if something
> smaller is configured by the user.
>
> VIRTIO_MEM only supports Linux (depends on LINUX), so we can probe the
> THP size unconditionally.
>
> For now we only support virtio-mem on x86-64 - there isn't a user-visiable
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
>  hw/virtio/virtio-mem.c | 82 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 8fbec77ccc..58098686ee 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -33,10 +33,70 @@
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
> +static uint32_t default_block_size;
> +
> +#define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> +static uint32_t virtio_mem_default_block_size(void)
> +{
> +    gchar *content = NULL;
> +    const char *endptr;
> +    uint64_t tmp;
> +
> +    if (default_block_size) {
> +        return default_block_size;
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
> +            warn_report("Detected a THP size of %" PRIx64
> +                        " MiB, falling back to 1 MiB.", tmp / MiB);
> +            default_block_size = 1 * MiB;

Probably use macro "VIRTIO_MEM_MIN_BLOCK_SIZE"
> +        } else {
> +            default_block_size = tmp;
> +        }
> +    } else {
> +#if defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) || \
> +    defined(__powerpc64__)
> +        default_block_size = 2 * MiB;
> +#else
> +        /* fallback to 1 MiB (e.g., the THP size on s390x) */
> +        default_block_size = 1 * MiB;
> +#endif

Maybe we can declare this macro near to "VIRTIO_MEM_MIN_BLOCK_SIZE
((uint32_t)(1 * MiB))"
or club into one, just a thought.

> +        warn_report("Could not detect THP size, falling back to %" PRIx64
> +                    "  MiB.", default_block_size / MiB);
> +    }
> +
> +    g_free(content);
> +    return default_block_size;
> +}
> +
>  /*
>   * Size the usable region bigger than the requested size if possible. Esp.
>   * Linux guests will only add (aligned) memory blocks in case they fully
> @@ -437,6 +497,15 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>      rb = vmem->memdev->mr.ram_block;
>      page_size = qemu_ram_pagesize(rb);
>
> +    /*
> +     * If the block size wasn't configured by the user, use a sane default. This
> +     * allows using hugetlbfs backends with a pagesize bigger than the detected
> +     * THP size without manual intervention/configuration.
> +     */
> +    if (!vmem->block_size) {
> +        vmem->block_size = MAX(page_size, virtio_mem_default_block_size());
> +    }
> +
>      if (vmem->block_size < page_size) {
>          error_setg(errp, "'%s' property has to be at least the page size (0x%"
>                     PRIx64 ")", VIRTIO_MEM_BLOCK_SIZE_PROP, page_size);
> @@ -760,6 +829,12 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "'%s' property has to be a power of two", name);
>          return;
>      }
> +
> +    if (value < virtio_mem_default_block_size()) {
> +        warn_report("'%s' property is smaller than the default block size "
> +                    "(detected THP size) of %" PRIx64 " MiB", name,
> +                    virtio_mem_default_block_size() / MiB);
> +    }
>      vmem->block_size = value;
>  }
>
> @@ -810,7 +885,6 @@ static void virtio_mem_instance_init(Object *obj)
>  {
>      VirtIOMEM *vmem = VIRTIO_MEM(obj);
>
> -    vmem->block_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
>      notifier_list_init(&vmem->size_change_notifiers);
>      vmem->precopy_notifier.notify = virtio_mem_precopy_notify;
>
> --
> 2.26.2
>

