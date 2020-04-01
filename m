Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567AAC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208B72078B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="La4UZQlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208B72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJalf-0008L5-6K
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJal0-0007oj-A0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJaky-0004cs-Gm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:38:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJaky-0004YG-Cz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585737479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raS5hmhZnXVqq4ElSc8SDvkKufIDVApCf58MPSTo8jE=;
 b=La4UZQlFF5TJg0KE8XTB85ckUMT2J1DScj0Hlqk+4thUQ3hHH4EfGcjX5dJ4gkCR9tLp/M
 8qMddVX0LiJVf3ymDLjhz8IL7LnQAII50wIrhpDMILJtoawim8eYgu4J9BTHG8Q5GE9Z+W
 g/HzBO1cXGgmyZXiTuzDfnZZNvt8Zcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-rAy6HmTGOfGVEH04MzCIvQ-1; Wed, 01 Apr 2020 06:37:58 -0400
X-MC-Unique: rAy6HmTGOfGVEH04MzCIvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B997F10CE789;
 Wed,  1 Apr 2020 10:37:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-172.ams2.redhat.com [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A702999DE9;
 Wed,  1 Apr 2020 10:37:49 +0000 (UTC)
Date: Wed, 1 Apr 2020 12:37:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200401103748.GA4680@linux.fritz.box>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <518198448.62.1585671498399@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.03.2020 um 18:18 hat Dietmar Maurer geschrieben:
> > > Looks bdrv_parent_drained_poll_single() calls
> > > blk_root_drained_poll(), which return true in my case (in_flight > 5)=
.
> >=20
> > Can you identify which BlockBackend is this? Specifically if it's the
> > one attached to a guest device or whether it belongs to the block job.
>=20
> This can trigger from various different places, but the simplest case is =
when
> its called from drive_backup_prepare=20
>=20
> >   bdrv_drained_begin(bs);
>=20
> which is the backup source drive.

I mean the BlockBackend for which blk_root_drained_poll() is called.

> > Maybe have a look at the job coroutine, too. You can probably easiest
> > find it in the 'jobs' list, and then print the coroutine backtrace for
> > job->co.
>=20
> There is in drive_backup_prepare(), before the job gets created.

Oh, I see. Then it can't be job BlockBackend, of course.

> > > Looks like I am loosing poll events somewhere?
> >=20
> > I don't think we've lost any event if in_flight > 0. It means that
> > something is still supposedly active. Maybe the job deadlocked.
>=20
> This is a simple call to bdrv_drained_begin(bs) (before we setup the job)=
.
>=20
> I really nobody else able to reproduce this (somebody already tried to re=
produce)?

I can get hangs, but that's for job_completed(), not for starting the
job. Also, my hangs have a non-empty bs->tracked_requests, so it looks
like a different case to me.

In my case, the hanging requests looks like this:

(gdb) qemu coroutine 0x556e055750e0
#0  0x0000556e03999150 in qemu_coroutine_switch (from_=3Dfrom_@entry=3D0x55=
6e055750e0, to_=3Dto_@entry=3D0x7fd34bbeb5b8, action=3Daction@entry=3DCOROU=
TINE_YIELD) at util/coroutine-ucontext.c:218
#1  0x0000556e03997e31 in qemu_coroutine_yield () at util/qemu-coroutine.c:=
193
#2  0x0000556e0397fc88 in thread_pool_submit_co (pool=3D0x7fd33c003120, fun=
c=3Dfunc@entry=3D0x556e038d59a0 <handle_aiocb_rw>, arg=3Darg@entry=3D0x7fd2=
d2b96440) at util/thread-pool.c:289
#3  0x0000556e038d511d in raw_thread_pool_submit (bs=3Dbs@entry=3D0x556e04e=
459b0, func=3Dfunc@entry=3D0x556e038d59a0 <handle_aiocb_rw>, arg=3Darg@entr=
y=3D0x7fd2d2b96440) at block/file-posix.c:1894
#4  0x0000556e038d58c3 in raw_co_prw (bs=3D0x556e04e459b0, offset=3D2309570=
56, bytes=3D4096, qiov=3D0x7fd33c006fe0, type=3D1) at block/file-posix.c:19=
41

Checking the thread pool request:

(gdb) p *((ThreadPool*)0x7fd33c003120).head .lh_first
$9 =3D {common =3D {aiocb_info =3D 0x556e03f43f80 <thread_pool_aiocb_info>,=
 bs =3D 0x0, cb =3D 0x556e0397f670 <thread_pool_co_cb>, opaque =3D 0x7fd2d2=
b96400, refcnt =3D 1}, pool =3D 0x7fd33c003120,
  func =3D 0x556e038d59a0 <handle_aiocb_rw>, arg =3D 0x7fd2d2b96440, state =
=3D THREAD_DONE, ret =3D 0, reqs =3D {tqe_next =3D 0x0, tqe_circ =3D {tql_n=
ext =3D 0x0, tql_prev =3D 0x0}}, all =3D {le_next =3D 0x0,
    le_prev =3D 0x7fd33c0031d0}}

So apparently the request is THREAD_DONE, but the coroutine was never
reentered. I saw one case where ctx.bh_list was empty, but I also have a
case where a BH sits there scheduled and apparently just doesn't get
run:

(gdb) p *((ThreadPool*)0x7fd33c003120).ctx.bh_list .slh_first
$13 =3D {ctx =3D 0x556e04e41a10, cb =3D 0x556e0397f8e0 <thread_pool_complet=
ion_bh>, opaque =3D 0x7fd33c003120, next =3D {sle_next =3D 0x0}, flags =3D =
3}

Stefan, I wonder if this is related to the recent changes to the BH
implementation.

Kevin


