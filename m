Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC304C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E33520738
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMqiraOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E33520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUJb-00017B-4l
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLTdM-0005Gk-C5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kLTdJ-0001ry-GG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dXAN1AEuHxZeGXzbuduQk0HLokhpg2HmL3oGwsdnAg=;
 b=PMqiraOE3NYXxIuI9Ymc78flivMwA9MIfbkzcIz8XSilL5pbQEED+Tg8ZbSVU10hRZ3xUF
 4aGVb3BbI6vJXY3w9+Z+2bpiL21GQy/FEDQtTpqvnac8NtnB5sSjIfNRqrN7a+L6Oz9KpR
 Z9kLKB4ZhB2Dc7RdIB63yS3MxZDYj5s=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Ob4KLpmdOhq7ObBWJz1LwA-1; Thu, 24 Sep 2020 11:58:05 -0400
X-MC-Unique: Ob4KLpmdOhq7ObBWJz1LwA-1
Received: by mail-yb1-f199.google.com with SMTP id k3so3256799ybk.16
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 08:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2dXAN1AEuHxZeGXzbuduQk0HLokhpg2HmL3oGwsdnAg=;
 b=URWRPoF/Hqa/0czBbLiVkkVysyNVaH3hVY0K+G0I+zuDGSX04IwhKXwJk54YZ1GV/v
 KuhagZp2TwY8l1YRdbUNXPQhgcxOJPeJ5SJmx0NWfo54v4FhBZ4d4+ZhwxX7dLXp2igt
 m4O5S2fdCybOVA5UUBqtfaojV9c81opFmehCVMZDk4gXw1Oyk+SHSFOk08Vr6MEwHawO
 daPaMjPWjlRq8CjiA6/7XwOdePmIun4to/sVaxwNyIWMTfhITOgh2/lNIOCdBLiQExWM
 k2Ej5B/yav+sQJWgcoTg3E+czGD8StQeozpQvJ7gmmWym5jCPCRblS+4BZy2qxllWNmg
 QvXA==
X-Gm-Message-State: AOAM531QImgXpAVzVjRVwRPR0WGSqJEGRuLXHo6usrv5FRN/+0qtBmlQ
 xmMGalMVuLXSzfRaK+Ct0s1H5YmhzfsJEGDgw9i0Y81H1TNibEc8SY3TDx6zqlx5kokDj0+ojoy
 k9k2CQrMUXY/lVMW2hExVRYXWADufBw4=
X-Received: by 2002:a25:6084:: with SMTP id u126mr290879ybb.321.1600963084501; 
 Thu, 24 Sep 2020 08:58:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE6Uvh9fxgKS0uCkFfy/sVD6XHLMJ4ug5J0fUTWrbId80DMzONIyrzkvZ5uSF8Vad+UrRULV7/n0MJKK1HzRE=
X-Received: by 2002:a25:6084:: with SMTP id u126mr290842ybb.321.1600963084241; 
 Thu, 24 Sep 2020 08:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200924151511.131471-1-sgarzare@redhat.com>
In-Reply-To: <20200924151511.131471-1-sgarzare@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 24 Sep 2020 17:57:53 +0200
Message-ID: <CAMDeoFUNv2q5u-OZHoJUFtbQXoTW_uEXZ9c_aiWRHmqjjRmEEw@mail.gmail.com>
Subject: Re: [PATCH] docs: add 'io_uring' option to 'aio' param in
 qemu-options.hx
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 5:15 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> When we added io_uring AIO engine, we forgot to update qemu-options.hx,
> so qemu(1) man page and qemu help were outdated.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Julia Suvorova <jusual@redhat.com>

> ---
>  qemu-options.hx | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 47f64be0c0..5b098577fe 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1053,7 +1053,8 @@ SRST
>              The path to the image file in the local filesystem
>
>          ``aio``
> -            Specifies the AIO backend (threads/native, default: threads)
> +            Specifies the AIO backend (threads/native/io_uring,
> +            default: threads)
>
>          ``locking``
>              Specifies whether the image file is protected with Linux OFD
> @@ -1175,7 +1176,8 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
>      "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
>      "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
>      "       [,snapshot=on|off][,rerror=ignore|stop|report]\n"
> -    "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
> +    "       [,werror=ignore|stop|report|enospc][,id=name]\n"
> +    "       [,aio=threads|native|io_uring]\n"
>      "       [,readonly=on|off][,copy-on-read=on|off]\n"
>      "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
>      "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
> @@ -1247,8 +1249,8 @@ SRST
>          The default mode is ``cache=writeback``.
>
>      ``aio=aio``
> -        aio is "threads", or "native" and selects between pthread based
> -        disk I/O and native Linux AIO.
> +        aio is "threads", "native", or "io_uring" and selects between pthread
> +        based disk I/O, native Linux AIO, or Linux io_uring API.
>
>      ``format=format``
>          Specify which disk format will be used rather than detecting the
> --
> 2.26.2
>


