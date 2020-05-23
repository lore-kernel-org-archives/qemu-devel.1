Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ECDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B8A20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="POYs+yCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B8A20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcaWU-0000P7-9X
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 16:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcaVm-0008L2-7D
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:12:50 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcaVk-0001Ii-Pu
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:12:49 -0400
Received: by mail-qt1-x842.google.com with SMTP id z18so11158834qto.2
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vhVBZEuf24aUiYCSCDF+fPwKgYeYDEVSL4wZWgyiOOU=;
 b=POYs+yCpUomvXYSBgsnds6tLLho1fCA/wdhlsOnplPli7aY3lEJ0/U3guMtw0L4F1A
 XqF1MCljZVlouDoR/ZZXy0WlUvPo4uvEefItnwLnv2hVCVD0AegKE+u2HL9mCO6V5yp6
 R/ughoLHdGrJctFuEXjTgyZ03nLdP21Gz4gXJ9DXz6yV7wZaqwopkEo97fQWnlIz33NN
 0FzecvKWPhv+MMOIUb18IslmO6r6picXm9J9aDiYn2bEEME+ErLPw//4AKmmOTmky+eJ
 WO3+jbyYufYBXlTnCLNnxPZpWt7ba2k0KIbVCi5gDvRgS0o+iOS454tSHsj9n57vRIlw
 VvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vhVBZEuf24aUiYCSCDF+fPwKgYeYDEVSL4wZWgyiOOU=;
 b=EwxUCBW/alHbC7vIQtEW8RnqFhfkxWJJV4HGVieOg7B9EWha2e4cfAxF/copLHl3mN
 ZlZOmiw4xnWa+pnvyrzvjOaO9qFfJikqLbTUfP13WGU5b3UCIojG3nefEx3rpRr/KrPh
 mSzBLlMaVAOQtmVEU31OTbGfUmrLEJacLq9Q58hlkRdOrfOY6okT3ugaBxXfpbqC8PW/
 XkXMwKiExQnf66xhiv4TJMM2t0OVuDoI2pP2pmYUKoFeokt/xHqggwnCh60vmKK/X7i0
 lXmY1vAUO2Dl6TgYIXGGGDkrLt002951VqI+mbkairqaXFPw/aisN4PDFaYKd7bI0Iha
 5L5Q==
X-Gm-Message-State: AOAM53207wp1PzBGADuh8dfWfM74CUCbZ4SHoTJT0OmM3kBw9mozu65g
 6SkyUPyaCBfeVatJmI9hW0WKSw==
X-Google-Smtp-Source: ABdhPJznRNLD0TK9blQ2SPhfz5pYF5nVxdMpK9DzzJBmSguLZX6m19SCVyLxQAb77IPxN+9kNeGOHA==
X-Received: by 2002:ac8:7345:: with SMTP id q5mr13298994qtp.180.1590264767698; 
 Sat, 23 May 2020 13:12:47 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id c197sm10711181qkg.133.2020.05.23.13.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 13:12:46 -0700 (PDT)
Date: Sat, 23 May 2020 16:12:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 14/19] util/async: Fixed tsan warnings
Message-ID: <20200523201246.GF382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-15-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160755.886-15-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::842;
 envelope-from=cota@braap.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 12:07:50 -0400, Robert Foley wrote:
> For example:
>   Atomic write of size 8 at 0x7b4800113c28 by main thread (mutexes: write M30):
>     #0 __tsan_atomic64_exchange <null> (qemu-system-aarch64+0x386f85)
>     #1 aio_bh_poll util/async.c:146:5 (qemu-system-aarch64+0xcd1f61)
>     #2 aio_dispatch util/aio-posix.c:380:5 (qemu-system-aarch64+0xcd8abb)
>     #3 aio_ctx_dispatch util/async.c:298:5 (qemu-system-aarch64+0xcd31b0)
>     #4 g_main_context_dispatch <null> (libglib-2.0.so.0+0x4c416)
>     #5 qemu_main_loop softmmu/vl.c:1664:9 (qemu-system-aarch64+0x5cc6d6)
>     #6 main softmmu/main.c:49:5 (qemu-system-aarch64+0xc62857)
> 
>   Previous read of size 8 at 0x7b4800113c28 by thread T3 (mutexes: write M81):
>     #0 aio_bh_enqueue util/async.c:81:9 (qemu-system-aarch64+0xcd2267)
>     #1 qemu_bh_schedule util/async.c:181:5 (qemu-system-aarch64+0xcd2267)
>     #2 worker_thread util/thread-pool.c:113:9 (qemu-system-aarch64+0xcd473c)
>     #3 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xcde280)
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  util/async.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/util/async.c b/util/async.c
> index 1319eee3bc..51e306bf0c 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -33,6 +33,7 @@
>  #include "block/raw-aio.h"
>  #include "qemu/coroutine_int.h"
>  #include "trace.h"
> +#include "qemu/tsan.h"
>  
>  /***********************************************************/
>  /* bottom halves (can be seen as timers which expire ASAP) */
> @@ -76,10 +77,12 @@ static void aio_bh_enqueue(QEMUBH *bh, unsigned new_flags)
>       * 2. ctx is loaded before the callback has a chance to execute and bh
>       *    could be freed.
>       */
> +    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();

Why do we need these annotations here? It looks like the fix for the
race in the commit message is below (i.e. atomic_read).

In general, I'd expect annotations to come with a comment, since
they should be used sparingly. That is, the assumption is that
tsan is almost always right.

>      old_flags = atomic_fetch_or(&bh->flags, BH_PENDING | new_flags);
>      if (!(old_flags & BH_PENDING)) {
>          QSLIST_INSERT_HEAD_ATOMIC(&ctx->bh_list, bh, next);
>      }
> +    TSAN_ANNOTATE_IGNORE_WRITES_END();
>  
>      aio_notify(ctx);
>  }
> @@ -143,7 +146,9 @@ int aio_bh_poll(AioContext *ctx)
>      BHListSlice *s;
>      int ret = 0;
>  
> +    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
>      QSLIST_MOVE_ATOMIC(&slice.bh_list, &ctx->bh_list);
> +    TSAN_ANNOTATE_IGNORE_WRITES_END();

ditto

>      QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
>  
>      while ((s = QSIMPLEQ_FIRST(&ctx->bh_slice_list))) {
> @@ -280,14 +285,16 @@ aio_ctx_check(GSource *source)
>      aio_notify_accept(ctx);
>  
>      QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
> -        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
> +        if ((atomic_read(&bh->flags) & (BH_SCHEDULED | BH_DELETED))
> +             == BH_SCHEDULED) {
>              return true;
>          }
>      }
>  
>      QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
>          QSLIST_FOREACH_RCU(bh, &s->bh_list, next) {
> -            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
> +            if ((atomic_read(&bh->flags) & (BH_SCHEDULED | BH_DELETED))
> +                 == BH_SCHEDULED) {

This hunk like the real fix. Also, I'd put "fix race" in the commit
title as opposed to "fix warning" since fixing races is the goal, not
fixing warnings.

Thanks,

		Emilio

