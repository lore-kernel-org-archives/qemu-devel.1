Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2208AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E206E20732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFhR7PUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E206E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93nz-0007hL-8J
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93nS-0007CW-T1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:57:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93nR-0006ji-65
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598003836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mv2Gt5SMt99MSr39l1yt6CCNf8i2al1nhduJfCCgy8=;
 b=HFhR7PUjJ+i/Gl9VX/Txx09pnAYwK9m30wsMidA767aT5srA9CzqISWIr5l2jZCARNaonv
 sFsR5QwUjkJBm8w9OCilBg/DWYv7KVj3I6G84dr/r9pvoxexAv345A3I+78AVbSCCxqLjd
 AHIBu2ctcrkD7OILSVgrmbyPX6XeLUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-FSVBMdhaMz-jY4G71_QWtQ-1; Fri, 21 Aug 2020 05:57:14 -0400
X-MC-Unique: FSVBMdhaMz-jY4G71_QWtQ-1
Received: by mail-wm1-f71.google.com with SMTP id c186so744637wmd.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mUSuYJy5HAZ4m6UTXOnHfmIlMgU1DJ+w7zgVLveJ8NQ=;
 b=PDRXt5J/SmXmwjfy/OsNAYNmKCIOJW5rK7N44MHvD8KyCp2SPgBkMKlO60QMiCEA8v
 KaPGMMwIkwahU8B4/e0fUvFTwGGchs2disYtWhT1V8Upr4h0XUtco/6X0ik8v8hy8Smw
 mNbLHCer92l26nthwGF6vHQYTkCLJoHj5Rj6IrtiWNJHWVLRJauRgOr9SMJL5DU4juZn
 WWfoGe3he6Fy48zWDBMh+hXkVDa1VCiCkzCpKt+7ZsgoY9Nk0zGDN2hG+06z4gNPf0fj
 UlbGlAh/t7bRBL2PC60k2C2V59ZXmoPk5OXXKW2MWv0n5ZGJ2SNOVCnk5saaVT8dktKV
 axvg==
X-Gm-Message-State: AOAM532C+/yOi9FHMMySIs3iyo+Pgf2ty7/0/t8wWfNSRNoDln2qIP1a
 t25sb/WmR7ovXK4Kzie3ERVxJ6sy4fJku9BqvkaAhuT7wXiuXpr7vzXYkbhAb8QGiSA9KV6v1yB
 WOP5INl2YcbtCFG4=
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr1944491wrw.311.1598003833146; 
 Fri, 21 Aug 2020 02:57:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs8x2pApFj79/8yqBSltUEaQ3aR2aSF8Poo4FYoe/iofL0LcjUbNPO0hJSwmJRQvfAcg2YXA==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr1944479wrw.311.1598003832882; 
 Fri, 21 Aug 2020 02:57:12 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id d14sm3394420wre.44.2020.08.21.02.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 02:57:12 -0700 (PDT)
Date: Fri, 21 Aug 2020 11:57:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 07/15] block/nvme: Rename local variable
Message-ID: <20200821095709.hm3yyxzjmw423w2z@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-8-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-8-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
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

On Thu, Aug 20, 2020 at 06:58:53PM +0200, Philippe Mathieu-Daudé wrote:
> We are going to modify the code in the next commit. Renaming
> the 'resp' variable to 'id' first makes the next commit easier
> to review. No logical changes.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 3101f1ad55d..99822d9fd36 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -510,8 +510,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>      BDRVNVMeState *s = bs->opaque;
>      NvmeIdCtrl *idctrl;
>      NvmeIdNs *idns;
> +    uint8_t *id;
>      NvmeLBAF *lbaf;
> -    uint8_t *resp;
>      uint16_t oncs;
>      int r;
>      uint64_t iova;
> @@ -520,14 +520,14 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          .cdw10 = cpu_to_le32(0x1),
>      };
>  
> -    resp = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
> -    if (!resp) {
> +    id = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
> +    if (!id) {
>          error_setg(errp, "Cannot allocate buffer for identify response");
>          goto out;
>      }
> -    idctrl = (NvmeIdCtrl *)resp;
> -    idns = (NvmeIdNs *)resp;
> -    r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
> +    idctrl = (NvmeIdCtrl *)id;
> +    idns = (NvmeIdNs *)id;
> +    r = qemu_vfio_dma_map(s->vfio, id, sizeof(NvmeIdCtrl), true, &iova);
>      if (r) {
>          error_setg(errp, "Cannot map buffer for DMA");
>          goto out;
> @@ -554,8 +554,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>      s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
>      s->supports_discard = !!(oncs & NVME_ONCS_DSM);
>  
> -    memset(resp, 0, 4096);
> -
> +    memset(id, 0, 4096);
>      cmd.cdw10 = 0;
>      cmd.nsid = cpu_to_le32(namespace);
>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
> @@ -587,8 +586,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>  
>      s->blkshift = lbaf->ds;
>  out:
> -    qemu_vfio_dma_unmap(s->vfio, resp);
> -    qemu_vfree(resp);
> +    qemu_vfio_dma_unmap(s->vfio, id);
> +    qemu_vfree(id);
>  }
>  
>  static bool nvme_poll_queues(BDRVNVMeState *s)
> -- 
> 2.26.2
> 
> 


