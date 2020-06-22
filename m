Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C39C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D210D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bq3YN/2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D210D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOKZ-0007dv-3N
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jnOFX-00088O-M2
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:20:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jnOFU-0007mG-Jy
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592839239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GjzfrEPaPPpi5f+42U2vMZGbCdW4NKIHL/fTa67oKiY=;
 b=Bq3YN/2/ku5PYp1dG5u7FzWCVtcruE8RJ6T92NKq28YnZk5c3bSl1UcoCfXhmJvuYa4rs3
 zyy2qkT7iNBdtEnw3XB0NYC3Zm3aZQCbjKy2awDBa1atO0zsg/WIMqYmqF82ouhrx/5ejK
 djZuxscjSyUpBYt8wvb+tExgRLWU2LE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-aiNTiTKUOeW0fT-4-hT3hQ-1; Mon, 22 Jun 2020 11:20:38 -0400
X-MC-Unique: aiNTiTKUOeW0fT-4-hT3hQ-1
Received: by mail-ot1-f72.google.com with SMTP id z16so45452otj.11
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GjzfrEPaPPpi5f+42U2vMZGbCdW4NKIHL/fTa67oKiY=;
 b=EkYbZCU0/69LiI92GHUttb+25wYmL9uk/IsorshAv1HRl4w3J+Oo7skZwbA/0QpxEh
 RHor9qTm6kLqYa/BwumOjEuVGx0zgreqypcvBOWZwkOIZ5mZI+yhoPBCc42DVgZcebb0
 JL52+mvAIA2Hk0SY1p/VecM492/DW6G/AiMr3UMTcDk/tP2ce8wa29QM3s+x4Q6JRrn6
 ylonLTnOl8x/QB8eL0shUgNvuYG0arG/kb2UOHk+q9tcRlVY4Ai6Z1DFQp2qliHezm9I
 /Y44pC9vadbaXFqvV5TKE/b4QvqCt0UtFiScBXn+RIhMqAMgBHrKt3nHMRtQ4mSx1bjK
 aGug==
X-Gm-Message-State: AOAM533uGSFDQAZhTeKoAYHLPmCSRet8lMSX7ebA7+ULfPGnfPA/YWec
 zk4fQ7rISUA/KQMWMf06GwGCDlzDy0gr8iv99Gyw2hxvrpAFxQmGxDzoqkxdlUa9b0wOFecqtag
 RsLWqf18nApZd7TQx5PDu94fWZS1R2aQ=
X-Received: by 2002:a9d:71d6:: with SMTP id z22mr14461745otj.81.1592839237330; 
 Mon, 22 Jun 2020 08:20:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxObLrhseR+z0Y2WYcDenwl4pwv6FBB+HxtXVTfNIlV+AXwC/FQRjXFxcL5XUtLpQm4oHRJ5vzOa8s+3+a77b4=
X-Received: by 2002:a9d:71d6:: with SMTP id z22mr14461717otj.81.1592839237052; 
 Mon, 22 Jun 2020 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200622151203.35624-1-kwolf@redhat.com>
In-Reply-To: <20200622151203.35624-1-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 22 Jun 2020 18:20:20 +0300
Message-ID: <CAMRbyytsAz1MpCMQNtfFgb2+rXmWckMYyVb_VA+66stmHpq0ZQ@mail.gmail.com>
Subject: Re: [PATCH] qemu-img convert: Don't pre-zero images
To: Kevin Wolf <kwolf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pl@kamp.de, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 6:12 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Since commit 5a37b60a61c, qemu-img create will pre-zero the target image
> if it isn't already zero-initialised (most importantly, for host block
> devices, but also iscsi etc.), so that writing explicit zeros wouldn't
> be necessary later.
>
> This could speed up the operation significantly, in particular when the
> source image file was only sparsely populated. However, it also means
> that some block are written twice: Once when pre-zeroing them, and then
> when they are overwritten with actual data. On a full image, the
> pre-zeroing is wasted work because everything will be overwritten.
>
> In practice, write_zeroes typically turns out faster than writing
> explicit zero buffers, but slow enough that first zeroing everything and
> then overwriting parts can be a significant net loss.
>
> Meanwhile, qemu-img convert was rewritten in 690c7301600 and zero blocks
> are now written to the target using bdrv_co_pwrite_zeroes() if the
> target could be pre-zeroed. This way we already make use of the faster
> write_zeroes operation, but avoid writing any blocks twice.
>
> Remove the pre-zeroing because these days this former optimisation has
> actually turned into a pessimisation in the common case.
>
> Reported-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Thanks, you can also add:

    Tested-by:  Nir Soffer <nsoffer@redhat.com>

> ---
>  qemu-img.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index d7e846e607..bdb9f6aa46 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2084,15 +2084,6 @@ static int convert_do_copy(ImgConvertState *s)
>          s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
>      }
>
> -    if (!s->has_zero_init && !s->target_has_backing &&
> -        bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
> -    {
> -        ret = blk_make_zero(s->target, BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK);
> -        if (ret == 0) {
> -            s->has_zero_init = true;
> -        }
> -    }
> -
>      /* Allocate buffer for copied data. For compressed images, only one cluster
>       * can be copied at a time. */
>      if (s->compressed) {
> --
> 2.25.4
>


