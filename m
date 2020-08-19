Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2826C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB04C20882
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/HTKm1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB04C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PhJ-0006Cg-TV
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8PgT-0005P6-Mt
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8PgQ-0006c2-Dy
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597849640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AqWclChQ726Qg4ueFB4QItpCbxf6IQ5qkFhhKGlcaL8=;
 b=D/HTKm1ryBcy1EMkQx9uF1tVZ57bZtNn1wdei2qsEx4h1MhEXxC9VyHcPeLP59U9veDWI4
 WvsOxUnAFlIDo2YNs0u2wqNC9MbEggEdfCr5QadbZhBMgQB2s1GGDlp/Ex+OgVMjB0QxaG
 JflkR4WJWCfQkANwL0Ot8a5voXc/r/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-HXFKHSl8PH6yUbpCxz_vxw-1; Wed, 19 Aug 2020 11:07:16 -0400
X-MC-Unique: HXFKHSl8PH6yUbpCxz_vxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33EF414996;
 Wed, 19 Aug 2020 15:07:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA8405D9D5;
 Wed, 19 Aug 2020 15:07:12 +0000 (UTC)
Date: Wed, 19 Aug 2020 17:07:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
Message-ID: <20200819150711.GE10272@linux.fritz.box>
References: <cover.1597416317.git.berto@igalia.com>
 <20200817101019.GD11402@linux.fritz.box>
 <w518sedz3td.fsf@maestria.local.igalia.com>
 <20200817155307.GS11402@linux.fritz.box>
 <w51pn7memr7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51pn7memr7.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: bfoster@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.08.2020 um 16:25 hat Alberto Garcia geschrieben:
> On Mon 17 Aug 2020 05:53:07 PM CEST, Kevin Wolf wrote:
> >> > Or are you saying that ZERO_RANGE + pwrite on a sparse file (=
> >> > cluster allocation) is faster for you than just the pwrite alone (=
> >> > writing to already allocated cluster)?
> >> 
> >> Yes, 20% faster in my tests (4KB random writes), but in the latter
> >> case the cluster is already allocated only at the qcow2 level, not on
> >> the filesystem. preallocation=falloc is faster than
> >> preallocation=metadata (preallocation=off sits in the middle).
> >
> > Hm, this feels wrong. Doing more operations should never be faster
> > than doing less operations.
> >
> > Maybe the difference is in allocating 64k at once instead of doing a
> > separate allocation for every 4k block? But with the extent size hint
> > patches to file-posix, we should allocate 1 MB at once by default now
> > (if your test image was newly created). Can you check whether this is
> > in effect for your image file?
> 
> I checked with xfs on my computer. I'm not very familiar with that
> filesystem so I was using the default options and I didn't tune
> anything.
> 
> What I got with my tests (using fio):
> 
> - Using extent_size_hint didn't make any difference in my test case (I
>   do see a clear difference however with the test case described in
>   commit ffa244c84a).

Hm, interesting. What is your exact fio configuration? Specifically,
which iodepth are you using? I guess with a low iodepth (and O_DIRECT),
the effect of draining the queue might not be as visible.

> - preallocation=off is still faster than preallocation=metadata.

Brian, can you help us here with some input?

Essentially what we're having here is a sparse image file on XFS that is
opened with O_DIRECT (presumably - Berto, is this right?), and Berto is
seeing cases where a random write benchmark is faster if we're doing the
64k ZERO_RANGE + 4k pwrite when touching a 64k cluster for the first
time compared to always just doing the 4k pwrite. This is with a 1 MB
extent size hint.

From the discussions we had the other day [1][2] I took away that your
suggestion is that we should not try to optimise things with
fallocate(), but just write the areas we really want to write and let
the filesystem deal with the sparse parts. Especially with the extent
size hint that we're now setting, I'm surprised to hear that doing a
ZERO_RANGE first still seems to improve the performance.

Do you have any idea why this is happening and what we should be doing
with this?

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1850660
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1666864

>   If I disable handle_alloc_space() (so there is no ZERO_RANGE used)
>   then it is much slower.

This makes some sense because then we're falling back to writing
explicit zero buffers (unless you disabled that, too).

> - With preallocation=falloc I get the same results as with
>   preallocation=metadata.

Interesting, this means that the fallocate() call costs you basically no
time. I would have expected preallocation=falloc to be a little faster.

> - preallocation=full is the fastest by far.

I guess this saves the conversion of unwritten extents to fully
allocated ones?

As the extent size hint doesn't seem to influence your test case anyway,
can I assume that ext4 behaves similar to XFS in all four cases?

Kevin


