Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6AEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B589820672
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrfGBpkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B589820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04qn-0007Ek-0W
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04nv-0003yR-82
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:12:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04ns-0008P5-Sn
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595862755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqjjsJhyq04hcBycB629wZ1dY8ay2+QWeP3yUxLxxS0=;
 b=VrfGBpkBqmKOM73U/oB+dUj1AbIj/fRJ1R041NMr9b1MIVocAd3Wl+aPG1Dfwg6/W9Lnxz
 CTe01PkldRZ3lsQnwG55O4/7JJdcCds8EtwiVFDebCdW26P0FngzHRs13ZgTqeN22aIfaL
 UWZKghWwgUbfWiy8FAl9OY3G8JrTlGk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-86wlJKwCMDqWPNCkYjae4w-1; Mon, 27 Jul 2020 11:12:32 -0400
X-MC-Unique: 86wlJKwCMDqWPNCkYjae4w-1
Received: by mail-oi1-f198.google.com with SMTP id t4so8893935oij.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VqjjsJhyq04hcBycB629wZ1dY8ay2+QWeP3yUxLxxS0=;
 b=hYx9ckPv5ghUmp00ZVnyGil2L0/jZPlo7VN9tkN0wlNXuvXUU939WWHujXMi01zWu9
 aNNcdyZNwlgfbWKg+5jtf5lFoM3CMVeJcEODJNMuDXAc7/xvkhCfTJFh/9Bs/QlQ7M6s
 lCXOUNWTkyfEqyeNAviayBbSDYfzI7qHqvpQ0ghnewGCoESjDBvnImYyOlKEOGdkEM5O
 zkyzmE3p2ydyASGybzhmfPmDRgr5mjbdrjM1xwXoo0Fs/RzWPU8RIXQDLY1kmHpfDPLp
 utmjUyz5gYU1p2iEVftkkMmHlUDbtPkS2fQ/vSqkkndk+uxHynFFEHcIPhjNZ5TO5qOw
 esWw==
X-Gm-Message-State: AOAM532wrqQQsx25n6gQWAheD2ftKuWP/S3sq/b7/9GbP2R2aaile+9V
 BNv0TT3QpmfPTuuAjTbfTdn+A8mEIhU/vF72LOUgpDfCri2umiAy1/7Jgtj40X7z3Cz8DIKmEgV
 Mi3fTHl7UvtsP1yEbZfFlT0FF0A0gyaM=
X-Received: by 2002:a05:6808:486:: with SMTP id
 z6mr19388082oid.56.1595862751687; 
 Mon, 27 Jul 2020 08:12:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNk/DiwCmak3npfh1kAwMumgaUwDeymyQ2rkpLTvOupt4Eaivg78zbN+F/LXbUxVxK4AsXD6b9M5yutxKLJgI=
X-Received: by 2002:a05:6808:486:: with SMTP id
 z6mr19388061oid.56.1595862751426; 
 Mon, 27 Jul 2020 08:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-2-nsoffer@redhat.com>
 <1737bdc4-6192-1adb-7027-faf09bdbd92c@redhat.com>
In-Reply-To: <1737bdc4-6192-1adb-7027-faf09bdbd92c@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 27 Jul 2020 18:12:15 +0300
Message-ID: <CAMRbyyviP+vsH2_Mf3=37E+STnm5kH0zgTiWKQU_McyM5U1vBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: nbd: Fix convert qcow2 compressed to nbd
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
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
>
> >
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

Do we want to fail if someone specifies -o preallocation={falloc,full}?

I see we convert DRV_REQ_MAY_UNMAP to NBD_CMD_FLAG_NO_HOLE
so using -o preallocation=falloc,full should be correct. But the last
request zero
length write request does not do anything, so failing does not look useful.

> As you have a bugzilla entry, I think this is safe for -rc2; I'll be
> touching up the typos and queuing it through my NBD tree later today.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>


