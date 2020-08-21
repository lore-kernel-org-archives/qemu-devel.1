Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE04C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C88420732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVgjt12Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C88420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k946r-0002PT-Ns
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9458-0000G7-Ka
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k9455-0000ag-Qo
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYoghDc0cAzESmEmaajTEI3b2OGWRJ8ywOW5nR5gBMU=;
 b=CVgjt12Qm/wT8EwaMe5QNb0BQbvDS315NZ7mImR352bTAncV78oLQIe/5mtP/mt/s91tTK
 eFKCdVxpx+oWe36t/kiyDX/YyoFgdgCbo2ypDOtTkxnQlOYJWUcAOm7qSZhSr4X6EdEH+c
 v0DQxjGVRNYisOMnZpv50m81rkgRKGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-LGWG69FINV-6hWXuxjYdCg-1; Fri, 21 Aug 2020 06:15:29 -0400
X-MC-Unique: LGWG69FINV-6hWXuxjYdCg-1
Received: by mail-wm1-f70.google.com with SMTP id h7so636463wmm.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=v2C6ZkgJBU7D+1tGBxZ7k+G8K0aiELtt0plGGzPPRfY=;
 b=KBefgzQYAeRmawe4nVGY8SHHsF6K+jSNi3KH7wP+SI/W87Kf3nfDjTGH+WkjlnWMfl
 jXSHBa/rgFm9nvhkbBK2a7cwZkqCWZWKurHT9pnipSIIgSr+dr0w1CNq9kT/n8MGtp4A
 Sd8w8y/OrfZNGHDSIRk1bp7Pg6dIopEiic4UPxbLNYGWc4YF1FRdo3JnN2UUDTY13QV/
 atHY/TlwsgaeVfgql+1KvhfPMdKTTsXqg8YLHSZpTjH4z7vMKjgyJ8pG0bSQzg+HyMbR
 5Yd6uLLQEbq4CztIY1l9x11c2tFfd9IwWylDBxcBPt+sNY17zv7H/XI9m/3g2y5+fKPM
 pVAg==
X-Gm-Message-State: AOAM533MOELe+89mee/L2AKszxqzkwIUZCsthQeZm9SrPKZcWIgTDlQY
 5G0ZbX97Bc4nomUHChG6mlnvoOLX2OiWpFELEnObCKBexp1n5nb2rlcSauOZhPb80Fi1No8gfyj
 cgYsbetgcWDNMBrA=
X-Received: by 2002:a1c:48c2:: with SMTP id v185mr2372873wma.5.1598004927972; 
 Fri, 21 Aug 2020 03:15:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzanDrnj+4aLrLRbunFHEIKABxH6glsK9+lBDrQXowYY8kYbJPDIMxPSPC6THtRvgOxzlQSXw==
X-Received: by 2002:a1c:48c2:: with SMTP id v185mr2372852wma.5.1598004927709; 
 Fri, 21 Aug 2020 03:15:27 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id t25sm3762300wmj.18.2020.08.21.03.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 03:15:27 -0700 (PDT)
Date: Fri, 21 Aug 2020 12:15:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 12/15] block/nvme: Replace BDRV_POLL_WHILE by
 AIO_WAIT_WHILE
Message-ID: <20200821101517.tgypwxqsjw2wfbxy@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-13-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-13-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 20, 2020 at 06:58:58PM +0200, Philippe Mathieu-Daudé wrote:
> BDRV_POLL_WHILE() is defined as:
> 
>   #define BDRV_POLL_WHILE(bs, cond) ({          \
>       BlockDriverState *bs_ = (bs);             \
>       AIO_WAIT_WHILE(bdrv_get_aio_context(bs_), \
>                      cond); })
> 
> As we will remove the BlockDriverState use in the next commit,
> start by using the exploded version of BDRV_POLL_WHILE().
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 5b69fc75a60..456fe61f5ea 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -493,6 +493,7 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
>  static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
>                           NvmeCmd *cmd)
>  {
> +    AioContext *aio_context = bdrv_get_aio_context(bs);
>      NVMeRequest *req;
>      int ret = -EINPROGRESS;
>      req = nvme_get_free_req(q);
> @@ -501,7 +502,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
>      }
>      nvme_submit_command(q, req, cmd, nvme_cmd_sync_cb, &ret);
>  
> -    BDRV_POLL_WHILE(bs, ret == -EINPROGRESS);
> +    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);

Maybe I would have:

    AIO_WAIT_WHILE(bdrv_get_aio_context(bs), ret == -EINPROGRESS);

But it doesn't matter, LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>      return ret;
>  }
>  
> -- 
> 2.26.2
> 
> 


