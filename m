Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E267C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C800247E5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJSWaMKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C800247E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXo5a-0003bQ-8o
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXo4U-00035W-0y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXo4P-0005U8-3S
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603901584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pz8w8EzTVQRD33Rkm9s8A51L2sbdizJ/PWLZ/f2Arbg=;
 b=jJSWaMKoymmNPH7+/chgRLhW1WzYPnXRBSeB9ip7bQa9DQ9+ikzCs3Dpg/wVn6XJ5Gq0es
 1eLA+dSEjZFaOCurjAaGoSb2VheceWW6Y0bAutBglOD0bFH66ETyzmH9V1l63wSz3LDe6n
 Hf31KRsEj5Ml3P+BPSJnW/AOusieBXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-lmoLxr_UNCGFyO404MoXng-1; Wed, 28 Oct 2020 12:13:01 -0400
X-MC-Unique: lmoLxr_UNCGFyO404MoXng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 020ED879536;
 Wed, 28 Oct 2020 16:13:00 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACC7175121;
 Wed, 28 Oct 2020 16:12:54 +0000 (UTC)
Subject: Re: [RFC PATCH 25/25] block/nvme: Fix use of write-only doorbells
 page on Aarch64 arch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-26-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <03cf4e49-33f8-76a5-046d-db0f7b896bcb@redhat.com>
Date: Wed, 28 Oct 2020 17:12:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-26-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> qemu_vfio_pci_map_bar() calls mmap(), and mmap(2) states:
> 
>   'offset' must be a multiple of the page size as returned
>    by sysconf(_SC_PAGE_SIZE).
> 
> In commit f68453237b9 we started to use an offset of 4K which
> broke this contract on Aarch64 arch.
> 
> Fix by mapping at offset 0, and and accessing doorbells at offset=4K.
> 
> Fixes: f68453237b9 ("block/nvme: Map doorbells pages write-only")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  block/nvme.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index c1c52bae44f..ff645eefe6a 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -94,6 +94,7 @@ typedef struct {
>  struct BDRVNVMeState {
>      AioContext *aio_context;
>      QEMUVFIOState *vfio;
> +    void *bar0_wo_map;
>      /* Memory mapped registers */
>      volatile struct {
>          uint32_t sq_tail;
> @@ -778,8 +779,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>          }
>      }
>  
> -    s->doorbells = qemu_vfio_pci_map_bar(s->vfio, 0, sizeof(NvmeBar),
> -                                         NVME_DOORBELL_SIZE, PROT_WRITE, errp);
> +    s->bar0_wo_map = qemu_vfio_pci_map_bar(s->vfio, 0, 0,
> +                                           sizeof(NvmeBar) + NVME_DOORBELL_SIZE,
> +                                           PROT_WRITE, errp);
> +    s->doorbells = (void *)((uintptr_t)s->bar0_wo_map + sizeof(NvmeBar));
>      if (!s->doorbells) {
>          ret = -EINVAL;
>          goto out;
> @@ -913,8 +916,8 @@ static void nvme_close(BlockDriverState *bs)
>                             &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
>                             false, NULL, NULL);
>      event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
> -    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->doorbells,
> -                            sizeof(NvmeBar), NVME_DOORBELL_SIZE);
> +    qemu_vfio_pci_unmap_bar(s->vfio, 0, s->bar0_wo_map,
> +                            0, sizeof(NvmeBar) + NVME_DOORBELL_SIZE);
>      qemu_vfio_close(s->vfio);
>  
>      g_free(s->device);
> 


