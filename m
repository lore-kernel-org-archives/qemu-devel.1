Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA679C433F2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C80207BB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4I8nzZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C80207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04V9-0007JQ-NA
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04Ub-0006oI-1K
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:52:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30402
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04UZ-0004JK-Bh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595861558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+Zqe46IqBSR+ZLX0XYafA2uSNHALh4ak8QDNk1Luu8=;
 b=d4I8nzZ7aO/hQsaPYvC9vZVM5zkBT59zmhz/WUNi/1+FRVDqADpiyPKzqZUbtuKhSSvMB8
 CkNhG9Hwn2V2k+bZcQIpDXa61r2KEK+Hue8t0isXhdbaf3ylRanK39ACvJY/QF4eYW0Lg7
 pMeXoyLsg36usYIIxAD8TKiq9Uf8ZPc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-6aUaP_cXOvKdykuEcdJ29g-1; Mon, 27 Jul 2020 10:52:36 -0400
X-MC-Unique: 6aUaP_cXOvKdykuEcdJ29g-1
Received: by mail-ot1-f71.google.com with SMTP id i4so6850468otr.22
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z+Zqe46IqBSR+ZLX0XYafA2uSNHALh4ak8QDNk1Luu8=;
 b=MujQl8gpCA/buDskVHrglbKmvZ3xk/vuq4/DxIujhHGbaBHYdG4Eoj0MWGVLkZaQj/
 1zRoSQR7il2/+Kkq8a120DJawn8nBg4kmujOo7A/v60wc/MaR476Zp9T+OMXDEOScko4
 V31gzgS9OloJ/stfGP3v+SIYPYHRGOYXlsnY0w/yJbyhchpNiNu6mXjw9m4xfC4YbTVg
 5bXQY33nvzob1Ldr76bcI2XcSdkF+n8rMfaMD1HX6NuV5Z8GvjKYowxg3kgwQ/6AG73H
 /qHJGgx9QqnGnYgZbIAXIPmU/rkOZ6qlLsR0uPbcJmLNSexPjmBPmCye5ucXeaFHuFZp
 aeGg==
X-Gm-Message-State: AOAM533MdzjuTFFWMffvhh/zxW0iVcFAz6KrfAkdTUQMSiNQz0qi1p6O
 XpgTTqrG4dHfPo9xl4EwH5eS3IEzRHxoZXqW7LM3Ao2jsyEMBczrI9kVgsqJJ6bgs84+8CYfHSV
 6iXZS+jBnoW/uzH8qirFAATlAhcRMyZo=
X-Received: by 2002:a54:4403:: with SMTP id k3mr19080709oiw.16.1595861555418; 
 Mon, 27 Jul 2020 07:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLnvTEJqm406x89SjrcCFtpwM0ZLwKIfpSK5aPUR6/I038MiNhrVqcWEeDzz+00NaMBP+JgjZcrPZfkOX+XyA=
X-Received: by 2002:a54:4403:: with SMTP id k3mr19080688oiw.16.1595861555149; 
 Mon, 27 Jul 2020 07:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-2-nsoffer@redhat.com>
 <1737bdc4-6192-1adb-7027-faf09bdbd92c@redhat.com>
In-Reply-To: <1737bdc4-6192-1adb-7027-faf09bdbd92c@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 27 Jul 2020 17:52:19 +0300
Message-ID: <CAMRbyyt=ryEoxaRzsWaC=1BuFO3=AhGjfJ1k9WCRb3UDb1riLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: nbd: Fix convert qcow2 compressed to nbd
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 5:04 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 7/26/20 10:25 AM, Nir Soffer wrote:
> > When converting to qcow2 compressed format, the last step is a special
> > zero length compressed write, ending in call to bdrv_co_truncate(). This
> > call always fail for the nbd driver since it does not implement
>
> fails
>
> > bdrv_co_truncate().
>
> Arguably, qemu-img should be taught to ignore the failure, since it is
> not unique to the nbd driver. But I can live with your approach here.

I started with ignoring ENOTSUP in qcow2, but felt less safe about this
approach since the same issue may happen in other flows, and making nbd
driver behave like a block device looks like a safer change.

> > For block devices, which have the same limits, the call succeeds since
> > file driver implements bdrv_co_truncate(). If the caller asked to
> > truncate to the same or smaller size with exact=false, the truncate
> > succeeds. Implement the same logic for nbd.
> >
> > Example failing without this change:
> >
>
> >
> > Fixes: https://bugzilla.redhat.com/1860627
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >   block/nbd.c | 27 +++++++++++++++++++++++++++
> >   1 file changed, 27 insertions(+)
> >
> > diff --git a/block/nbd.c b/block/nbd.c
> > index 65a4f56924..2154113af3 100644
> > --- a/block/nbd.c
> > +++ b/block/nbd.c
> > @@ -1966,6 +1966,30 @@ static void nbd_close(BlockDriverState *bs)
> >       nbd_clear_bdrvstate(s);
> >   }
> >
> > +/*
> > + * NBD cannot truncate, but if the caller ask to truncate to the same size, or
>
> asks
>
> > + * to a smaller size with extact=false, there is not reason to fail the
>
> exact, no
>
> > + * operation.
> > + */
> > +static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
> > +                                        bool exact, PreallocMode prealloc,
> > +                                        BdrvRequestFlags flags, Error **errp)
> > +{
> > +    BDRVNBDState *s = bs->opaque;
> > +
> > +    if (offset != s->info.size && exact) {
> > +        error_setg(errp, "Cannot resize NBD nodes");
> > +        return -ENOTSUP;
> > +    }
> > +
> > +    if (offset > s->info.size) {
> > +        error_setg(errp, "Cannot grow NBD nodes");
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
>
> Looks reasonable.  As Max said, I wonder if we want to reject particular
> preallocation modes (looking at block/file-posix.c:raw_co_truncate), in
> the case where the image was resized down and then back up (since
> s->info.size is constant, but the BDS size is not if inexact resize
> succeeds).
>
> As you have a bugzilla entry, I think this is safe for -rc2; I'll be
> touching up the typos and queuing it through my NBD tree later today.

I'll post v2 with the test fixes later today.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>


