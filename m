Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C67C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A05C22B4E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTyO+F5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A05C22B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxX8S-0000ML-Tv
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jxX7o-0008BK-3a
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:50:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54317
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jxX7l-0007wQ-Og
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595256636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7P51uThIbBY7bCg8+9JC6OejqFwHFWdvtmvnifUFwug=;
 b=jTyO+F5HZTFu9i1J2G6x2FWV23CbyVMQ0RolLkBueWvbcghBevdUAlZCKFHRv0mR8/AIQ1
 Db8TVBfpazKs7Wh39YlcGfktzfNwQE9S6mKXub0ggVOs8e466CK77yoPJ9A/be6gbj68tX
 HqyNagMEo+XCWDdvOltvKb4x+qtq3G8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-bFMCmj61MLuELa2_-rOPuQ-1; Mon, 20 Jul 2020 10:50:34 -0400
X-MC-Unique: bFMCmj61MLuELa2_-rOPuQ-1
Received: by mail-oo1-f72.google.com with SMTP id u19so7841636oof.21
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 07:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7P51uThIbBY7bCg8+9JC6OejqFwHFWdvtmvnifUFwug=;
 b=VnUnLIJTRNsrr5bsKgisg36XvH7A+AmzZgaNUjDfFQXjx0Jj/Di70UqqhfhJAFQ4GG
 5W+g27OjakUoYyqgORFrwnrWwrnVHhxY58SEyflpweYRlJr6yJgopIBuG+6iOux15qj2
 Mw1VxknY+I9cEhgpZArhvPdKyJJW3hKPvi6UDTJLqC7ZXb/RRYgD3p7f/vzHwG+8P1Ld
 e01VNfYCVZ64dhvy2EdX8L+pkUevzAX/K2TYSa789URT1/yXfROe36/D33L0GbsE5VDR
 MSofdC1OXCG6Y/0ljBZVdodDTYb9Z9IocUnSFlxPl/o0/o6bBbxJZ+yTfI5I09dmP6eH
 R4Fg==
X-Gm-Message-State: AOAM530WJlyT0xsD04NMtNmZVkrs/chEq0YOvoBnWi/O6CqMskYju/so
 X6sm135xoAqT4SMFGxvly+XR4ECwFe0wncSi167aeYc7+cLJSUlFl2yx+8pM5CN19gEi0Kq6YnY
 pb9YPo2O5ZJOYGWrGgYz5/BrBeJaQiEA=
X-Received: by 2002:a4a:ea03:: with SMTP id x3mr20153700ood.16.1595256633383; 
 Mon, 20 Jul 2020 07:50:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9cN007SWZ2gMUBnCuL91aEbBnYoPS84QGjKErYpzCEUOyprifshLucbQNTPnNUNAaOKWNh8HFzRrVE5APXRI=
X-Received: by 2002:a4a:ea03:: with SMTP id x3mr20153681ood.16.1595256633096; 
 Mon, 20 Jul 2020 07:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200720131810.177978-1-kwolf@redhat.com>
 <20200720131810.177978-2-kwolf@redhat.com>
In-Reply-To: <20200720131810.177978-2-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 20 Jul 2020 17:50:16 +0300
Message-ID: <CAMRbyyv==4=gGwtPn_D=1bxLmxX8SXhLNhbg+jSM90Z0zCp5pA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/2] qcow2: Implement v2 zero writes with discard
 if possible
To: Kevin Wolf <kwolf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 4:18 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> qcow2 version 2 images don't support the zero flag for clusters, so for
> write_zeroes requests, we return -ENOTSUP and get explicit zero buffer
> writes. If the image doesn't have a backing file, we can do better: Just
> discard the respective clusters.
>
> This is relevant for 'qemu-img convert -O qcow2 -n', where qemu-img has
> to assume that the existing target image may contain any data, so it has
> to write zeroes. Without this patch, this results in a fully allocated
> target image, even if the source image was empty.
>
> Reported-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2-cluster.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 4b5fc8c4a7..a677ba9f5c 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1797,8 +1797,15 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
>             end_offset >= bs->total_sectors << BDRV_SECTOR_BITS);
>
> -    /* The zero flag is only supported by version 3 and newer */
> +    /*
> +     * The zero flag is only supported by version 3 and newer. However, if we
> +     * have no backing file, we can resort to discard in version 2.
> +     */
>      if (s->qcow_version < 3) {
> +        if (!bs->backing) {
> +            return qcow2_cluster_discard(bs, offset, bytes,
> +                                         QCOW2_DISCARD_REQUEST, false);
> +        }
>          return -ENOTSUP;
>      }

Looks good to me.

>
> --
> 2.25.4
>


