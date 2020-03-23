Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D55C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9054F2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuooSzc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9054F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKNc-0006iC-MH
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGKMA-0005DT-8u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGKM8-0004wu-9L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:53 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGKM8-0004wV-3V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:52 -0400
Received: by mail-oi1-x241.google.com with SMTP id r7so14283887oij.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TxV1bllHGMDtSULJerTixPBu/ImXQfX3UQSx7CB+vBk=;
 b=FuooSzc8TzNI/+Dgo3+9yoBiUt4qQOym+TB5D2PVP0Xq9z5nG4JIuaSSbfz8UYXPTq
 nYLBITvz7suyxm7+/3xD2YS9C5qUj2df3LWMvGPib+x0I4bDO1a8QCOTkUPilLG/Kvu3
 eElTEMCkJxGpZcSMflMDvmnQz3oBbup52jG0r13yrnqPrqFcdsHW9v6jxpefWjug+Z3a
 UP+/FXose/ztgjLxEn6lQKlsOsRvGcYTSIoc2Q7QS8w0/ADHq22KcFUkNxf49w8s0hfB
 WvMwFG0GQuyHqJPlNFZUhLJwJxAFb/9DkBNl2RFtR+qDvLMGBye7xRkHE0k1NTIrRbqA
 SpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TxV1bllHGMDtSULJerTixPBu/ImXQfX3UQSx7CB+vBk=;
 b=otlMXKez4CUz2SXbn0stNTDGAqYvNLtM7pWrv2NJVlByf9dAmrGp7GijA76LE5+4Ip
 WEAdCn80xdo68K680YgqWin4kHLWCqlw4J4hIos1xHohT2XZOV8fn2iDfSW/TwH0xGCU
 1uG70X84POJJozHF/LKqhHZCRjVoRBlbhvVp86GYqaD2zGWKnkeWvbwlk1j5nF9pOulK
 g3WQURQK4GC6/QCbfuL6dw56TIF4Z2yGtdvM9a8ECg26CrvX5p4DO8GtnkJhpMaFtzz1
 8hyPcnHORbUI528m0vlDtJnMPt02LDZktAAKtsnzwIIyuHUfR0mmu6fq1cAKggMzrdvP
 tFMw==
X-Gm-Message-State: ANhLgQ37Gm739Ync0OBgRxvV4fvUkyFZwLtNMyz8FX/f5VPmXB6zfdIr
 Bsy6IG4mC7w1Hj5Jil9EWG9V9d2B2kNnzqe7Mwkzjg==
X-Google-Smtp-Source: ADFU+vssP6QiP7VmDZbV8L2+viS9+3vHlPUcmTXnjfGiwwOf5b7ZSNsNy033IWXic0MO9yQNgZueVlKz/5cYLXotjwI=
X-Received: by 2002:a54:4614:: with SMTP id p20mr1949510oip.48.1584959451236; 
 Mon, 23 Mar 2020 03:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190310084610.23077-1-yuval.shaia@oracle.com>
 <20190310084610.23077-8-yuval.shaia@oracle.com>
In-Reply-To: <20190310084610.23077-8-yuval.shaia@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 10:30:40 +0000
Message-ID: <CAFEAcA86hGnX5MfZjzfR0486qNOXfLmC+YSfc7GOc7d9jakrFQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/10] hw/rdma: Free all receive buffers
 when QP is destroyed
To: Yuval Shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 10 Mar 2019 at 09:25, Yuval Shaia <yuval.shaia@oracle.com> wrote:
>
> When QP is destroyed the backend QP is destroyed as well. This ensures
> we clean all received buffer we posted to it.
> However, a contexts of these buffers are still remain in the device.
> Fix it by maintaining a list of buffer's context and free them when QP
> is destroyed.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Hi; Coverity has just raised an issue on this code (CID 1421951):

> diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
> index 0a8abe572d..73f279104c 100644
> --- a/hw/rdma/rdma_utils.c
> +++ b/hw/rdma/rdma_utils.c
> @@ -90,3 +90,32 @@ int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)
>
>      return qnum_get_uint(qobject_to(QNum, obj));
>  }
> +
> +void rdma_protected_gslist_init(RdmaProtectedGSList *list)
> +{
> +    qemu_mutex_init(&list->lock);
> +}
> +
> +void rdma_protected_gslist_destroy(RdmaProtectedGSList *list)
> +{
> +    if (list->list) {
> +        g_slist_free(list->list);
> +        list->list = NULL;
> +    }

Coverity wonders whether this function should take the list->lock
before freeing the list, because the other places which manipulate
list->list take the lock.

> +}

This is one of those Coverity checks which is quite prone to
false positives because it's just heuristically saying "you
look like you take the lock when you modify this field elsewhere,
maybe this place should take the lock too". Does this function
need to take a lock, or does the code that uses it guarantee
that it's never possible for another thread to be running
with access to the structure once we decide to destroy it?

thanks
-- PMM

