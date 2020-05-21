Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E01DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3D6206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kw8VCNZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3D6206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblI4-0003u7-Ck
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jblGy-0002RZ-KJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:30:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jblGx-0004Xa-IA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590067806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWdxwdP7dHhrWME3XQ+jIY8tJN86esH97ipF+br3PdQ=;
 b=Kw8VCNZEIZACDM3GOgW8HLOrIhtCEsjP94aB1UQtFQQajrySgBuqy73zO0TQTW6m2M18i7
 px/5ga91hC1dXxtuU5VmWUtijonwETtdXyQnJeJO6amfEYr5S4/d+4OMVekLM3IaxC2m8i
 NMel9p3iu1ujH90PRhebNardRcT4N2Q=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283--Mc7MNV8PlK2rcj53ZZpPQ-1; Thu, 21 May 2020 09:29:59 -0400
X-MC-Unique: -Mc7MNV8PlK2rcj53ZZpPQ-1
Received: by mail-oi1-f197.google.com with SMTP id k23so3275852oiw.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WWdxwdP7dHhrWME3XQ+jIY8tJN86esH97ipF+br3PdQ=;
 b=C7693Cf0XaQ8L0d0XaQEiVsYSa6WBe9uMhCiy8mv3MPlNyG2bM0OcZDxVC7W9zQEcq
 KfbtSwWL7rI9Tx55lJnldwJ1ZNI3W+9oPrjPxqzqYSHmPN1sXwaY0fmLrWWwFVETDjMx
 OyZoBhb9FgedqeOCSrAHbN0s6vNFWgccbBaO1ZCFZay9l9NYXtzVOIKfJgJoQU9LZTh1
 1z1reyP/vDcL8Xeri7k+vJrGoArBuOM3S4num8gb4oy1wzuNrcOfrdBSwhzRrb0k4Otp
 njyJvr/V+y9NXvVDfOe+FHprUw2J/uM37ugxcK4t/wMugU4g1QYDzwmU0Ww23cQDGVk/
 Eoew==
X-Gm-Message-State: AOAM530FBXPoj/5GGc/yc3oXut/GTKbVtP/nQxREUyuog9G7ZHkuFafu
 1196q9p3XWAvoTs1WriDmj84ggAjc74agOj83/e0TCGamB5xIFvxsq8t/0pC3tlgsIeHh0jpiUb
 kcRlncEbsh354QKqTS86vzsygTu6BVgE=
X-Received: by 2002:aca:f18a:: with SMTP id p132mr7038209oih.56.1590067799023; 
 Thu, 21 May 2020 06:29:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw6Tn1MvjCysY55V7mKqx52p5YBJWiJ7fAn+0cZKLU7RU7wBUJdeq4rbHQjjdj2nEQ6RQeRZFwCo++UynrAYQ=
X-Received: by 2002:aca:f18a:: with SMTP id p132mr7038190oih.56.1590067798685; 
 Thu, 21 May 2020 06:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-3-eblake@redhat.com>
 <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
 <295f514d-f4c8-551a-d828-77a70b4d6fa3@virtuozzo.com>
In-Reply-To: <295f514d-f4c8-551a-d828-77a70b4d6fa3@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 21 May 2020 16:29:42 +0300
Message-ID: <CAMRbyyvrYmhh9OK+6-nBVs1wqbHruYTq7Stn8iBZ17a_V_4wkQ@mail.gmail.com>
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

On Thu, May 21, 2020 at 2:40 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 21.05.2020 02:00, Nir Soffer wrote:
> > On Thu, May 21, 2020 at 1:01 AM Eric Blake <eblake@redhat.com> wrote:
> >>
> >> It's useful to know how much space can be occupied by qcow2 persistent
> >> bitmaps, even though such metadata is unrelated to the guest-visible
> >> data.  Report this value as an additional QMP field, present when
> >> measuring an existing image and output format that both support
> >> bitmaps.  Update iotest 178 and 190 to updated output, as well as new
> >> coverage in 190 demonstrating non-zero values made possible with the
> >> recently-added qemu-img bitmap command.
> >>
> >> On the command-line side, 'qemu-img measure' gains a new --bitmaps
> >> flag.  When present, the bitmap size is rolled into the two existing
> >> measures (or errors if either the source image or destination format
> >> lacks bitmaps); when absent, there is never an error (for
> >> back-compat), but the output will instead include a new line item for
> >> bitmaps (which you would have to manually add), with that line being
> >> omitted in the same cases where passing --bitmaps would error.
> >
> > Supporting 2 ways to measure, one by specifying --bitmaps, and another
> > by adding bitmaps key is not a good idea. We really need one way.
> >
> > Each one has advantages. adding --bitmaps flag is consistent with
> > "qemu-img convert"
> > and future extensions that may require  new flag, and adding "bitmaps"
> > key is consistent
> > with "qmeu-img info", showing bitmaps when they exist.
> >
> > Adding a "bitmaps" key has an advantage that we can use it to test if q=
emu-img
> > supports measuring and copying bitmaps (since both features are expecte=
d to
> > be delivered at the same time). So we can avoid checking --help learn a=
bout
> > the capabilities.
> >
> > I'm ok with both options, can we have only one?
>
> Hi! What are your scenarios? Are you using qemu-img by hand, or it is use=
d from some management tool? For management tool, I'd recommend to use qmp =
interface, which is a lot more strict, reliable and stable, and documented.=
 You just need to run qemu binary in stopped mode for it.

The use case is oVirt - it is a management system but it uses qemu-img
to perform various
operations, like copying disks around. The specific use case is
cloning qcow2 image chain
from one server to another, or cloning on the same server.

In the case of qcow2 images on logical volumes, we need to create a
large enough  logical
volume to copy an image, and for this we use "qemu-img measure". With
the current patches
we will be able to create large enough logical volume and copy the
image data and the bitmps
to the destination.

qmp interface is nice but to use it we have to rewrite all the code
using qemu-img to start qemu
with the relevant disks and perform operation via qmp or via libvirt.
This a huge rewrite and I'm
not sure it's worth the effort.

This approach also has limitations, for example using qemu-img we can
copy disks in parallel on
multiple hosts, while using libvirt and qemu will limit us to using
one host since qemu takes locks
that we control.

Also using libvirt means that all new features take more time to
complete since now we have
a new layer between oVirt and qemu.


