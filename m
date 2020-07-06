Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8C6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984FF20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjTOug0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984FF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsS7l-00088O-SA
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsS76-0007cA-2A
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:28:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsS72-0002vZ-Vm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594045731;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3mb8s014qn39KYvpLr5TcWlSWfvbid3DmbCJRLOCmQ=;
 b=XjTOug0pTPowyprYsk/JGXKFdOxaFN1U99kF3MYSSApj7k858RB0cVpgROtahZgn0Rf6XW
 laURxvu6Fpam/NsARYyCT+Yv2GOiZAs9zw694sX0P6PBX6rMM+ANLc5gPcCGQUjzDKwWeB
 V/pdTYUWocKEERuezhrAUnbFH8fjIjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-XsHvi9ELNvSv4ZrExI9Zfg-1; Mon, 06 Jul 2020 10:28:42 -0400
X-MC-Unique: XsHvi9ELNvSv4ZrExI9Zfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E02131005510;
 Mon,  6 Jul 2020 14:28:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A00E310013D0;
 Mon,  6 Jul 2020 14:28:37 +0000 (UTC)
Date: Mon, 6 Jul 2020 15:28:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
Message-ID: <20200706142834.GF2603839@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <a747fcd4-d87e-8124-a988-f3ae678c856e@virtuozzo.com>
 <20200703172224.GT2213227@redhat.com>
 <a8015fd3-e73e-c70e-9ba7-fa1bc047a1c2@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <a8015fd3-e73e-c70e-9ba7-fa1bc047a1c2@virtuozzo.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 08:29:08PM +0300, Denis V. Lunev wrote:
