Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10B4206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5FoF4Qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10B4206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDhp-0004eQ-WE
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleksandr@redhat.com>)
 id 1jZ8e1-00057e-Ap
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:51:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <oleksandr@redhat.com>)
 id 1jZ8dy-00019i-GT
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589442661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kePBhhoxADCW6v1tC2y/RCtulkfJ6Wv+KsUt8s3aYOk=;
 b=f5FoF4Qszv3rJrlYu/M10LVqwSn1h5u/qlewsvLv9PwEi8QsBcTPqGFC2rNFFWH79Cuxwh
 aeLZ2KlbByEXR51pUuVGiaKOVCtfgdUqx4emO0tYJ3+6mI2gwy+mEE2THYr7CMwn7dR20R
 vAA93oRDcNKsS2wZup5iKMClbTWvqV0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-qlW2A-nwNAaDZjg3J8aiSw-1; Thu, 14 May 2020 03:49:39 -0400
X-MC-Unique: qlW2A-nwNAaDZjg3J8aiSw-1
Received: by mail-wm1-f71.google.com with SMTP id n66so2983147wme.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kePBhhoxADCW6v1tC2y/RCtulkfJ6Wv+KsUt8s3aYOk=;
 b=NaQ6wB+2xx2X8l/mKjMl7MxFiCI/B2T3p/raMTh5TNMzMPqAKO3QneGjFdrDf7t3XS
 nb1XenPHBoy8bM7hNRzC3igPpuopvz2bbEUSG9eRB5iAJUAUotFoP+fRT0ub7YAYtYN1
 wGjfuO2xFhiG2O8xzLlS7M/gK7Mg7iWM5YSXmpJSw47O0er1Kfg6cltRzwamyTNfbLhT
 kAxHJQUsUs4G/s8RfyrMMXkuuQ5GwyaldcBV8loZOrBWCH5mKC+J+pANaOkofM98Yycf
 09nI7u1+rpIqWyYppxwi5Ll9Cvg7venxcQQztJksZv2dr2D5Z4ZmYee3lrUnnNxGoFw7
 tQUQ==
X-Gm-Message-State: AOAM533AGg+cbyCugFMjhTAgURVsfE1wBby9YLfaY0jZVLtr9KLXqARt
 vZDeqfkfRwUGB16vxhjwh5JBucwi5t4+K/rHfkpLMTDy9I2Hs3f6uX5lLDCjedW6KpHUtW3lgeh
 CabzONuMS31XzExk=
X-Received: by 2002:adf:8401:: with SMTP id 1mr3936551wrf.241.1589442577832;
 Thu, 14 May 2020 00:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxTxlBIXQHEKqzvOXpBapO0pCJhj+/bAM22wkTcw2X8JjfEcjKXsGt8Y6p9DzbJc5TGO9VtA==
X-Received: by 2002:adf:8401:: with SMTP id 1mr3936533wrf.241.1589442577625;
 Thu, 14 May 2020 00:49:37 -0700 (PDT)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
 by smtp.gmail.com with ESMTPSA id m82sm28350532wmf.3.2020.05.14.00.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 00:49:36 -0700 (PDT)
Date: Thu, 14 May 2020 09:49:35 +0200
From: Oleksandr Natalenko <oleksandr@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] aio-posix: disable fdmon-io_uring when GSource is used
Message-ID: <20200514074935.przvh6coztf6fklj@butterfly.localdomain>
References: <20200511183630.279750-1-stefanha@redhat.com>
 <20200511183630.279750-3-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200511183630.279750-3-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=oleksandr@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 May 2020 09:13:25 -0400
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 07:36:30PM +0100, Stefan Hajnoczi wrote:
> The glib event loop does not call fdmon_io_uring_wait() so fd handlers
> waiting to be submitted build up in the list. There is no benefit is
> using io_uring when the glib GSource is being used, so disable it
> instead of implementing a more complex fix.
> 
> This fixes a memory leak where AioHandlers would build up and increasing
> amounts of CPU time were spent iterating them in aio_pending(). The
> symptom is that guests become slow when QEMU is built with io_uring
> support.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1877716
> Fixes: 73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4ccf ("aio-posix: add io_uring fd monitoring implementation")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h |  3 +++
>  util/aio-posix.c    | 12 ++++++++++++
>  util/aio-win32.c    |  4 ++++
>  util/async.c        |  1 +
>  4 files changed, 20 insertions(+)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 62ed954344..b2f703fa3f 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -701,6 +701,9 @@ void aio_context_setup(AioContext *ctx);
>   */
>  void aio_context_destroy(AioContext *ctx);
>  
> +/* Used internally, do not call outside AioContext code */
> +void aio_context_use_g_source(AioContext *ctx);
> +
>  /**
>   * aio_context_set_poll_params:
>   * @ctx: the aio context
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 8af334ab19..1b2a3af65b 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -682,6 +682,18 @@ void aio_context_destroy(AioContext *ctx)
>      aio_free_deleted_handlers(ctx);
>  }
>  
> +void aio_context_use_g_source(AioContext *ctx)
> +{
> +    /*
> +     * Disable io_uring when the glib main loop is used because it doesn't
> +     * support mixed glib/aio_poll() usage. It relies on aio_poll() being
> +     * called regularly so that changes to the monitored file descriptors are
> +     * submitted, otherwise a list of pending fd handlers builds up.
> +     */
> +    fdmon_io_uring_destroy(ctx);
> +    aio_free_deleted_handlers(ctx);
> +}
> +
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>                                   int64_t grow, int64_t shrink, Error **errp)
>  {
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index 729d533faf..953c56ab48 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -414,6 +414,10 @@ void aio_context_destroy(AioContext *ctx)
>  {
>  }
>  
> +void aio_context_use_g_source(AioContext *ctx)
> +{
> +}
> +
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>                                   int64_t grow, int64_t shrink, Error **errp)
>  {
> diff --git a/util/async.c b/util/async.c
> index 3165a28f2f..1319eee3bc 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -362,6 +362,7 @@ static GSourceFuncs aio_source_funcs = {
>  
>  GSource *aio_get_g_source(AioContext *ctx)
>  {
> +    aio_context_use_g_source(ctx);
>      g_source_ref(&ctx->source);
>      return &ctx->source;
>  }

Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>

(run Windows 10 VM with storage accessible via io_uring on qemu v5.0.0
with these 2 patches)

Thank you.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer


