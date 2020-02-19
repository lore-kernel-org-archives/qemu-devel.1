Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5CAC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164CC208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYw87kAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164CC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4NFW-0005vB-6j
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4NEr-0005U0-FP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4NEp-0000FL-21
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:09:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4NEo-0000Eq-Sw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582110594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBvN0hJPv+LELJR3Hr5y6jxEG/k/t5AiIzROdPPskBg=;
 b=VYw87kAucN0Az51eeIOrHycUbew7DG2sDojSBvYvRuJNmJmKO9juQjxCi38jQrHQJ7p9dT
 BBs6b/oOROYTzfS3tTeOoEEOBJ1DOgPJT0ZFWLG7MFV3WWu5qi6vZo3lr7mnNuko94y9Ij
 Gh86ybg6/UranPznMVG4h9lnynYk77w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-YNWi2asiMTuyJLmg-XQXUw-1; Wed, 19 Feb 2020 06:09:50 -0500
Received: by mail-wm1-f70.google.com with SMTP id 7so27741wmf.9
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 03:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VBvN0hJPv+LELJR3Hr5y6jxEG/k/t5AiIzROdPPskBg=;
 b=JY/bkWgxipR6jF7aQwjiJzVPf58CuPwiYeEcAwokAxbS/UdD/vJCRBeznvVWQ9IfXS
 4C1ZcSk+3Uj0Ld6H9+iM2Mz5hsdf+YoDgMEDOPUqNa28xXFnUuubxf7Scr1DV6CZrtCa
 cGT1Lagde7MUo+m0JX+250bKziJ9ww9+twy/q+Q7pmybdFI/5h8ejL7u6QDGAHvv80Fj
 6ibxw8uvpuCzknKN6QSQv7kFQ7iP1e/JRa/sN4d0xyGD7d67sCseC/veMkYhxQLPvikY
 +AhXJbTwoco7LEfQHVUI6OaswexFVga13AvzhUqmb4NQyg8phQ3xYIMJiNsK0wqf4hsY
 KJMQ==
X-Gm-Message-State: APjAAAUz6b2V5g4XvaCy298DxXALoatOrCTdMxSRjtkF6J/EIzTwexk8
 dxyVbMWmTYHbKKfAaLg3C2a0aBLm0VOf31TtAjpYkD8GIvkJPYnoXHnL/DqTEBrayUKaAGIGKQw
 tvqM/eyLP8Hbmtas=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr6742714wmc.39.1582110589236; 
 Wed, 19 Feb 2020 03:09:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzo4q+FCV1FeBulP7iQ6pEpbeqwrK7QKPFDy4rCkSIW7V5BqkMqqpe/fSEDxNgMFxRI/X3aLg==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr6742675wmc.39.1582110588903; 
 Wed, 19 Feb 2020 03:09:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51?
 ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
 by smtp.gmail.com with ESMTPSA id j5sm2510302wrw.24.2020.02.19.03.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 03:09:48 -0800 (PST)
Subject: Re: [PATCH] util/async: make bh_aio_poll() O(1)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200219100045.1074381-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad80faf5-7e77-739e-36d7-8d88101b9d59@redhat.com>
Date: Wed, 19 Feb 2020 12:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200219100045.1074381-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: YNWi2asiMTuyJLmg-XQXUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Really a great idea, though I have some remarks on the implementation below.

On 19/02/20 11:00, Stefan Hajnoczi wrote:
> + * Each aio_bh_poll() call carves off a slice of the BH list.  This way newly
> + * scheduled BHs are not processed until the next aio_bh_poll() call.  This
> + * concept extends to nested aio_bh_poll() calls because slices are chained
> + * together.

This is the tricky part so I would expand a bit on why it's needed:

/*
 * Each aio_bh_poll() call carves off a slice of the BH list, so that
 * newly scheduled BHs are not processed until the next aio_bh_poll()
 * call.  All active aio_bh_poll() calls chained their slices together
 * in a list, so that nested aio_bh_poll() calls process all scheduled
 * bottom halves.
 */

> +struct BHListSlice {
> +    QEMUBH *first_bh;
> +    BHListSlice *next;
> +};
> +

Using QLIST and QSLIST removes the need to create your own lists, since
you can use QSLIST_MOVE_ATOMIC and QSLIST_INSERT_HEAD_ATOMIC.  For example:

struct BHListSlice {
    QSLIST_HEAD(, QEMUBH) first_bh;
    QLIST_ENTRY(BHListSlice) next;
};

...

    QSLIST_HEAD(, QEMUBH) active_bh;
    QLIST_HEAD(, BHListSlice) bh_list;

Related to this, in the aio_bh_poll() loop:

    for (s = ctx->bh_list.next; s; s = s->next) {
    }

You can actually do the removal inside the loop.  This is slightly more
efficient since you can remove slices early from the nested
aio_bh_poll().  Not that it's relevant for performance, but I think the
FIFO order for slices is also more intuitive than LIFO.

Putting this idea together with the QLIST one, you would get:

    /*
     * If a bottom half causes a recursive call, this slice will be
     * removed by the nested aio_bh_poll().
     */
    QSLIST_MOVE_ATOMIC(&slice.first_bh, ctx->active_bh);
    QLIST_INSERT_TAIL(&ctx->bh_list, slice);
    while ((s = QLIST_FIRST(&ctx->bh_list)) {
        while ((bh = aio_bh_dequeue(&s, &flags))) {
        }
        QLIST_REMOVE_HEAD(s, next);
    }

>  /* Multiple occurrences of aio_bh_poll cannot be called concurrently.
>   * The count in ctx->list_lock is incremented before the call, and is
>   * not affected by the call.

The second sentence is now stale.

Paolo

>   */
>  int aio_bh_poll(AioContext *ctx)
>  {
> -    QEMUBH *bh, **bhp, *next;
> +    BHListSlice slice;
> +    BHListSlice **old_tail;
> +    BHListSlice *s;
> +    QEMUBH *bh;
> +    unsigned flags;
>      int ret;
> -    bool deleted = false;
> +
> +    old_tail = push_bh_list_slice(ctx, &slice);
>  


