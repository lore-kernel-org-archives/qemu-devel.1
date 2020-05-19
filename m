Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D073C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C51020657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5UW1599"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C51020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4Lt-00006C-JJ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb4CS-0001SD-MP
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:30:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb4CP-0003gx-W8
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589902233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfA7KR4QwKX4/PPuEVwcgelVbKSpQAyAq/finapfqAI=;
 b=M5UW1599cfIQ4fOK+AqkSn8U/ziT0JoO/mItKE/sAMFlb9oTU0GQgK0/uS+inuYxd2sxYS
 JCcih0trVESdIBzkveyNIvx0YfTN/LK/RcShW9Bs8SNjDXjvBC4T24YHl9az0vORuUP8nk
 YEGkhitVO3pf75inX0bAzHJCCDpR7aU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-0l-zHbA-POOoZh6Pwv61Zw-1; Tue, 19 May 2020 11:30:10 -0400
X-MC-Unique: 0l-zHbA-POOoZh6Pwv61Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C394C1B18BC6;
 Tue, 19 May 2020 15:30:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 834295C1BB;
 Tue, 19 May 2020 15:30:01 +0000 (UTC)
Date: Tue, 19 May 2020 17:29:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
Message-ID: <20200519152959.GP7652@linux.fritz.box>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
 <20200514142606.GH5518@linux.fritz.box>
 <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
 <548700ea-78db-fabc-d1eb-6d89af39ece3@virtuozzo.com>
 <20200519141858.GN7652@linux.fritz.box>
 <dfed81f7-9806-9aaf-459f-13f786b67e0a@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <dfed81f7-9806-9aaf-459f-13f786b67e0a@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, s.reiter@proxmox.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.05.2020 um 17:05 hat Denis Plotnikov geschrieben:
