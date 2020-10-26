Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8023CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C084220809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TelVJ0BJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C084220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9H5-0006sc-AU
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX934-0002gm-G3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX92z-0000Ho-L0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603743890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGWbuNMZa8awyvdf0sLZjJkD+O7g+X247aYn80ESIx0=;
 b=TelVJ0BJ3ctIobULUWCp9/gKz/0Z1TB9uFA4dJ4rLRDHufftUvu5RZwU+YCcbwAGkoYJn9
 u/5i7/EC170I4KicEiF+zraw7AM0XiUnKGUYaWPk/EHXLHhgmM3c89tyUhlSjBUoEn5rRe
 ze+zQ274syt8qUYbiUdX0B3T5cTuE/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-6HaPKfDvN_2waNhDSG5zTA-1; Mon, 26 Oct 2020 16:24:48 -0400
X-MC-Unique: 6HaPKfDvN_2waNhDSG5zTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7472C56C8B;
 Mon, 26 Oct 2020 20:24:47 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B05846EF50;
 Mon, 26 Oct 2020 20:24:39 +0000 (UTC)
Subject: Re: [PATCH v2 16/19] util/vfio-helpers: Introduce
 qemu_vfio_pci_msix_init_irqs()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-17-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2ac9b0ba-ce14-5d52-c93c-6934d52852ce@redhat.com>
Date: Mon, 26 Oct 2020 21:24:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-17-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/26/20 11:55 AM, Philippe Mathieu-Daudé wrote:
> qemu_vfio_pci_init_irq() allows us to initialize any type of IRQ,
> but only one. Introduce qemu_vfio_pci_msix_init_irqs() which is
> specific to MSIX IRQ type, and allow us to use multiple IRQs
> (thus passing multiple eventfd notifiers).
> All eventfd notifiers are initialized with the special '-1' value
> meaning "un-assigned".
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  6 +++-
>  util/vfio-helpers.c         | 65 ++++++++++++++++++++++++++++++++++++-
>  util/trace-events           |  1 +
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 4b97a904e93..492072cba2f 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -1,11 +1,13 @@
>  /*
>   * QEMU VFIO helpers
>   *
> - * Copyright 2016 - 2018 Red Hat, Inc.
> + * Copyright 2016 - 2020 Red Hat, Inc.
>   *
>   * Authors:
>   *   Fam Zheng <famz@redhat.com>
> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
>   *
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
>   */
> @@ -29,5 +31,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>                               uint64_t offset, uint64_t size);
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>                             int irq_type, Error **errp);
> +int qemu_vfio_pci_msix_init_irqs(QEMUVFIOState *s,
> +                                 unsigned *irq_count, Error **errp);
>  
>  #endif
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 874d76c2a2a..d88e2c7dc1f 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -1,11 +1,13 @@
>  /*
>   * VFIO utility
>   *
> - * Copyright 2016 - 2018 Red Hat, Inc.
> + * Copyright 2016 - 2020 Red Hat, Inc.
>   *
>   * Authors:
>   *   Fam Zheng <famz@redhat.com>
> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
>   *
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
>   */
> @@ -230,6 +232,67 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>      return 0;
>  }
>  
> +/**
> + * Initialize device MSIX IRQs and register event notifiers.
> + * @irq_count: pointer to number of MSIX IRQs to initialize
> + *
> + * If the number of IRQs requested exceeds the available on the device,
> + * store the number of available IRQs in @irq_count and return -EOVERFLOW.
> + */
> +int qemu_vfio_pci_msix_init_irqs(QEMUVFIOState *s,
> +                                 unsigned *irq_count, Error **errp)
> +{
> +    int r;
> +    size_t irq_set_size;
> +    struct vfio_irq_set *irq_set;
> +    struct vfio_irq_info irq_info = {
> +        .argsz = sizeof(irq_info),
> +        .index = VFIO_PCI_MSIX_IRQ_INDEX
> +    };
> +
> +    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
> +        error_setg_errno(errp, errno, "Failed to get device interrupt info");
> +        return -errno;
> +    }
> +    trace_qemu_vfio_msix_info_irqs(irq_info.count, *irq_count);
> +    if (irq_info.count < *irq_count) {
> +        error_setg(errp, "Not enough device interrupts available");
> +        *irq_count = irq_info.count;
> +        return -EOVERFLOW;
> +    }
> +    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
> +        error_setg(errp, "Device interrupt doesn't support eventfd");
> +        return -EINVAL;
> +    }
> +
> +    irq_set_size = sizeof(*irq_set) + *irq_count * sizeof(int32_t);
> +    irq_set = g_malloc0(irq_set_size);
> +
> +    /* Get to a known IRQ state */
> +    *irq_set = (struct vfio_irq_set) {
> +        .argsz = irq_set_size,
> +        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
> +        .index = VFIO_PCI_MSIX_IRQ_INDEX,
> +        .start = 0,
> +        .count = *irq_count,
> +    };
> +
> +    for (unsigned i = 0; i < *irq_count; i++) {
> +        ((int32_t *)&irq_set->data)[i] = -1; /* un-assigned: skip */
> +    }
> +    r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
> +    g_free(irq_set);
> +    if (r < 0) {
> +        error_setg_errno(errp, errno, "Failed to setup device interrupts");
> +        return -errno;
> +    } else if (r > 0) {
Can it happen?

Thanks

Eric
> +        error_setg(errp, "Not enough device interrupts available");
> +        *irq_count = r;
> +        return -EOVERFLOW;
> +    }
> +    return 0;
> +}
> +
>  static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
>                                       int size, int ofs)
>  {
> diff --git a/util/trace-events b/util/trace-events
> index 3c36def9f30..ec93578b125 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -87,6 +87,7 @@ qemu_vfio_do_mapping(void *s, void *host, uint64_t iova, size_t size) "s %p host
>  qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d &iova %p"
>  qemu_vfio_dma_mapped(void *s, void *host, uint64_t iova, size_t size) "s %p host %p <-> iova 0x%"PRIx64" size 0x%zx"
>  qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
> +qemu_vfio_msix_info_irqs(uint32_t count, unsigned asked) "msix irqs %"PRIu32" (asked: %u)"
>  qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x%08"PRIx64
>  qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
>  qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
> 


