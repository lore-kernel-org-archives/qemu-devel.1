Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D3920732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYo4LISA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D3920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93mP-0005iL-DH
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93lf-00059M-MP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:55:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25131
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93ld-0006TR-S5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598003725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6WRmOa2VPYzo+gjmhWxhrWl1k8z8YH7ddKHaOAHoxs=;
 b=IYo4LISA6dzu/h/+p//DWKdAws33YLE0mIBNInEIfVBpO1jTCdIJyu+ps7ZylHP4FX9ZTc
 zgYFzGFcWTp/VUqaAxExanJBeRMJatFk1ItmnRvJ255E1Jc5Tzgy0767zu5AEvnim3riw0
 Nx+t0N4992Zps3R/c3t1S1rHcX6d5ks=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-f6JuiByNMVyjcHfHAn0dNg-1; Fri, 21 Aug 2020 05:55:23 -0400
X-MC-Unique: f6JuiByNMVyjcHfHAn0dNg-1
Received: by mail-wm1-f71.google.com with SMTP id q15so618694wmj.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sjI1zE2CcvHpqM0ciX1FuQqOWBK7BbY0fXSldqWiwME=;
 b=K6JYn4eqlMz75NXvPI4hIpEkhFz5pywXZJVywXL3+qzE7Mnery5COb+fVN7i5oyExV
 s3RYd1sS/32tbTDmyCf1ZZ1cg7HsC/FNKF0ay7R1CfD+t+MQ2k0aIC67buTZ2CbXUGc4
 ycVh6jo0Jpv2VpQNKdrI7s+JWgru0U+GzKoX0E1C0fhj3Q1xaoW5KMNlD0WUNHTstK0c
 3rHg5zJ7MetglaBNkPDuzW+y9oVSz0u3vn4y90fHehheQ/+/mNd1lQ7i8Q4mgOqOptIW
 AxAR9oBb7sgXlLgLWSpKqGC5YREs8vHiTj44f4jQDvwLERJ5LAVgjuaL2wHVaveMW3Sn
 /Tbg==
X-Gm-Message-State: AOAM530rKHCN2WuHtFxT0N37fjE2vjhbfE6fDTeTktwBuMaueBrrfYPr
 tcHUEZtruJJdenS+4qt6AUs54mvDIhpcZ7e20vtMnPZAv1S2bC8hMYI0b9QqSG8qXVxTGJRpWUy
 lwzX2ZHOWuNdF4IU=
X-Received: by 2002:adf:97d3:: with SMTP id t19mr1901595wrb.138.1598003722335; 
 Fri, 21 Aug 2020 02:55:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNPmX/3rjHBGkFxaFnbZxS9TQ0bbyvuiFtoRmwpOQ26d//b4SqxgukRW50Wsh5TzTw4qZtBA==
X-Received: by 2002:adf:97d3:: with SMTP id t19mr1901581wrb.138.1598003722124; 
 Fri, 21 Aug 2020 02:55:22 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id v16sm3933877wmj.14.2020.08.21.02.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 02:55:21 -0700 (PDT)
Date: Fri, 21 Aug 2020 11:55:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 06/15] block/nvme: Use common error path in
 nvme_add_io_queue()
Message-ID: <20200821095518.bq7fllhmm7blattk@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-7-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-7-philmd@redhat.com>
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

On Thu, Aug 20, 2020 at 06:58:52PM +0200, Philippe Mathieu-Daudé wrote:
> Rearrange nvme_add_io_queue() by using a common error path.
> This will be proven useful in few commits where we add IRQ
> notification to the IO queues.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 53448b7d230..3101f1ad55d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -649,8 +649,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      };
>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>          error_setg(errp, "Failed to create CQ io queue [%d]", n);
> -        nvme_free_queue_pair(q);
> -        return false;
> +        goto out_error;
>      }
>      cmd = (NvmeCmd) {
>          .opcode = NVME_ADM_CMD_CREATE_SQ,
> @@ -660,13 +659,15 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      };
>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>          error_setg(errp, "Failed to create SQ io queue [%d]", n);
> -        nvme_free_queue_pair(q);
> -        return false;
> +        goto out_error;
>      }
>      s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
>      s->queues[n] = q;
>      s->nr_queues++;
>      return true;
> +out_error:
> +    nvme_free_queue_pair(q);
> +    return false;
>  }
>  
>  static bool nvme_poll_cb(void *opaque)
> -- 
> 2.26.2
> 
> 


