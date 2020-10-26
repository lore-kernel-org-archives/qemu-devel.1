Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48873C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3642087C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hChcoL4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3642087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX71C-0001LE-O4
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6SQ-0000V6-GY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6SN-0002eY-L0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603733934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AegaS1VTIJfnYl3OMfTO7USEYjr/XchHK32qhL+7rfU=;
 b=hChcoL4bmUTBfc5zIy2n54K+ZBqkAXaA5p1KEGnEzRHMsPQWdxzB8FO/p+iS2jG3dbNUuZ
 m0mXdeZ02Uj+9PYiw6jjLZkfqMm0xisMl+htMhBkgWAvayNxKRshXkgDu/jq64Pxe8mlCe
 vIu8bEka8XxuoEi5ModbYsMj05hoVyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-5YT0nNBkOfyVjmepWYMzTA-1; Mon, 26 Oct 2020 13:38:52 -0400
X-MC-Unique: 5YT0nNBkOfyVjmepWYMzTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFD7D10A0B80;
 Mon, 26 Oct 2020 17:38:51 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C3419D6C;
 Mon, 26 Oct 2020 17:38:44 +0000 (UTC)
Subject: Re: [PATCH v2 03/19] block/nvme: Introduce device/iommu
 'page_size_min' variables
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-4-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <81caffeb-832d-ab6f-b733-dc3ea61a9d93@redhat.com>
Date: Mon, 26 Oct 2020 18:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/26/20 11:54 AM, Philippe Mathieu-Daudé wrote:
> Introduce device/iommu 'page_size_min' variables to make
> the code clearer.

I am unclear how much the device and the iommu page size must equal. For
instance, in [RFC 0/5] NVMe passthrough: Support 64kB page host, I have
a 64kB host page and an MPS set to 4kB.

Thanks

Eric
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index aa290996679..5abd7257cac 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -690,6 +690,8 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      uint64_t deadline, now;
>      Error *local_err = NULL;
>      volatile NvmeBar *regs = NULL;
> +    size_t device_page_size_min;
> +    size_t iommu_page_size_min = 4096;
>  
>      qemu_co_mutex_init(&s->dma_map_lock);
>      qemu_co_queue_init(&s->dma_flush_queue);
> @@ -724,7 +726,8 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>          goto out;
>      }
>  
> -    s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
> +    device_page_size_min = 1u << (12 + NVME_CAP_MPSMIN(cap));
> +    s->page_size = MAX(iommu_page_size_min, device_page_size_min);
>      s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
>      bs->bl.opt_mem_alignment = s->page_size;
>      bs->bl.request_alignment = s->page_size;
> 


