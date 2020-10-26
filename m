Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF919C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FDC207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rcu1lZP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FDC207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9ED-0003HR-La
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX9B4-0000az-4A
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX9B2-0001Qu-CE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603744390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdIPT0F2dM5OhV9BPUNGNlIy2p3hgZx2huSh/dK9uhQ=;
 b=Rcu1lZP70FqCYUC03lir7iSh32qKed7cqQums/y7B6E71iwMKbgtDU/DjgJ9lJvJ+SjYJT
 yu5dpzscvaqGb5RQP6uQ8QqsxuN/8rEwVQRVYNSpAUKMqt2ZXXHc34Bx+GR1Ojj2S5ptlB
 JKUm0oGySrtw+XbFjQQzoC0snc8qjPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-vwTWjN5ROEuvvRowLZ42Bg-1; Mon, 26 Oct 2020 16:33:08 -0400
X-MC-Unique: vwTWjN5ROEuvvRowLZ42Bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9076A108E1A1;
 Mon, 26 Oct 2020 20:33:07 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E851E5B4A4;
 Mon, 26 Oct 2020 20:32:58 +0000 (UTC)
Subject: Re: [PATCH v2 18/19] block/nvme: Switch to using the MSIX API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-19-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f07fe7f6-06f7-781f-4c09-f8a5d4066cd1@redhat.com>
Date: Mon, 26 Oct 2020 21:32:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-19-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> In preparation of using multiple IRQs, switch to using the recently
> introduced MSIX API. Instead of allocating and assigning IRQ in
> a single step, we now have to use two distinct calls.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 46b09b3a3a7..191678540b6 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -693,6 +693,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      size_t device_page_size_min;
>      size_t device_page_size_max;
>      size_t iommu_page_size_min = 4096;
> +    unsigned irq_count = MSIX_IRQ_COUNT;
>  
>      qemu_co_mutex_init(&s->dma_map_lock);
>      qemu_co_queue_init(&s->dma_flush_queue);
> @@ -809,8 +810,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>          }
>      }
>  
> -    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
> -                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
> +    ret = qemu_vfio_pci_msix_init_irqs(s->vfio, &irq_count, errp);
> +    if (ret) {
> +        if (ret == -EOVERFLOW) {
> +            error_append_hint(errp, "%u IRQs requested but only %u available\n",
> +                              MSIX_IRQ_COUNT, irq_count);
This message can be directly printed in qemu_vfio_pci_msix_init_irqs()
> +        }
> +        goto out;
> +    }
> +
> +    ret = qemu_vfio_pci_msix_set_irq(s->vfio, MSIX_SHARED_IRQ_IDX,
> +                                     s->irq_notifier, errp);
>      if (ret) {
>          goto out;
>      }
> 
Thanks

Eric