> On 7/3/20 8:22 PM, Daniel P. Berrangé wrote:
> > On Fri, Jul 03, 2020 at 08:15:44PM +0300, Denis V. Lunev wrote:
> >> On 7/2/20 8:57 PM, Daniel P. Berrangé wrote:
> >>> When QMP was first introduced some 10+ years ago now, the snapshot
> >>> related commands (savevm/loadvm/delvm) were not converted. This was
> >>> primarily because their implementation causes blocking of the thread
> >>> running the monitor commands. This was (and still is) considered
> >>> undesirable behaviour both in HMP and QMP.
> >>>
> >>> In theory someone was supposed to fix this flaw at some point in the
> >>> past 10 years and bring them into the QMP world. Sadly, thus far it
> >>> hasn't happened as people always had more important things to work
> >>> on. Enterprise apps were much more interested in external snapshots
> >>> than internal snapshots as they have many more features.
> >>>
> >>> Meanwhile users still want to use internal snapshots as there is
> >>> a certainly simplicity in having everything self-contained in one
> >>> image, even though it has limitations. Thus the apps that end up
> >>> executing the savevm/loadvm/delvm via the "human-monitor-command"
> >>> QMP command.
> >>>
> >>>
> >>> IOW, the problematic blocking behaviour that was one of the reasons
> >>> for not having savevm/loadvm/delvm in QMP is experienced by applications
> >>> regardless. By not portting the commands to QMP due to one design flaw,
> >>> we've forced apps and users to suffer from other design flaws of HMP (
> >>> bad error reporting, strong type checking of args, no introspection) for
> >>> an additional 10 years. This feels rather sub-optimal :-(
> >>>
> >>> In practice users don't appear to care strongly about the fact that these
> >>> commands block the VM while they run. I might have seen one bug report
> >>> about it, but it certainly isn't something that comes up as a frequent
> >>> topic except among us QEMU maintainers. Users do care about having
> >>> access to the snapshot feature.
> >>>
> >>> Where I am seeing frequent complaints is wrt the use of OVMF combined
> >>> with snapshots which has some serious pain points. This is getting worse
> >>> as the push to ditch legacy BIOS in favour of UEFI gain momentum both
> >>> across OS vendors and mgmt apps. Solving it requires new parameters to
> >>> the commands, but doing this in HMP is super unappealing.
> >>>
> >>>
> >>>
> >>> After 10 years, I think it is time for us to be a little pragmatic about
> >>> our handling of snapshots commands. My desire is that libvirt should never
> >>> use "human-monitor-command" under any circumstances, because of the
> >>> inherant flaws in HMP as a protocol for machine consumption. If there
> >>> are flaws in QMP commands that's fine. If we fix them in future, we can
> >>> deprecate the current QMP commands and remove them not too long after,
> >>> without being locked in forever.
> >>>
> >>>
> >>> Thus in this series I'm proposing a direct 1-1 mapping of the existing
> >>> HMP commands for savevm/loadvm/delvm into QMP as a first step. This does
> >>> not solve the blocking thread problem, but it does eliminate the error
> >>> reporting, type checking and introspection problems inherant to HMP.
> >>> We're winning on 3 out of the 4 long term problems.
> >>>
> >>> If someone can suggest a easy way to fix the thread blocking problem
> >>> too, I'd be interested to hear it. If it involves a major refactoring
> >>> then I think user are better served by unlocking what look like easy
> >>> wins today.
> >>>
> >>> With a QMP variant, we reasonably deal with the problems related to OVMF:
> >>>
> >>>  - The logic to pick which disk to store the vmstate in is not
> >>>    satsifactory.
> >>>
> >>>    The first block driver state cannot be assumed to be the root disk
> >>>    image, it might be OVMF varstore and we don't want to store vmstate
> >>>    in there.
> >>>
> >>>  - The logic to decide which disks must be snapshotted is hardwired
> >>>    to all disks which are writable
> >>>
> >>>    Again with OVMF there might be a writable varstore, but this can be
> >>>    raw rather than qcow2 format, and thus unable to be snapshotted.
> >>>    While users might wish to snapshot their varstore, in some/many/most
> >>>    cases it is entirely uneccessary. Users are blocked from snapshotting
> >>>    their VM though due to this varstore.
> >>>
> >>> These are solved by adding two parameters to the commands. The first is
> >>> a block device node name that identifies the image to store vmstate in,
> >>> and the second is a list of node names to exclude from snapshots.
> >>>
> >>> In the block code I've only dealt with node names for block devices, as
> >>> IIUC, this is all that libvirt should need in the -blockdev world it now
> >>> lives in. IOW, I've made not attempt to cope with people wanting to use
> >>> these QMP commands in combination with -drive args.
> >>>
> >>> I've done some minimal work in libvirt to start to make use of the new
> >>> commands to validate their functionality, but this isn't finished yet.
> >>>
> >>> My ultimate goal is to make the GNOME Boxes maintainer happy again by
> >>> having internal snapshots work with OVMF:
> >>>
> >>>   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
> >>> f45c5f64048f16a6e
> >>>
> >>> Daniel P. Berrang=C3=A9 (6):
> >>>   migration: improve error reporting of block driver state name
> >>>   migration: introduce savevm, loadvm, delvm QMP commands
> >>>   block: add ability to filter out blockdevs during snapshot
> >>>   block: allow specifying name of block device for vmstate storage
> >>>   migration: support excluding block devs in QMP snapshot commands
> >>>   migration: support picking vmstate disk in QMP snapshot commands
> >>>
> >>>  block/monitor/block-hmp-cmds.c |  4 +-
> >>>  block/snapshot.c               | 68 +++++++++++++++++++------
> >>>  include/block/snapshot.h       | 21 +++++---
> >>>  include/migration/snapshot.h   | 10 +++-
> >>>  migration/savevm.c             | 71 +++++++++++++++++++-------
> >>>  monitor/hmp-cmds.c             | 20 ++------
> >>>  qapi/migration.json            | 91 ++++++++++++++++++++++++++++++++++
> >>>  replay/replay-snapshot.c       |  4 +-
> >>>  softmmu/vl.c                   |  2 +-
> >>>  9 files changed, 228 insertions(+), 63 deletions(-)
> >> I have tried to work in this interface in 2016. That time
> >> we have struggled with the idea that this QMP interface should
> >> be ready to work asynchronously.
> >>
> >> Write-protect userfaultfd was merged into vanilla Linux
> >> thus it is time to async savevm interface, which will also
> >> bring async loadvm and some rework for state storing.
> >>
> >> Thus I think that with the introduction of the QMP interface
> >> we should at least run save VM not from the main
> >> thread but from the background with the event at the end.
> > spawning a thread in which to invoke save_snapshot() and load_snapshot()
> > is easy enough.  I'm not at all clear on what we need in the way of
> > mutex locking though, to make those methods safe to run in a thread
> > that isn't the main event loop.
> 
> I am unsure that this is so easy. We need to be protected from other
> operations
> coming through QMP interface. Right now parallel operations are not allowed.
> 
> > Even with savevm/loadvm being blocking, we could introduce a QMP event
> > straight away, and document that users shouldn't assume the operation
> > is complete until they see the event. That would let us make the commands
> > non-blocking later with same documented semantics.
> OK. Let us assume that you have added QMP savevm as proposed. It is
> sync now. Sooner or later (I hope sooner) we will have to re-implement
> this command with async version of the command, which will bring
> again event etc and thus you will have to add compat layers to the
> libvirt.
> 
> I think that it would be cleaner to start with the interface suitable for
> further (coming) features and not copy obsolete implementation.
> Yes, unfortunately, this is much more complex :(

QMP-ifying the current design gives us a quick win by removing the
dependancy on HMP, for negligible effort. It further lets us unlock
a few extra useful features, again for negligible effort or maint
burden, since we already have pretty much all the code already for HMP.

Supporting internal snapshots is an explicit non-goal for Red Hat in terms
of the products we're using QEMU with, as they all use external snapshots.
Thus I'm very limited in time I can put into this feature myself. I am 
proposing this QMP-ification with my community hat on instead, as it looks
like a quick win to help out various apps today, but it limits the amount
of time I can justify spending on this.

If someone wants to work on a perfect design that's great, but I don't
want us to do nothing now, and continue to wait for a perfect solution
that has shown no sign of arriving in 10 years.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


