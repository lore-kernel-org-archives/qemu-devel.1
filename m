Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A129FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A722063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj2DuPY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A722063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hSy-0000aG-DU
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7hRk-0006jK-IC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:53:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7hRi-0000u0-J9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597679593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nc5EolNRdiJ/j1gTzmj9QZS86mcIQFLXMgKWisz3OVA=;
 b=Oj2DuPY044pwtCAY4L8EF5F8kFDc3RmacHYfennor4GI4K71j8twfOIgkicfMXIxOpPEJj
 GSm/7rqhHLHUrJemTIk4m8WaUS+NAco7pN0v/HmTG2b9CtZYJGxGjMEBurDfe6mdbjE03g
 IZmRSO3nmtwR2tVANLrTOCu7DCRX/N4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-crkwdAsMNH-IZefa8Hj9kQ-1; Mon, 17 Aug 2020 11:53:12 -0400
X-MC-Unique: crkwdAsMNH-IZefa8Hj9kQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D25851800D41;
 Mon, 17 Aug 2020 15:53:10 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAE666F15D;
 Mon, 17 Aug 2020 15:53:08 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:53:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
Message-ID: <20200817155307.GS11402@linux.fritz.box>
References: <cover.1597416317.git.berto@igalia.com>
 <20200817101019.GD11402@linux.fritz.box>
 <w518sedz3td.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w518sedz3td.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.08.2020 um 17:31 hat Alberto Garcia geschrieben:
> On Mon 17 Aug 2020 12:10:19 PM CEST, Kevin Wolf wrote:
> >> Since commit c8bb23cbdbe / QEMU 4.1.0 (and if the storage backend
> >> allows it) writing to an image created with preallocation=metadata
> >> can be slower (20% in my tests) than writing to an image with no
> >> preallocation at all.
> >
> > A while ago we had a case where commit c8bb23cbdbe was actually
> > reported as a major performance regression, so it's a big "it
> > depends".
> >
> > XFS people told me that they consider this code a bad idea. Just
> > because it's a specialised "write zeroes" operation, it's not
> > necessarily fast on filesystems. In particular, on XFS, ZERO_RANGE
> > causes a queue drain with O_DIRECT (probably hurts cases with high
> > queue depths) and additionally even a page cache flush without
> > O_DIRECT.
> >
> > So in a way this whole thing is a two-edged sword.
> 
> I see... on ext4 the improvements are clearly visible. Are we not
> detecting this for xfs? We do have an s->is_xfs flag.

My understanding is that XFS and ext4 behave very similar in this
respect. It's not a clear loss on XFS either, some cases are improved.
But cases that get a performance regression exist, too. It's a question
of the workload, the file system state (e.g. fragmentation of the image
file) and the storage.

So I don't think checking for a specific filesystem is going to improve
things.

> >> a) shall we include a warning in the documentation ("note that this
> >> preallocation mode can result in worse performance")?
> >
> > To be honest, I don't really understand this case yet. With metadata
> > preallocation, the clusters are already marked as allocated, so why
> > would handle_alloc_space() even be called? We're not allocating new
> > clusters after all?
> 
> It's not called, what happens is what you say below:
> 
> > Or are you saying that ZERO_RANGE + pwrite on a sparse file (= cluster
> > allocation) is faster for you than just the pwrite alone (= writing to
> > already allocated cluster)?
> 
> Yes, 20% faster in my tests (4KB random writes), but in the latter case
> the cluster is already allocated only at the qcow2 level, not on the
> filesystem. preallocation=falloc is faster than preallocation=metadata
> (preallocation=off sits in the middle).

Hm, this feels wrong. Doing more operations should never be faster than
doing less operations.

Maybe the difference is in allocating 64k at once instead of doing a
separate allocation for every 4k block? But with the extent size hint
patches to file-posix, we should allocate 1 MB at once by default now
(if your test image was newly created). Can you check whether this is in
effect for your image file?

Kevin


