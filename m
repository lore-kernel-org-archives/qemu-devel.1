Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1A820734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6a9QQk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1A820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiys7-0006mL-VW
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiyrA-0006Bh-8C
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:25:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiyr8-00048R-BT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591788313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqqmEFDdxavXBaphoh/SR8PimfEqa3T+RC0eF8AMizM=;
 b=E6a9QQk0/mIIhpQ1T3dbAYJfK5tGto6YZUTvmPCr8OSDvsYSd2iOgaISyKPG9J/QxNoPNE
 pmNDtMUY3Su6F4GIvcynxQ6fB3Hty4WxJCYTmV3iCgvpT27xYt16yx0NneHEIazPj6QBz1
 PO1EcRysxRa5H2H4tThPXuLx/mRvZGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-bJ1ET5BjPEKVrUjcV6VwdQ-1; Wed, 10 Jun 2020 07:25:09 -0400
X-MC-Unique: bJ1ET5BjPEKVrUjcV6VwdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34031EC1A0;
 Wed, 10 Jun 2020 11:25:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-151.ams2.redhat.com [10.36.113.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 369B37C38C;
 Wed, 10 Jun 2020 11:25:06 +0000 (UTC)
Date: Wed, 10 Jun 2020 13:25:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
Message-ID: <20200610112504.GB6947@linux.fritz.box>
References: <20200609140859.142230-1-kwolf@redhat.com>
 <02e24dca-99da-873d-8425-09a07571e675@virtuozzo.com>
 <042f0b8f-dd51-acc3-8498-ac9a5532df15@redhat.com>
 <20200609151810.GD11003@linux.fritz.box>
 <b2c59302-2c14-474b-3bb8-3b48806f2689@redhat.com>
 <07251d29-538b-82a0-2bf4-975127274127@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <07251d29-538b-82a0-2bf4-975127274127@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: anton.nefedov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.06.2020 um 08:50 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 09.06.2020 19:19, Eric Blake wrote:
> > On 6/9/20 10:18 AM, Kevin Wolf wrote:
> > 
> > > > > > -        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
> > > > > > -                                    m->nb_clusters * s->cluster_size,
> > > > > > +        ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
> > > > > >                                        BDRV_REQ_NO_FALLBACK);
> > > > 
> > > > Good point.  If we weren't using BDRV_REQ_NO_FALLBACK, then avoiding a
> > > > pre-zero pass over the middle is essential.  But since we are insisting that
> > > > the pre-zero pass be fast or else immediately fail, the time spent in
> > > > pre-zeroing should not be a concern.  Do you have benchmark numbers stating
> > > > otherwise?
> > > 
> > > I stumbled across this behaviour (write_zeros for 2 MB, then overwrite
> > > almost everything) in the context of a different bug, and it just didn't
> > > make much sense to me. Is there really a file system where fragmentation
> > > is introduced by not zeroing the area first and then overwriting it?
> > > 
> > > I'm not insisting on making this change because the behaviour is
> > > harmless if odd, but if we think that writing twice to some blocks is an
> > > optimisation, maybe we should actually measure and document this.
> > > 
> > > 
> > > Anyway, let's talk about the reported bug that made me look at the
> > > strace that showed this behaviour because I feel it supports my last
> > > point. It's a bit messy, but anyway:
> > > 
> > >      https://bugzilla.redhat.com/show_bug.cgi?id=1666864
> > > 
> > > So initially, bad performance on a fragmented image file was reported.
> > > Not much to do there, but then in comment 16, QA reported a performance
> > > regression in this case between 4.0 and 4.2. And this change caused by
> > > c8bb23cbdbe, i.e. the commit that introduced handle_alloc_space().
> > > 
> > > Turns out that BDRV_REQ_NO_FALLBACK doesn't always guarantee that it's
> > > _really_ fast. fallocate(FALLOC_FL_ZERO_RANGE) causes some kind of flush
> > > on XFS and buffered writes don't. So with the old code, qemu-img convert
> > > to a file on a very full filesystem that will cause fragmentation, was
> > > much faster with writing a zero buffer than with write_zeroes (because
> > > it didn't flush the result).
> > 
> > Wow. That makes it sound like we should NOT attempt
> > fallocate(FALLOC_FL_ZERO_RANGE) on the fast path, because we don't
> > have guarantees that it is fast.
> > 
> > I really wish the kernel would give us
> > fallocate(FALLOC_FL_ZERO_RANGE|FALLOC_FL_NO_FALLBACK) which would
> > fail fast rather than doing a flush or other slow fallback.
> > 
> > > 
> > > I don't fully understand why this is and hope that XFS can do
> > > something about it. I also don't really think we should revert the
> > > change in QEMU, though I'm not completely sure. But I just wanted
> > > to share this to show that "obvious" characteristics of certain
> > > types of requests aren't always true and doing obscure
> > > optimisations based on what we think filesystems may do can
> > > actually achieve the opposite in some cases.
> > 
> > It also goes to show us that the kernel does NOT yet give us enough
> > fine-grained control over what we really want (which is: 'pre-zero
> > this if it is fast, but don't waste time if it is not).  Most of the
> > kernel interfaces end up being 'pre-zero this, and it might be fast,
> > fail fast, or even fall back to something safe but slow, and you
> > can't tell the difference short of trying'.
> 
> Hmm, actually, for small cow areas (several bytes? several sectors?),
> I'm not surprised that direct writing zeroed buffer may work faster
> than any kind of WRITE_ZERO request. Especially, expanding
> write-request for a small amount of bytes may be faster than doing
> intead two requests. Possibly, we need some heuristics here. And I
> think, it would be good to add some benchmarks based on
> scripts/simplebench to have real numbers (we'll try).

I'll continue the discussion in the BZ, but yes, at the moment the
recommendation of the XFS people seems to be that we avoid fallocate()
(at least without FALLOC_FL_KEEP_SIZE and on local filesystems) for
small sizes.

It's not obvious what "small sizes" means in practice, but I wouldn't be
surprised if a qcow2 cluster is always in this category, even if it's
2 MB. (The pathological qemu-img convert case does use 2 MB buffers.)

Kevin


