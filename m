Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE7AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2235D20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gb8QviAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2235D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbo4p-0004Ln-Cn
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jbo3o-0003r3-Jj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:28:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jbo3m-0002mg-FS
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590078520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZ5q3mHC4JMLNq/1lkqNYb/MC3zoMJza6FSU6mV18l8=;
 b=Gb8QviASMRq9OUza4BhAUXtN9ZFxba9qji2n/w/nRSid7+SZQUliJaXuIt9/oOtAOpdsCc
 pYpCJseUwk0SRNOyR9sJtiFGDfvoBac4GG9t79ht7VHHsjBLN8Ac9fctzjDUK8c73UEIFM
 O6PhIJaw3tOjylXmLdRsf0C4aa+RPdU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-qqgyHWCGOZi74oJLGNLHlg-1; Thu, 21 May 2020 12:28:37 -0400
X-MC-Unique: qqgyHWCGOZi74oJLGNLHlg-1
Received: by mail-oo1-f69.google.com with SMTP id c19so3685229oob.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zZ5q3mHC4JMLNq/1lkqNYb/MC3zoMJza6FSU6mV18l8=;
 b=ogi2DmWznFFr8ejrCpm0xh2/mhj552Ihb1Ekt4a6zJY44liiYSRzQVWMFCnIG7kiKM
 okXhEhj8EOQRE3CvyRxm1otOMNHY5RN+6cg36tUGtB2ZVPqdHY089s47ryHUoUyKrCz2
 OBRmHOn5G5u/nW/j0mpMExeCwmUZXqMMJ340aPY67frCIbfBDtbGbd848z35z9XUZncJ
 4xIg1p2j+6rwufFHjxVMA6nRIfH6u1SsYuzZnPJu7FNXrnXvuU5CKWAuYQGA+s5zgdds
 w+tqpdP8RObyTkwgyGCneZnptdwJxkMt50kuLMe9P9BhqIacANrFF4pKk1q4qDBdjjQQ
 wCnQ==
X-Gm-Message-State: AOAM530zJbJghIYwERuXErimtA2HO8QZ96ntvEqCkUHyxxn7DR4vfawO
 saTlcl7RqUQ+Yk84YpLaqVzBZQEcHomeRTJaB8jqvx3QdxN3I86xvgUrVHgI4MO6kOPgRLqHbFj
 UR0oQl96ih7U07V20YcnnLsDQSNbMgKE=
X-Received: by 2002:a9d:3785:: with SMTP id x5mr7671151otb.81.1590078516904;
 Thu, 21 May 2020 09:28:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1Ay0Qwg8WZGS6NAH6ENvOdnNUv/pvcUyXn3wmmKC6vWg5l2TTHgMoj6DU5jwAYHGsQN/2xqCSLEs1dDe0BfE=
X-Received: by 2002:a9d:3785:: with SMTP id x5mr7671116otb.81.1590078516428;
 Thu, 21 May 2020 09:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-3-eblake@redhat.com>
 <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
 <295f514d-f4c8-551a-d828-77a70b4d6fa3@virtuozzo.com>
 <CAMRbyyvrYmhh9OK+6-nBVs1wqbHruYTq7Stn8iBZ17a_V_4wkQ@mail.gmail.com>
 <e2fe2f35-9df3-163b-c29a-470505c00590@virtuozzo.com>
