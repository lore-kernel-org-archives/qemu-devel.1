Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E767CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B54207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKu85TtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B54207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93cI-0000We-IF
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93bg-0008L8-7r
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93be-0005Ko-18
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598003105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uT8xpEn1ruTj0R3+gT3Cja3ymM85gU29yENjgTDtS3s=;
 b=PKu85TtG1zyLJP2PsLhq1yE3hq7CZqr5DgR/MG7gAk3TPDVAdsfDD0rKViJOP1VdZUbhTw
 vY5RlGhD27wnNMt/Zz8PvYe96Is4XnR3bN7SbW8cduwNVLzPaAa1xocPSWwI9s0Uyuay4i
 SvmerhxiG9NXfPw4/EjNEgsY5WBu23A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-t-78aP6NMgqZ9DCBSQullg-1; Fri, 21 Aug 2020 05:45:03 -0400
X-MC-Unique: t-78aP6NMgqZ9DCBSQullg-1
Received: by mail-wm1-f71.google.com with SMTP id q23so336528wmj.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JCr2o97lDQ29WNQolEsKNMftLo0JV2GaPklih3jHnm0=;
 b=mTnDCbrR+uJP9j9Lt7sOHA7slt2qVjnJp7YwjVcrXB+huT9xRBhrlfG97FPwpOWfHq
 OhZJ21j7oQM4TRZsdaabWpcCY0V6Umbh8svgDzyUqridDepby6sc82joLGeoWzkam84G
 b0mWBKKwlAfZHgXWOOU1cjtWY9GbcHJr7UXHxI+ghLAd75NOnyKLxWJaVZBVpH1NMBok
 s8bYdQkMcnYmrAsSWgCezgAf1maHp9e9A+xFhSHnhyScqqkYdKFXsjUV7wS7ZM7t3aZ1
 3NEdpMd94AGg+1ZJw75h4tsWceKiKCrT8C7i3z2Z2HK/x+/VOKDVyTKLj8k1AC2U/Sps
 50yQ==
X-Gm-Message-State: AOAM530E4fYbtFy9zJlrXiSl5AB2QEClzlo1JfVYD2xNSwsRi2RPY664
 RxVY7RWSEW5HcOjc5q3pCxcHB1J7k4v4Ly1Yq445zt5KjH1OQ2r6+POQVFZvbGCINlC2TJV0Do4
 2g9aCb5E4vaoh6Tw=
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr2430092wmn.78.1598003102343; 
 Fri, 21 Aug 2020 02:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL+4XDhu0EakdpZCcO8xvizsTC/89rYXeWo/dSXVqu9n+jLOM2SnEAvL5/qlxekXGaORglKg==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr2430062wmn.78.1598003102083; 
 Fri, 21 Aug 2020 02:45:02 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id y16sm3154717wrr.83.2020.08.21.02.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 02:45:01 -0700 (PDT)
Date: Fri, 21 Aug 2020 11:44:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 03/15] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
Message-ID: <20200821094458.fqspisyyl4xxibas@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-4-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:58:49PM +0200, Philippe Mathieu-Daudé wrote:
> As nvme_create_queue_pair() is allowed to fail, replace the
> alloc() calls by try_alloc() to avoid aborting QEMU.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 8c30a5fee28..e1893b4e792 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -213,14 +213,22 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
>      int i, r;
>      BDRVNVMeState *s = bs->opaque;
>      Error *local_err = NULL;
> -    NVMeQueuePair *q = g_new0(NVMeQueuePair, 1);
> +    NVMeQueuePair *q;
>      uint64_t prp_list_iova;
>  
> +    q = g_try_new0(NVMeQueuePair, 1);
> +    if (!q) {
> +        return NULL;
> +    }
> +    q->prp_list_pages = qemu_try_blockalign0(bs,
> +                                          s->page_size * NVME_QUEUE_SIZE);

Here you use NVME_QUEUE_SIZE instead of NVME_NUM_REQS, is that an
intentional change?

Maybe is not an issue, sice NVME_QUEUE_SIZE is bigger than
NVME_NUM_REQS, but we should mention in the commit message.

Thanks,
Stefano

> +    if (!q->prp_list_pages) {
> +        goto fail;
> +    }
>      qemu_mutex_init(&q->lock);
>      q->s = s;
>      q->index = idx;
>      qemu_co_queue_init(&q->free_req_queue);
> -    q->prp_list_pages = qemu_blockalign0(bs, s->page_size * NVME_NUM_REQS);
>      q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
>                                    nvme_process_completion_bh, q);
>      r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
> -- 
> 2.26.2
> 
> 


