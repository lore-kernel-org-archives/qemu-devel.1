Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD11C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB4121D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq3e+6uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB4121D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSVVw-00013t-Q5
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 21:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSVVK-0000d2-Cb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 21:22:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSVVI-0001SV-Lw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 21:22:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id m13so1919900otl.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=obVlzmUdwfQKs2rpVyj7mlBFItdCGXzomyiBXyKdMCc=;
 b=aq3e+6ukLsogS9aPaXnrTqIRv55oidGWxPR8iglI14pZrLp1DNg818RCbpnbYE5n0+
 JqvY4XqMHBWTODHJJStr3dEWOWUQRMKzJyzJjxj5MKTMS1GYAW0ipcoTXpcw+GABX5vb
 +MtHWJmfUgzP5+1SDu0ttgJw/5PR2WNvrIdQRFr+Kux52CvMc13smrvTuPpwRDd+PYRg
 BbJTCaM7TgdbJbGNaaOWieJqIgm2zW4bxijodfqak7QqlBtxutr4Ve1+hQraWCRPSv5b
 Uq15gDNpwMJDoTkpRsvVzAzFj+6gtAmYXoc6eoutSLqEL2D/7KHG47pUbpetrcHFoj4a
 6cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=obVlzmUdwfQKs2rpVyj7mlBFItdCGXzomyiBXyKdMCc=;
 b=cMvJ6lWnuNewM11fh00vSrchKxGkPstQIq8uIUhwSHfm9YLbhlpXzav+OukmlECaXF
 XsC3QNT5VzULvxtBwm0hKM+/akrb0omg85azsivDZYOnZUQP+fQhiKo9TMpSFonIsCmW
 ySnf5cLY9tNK8YZFndARohKkc3YqgUmdQBasrwJX35BfwYVvqgLj37eTpWqXxTSVVHxo
 ppydg2FneEb+0RR9yfMkyUcfN8pBD+sSLy9XE8wpoaXl5XbKIkT+w8tCUzeUHEjSDNKD
 0vdti1lPb8/eYZjLsDty8OHT+u1Eyd9Al2wYRQBxii4CUzThABDw0GeD6PpaXj/4Z6lz
 nkbA==
X-Gm-Message-State: AOAM532ukkOcsjTsLstDXVWRD7on+o7EdJGCldtAa+WWJoCk3y1L0EfI
 Pa9b8v5s4q96PsmbBDg2GcxVf+XnmHTolPUcVKE=
X-Google-Smtp-Source: ABdhPJxA0puoJaCBCkvANDc+qHsggG7fZ15gW1UJoasdqkkkpHyvCaAMWMzKbupGtyTucdcNyhQUMZk4dMB4EFLxz9Y=
X-Received: by 2002:a05:6830:1201:: with SMTP id
 r1mr1664108otp.326.1602638575392; 
 Tue, 13 Oct 2020 18:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131731.69684-1-chenjiajun8@huawei.com>
 <CAFubqFs1Vac2xQspDBF5M1oxCH0O9jEhjPj5g0CD6RSHrqwEiQ@mail.gmail.com>
 <1125cff0-29da-3f3d-5f6f-490f485418fe@huawei.com>
In-Reply-To: <1125cff0-29da-3f3d-5f6f-490f485418fe@huawei.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 13 Oct 2020 21:22:44 -0400
Message-ID: <CAFubqFsN9K0aOXFfPi6NnijbDoCvGG7FSW1c2EaWTcwqCymyNw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
To: chenjiajun <chenjiajun8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, QEMU <qemu-devel@nongnu.org>, xiexiangyou@huawei.com,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 7:12 AM chenjiajun <chenjiajun8@huawei.com> wrote:
>
>
>
> On 2020/10/2 10:05, Raphael Norwitz wrote:
> > On Mon, Sep 28, 2020 at 9:17 AM Jiajun Chen <chenjiajun8@huawei.com> wrote:
> >>
> >> Used_memslots is equal to dev->mem->nregions now, it is true for
> >> vhost kernel, but not for vhost user, which uses the memory regions
> >> that have file descriptor. In fact, not all of the memory regions
> >> have file descriptor.
> >> It is usefully in some scenarios, e.g. used_memslots is 8, and only
> >> 5 memory slots can be used by vhost user, it is failed to hot plug
> >> a new memory RAM because vhost_has_free_slot just returned false,
> >> but we can hot plug it safely in fact.
> >>
> >> --
> >> ChangeList:
> >> v3:
> >> -make used_memslots a member of struct vhost_dev instead of a global static value
> >>
> >> v2:
> >> -eliminating useless used_memslots_exceeded variable and used_memslots_is_exceeded() API
> >>
> >> v1:
> >> -vhost-user: add separate memslot counter for vhost-user
> >>
> >> Signed-off-by: Jiajun Chen <chenjiajun8@huawei.com>
> >> Signed-off-by: Jianjay Zhou <jianjay.zhou@huawei.com>
> >
> > I'm happy with this from a vhost/vhost-user perspective. vhost-backend
> > change looks good too. I'm a little confused by what's going on with
> > net/vhost-user.c.
> >
> >> ---
> >>  hw/virtio/vhost-backend.c         | 12 ++++++++++
> >>  hw/virtio/vhost-user.c            | 25 +++++++++++++++++++++
> >>  hw/virtio/vhost.c                 | 37 +++++++++++++++++++++++--------
> >>  include/hw/virtio/vhost-backend.h |  5 +++++
> >>  include/hw/virtio/vhost.h         |  1 +
> >>  net/vhost-user.c                  |  7 ++++++
> >>  6 files changed, 78 insertions(+), 9 deletions(-)
> >>
> >
> >> diff --git a/net/vhost-user.c b/net/vhost-user.c
> >> index 17532daaf3..7e93955537 100644
> >> --- a/net/vhost-user.c
> >> +++ b/net/vhost-user.c
> >> @@ -20,6 +20,7 @@
> >>  #include "qemu/error-report.h"
> >>  #include "qemu/option.h"
> >>  #include "trace.h"
> >> +#include "include/hw/virtio/vhost.h"
> >>
> >>  typedef struct NetVhostUserState {
> >>      NetClientState nc;
> >> @@ -347,6 +348,12 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
> >>          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> >>                                   net_vhost_user_event, NULL, nc0->name, NULL,
> >>                                   true);
> >
> > Can you elaborate on this check here? What does it have to do with
> > fixing memslots accounting? Maybe it should be in a separate change?
> >
> When the number of virtual machine memslots exceeds the upper limit of the back-end support,
> QEMU main thread may enters an endless loop and cannot process other requests.
> And number of memslots will not automatically decrease, so add a check here to exit from loop
> in this scenario. For the newly started virtual machine, boot fails; for the hot plug network card,
> hot plug fails.

I don't understand what you mean by "number of memslots will not
automatically decrease". Where did this happen before and what changes
when the new memslots counter is introduced?

> >> +
> >> +        if (!vhost_has_free_slot()) {
> >> +            error_report("used memslots exceeded the backend limit, quit "
> >> +                         "loop");
> >> +            goto err;
> >> +        }
> >>      } while (!s->started);
> >>
> >>      assert(s->vhost_net);
> >> --
> >> 2.27.0.dirty
> >>
> > .
> >

