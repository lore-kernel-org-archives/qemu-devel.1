Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17060C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42BE2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqCHkQi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42BE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jig29-0007VX-5q
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jig1C-0006yl-Km
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:18:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jig17-0003Jx-2w
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591715898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2grfrwW9+sGxUNTsRsUH9ssbac3pZdeUpdNDHhbrb0Y=;
 b=dqCHkQi0XCBdYGTY5NeW7U7Qu3Ko39oll7tG47JhNCYUnfh4/bk1HuORoxn+IanzwabLds
 Sa4vy8+1Nc2+Dq0b/RRtIirGqMvf7LEGR0n/crQmuzjNWBGeE6sSRoNbYsUCT1jtqzuhiV
 KWfa8E3XIyO5hmchIZqwGVVz25YqGus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-9AtcES1WNNKzFJs2c-oYGA-1; Tue, 09 Jun 2020 11:18:15 -0400
X-MC-Unique: 9AtcES1WNNKzFJs2c-oYGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383441009615;
 Tue,  9 Jun 2020 15:18:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-124.ams2.redhat.com [10.36.114.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEA4B8FF66;
 Tue,  9 Jun 2020 15:18:12 +0000 (UTC)
Date: Tue, 9 Jun 2020 17:18:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
Message-ID: <20200609151810.GD11003@linux.fritz.box>
References: <20200609140859.142230-1-kwolf@redhat.com>
 <02e24dca-99da-873d-8425-09a07571e675@virtuozzo.com>
 <042f0b8f-dd51-acc3-8498-ac9a5532df15@redhat.com>
MIME-Version: 1.0
In-Reply-To: <042f0b8f-dd51-acc3-8498-ac9a5532df15@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 anton.nefedov@virtuozzo.com, "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.06.2020 um 16:46 hat Eric Blake geschrieben:
> On 6/9/20 9:28 AM, Vladimir Sementsov-Ogievskiy wrote:
> > 09.06.2020 17:08, Kevin Wolf wrote:
> > > Since commit c8bb23cbdbe, handle_alloc_space() is called for newly
> > > allocated clusters to efficiently initialise the COW areas with zeros if
> > > necessary. It skips the whole operation if both start_cow nor end_cow
> > > are empty. However, it requests zeroing the whole request size (possibly
> > > multiple megabytes) even if only one end of the request actually needs
> > > this.
> > > 
> > > This patch reduces the write_zeroes request size in this case so that we
> > > don't unnecessarily zero-initialise a region that we're going to
> > > overwrite immediately.
> > > 
> 
> > 
> > Hmm, I'm afraid, that this may make things worse in some cases, as with
> > one big write-zero request
> > we preallocate data-region in the protocol file, so we have better
> > locality for the clusters we
> > are going to write. And, in the same time, with BDRV_REQ_NO_FALLBACK
> > flag write-zero must be
> > fast anyway (especially in comparison with the following write request).
> > 
> > >           /*
> > >            * instead of writing zero COW buffers,
> > >            * efficiently zero out the whole clusters
> > >            */
> > > -        ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
> > > -                                            m->nb_clusters *
> > > s->cluster_size,
> > > -                                            true);
> > > +        ret = qcow2_pre_write_overlap_check(bs, 0, start, len, true);
> > >           if (ret < 0) {
> > >               return ret;
> > >           }
> > >           BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
> > > -        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
> > > -                                    m->nb_clusters * s->cluster_size,
> > > +        ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
> > >                                       BDRV_REQ_NO_FALLBACK);
> 
> Good point.  If we weren't using BDRV_REQ_NO_FALLBACK, then avoiding a
> pre-zero pass over the middle is essential.  But since we are insisting that
> the pre-zero pass be fast or else immediately fail, the time spent in
> pre-zeroing should not be a concern.  Do you have benchmark numbers stating
> otherwise?

I stumbled across this behaviour (write_zeros for 2 MB, then overwrite
almost everything) in the context of a different bug, and it just didn't
make much sense to me. Is there really a file system where fragmentation
is introduced by not zeroing the area first and then overwriting it?

I'm not insisting on making this change because the behaviour is
harmless if odd, but if we think that writing twice to some blocks is an
optimisation, maybe we should actually measure and document this.


Anyway, let's talk about the reported bug that made me look at the
strace that showed this behaviour because I feel it supports my last
point. It's a bit messy, but anyway:

    https://bugzilla.redhat.com/show_bug.cgi?id=1666864

So initially, bad performance on a fragmented image file was reported.
Not much to do there, but then in comment 16, QA reported a performance
regression in this case between 4.0 and 4.2. And this change caused by
c8bb23cbdbe, i.e. the commit that introduced handle_alloc_space().

Turns out that BDRV_REQ_NO_FALLBACK doesn't always guarantee that it's
_really_ fast. fallocate(FALLOC_FL_ZERO_RANGE) causes some kind of flush
on XFS and buffered writes don't. So with the old code, qemu-img convert
to a file on a very full filesystem that will cause fragmentation, was
much faster with writing a zero buffer than with write_zeroes (because
it didn't flush the result).

I don't fully understand why this is and hope that XFS can do something
about it. I also don't really think we should revert the change in QEMU,
though I'm not completely sure. But I just wanted to share this to show
that "obvious" characteristics of certain types of requests aren't
always true and doing obscure optimisations based on what we think
filesystems may do can actually achieve the opposite in some cases.

Kevin


