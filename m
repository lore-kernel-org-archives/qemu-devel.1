Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C27207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfuNqg31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C27207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93xq-0000Be-1Y
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93xI-00088o-Jb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:07:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34740
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93xG-0007uZ-MJ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+X+U+Iysxs1CNB7UR02e+WPR9oZwBeOxZrnH/3mT4/0=;
 b=IfuNqg31e8g5pS/Q/PK/yuhryqe4tl9wrSAhU2IdSqCWcyYIOFtMfVnzt/90twKJmwOPOc
 zC7b6tcBdlXbvtUj6qqX7PGdXE8VwemnbuP4Mk0DV7KlCmEF9qGX4ZR/l/+QjuSKImBnSI
 xTZW1WjptaXT5Pr842yVh9RJ3yduZ08=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-AbLaWEzLPkKCjCfd25V6Yw-1; Fri, 21 Aug 2020 06:07:23 -0400
X-MC-Unique: AbLaWEzLPkKCjCfd25V6Yw-1
Received: by mail-wm1-f72.google.com with SMTP id z1so623169wmf.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BhiEfQ/2P1f8shDO1NWlezGe+GsNlDIcf/j4joj1Kio=;
 b=l6Qm1AYTTEECwTKgFWFuFk0Wce/lUTMHD05N9IFcUVqr3RaPvCjCAcfoXJHibepT6N
 8YI5AeCL4w/CiXsNXrj8kqlIRQe4bgXHcg1vFSRTfUOHv0JnWWLcUzmA17+iYDZskHp4
 mpd9qS8j/pfv9lnYq+V4LNbT+hOMVmUdRMEnFZ/veyc9FF/SJq7iF8CYXgz2ORUwsCc3
 HsJcQXHJ8CPGO+nBVv1PhVV3gDrTb2R3XS8LgXqv0KMb+gOS0T9KayPpIKmVzeyW/27a
 ELKR4BIfp8SLfzuidccC3V8vXlsESVHu6C/sKnBTz3R3BdJKA/Iz+azncCKtkmHdgwFD
 tf/A==
X-Gm-Message-State: AOAM533G8md5SoQ7N92db8fnB3aRcvagw/gh7SIZ8vrGiFf+CzV+7nBH
 OUryQgh19idV/bHXtpAVWDvO7GElKuOx57YbUNpWYvmzf2jpElc+QaggZykQUrR7HuYZMd+MYVy
 WeZCUKEdpePI77j0=
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr2531399wmj.189.1598004442341; 
 Fri, 21 Aug 2020 03:07:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIk7EnEX675sc6bJuKg+fqjGgMZuW7eJNJh9dJcM+Qif+bCv/GyKgOpiCOzA3sbQESgvqsXA==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr2531371wmj.189.1598004442102; 
 Fri, 21 Aug 2020 03:07:22 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id f19sm3896060wmh.44.2020.08.21.03.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 03:07:21 -0700 (PDT)
Date: Fri, 21 Aug 2020 12:07:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 09/15] block/nvme: Replace qemu_try_blockalign0 by
 qemu_try_blockalign/memset
Message-ID: <20200821100718.ttztf64aazzp5y5s@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-10-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-10-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
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

On Thu, Aug 20, 2020 at 06:58:55PM +0200, Philippe Mathieu-Daudé wrote:
> In the next commit we'll get rid of qemu_try_blockalign().
> To ease review, first replace qemu_try_blockalign0() by explicit
> calls to qemu_try_blockalign() and memset().
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 2bd1935f951..ac6bb52043d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -174,12 +174,12 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
>  
>      bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
>      q->head = q->tail = 0;
> -    q->queue = qemu_try_blockalign0(bs, bytes);
> -
> +    q->queue = qemu_try_blockalign(bs, bytes);
>      if (!q->queue) {
>          error_setg(errp, "Cannot allocate queue");
>          return;
>      }
> +    memset(q->queue, 0, bytes);
>      r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
>      if (r) {
>          error_setg(errp, "Cannot map queue");
> @@ -223,11 +223,12 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
>      if (!q) {
>          return NULL;
>      }
> -    q->prp_list_pages = qemu_try_blockalign0(bs,
> +    q->prp_list_pages = qemu_try_blockalign(bs,
>                                            s->page_size * NVME_QUEUE_SIZE);
>      if (!q->prp_list_pages) {
>          goto fail;
>      }
> +    memset(q->prp_list_pages, 0, s->page_size * NVME_QUEUE_SIZE);
>      qemu_mutex_init(&q->lock);
>      q->s = s;
>      q->index = idx;
> @@ -521,7 +522,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          .cdw10 = cpu_to_le32(0x1),
>      };
>  
> -    id = qemu_try_blockalign0(bs, sizeof(*id));
> +    id = qemu_try_blockalign(bs, sizeof(*id));
>      if (!id) {
>          error_setg(errp, "Cannot allocate buffer for identify response");
>          goto out;
> @@ -531,8 +532,9 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          error_setg(errp, "Cannot map buffer for DMA");
>          goto out;
>      }
> -    cmd.prp1 = cpu_to_le64(iova);
>  
> +    memset(id, 0, sizeof(*id));
> +    cmd.prp1 = cpu_to_le64(iova);
>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>          error_setg(errp, "Failed to identify controller");
>          goto out;
> @@ -1283,11 +1285,11 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
>  
>      assert(s->nr_queues > 1);
>  
> -    buf = qemu_try_blockalign0(bs, s->page_size);
> +    buf = qemu_try_blockalign(bs, s->page_size);
>      if (!buf) {
>          return -ENOMEM;
>      }
> -
> +    memset(buf, 0, s->page_size);
>      buf->nlb = cpu_to_le32(bytes >> s->blkshift);
>      buf->slba = cpu_to_le64(offset >> s->blkshift);
>      buf->cattr = 0;
> -- 
> 2.26.2
> 
> 


