Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FFDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93181206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtIBLzcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93181206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Jv4-0007La-RH
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8JuP-0006s3-9G
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:57:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8JuN-0005Su-J9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597827442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zVoTEhUq5WTw7k//LQdPrl1Xzg0mEmeqPRbn39j4bXo=;
 b=PtIBLzccbTYdJ43aCzotPQHtOFnT4U9/srxiKzAq/tJW2T7i4sAh6p4yKM7n5Toc3We0bR
 V8CD2aaPRIJQrh9lfnws5BJFcx4xs1bfprK/hXQ0ahvC3lmKkEtH2+k8y9odx74DavgwYa
 wpl8uJFtHSizoYxsuvVjR+7++y2/Ujs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-YHlzROpaPwqRTU39GEpFuA-1; Wed, 19 Aug 2020 04:57:20 -0400
X-MC-Unique: YHlzROpaPwqRTU39GEpFuA-1
Received: by mail-wm1-f70.google.com with SMTP id q15so676734wmj.6
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 01:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zVoTEhUq5WTw7k//LQdPrl1Xzg0mEmeqPRbn39j4bXo=;
 b=YAX46jGR0j3LaRItnsYF308z9ZAZjp2oB1fkfzpitakMSeGqx65WelAmj36QVdhTPy
 0j16jaVE4OWPFuMzSW3PXo+FsaQeqvdysrI9gjcsn29srzftvUoGTOCGD77J9Cqsqd1x
 geNs/NyHUV1N+hFmSQfS9twJ2+H9wQDO8wq8XnEmxHkul/ToTYMNukEh2Z/PXKZFy8pZ
 TTTb8VHDuxRLl8VkUQFtFpA5AwSYWNVk1fh+ZrsnCbCJ0Fu1AswjOuNfMrxuJQ4Tslnp
 pe3OlLIf3QyDE1FTQhKYEHkopERnz00K1DmyzTkTQNREZ3blWRPd2LTqvsU9zMBr7YOe
 fmSA==
X-Gm-Message-State: AOAM530mqg+xPOcLcQ5G2ZGRk9ifYTjw4eQhnZhFIx6RCXSldIHlyXQm
 ds0R8///RV7Mu66DRKr6ezYFjEwViFxfRS+lPJzmsuVs0L2D/A7c7JN+3k4zu3VDs6AZYUfT5CY
 8KcFxjezuPXLT5+s=
X-Received: by 2002:a1c:6289:: with SMTP id w131mr4052855wmb.41.1597827439247; 
 Wed, 19 Aug 2020 01:57:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5s6M7kUu91qEV11obU4m95uqfzexaYo3N2KXjbfq/UDLRR392fzysYVJtXexdRINID0piEg==
X-Received: by 2002:a1c:6289:: with SMTP id w131mr4052839wmb.41.1597827439025; 
 Wed, 19 Aug 2020 01:57:19 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id 32sm40428067wrn.86.2020.08.19.01.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 01:57:18 -0700 (PDT)
Date: Wed, 19 Aug 2020 10:57:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yi Li <yili@winhong.com>
Subject: Re: [PATCH v2] qemu-img: Explicit number replaced by a constant
Message-ID: <20200819085713.mtdgxvkpxvcbufse@steredhat.lan>
References: <0107e40a-1d96-fa3d-bd15-019c004d0353@redhat.com>
 <20200819013607.32280-1-yili@winhong.com>
MIME-Version: 1.0
In-Reply-To: <20200819013607.32280-1-yili@winhong.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
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
Cc: kwolf@redhat.com, yilikernel@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 09:36:07AM +0800, Yi Li wrote:
> Signed-off-by: Yi Li <yili@winhong.com>
> ---
>  qemu-img.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 5308773811..aa2e31c8ae 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1200,10 +1200,10 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
>          *pnum = 0;
>          return 0;
>      }
> -    is_zero = buffer_is_zero(buf, 512);
> +    is_zero = buffer_is_zero(buf, BDRV_SECTOR_SIZE);
>      for(i = 1; i < n; i++) {
> -        buf += 512;
> -        if (is_zero != buffer_is_zero(buf, 512)) {
> +        buf += BDRV_SECTOR_SIZE;
> +        if (is_zero != buffer_is_zero(buf, BDRV_SECTOR_SIZE)) {
>              break;
>          }
>      }
> @@ -2489,8 +2489,8 @@ static int img_convert(int argc, char **argv)
>              }
>          }
>  
> -        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, s.total_sectors * 512,
> -                            &error_abort);
> +        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
> +                            s.total_sectors * BDRV_SECTOR_SIZE, &error_abort);
>          ret = add_old_style_options(out_fmt, opts, out_baseimg, NULL);
>          if (ret < 0) {
>              goto out;
> -- 
> 2.25.3
> 
> 
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