> On 19.05.2020 17:18, Kevin Wolf wrote:
> > Am 19.05.2020 um 15:54 hat Denis Plotnikov geschrieben:
> > > 
> > > On 19.05.2020 15:32, Vladimir Sementsov-Ogievskiy wrote:
> > > > 14.05.2020 17:26, Kevin Wolf wrote:
> > > > > Am 14.05.2020 um 15:21 hat Thomas Lamprecht geschrieben:
> > > > > > On 5/12/20 4:43 PM, Kevin Wolf wrote:
> > > > > > > Stefan (Reiter), after looking a bit closer at this, I think
> > > > > > > there is no
> > > > > > > bug in QEMU, but the bug is in your coroutine code that calls block
> > > > > > > layer functions without moving into the right AioContext first. I've
> > > > > > > written this series anyway as it potentially makes the life of callers
> > > > > > > easier and would probably make your buggy code correct.
> > > > > > > However, it doesn't feel right to commit something like
> > > > > > > patch 2 without
> > > > > > > having a user for it. Is there a reason why you can't upstream your
> > > > > > > async snapshot code?
> > > > > > I mean I understand what you mean, but it would make the
> > > > > > interface IMO so
> > > > > > much easier to use, if one wants to explicit schedule it
> > > > > > beforehand they
> > > > > > can still do. But that would open the way for two styles doing
> > > > > > things, not
> > > > > > sure if this would seen as bad. The assert about from patch 3/3
> > > > > > would be
> > > > > > already really helping a lot, though.
> > > > > I think patches 1 and 3 are good to be committed either way if people
> > > > > think they are useful. They make sense without the async snapshot code.
> > > > > 
> > > > > My concern with the interface in patch 2 is both that it could give
> > > > > people a false sense of security and that it would be tempting to write
> > > > > inefficient code.
> > > > > 
> > > > > Usually, you won't have just a single call into the block layer for a
> > > > > given block node, but you'll perform multiple operations. Switching to
> > > > > the target context once rather than switching back and forth in every
> > > > > operation is obviously more efficient.
> > > > > 
> > > > > But chances are that even if one of these function is bdrv_flush(),
> > > > > which now works correctly from a different thread, you might need
> > > > > another function that doesn't implement the same magic. So you always
> > > > > need to be aware which functions support cross-context calls which
> > > > > ones don't.
> > > > > 
> > > > > I feel we'd see a few bugs related to this.
> > > > > 
> > > > > > Regarding upstreaming, there was some historical attempt to upstream it
> > > > > > from Dietmar, but in the time frame of ~ 8 to 10 years ago or so.
> > > > > > I'm not quite sure why it didn't went through then, I see if I can get
> > > > > > some time searching the mailing list archive.
> > > > > > 
> > > > > > We'd be naturally open and glad to upstream it, what it effectively
> > > > > > allow us to do is to not block the VM to much during snapshoting it
> > > > > > live.
> > > > > Yes, there is no doubt that this is useful functionality. There has been
> > > > > talk about this every now and then, but I don't think we ever got to a
> > > > > point where it actually could be implemented.
> > > > > 
> > > > > Vladimir, I seem to remember you (or someone else from your team?) were
> > > > > interested in async snapshots as well a while ago?
> > > > Den is working on this (add him to CC)
> > > Yes, I was working on that.
> > > 
> > > What I've done can be found here:
> > > https://github.com/denis-plotnikov/qemu/commits/bgs_uffd
> > > 
> > > The idea was to save a snapshot (state+ram) asynchronously to a separate
> > > (raw) file using the existing infrastructure.
> > > The goal of that was to reduce the VM downtime on snapshot.
> > > 
> > > We decided to postpone this work until "userfaultfd write protected mode"
> > > wasn't in the linux mainstream.
> > > Now, userfaultfd-wp is merged to linux. So we have plans to continue this
> > > work.
> > > 
> > > According to the saving the "internal" snapshot to qcow2 I still have a
> > > question. May be this is the right place and time to ask.
> > > 
> > > If I remember correctly, in qcow2 the snapshot is stored at the end of
> > > the address space of the current block-placement-table.
> > Yes. Basically the way snapshots with VM state work is that you write
> > the VM state to some offset after the end of the virtual disk, when the
> > VM state is completely written you snapshot the current state (including
> > both content of the virtual disk and VM state) and finally discard the
> > VM state again in the active L1 table.
> > 
> > > We switch to the new block-placement-table after the snapshot storing
> > > is complete. In case of sync snapshot, we should switch the table
> > > before the snapshot is written, another words, we should be able to
> > > preallocate the the space for the snapshot and keep a link to the
> > > space until snapshot writing is completed.
> > I don't see a fundamental difference between sync and async in this
> > respect. Why can't you write the VM state to the current L1 table first
> > like we usually do?
> 
> I'm not quite sure I understand the point.
> Let's see all the picture of async snapshot: our goal is to minimize a VM
> downtime during the snapshot.
> When we do async snapshot we save vmstate except RAM when a VM is stopped
> using the current L1 table (further initial L1 table). Then, we want the VM
> start running
> and write RAM content. At this time all RAM is write-protected.
> We unprotect each RAM page once it has been written.

Oh, I see, you're basically doing something like postcopy migration. I
was assuming it was more like regular live migration, except that you
would overwrite updated RAM blocks instead of appending them.

I can see your requirement then.

> All those RAM pages should go to the snapshot using the initial L1 table.
> Since the VM is running, it may want to write new disk blocks,
> so we need to use a NEW L1 table to provide this ability. (Am I correct so
> far?)
> Thus, if I understand correctly, we need to use two L1 tables: the initial
> one to store RAM pages
> to the vmstate and the new one to allow disk writings.
> 
> May be I can't see a better way to achieve that. Please, correct me if I'm
> wrong.

I guess I could imagine a different, though probably not better way: We
could internally have a separate low-level operation that moves the VM
state from the active layer to an already existing disk snapshot. Then
you would snapshot the disk and start writing the VM to the active
layer, and when the VM state write has completed you move it into the
snapshot.

The other options is doing what you suggested. There is nothing in the
qcow2 on-disk format that would prevent this, but we would have to
extend the qcow2 driver to allow I/O to inactive L1 tables. This sounds
like a non-trivial amount of code changes, though it would potentially
enable more use cases we never implemented ((read-only) access to
internal snapshots as block nodes, so you could e.g. use block jobs to
export a snapshot).

Kevin


