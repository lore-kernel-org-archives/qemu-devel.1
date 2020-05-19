Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90EAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DED620709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8QMNal1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DED620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb36f-0003tR-SN
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb35q-0002g3-7L
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:19:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb35n-0003VP-Lj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589897978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=muucTWqm6R4TucIg4MB14Ay0EPdtDO6Gn2h+wM/7VxQ=;
 b=F8QMNal1hYzXf+eTCfXzua5yvsgsaZTtIe0np9G2V6HdpCQnyX55t7RW5Pv1XgkFP97gOc
 FqjvOR1M/xbch2Y2JCdtEqstSWxbZGlGOGmlQkJzrk9p3IBIZpX0Bycs1/d1SYxXFfGaPU
 G8CWxj5ZEL5Aa4Lli9K+KYYZZxro6pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-kNY6OldfO-O2psdGbAZSRg-1; Tue, 19 May 2020 10:19:34 -0400
X-MC-Unique: kNY6OldfO-O2psdGbAZSRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20D528B11BC;
 Tue, 19 May 2020 14:19:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD6BE60BE1;
 Tue, 19 May 2020 14:18:59 +0000 (UTC)
Date: Tue, 19 May 2020 16:18:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
Message-ID: <20200519141858.GN7652@linux.fritz.box>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
 <20200514142606.GH5518@linux.fritz.box>
 <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
 <548700ea-78db-fabc-d1eb-6d89af39ece3@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <548700ea-78db-fabc-d1eb-6d89af39ece3@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, s.reiter@proxmox.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.05.2020 um 15:54 hat Denis Plotnikov geschrieben:
> 
> 
> On 19.05.2020 15:32, Vladimir Sementsov-Ogievskiy wrote:
> > 14.05.2020 17:26, Kevin Wolf wrote:
> > > Am 14.05.2020 um 15:21 hat Thomas Lamprecht geschrieben:
> > > > On 5/12/20 4:43 PM, Kevin Wolf wrote:
> > > > > Stefan (Reiter), after looking a bit closer at this, I think
> > > > > there is no
> > > > > bug in QEMU, but the bug is in your coroutine code that calls block
> > > > > layer functions without moving into the right AioContext first. I've
> > > > > written this series anyway as it potentially makes the life of callers
> > > > > easier and would probably make your buggy code correct.
> > > > 
> > > > > However, it doesn't feel right to commit something like
> > > > > patch 2 without
> > > > > having a user for it. Is there a reason why you can't upstream your
> > > > > async snapshot code?
> > > > 
> > > > I mean I understand what you mean, but it would make the
> > > > interface IMO so
> > > > much easier to use, if one wants to explicit schedule it
> > > > beforehand they
> > > > can still do. But that would open the way for two styles doing
> > > > things, not
> > > > sure if this would seen as bad. The assert about from patch 3/3
> > > > would be
> > > > already really helping a lot, though.
> > > 
> > > I think patches 1 and 3 are good to be committed either way if people
> > > think they are useful. They make sense without the async snapshot code.
> > > 
> > > My concern with the interface in patch 2 is both that it could give
> > > people a false sense of security and that it would be tempting to write
> > > inefficient code.
> > > 
> > > Usually, you won't have just a single call into the block layer for a
> > > given block node, but you'll perform multiple operations. Switching to
> > > the target context once rather than switching back and forth in every
> > > operation is obviously more efficient.
> > > 
> > > But chances are that even if one of these function is bdrv_flush(),
> > > which now works correctly from a different thread, you might need
> > > another function that doesn't implement the same magic. So you always
> > > need to be aware which functions support cross-context calls which
> > > ones don't.
> > > 
> > > I feel we'd see a few bugs related to this.
> > > 
> > > > Regarding upstreaming, there was some historical attempt to upstream it
> > > > from Dietmar, but in the time frame of ~ 8 to 10 years ago or so.
> > > > I'm not quite sure why it didn't went through then, I see if I can get
> > > > some time searching the mailing list archive.
> > > > 
> > > > We'd be naturally open and glad to upstream it, what it effectively
> > > > allow us to do is to not block the VM to much during snapshoting it
> > > > live.
> > > 
> > > Yes, there is no doubt that this is useful functionality. There has been
> > > talk about this every now and then, but I don't think we ever got to a
> > > point where it actually could be implemented.
> > > 
> > > Vladimir, I seem to remember you (or someone else from your team?) were
> > > interested in async snapshots as well a while ago?
> > 
> > Den is working on this (add him to CC)
> Yes, I was working on that.
> 
> What I've done can be found here:
> https://github.com/denis-plotnikov/qemu/commits/bgs_uffd
> 
> The idea was to save a snapshot (state+ram) asynchronously to a separate
> (raw) file using the existing infrastructure.
> The goal of that was to reduce the VM downtime on snapshot.
> 
> We decided to postpone this work until "userfaultfd write protected mode"
> wasn't in the linux mainstream.
> Now, userfaultfd-wp is merged to linux. So we have plans to continue this
> work.
> 
> According to the saving the "internal" snapshot to qcow2 I still have a
> question. May be this is the right place and time to ask.
> 
> If I remember correctly, in qcow2 the snapshot is stored at the end of
> the address space of the current block-placement-table.

Yes. Basically the way snapshots with VM state work is that you write
the VM state to some offset after the end of the virtual disk, when the
VM state is completely written you snapshot the current state (including
both content of the virtual disk and VM state) and finally discard the
VM state again in the active L1 table.

> We switch to the new block-placement-table after the snapshot storing
> is complete. In case of sync snapshot, we should switch the table
> before the snapshot is written, another words, we should be able to
> preallocate the the space for the snapshot and keep a link to the
> space until snapshot writing is completed.

I don't see a fundamental difference between sync and async in this
respect. Why can't you write the VM state to the current L1 table first
like we usually do?

We always have only one active L1 table at a time, which simplifies
cluster allocation a bit, so it would be preferable to keep it this way.

Kevin


