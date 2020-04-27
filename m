Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155FC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2F02064C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViMJVQ8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2F02064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT69m-0005nl-LH
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jT68w-0004Yg-80
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jT68v-00020L-Pr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:58:02 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jT68v-0001zp-D2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:58:01 -0400
Received: by mail-il1-x143.google.com with SMTP id c18so1909785ile.5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3WUokp9L9797lNc9geL3wYxOPsZwLiVLmWg3B3HLIZg=;
 b=ViMJVQ8xKNlOKq3JBmMIxN3esoTAFMrONe0dr2j0ErKce5UKBq13OG4dxICG9AOPD2
 j3j4K1UYq2VcCGCpiuIdO6Yi0fZcTmj1L32VY53YmYuaVfwniA6/c/Z4hUZmbxRZ7nCd
 zK1OGjr7CpWeQtHWwEihuaAP+lNHeI32nVuz2AkdcP6J7wLVqU4rn9+Cv3zv/IFwIKBa
 uY0qLKsCQK7BbKBkI8c19omsC5bewDIsUMnpfDLGMlyR2K9UWAfbHDb/jNxDKm/bcqBC
 b1dn/0XAGAv8VvGiRPyZe6wz7HFLw0TPptdDMXjAOwEu5oqwADO3NFE217sfJEfiSmUD
 dHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3WUokp9L9797lNc9geL3wYxOPsZwLiVLmWg3B3HLIZg=;
 b=cmqoD6r04Z9wNmAKLVt46A+Edy3zBtMoMz9nzOZPvuwjmYcJjvURkiEyBNtQc4Jvbi
 aEiF5j3CDYpKt70ElD3km2GIgmzga1K5RxkB4678gCwQsti5/rspyc1BBz6KhgsUgZlL
 sl99FSiPz2z+reD/FZc5nX99SAmhSw5vWEvB2GKfJHvJdIqLhbiPF9bcbRmydg/FjEsk
 bxvpIupgH/R7aN98Z8Jaig0dTbMJf7egEcVP8PCZ5TBm/H5HETws+enqI5iXKYQKdU4y
 kuXvZ4V2OEZ9vZc+1+n2SUTR+6nvpySpNlUwQqgE/xMwpzphY94EuvwepsN4QnRuuBjP
 qnZw==
X-Gm-Message-State: AGi0PuYn0vcglr35tGAYeXmXkRnjW5qQV9BJhTk8e6pjrDRO1XLZsI7R
 5uoRJEGAvazq9xI5ZatxdvUVt7h0/v9AsPZwSag=
X-Google-Smtp-Source: APiQypLqIoL6RcVVQ4t0XCeo0TiRDdx5TsCCZqw3NinFRfiuJhFjxGuSDnGuhBOat9k544FbHHVa1jmttrlkJwuurGM=
X-Received: by 2002:a92:3dd5:: with SMTP id k82mr19869763ilf.237.1588003080226; 
 Mon, 27 Apr 2020 08:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200424164239.10723.58352.stgit@localhost.localdomain>
 <20200424165021.10723.14111.stgit@localhost.localdomain>
 <7ce2bcde-7466-2764-7248-36f67bb9b573@redhat.com>
 <CAKgT0Uckr4uN=WCvGtp5GtXRZjfR+x1BR7L5b=RvnT7CHwtsMw@mail.gmail.com>
 <829a7d06-d5f4-1d82-32b9-744603288d84@redhat.com>
In-Reply-To: <829a7d06-d5f4-1d82-32b9-744603288d84@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 27 Apr 2020 08:57:49 -0700
Message-ID: <CAKgT0Ud2wbG_qRw2PXuz1E45DTT-NWQgVf=155172RPSf84joA@mail.gmail.com>
Subject: Re: [PATCH v22 QEMU 3/5] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 8:11 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 27.04.20 17:08, Alexander Duyck wrote:
> > On Mon, Apr 27, 2020 at 1:15 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> There is only one wrong comment remaining I think. Something like
> >>
> >> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >> index a1d6fb52c8..1b2127c04c 100644
> >> --- a/hw/virtio/virtio-balloon.c
> >> +++ b/hw/virtio/virtio-balloon.c
> >> @@ -554,8 +554,8 @@ static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
> >>           */
> >>          qemu_mutex_lock(&s->free_page_lock);
> >>          /*
> >> -         * The guest hasn't done the reporting, so host sends a notification
> >> -         * to the guest to actively stop the reporting.
> >> +         * The guest isn't done with hinting, so the host sends a notification
> >> +         * to the guest to actively stop the hinting.
> >
> > I'll probably tweak it slightly and drop the "with". So the comment will read:
> >         /*
> >          * The guest isn't done hinting, so host sends a notification
>
> I always feel like "so host sends" sounds wrong ("the host"). But I am
> not a native speaker.

Actually it might read better to get rid of "the host" entirely to
make it more of an imperative statement rather than a declarative one.
Maybe something more like:
        /*
         * The guest isn't done hinting, so send a notification
         * to the guest to actively stop the hinting.
         */

