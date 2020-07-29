Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6400BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD0820809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwJmyOch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD0820809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0nwK-0001IC-Cm
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0nvH-0000FG-8v; Wed, 29 Jul 2020 11:23:15 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0nvF-0002t9-DZ; Wed, 29 Jul 2020 11:23:14 -0400
Received: by mail-pj1-x1042.google.com with SMTP id c10so546197pjn.1;
 Wed, 29 Jul 2020 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=S/IR9QUDRzwhu73llN8tLENtLbE7RxbEfsA3GQ0Pzp0=;
 b=TwJmyOchyqszeOAaoPTEXj3NkRiRl7TcfWD2pK4p+/tfeCCbbZrmWoPa+/TKPTqjll
 XPBZeTLT97WBPr6Scw00E2xFzd1pRQHTO71j+nWsUcyISaILC8l/NYkoU2Fv/MIlqe5C
 0xZCuDYgpL9gAhPAuxqrbRp9DHzSCRgPwvJZbInut531Ewx6i+/J4oyZ6ZDHGHn0Gysn
 EcJBL3G85ENCo8K3ukDprDyzX4xT9dJUwGCG1Yn1Wuwke2icSb60p1uShJzO9nUBNoWE
 BD6o5n7gAac7dggYUlsTaqxdOjm9Cx9Gu07JWk7hUQb5SaOWaYMIBbr+PrBkzUdD4Mi2
 k1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=S/IR9QUDRzwhu73llN8tLENtLbE7RxbEfsA3GQ0Pzp0=;
 b=V+aCXKtqCw9z2k5YXSatqS8+V88aYFCV8AYj/YSxsOIcukE+lTAwN4IwJbuSMFT28I
 Y8gPlD5rpPu1mwT5iFx9LeUAPGAd5nXc5MP4+0t2sbvg9gO52asb/CHakfnHjjYkIW5w
 AaLcrm6PkdY3UIQdjmaLacbNIUrHQCbz3zlKOU3L2/lXFzVxjOYPvVvImetiYLTP5lKI
 sE3rarpxz7j/WspgVh4sl+r7+0Fz6T+ozFagNpaHv6MjcKvL3iwNPhPs9vKJGmXkTqg4
 ren6JBixrbiAC/N/N21ONV1jW426PsxnUn1M3I+e60JjQKrW+PO7c/8bhpbJA/plEf7L
 EpAA==
X-Gm-Message-State: AOAM532W99W/jyhSt+O8XSQJJP3KMuI8BTO+Zu23FgAP+ec5gbgE219C
 y+AXQk5wvWEvUSp/5CN8nn8=
X-Google-Smtp-Source: ABdhPJy43/yO8kwihj1fJoIJkeuBde1OrMQ8iUzxCOO+Od09soXFithtEFcPF3eEQupFeKSybeq9PQ==
X-Received: by 2002:a17:902:ba83:: with SMTP id
 k3mr28656177pls.217.1596036191316; 
 Wed, 29 Jul 2020 08:23:11 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id f6sm2821724pje.16.2020.07.29.08.23.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 08:23:10 -0700 (PDT)
Date: Thu, 30 Jul 2020 00:23:08 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 03/16] hw/block/nvme: replace dma_acct with blk_acct
 equivalent
Message-ID: <20200729152308.GB14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-4-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-4-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Klaus,

On 20-07-20 13:37:35, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The QSG isn't always initialized, so accounting could be wrong. Issue a
> call to blk_acct_start instead with the size taken from the QSG or IOV
> depending on the kind of I/O.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9b1a080cdc70..cb236d1c8c46 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -620,9 +620,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> -    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
>      if (req->qsg.nsg > 0) {
>          req->has_sg = true;
> +        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
> +                         acct);
>          req->aiocb = is_write ?
>              dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
>                            nvme_rw_cb, req) :
> @@ -630,6 +631,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>                           nvme_rw_cb, req);
>      } else {
>          req->has_sg = false;
> +        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
> +                         acct);
>          req->aiocb = is_write ?
>              blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
>                              req) :

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,