In-Reply-To: <e2fe2f35-9df3-163b-c29a-470505c00590@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 21 May 2020 19:28:19 +0300
Message-ID: <CAMRbyysFPmra6m6nzCV1JhASA7o4vBokx4Oj1RY5qifP5P5Cug@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] qcow2: Expose bitmaps' size during measure
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 6:09 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 21.05.2020 16:29, Nir Soffer wrote:
> > On Thu, May 21, 2020 at 2:40 PM Vladimir Sementsov-Ogievskiy
> > <vsementsov@virtuozzo.com> wrote:
> >>
> >> 21.05.2020 02:00, Nir Soffer wrote:
> >>> On Thu, May 21, 2020 at 1:01 AM Eric Blake <eblake@redhat.com> wrote:
> >>>>
> >>>> It's useful to know how much space can be occupied by qcow2 persiste=
nt
> >>>> bitmaps, even though such metadata is unrelated to the guest-visible
> >>>> data.  Report this value as an additional QMP field, present when
> >>>> measuring an existing image and output format that both support
> >>>> bitmaps.  Update iotest 178 and 190 to updated output, as well as ne=
w
> >>>> coverage in 190 demonstrating non-zero values made possible with the
> >>>> recently-added qemu-img bitmap command.
> >>>>
> >>>> On the command-line side, 'qemu-img measure' gains a new --bitmaps
> >>>> flag.  When present, the bitmap size is rolled into the two existing
> >>>> measures (or errors if either the source image or destination format
> >>>> lacks bitmaps); when absent, there is never an error (for
> >>>> back-compat), but the output will instead include a new line item fo=
r
> >>>> bitmaps (which you would have to manually add), with that line being
> >>>> omitted in the same cases where passing --bitmaps would error.
> >>>
> >>> Supporting 2 ways to measure, one by specifying --bitmaps, and anothe=
r
> >>> by adding bitmaps key is not a good idea. We really need one way.
> >>>
> >>> Each one has advantages. adding --bitmaps flag is consistent with
> >>> "qemu-img convert"
> >>> and future extensions that may require  new flag, and adding "bitmaps=
"
> >>> key is consistent
> >>> with "qmeu-img info", showing bitmaps when they exist.
> >>>
> >>> Adding a "bitmaps" key has an advantage that we can use it to test if=
 qemu-img
> >>> supports measuring and copying bitmaps (since both features are expec=
ted to
> >>> be delivered at the same time). So we can avoid checking --help learn=
 about
> >>> the capabilities.
> >>>
> >>> I'm ok with both options, can we have only one?
> >>
> >> Hi! What are your scenarios? Are you using qemu-img by hand, or it is =
used from some management tool? For management tool, I'd recommend to use q=
mp interface, which is a lot more strict, reliable and stable, and document=
ed. You just need to run qemu binary in stopped mode for it.
> >
> > The use case is oVirt - it is a management system but it uses qemu-img
> > to perform various
> > operations, like copying disks around. The specific use case is
> > cloning qcow2 image chain
> > from one server to another, or cloning on the same server.
> >
> > In the case of qcow2 images on logical volumes, we need to create a
> > large enough  logical
> > volume to copy an image, and for this we use "qemu-img measure". With
> > the current patches
> > we will be able to create large enough logical volume and copy the
> > image data and the bitmps
> > to the destination.
> >
> > qmp interface is nice but to use it we have to rewrite all the code
> > using qemu-img to start qemu
> > with the relevant disks and perform operation via qmp or via libvirt.
> > This a huge rewrite and I'm
> > not sure it's worth the effort.
>
> OK, I'm not familiar with oVirt.. But maybe, you don't need to rewrite ev=
erything, but just add a possibility to use qmp interface, so, keep old fea=
tures working on qemu-img, while adding new features using qmp?

This is always the case, we always need to support old code for 2
versions when we add
new code. This is even worse. It makes sense only if this enables
stuff which is not possible
with qemu-img.

One case that we did not handle yet is copying bitmaps down after
"qemu-img commit",
which should be solved now in libvirt when using blockCommit(). If use
libvirt also for
cold-commit by running qemu paused, it makes sense to add this.

Another case we did not handle yet is backing up non-running vms,
which will also work
transparently if we run the vm paused just for the backup. So using
paused vm via
libvirt seems like a good direction.

> > This approach also has limitations, for example using qemu-img we can
> > copy disks in parallel on
> > multiple hosts, while using libvirt and qemu will limit us to using
> > one host since qemu takes locks
> > that we control.
>
> hmm.. do you open same image RW in several qemu-img processes? Or I don't=
 follow, what behavior is blocked by Qemu locks... qemu-img takes locks as =
well..

We don't copy images in parallel yet. Currently we just copy the image
one by one,
starting at the base image in the chain. If we start to copy in
parallel, we will run multiple
qemu-img processes, each copying one layer in the chain. It should be
possible since
only the destination image is writable,  and qemu does not need to
read the backing file
not on the source or destination. I think we tried this but maybe it
was before qemu-img
added locking.

> > Also using libvirt means that all new features take more time to
> > complete since now we have
> > a new layer between oVirt and qemu.
>
> May be, using qmp directly is still a good option.

We use qmp for testing our nbd client, it is awesome. This is another optio=
n
we need to consider.


