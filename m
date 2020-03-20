Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE1CC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D0920663
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MU+BV7kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D0920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLuY-0001A1-9R
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFLtr-0000ak-0Z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFLtp-0006Dj-Gd
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:57:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFLtp-00069w-AY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:57:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id k18so7465345oib.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZG8Y4pZ11pcMWaVI05Vqi/9+7qaLwwiAuSzMiyot2i4=;
 b=MU+BV7kfspeYndeX4RJVhAtfjLOY42z4rzROhwPQ5BRZwMiErKyavSeJM1XNdtDg2R
 m8kUT6vGiCo/H4+lk7AkxKTn7C7dKdy7LzImcYg/PQtglmxqWjENuu1uTip+N3dQ0d7v
 T2ehK0H6R3bjsqEJHrqVTHpMPUPAx9zYiR130OmJ4yE5te9eCGpJBnskyp3C3rv/b8/m
 oCQ7PnVR6Ix+vyz3sd5D0Wn/8JdB08Q9fBH7z8M/s450I/vii+jcwtzcyT2ha6xh8AIq
 Dvk2CgQNaI4M2l4yuzUE2pN5+ReYtpaBgxkYJpHNzZ3USszCdkBT7bG5QERRbq2cFTTC
 6Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZG8Y4pZ11pcMWaVI05Vqi/9+7qaLwwiAuSzMiyot2i4=;
 b=p2bqI4YgMpEBTjIi7MGnKp+VVEqn/bVlvMo6goey/85xJhpuVTuiJOR0csxPd1EBme
 4SvA91Nu3lq7DFLBq2wT0e8J3bxtpoNX9e1u79drwZh5NnKtU+WoWAleYkOiM3HZodS+
 +TYMqgfa4l5ih86otMQv+rnHY1iSyiNhpwxIzIiTIC0Fd1d3NYtiGKJGVGReiSceMTva
 PeN5p0LZ17uFHdx0diy4JhcuREvzPDwj+B0MrjV8VDFJtSgyF7QvDjdtCTTVmclslPxo
 DBNyZRudtjzDWg74/TYLLDpjBsaTnIhXuVAbA1uiTsJDvQL8JzsNHv0KRcvbLOjnGTBC
 hHzA==
X-Gm-Message-State: ANhLgQ0W9HlhZukjqoRoYICexOBdEfp5fkOr8XJ9J3xblLDowUuHaZQr
 GtFwUCX3kIAA1B2/ccBcW8gaCaOkka/wOWBkfFC+9A==
X-Google-Smtp-Source: ADFU+vskut/UBQn/ymrO3POB90ToVZxRL69CPR4eYZQOuIuaO86BOfQSwRtGMruevayj89TGErmuwPBz6X5k5gn91iw=
X-Received: by 2002:aca:190f:: with SMTP id l15mr7233325oii.48.1584727056324; 
 Fri, 20 Mar 2020 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190211205128.27146-1-eblake@redhat.com>
 <20190211205128.27146-4-eblake@redhat.com>
In-Reply-To: <20190211205128.27146-4-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 17:57:24 +0000
Message-ID: <CAFEAcA9wDiKKfL67B7cH1X=Wm_ayDJb6b0L-Pgiqcp2SkDNBAw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 3/4] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:qcow2" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Feb 2019 at 20:57, Eric Blake <eblake@redhat.com> wrote:
>
> From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:

Hi; Coverity has just noticed an issue (CID 1421894) with this change:

> diff --git a/block/qcow2.c b/block/qcow2.c
> index bcb80d0270c..65a54c9ac65 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4387,7 +4387,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>      spec_info = g_new(ImageInfoSpecific, 1);
>      *spec_info = (ImageInfoSpecific){
>          .type  = IMAGE_INFO_SPECIFIC_KIND_QCOW2,
> -        .u.qcow2.data = g_new(ImageInfoSpecificQCow2, 1),
> +        .u.qcow2.data = g_new0(ImageInfoSpecificQCow2, 1),
>      };
>      if (s->qcow_version == 2) {
>          *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
> @@ -4395,6 +4395,13 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>              .refcount_bits      = s->refcount_bits,
>          };
>      } else if (s->qcow_version == 3) {
> +        Qcow2BitmapInfoList *bitmaps;
> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            qapi_free_ImageInfoSpecific(spec_info);
> +            return NULL;

If we take this error-exit codepath, then we never free the
memory allocated by the earlier call to qcrypto_block_get_info().

> +        }
>          *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
>              .compat             = g_strdup("1.1"),
>              .lazy_refcounts     = s->compatible_features &
> @@ -4404,6 +4411,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>                                    QCOW2_INCOMPAT_CORRUPT,
>              .has_corrupt        = true,
>              .refcount_bits      = s->refcount_bits,
> +            .has_bitmaps        = !!bitmaps,
> +            .bitmaps            = bitmaps,
>          };
>      } else {
>          /* if this assertion fails, this probably means a new version was
> --
> 2.20.1

thanks
-- PMM

