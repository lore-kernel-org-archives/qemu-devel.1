Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFE8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5057920656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSw+I6WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5057920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k940n-00042S-Bw
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93zu-0003BX-9U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:10:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93zs-0008IQ-1y
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hdp93OLPJtT9yQtPPdii8WEyn+W86kMs+jCFydVOGNQ=;
 b=DSw+I6WR4VNnYCLYb/Zz2ZgcF+ftSWKOkTxYpUn888VzIf1gF2oY5M+kX3X2GsOjzQ9ZEW
 I3Xvk63NuF8a9RFOGVtzZStHq/bMGyJxJWhUzciENnqXi3/1Ys145VOBslHMHQ6W45p+Xt
 zhhOJWh0A7/T7bf+/41fif2WfGaydDw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-Qs3p95vgNn6fVo1y-0ohbw-1; Fri, 21 Aug 2020 06:10:05 -0400
X-MC-Unique: Qs3p95vgNn6fVo1y-0ohbw-1
Received: by mail-wr1-f69.google.com with SMTP id y6so399397wrs.11
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FevGmuLAcxuqW6GW9oRJuH8J8vmrlOJ9oqX0DVEnD8I=;
 b=GBZ2HiF6tQeblrhO4J368UVLRd+MN8NiLmchTfvM2AL1gNpjLnz8JDFqybyVhpMphG
 WwB5FijN9ezfG55/56Gc6s8ND6EGtGqKGj9Z7t6zDNVxZUb6X9YP4wPd15pRr3KjjTDb
 xATPODB9KbHjHF8gyraH7wLBREawtzARm8cGh+Ejwf87iTKSggl6UKLKHXYObjRPsiES
 ds5VSPHOQxQwpOjWcL9fEl8VkIATsKk+BFWb4Njaq6+xtSWoopAvk2adZ3+PurC57aip
 fzU99DYsVwvmtDVKqQB1I1tyXp+zLDx72m9+9/tY8Z9EUnuZSxHYhZelxB2k5jpbdQ/T
 k0Nw==
X-Gm-Message-State: AOAM5310nty9k/pF6Kl3gr33lbk+mVVpRZGo4qOkYxgPapwjRK9kW3kb
 Fb7fJaTt0m9V0doqAjRYELLPhaWYusuT4bkTryYFdiTtZlMIfsKBztjEQgGkJeDC28evw6EfKmi
 fszNk8l3tyPuMYVk=
X-Received: by 2002:a5d:688d:: with SMTP id h13mr333871wru.176.1598004604670; 
 Fri, 21 Aug 2020 03:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpb6jLDJ9FT8mYDsspXiDl97xm6Nm1dHUlOD/OlWES1vVIv+acMYCppvKCNywAOsqt+UNULQ==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr333839wru.176.1598004604321; 
 Fri, 21 Aug 2020 03:10:04 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id f19sm3912592wmh.44.2020.08.21.03.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 03:10:03 -0700 (PDT)
Date: Fri, 21 Aug 2020 12:10:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 11/15] block/nvme: Simplify nvme_init_queue() arguments
Message-ID: <20200821101001.pwzjvy34i6pvu5e6@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-12-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-12-philmd@redhat.com>
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:58:57PM +0200, Philippe Mathieu-Daudé wrote:
> nvme_init_queue() doesn't require BlockDriverState anymore.
> Replace it by BDRVNVMeState to simplify.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index f180078e781..5b69fc75a60 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -165,10 +165,9 @@ static QemuOptsList runtime_opts = {
>      },
>  };
>  
> -static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
> +static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
>                              int nentries, int entry_bytes, Error **errp)
>  {
> -    BDRVNVMeState *s = bs->opaque;
>      size_t bytes;
>      int r;
>  
> @@ -251,14 +250,14 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
>          req->prp_list_iova = prp_list_iova + i * s->page_size;
>      }
>  
> -    nvme_init_queue(bs, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
> +    nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto fail;
>      }
>      q->sq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale];
>  
> -    nvme_init_queue(bs, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
> +    nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto fail;
> -- 
> 2.26.2
> 
> 


