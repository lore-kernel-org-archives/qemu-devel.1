Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA836C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DAB20708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbY9WSHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DAB20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTng-0008LP-SZ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsTmo-0006zN-2F
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:16:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsTmm-0005zn-7G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594052163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNK82IqL+jti7ZQpDh3vhGrQEDlavYNK4Ggvbpe0zv8=;
 b=RbY9WSHF3afDl8ICjODXYd+BJoqaJR1Ls1nVA0wDoSZaYzmgAC1BRNzsXxm2OWtG8gUcYm
 2ToOJ6jVbRUOSWa2Psf/UUoY9Vji4BpuYmAevPvDPWC0g6YjYosU/TSuYAI3r7atYmtXeb
 T4IltOML8wGLmliZcqNcZuPsX/W2u5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-L_lwvBnNNgyOsuoFu8LpaA-1; Mon, 06 Jul 2020 12:15:59 -0400
X-MC-Unique: L_lwvBnNNgyOsuoFu8LpaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C441030981;
 Mon,  6 Jul 2020 16:15:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-203.ams2.redhat.com [10.36.114.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE6431A918;
 Mon,  6 Jul 2020 16:15:56 +0000 (UTC)
Date: Mon, 6 Jul 2020 18:15:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
Message-ID: <20200706161555.GE5052@linux.fritz.box>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
 <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
 <20200702182452.GP1888119@redhat.com>
 <20200703154933.GE6641@work-vm>
 <20200703160235.GM2213227@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703160235.GM2213227@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.07.2020 um 18:02 hat Daniel P. Berrangé geschrieben:
> On Fri, Jul 03, 2020 at 04:49:33PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > On Thu, Jul 02, 2020 at 01:12:52PM -0500, Eric Blake wrote:
> > > > On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> > > > > savevm, loadvm and delvm are some of the few commands that have never
> > > > > been converted to use QMP. The primary reason for this lack of
> > > > > conversion is that they block execution of the thread for as long as
> > > > > they run.
> > > > > 
> > > > > Despite this downside, however, libvirt and applications using libvirt
> > > > > has used these commands for as long as QMP has existed, via the
> > > > > "human-monitor-command" passthrough command. IOW, while it is clearly
> > > > > desirable to be able to fix the blocking problem, this is not an
> > > > > immediate obstacle to real world usage.
> > > > > 
> > > > > Meanwhile there is a need for other features which involve adding new
> > > > > parameters to the commands. This is possible with HMP passthrough, but
> > > > > it provides no reliable way for apps to introspect features, so using
> > > > > QAPI modelling is highly desirable.
> > > > > 
> > > > > This patch thus introduces trival savevm, loadvm, delvm commands
> > > > 
> > > > trivial
> > > > 
> > > > > to QMP that are functionally identical to the HMP counterpart, including
> > > > > the blocking problem.
> > > > 
> > > > Should we name them 'x-savevm', 'x-loadvm', 'x-delvm' to give ourselves room
> > > > to change them when we DO solve the blocking issue?  Or will the solution of
> > > > the blocking issue introduce new QMP commands, at which point we can add QMP
> > > > deprecation markers on these commands to eventually retire them?
> > > 
> > > I was in two minds about this, so I'm open to arguments either way.
> > > 
> > > The primary goal is for libvirt to consume the APIs as soon as possible,
> > > and generally libvirt doesn't want todo this is they are declared experimental
> > > via a "x-" prefix. So that pushes me away from "x-".
> > > 
> > > If we don't have an "x-" prefix and want to make changes, we can add extra
> > > parameters to trigger new behaviour in backwards compatible manner. Or we can
> > > simply deprecate these commands, deleting them 2 releases later, while adding
> > > completely new commands.
> > > 
> > > If we think the prposed design will definitely need incompatible changes in
> > > a very short time frame though, that would push towards "x-".
> > > 
> > > So IMHO the right answer largely depends on whether there is a credible
> > > strategy to implement the ideal non-blocking solution in a reasonable amount
> > > of time. I can't justify spending much time on this myself, but I'm willing
> > > to consider & try proposals for solving the blocking problem if they're not
> > > too complex / invasive.
> > 
> > Remind me, what was the problem with just making a block: migration
> > channel, and then we can migrate to it?

For normal migration, the VM is still running and changing its state, so
you would have to wait until migration completes and then snapshot the
disk. This is possible, but it would store redundant data and the
snapshot would be at an arbitrary point after actually receiving the
snapshot command, which is probably not what users expect.

So what you really want is some kind of postcopy migration inside the
same process. Virtuozzo had a look at this some years ago and when the
discussion comes up again, they say they are still kind of interested,
though it's not their priority. I have never seen the actual code, but I
imagine it's not trivial (unless the migration code already supports
something like this today, but I'm not aware of another use case for it,
so probably not?)

> migration only does vmstate, not disks. The current blockdev commands
> are all related to external snapshots, nothing for internal snapshots
> AFAIK. So we still need commands to load/save internal snapshots of
> the disk data in the qcow2 files.
> 
> So we could look at loadvm/savevm conceptually as a syntax sugar above
> a migration transport that targets disk images, and blockdev QMP command
> that can do internal snapshots. Neither of these exist though and feel
> like a significantly larger amount of work than using existing functionality
> that is currently working.

There is blockdev-snapshot-internal-sync, which does a disk-only
snapshot of a single node. A snapshot of multiple nodes can be taken by
putting multiple blockdev-snapshot-internal-sync inside a 'transaction'
command.

If we want to build on top of this, we'd have to implement a
transactionable command for storing only the VM state to a specific
node. This would probably still be a long-running job.

So some of it does exist, but I'm torn on whether separating things into
different commands is actually a good idea or not.

Kevin


