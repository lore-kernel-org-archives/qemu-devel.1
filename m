Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A1BC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655EA20732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M39bFqFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655EA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94BJ-0007K4-Nh
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k949i-00065W-2u
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:20:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55113
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k949f-00010P-CT
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rynFjBG6D7dubxOxvVsIkOZsVsDU2qaq6eimnAWdZMk=;
 b=M39bFqFXepF/q/lWKGM0HrjVbbh49R9OJ5JJkiEixTfmNjYXgRhjSdg1mz/HwH4c02Q+Lh
 I1aRCIEiZ9s9J7UGNLpBMZ/qMNCu8YHkui33QZpzSGK6YBl+mRAEAuWd5DSmHo2Ns6Eefy
 QfABs7hIm/pqS61MxxyLahkp+pY9lYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-tY1S2zHANnKKEeqCtvspOQ-1; Fri, 21 Aug 2020 06:20:12 -0400
X-MC-Unique: tY1S2zHANnKKEeqCtvspOQ-1
Received: by mail-wr1-f71.google.com with SMTP id s23so409053wrb.12
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dsVCYoocRCwKEzSUQc2OoTtzbXOZJoDlqIzMXdqZ0/M=;
 b=NE9SlYD6WGGV+JgkdeSQaYI7DGLCet5lmvEBHaHYwLaPFd1WXqdHHLNckilIKJgfTo
 Mb7gKM7zjZmWHcOqBytNCtUJSVuMjsSi6+J/wDYxr8HKcDfqmbQFM0pclavyCYy5952i
 1ERNpAj6H1K9Tnw/7K38OXitaOH/R5g2TdcWDsWmARBDCxURdVYeR/EDXdbTXkJ7yCF5
 BdPRP85leYyTWHuKFmgIxUWgaFs6ew3xik/Ndot6WzLjtuTzhqo3erAlnq081Lt6NzXa
 /MiY/eQOA2bnDO4ETx3QMR/9Ui64tncWFypY0wgzEehUCYv+RP2i+j8AFxk8kF+1jcc2
 CR+Q==
X-Gm-Message-State: AOAM533BMw2wQ0cgEnOCuxKDXHKEHufUylIriLjxwPb92EDZpPg5PsH6
 UBwe9zYE2+YVGH20JXsgySHlfpABe58ITlKwCCqVgiSzDHr/M6JSJt0cpYI00+kfZNdSUxPeujD
 aQYsUK2U8fnA1NKI=
X-Received: by 2002:adf:ec08:: with SMTP id x8mr1961410wrn.235.1598005211302; 
 Fri, 21 Aug 2020 03:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSDiNtbl6kruoUNmi2geWqlO8J5wIuetTgEgIETTMssAh3UMN8/hBbDIp2en/20dm2fkk26A==
X-Received: by 2002:adf:ec08:: with SMTP id x8mr1961384wrn.235.1598005210936; 
 Fri, 21 Aug 2020 03:20:10 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id v67sm4171221wma.46.2020.08.21.03.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 03:20:10 -0700 (PDT)
Date: Fri, 21 Aug 2020 12:20:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 13/15] block/nvme: Simplify nvme_create_queue_pair()
 arguments
Message-ID: <20200821102001.2nwbri2hvp6pu7w7@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-14-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-14-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:58:59PM +0200, Philippe Mathieu-Daudé wrote:
> nvme_create_queue_pair() doesn't require BlockDriverState anymore.
> Replace it by BDRVNVMeState and AioContext to simplify.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 456fe61f5ea..1f67e888c84 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -208,12 +208,12 @@ static void nvme_free_req_queue_cb(void *opaque)
>      qemu_mutex_unlock(&q->lock);
>  }
>  
> -static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
> +static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
> +                                             AioContext *aio_context,
>                                               int idx, int size,
>                                               Error **errp)
>  {
>      int i, r;
> -    BDRVNVMeState *s = bs->opaque;
>      Error *local_err = NULL;
>      NVMeQueuePair *q;
>      uint64_t prp_list_iova;
> @@ -232,8 +232,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
>      q->s = s;
>      q->index = idx;
>      qemu_co_queue_init(&q->free_req_queue);
> -    q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
> -                                  nvme_process_completion_bh, q);
> +    q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
>      r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
>                            s->page_size * NVME_NUM_REQS,
>                            false, &prp_list_iova);
> @@ -637,7 +636,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      NvmeCmd cmd;
>      int queue_size = NVME_QUEUE_SIZE;
>  
> -    q = nvme_create_queue_pair(bs, n, queue_size, errp);
> +    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
> +                               n, queue_size, errp);
>      if (!q) {
>          return false;
>      }
> @@ -683,6 +683,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>                       Error **errp)
>  {
>      BDRVNVMeState *s = bs->opaque;
> +    AioContext *aio_context = bdrv_get_aio_context(bs);
>      int ret;
>      uint64_t cap;
>      uint64_t timeout_ms;
> @@ -743,7 +744,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>  
>      /* Set up admin queue. */
>      s->queues = g_new(NVMeQueuePair *, 1);
> -    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
> +    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
>                                                            NVME_QUEUE_SIZE,
>                                                            errp);
>      if (!s->queues[INDEX_ADMIN]) {
> -- 
> 2.26.2
> 
> 


