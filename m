Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0599C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897EB206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTeKRohg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897EB206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8hc-0006GE-O5
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ix8gt-0005km-39
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ix8gr-0005tg-QS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:12:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ix8gr-0005t5-MD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580386376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrdBeCdq6d+adJxZVg9QAVq3KRP+KsZyWI9f08e5oRM=;
 b=BTeKRohgTaJC2La7tlLXIv3NetgTFcMIXPj9UkiXRV6TTsbLIeTckzS1rejBPZqep6IpZz
 ldazbpEWr8TJVG3gw31++2Cq2UuwlYtuCqyRPlfN51RLRK5+t58VhyRkw3I0ymwwqakLyU
 1w1/HPdBY2GyCSxpTXG1uBJYM85Snjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-j4bOS8UwOU6djpanWu7Ldg-1; Thu, 30 Jan 2020 07:12:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B272E10054E3;
 Thu, 30 Jan 2020 12:12:53 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-25.ams2.redhat.com [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B11087B00;
 Thu, 30 Jan 2020 12:12:52 +0000 (UTC)
Date: Thu, 30 Jan 2020 13:12:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: request_alignment vs file size, how to fix crash?
Message-ID: <20200130121250.GD6438@linux.fritz.box>
References: <2ca46523-44a2-1a48-dfa3-11bda9eef8e8@virtuozzo.com>
 <24d1a5f8-1f01-ec64-778d-5bab440714c7@virtuozzo.com>
 <20200130111144.GC6438@linux.fritz.box>
 <72b2fae2-dcd6-e2f2-c497-300302559ca4@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <72b2fae2-dcd6-e2f2-c497-300302559ca4@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: j4bOS8UwOU6djpanWu7Ldg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Nir Soffer <nsoffer@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.01.2020 um 12:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 30.01.2020 14:11, Kevin Wolf wrote:
> > Am 30.01.2020 um 11:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > 29.01.2020 21:01, Vladimir Sementsov-Ogievskiy wrote:
> > > > Hi!
> > > >=20
> > > > I found a crash, which may be simply triggered for images unaligned=
 to request_alignment:
> > > >=20
> > > > # ./qemu-io --image-opts -c 'write 0 512' driver=3Dblkdebug,align=
=3D4096,image.driver=3Dnull-co,image.size=3D512
> > > > qemu-io: block/io.c:1505: bdrv_aligned_pwritev: Assertion `end_sect=
or <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> > > > Aborted (core dumped)
> > > >=20
> > > > The problem is obvious: 512 is aligned to 4096 and becomes larger t=
han file size.
> > > >=20
> > > > I faced it after rebasing our downstream branches to newer Rhel ver=
sions. Seems that after some updates of alignment detection in file-posix.c=
, it started to detect 4096 alignment in our build environment, and iotest =
152 started to crash (as it operates on file of 512 bytes).
> > > >=20
> > > > My question is:
> > > >=20
> > > > What is wrong? Should we restrict images to be aligned to request_a=
lignment, or allow unaligned operations at EOF, if file is unaligned itself=
?
> > > >=20
> > >=20
> > >=20
> > > The problem started with commit
> > >=20
> > > commit a6b257a08e3d72219f03e461a52152672fec0612
> > > Author: Nir Soffer <nirsof@gmail.com>
> > > Date:   Tue Aug 13 21:21:03 2019 +0300
> > >=20
> > >      file-posix: Handle undetectable alignment
> > >=20
> > >=20
> > > It sets request_alignment to 4k, if probing of align=3D1 succeeded.. =
I think it's wrong logic. It leads to crashes for images unaligned to 4k.
> > >=20
> > > If we force alignment to be 4k, we at least should check that file si=
ze is aligned to 4k. Otherwise our assumption is definitely wrong.
> > >=20
> > > And still, I doubt that it's correct to force alignment to 4k, for de=
vices which doesn't request any alignment..
> >=20
> > What backend is this? O_DIRECT with byte alignment sounds wrong, so I
> > wonder if your storage really can do this or whether we just failed to
> > detect the actual alignment.
>=20
> The problem was disabled odirect in virtuozzo container which lead to byt=
e alignment. So, yes, it's on our part.

Oh, I see, so to QEMU it looked like it would do O_DIRECT and probing
was done, but what was actually opened was non-direct. Not sure if we
could possibly distinguish a situation like this from one where O_DIRECT
succeeds with byte alignment because the block was unallocated, but
would require larger alignment later.

> > I guess we could change the default to pick the largest size so that th=
e
> > image size is still a multiple of it. But if the image size isn't even
> > aligned to 512 bytes, I think refusing to open the image with O_DIRECT
> > feels more correct (I would be okay with doing the same with > 512 byte
> > images, too, if the image size isn't a multiple of the alignment).
> >=20
>=20
> OK, I'll think about a patch for file-posix.c, and may be blkdebug too.
>=20
> Also, we need to check it somewhere in generic layer too, to fail earlier=
 than assertion above.

Yes, I agree, it should be checked while opening the image.

Kevin


