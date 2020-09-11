Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7108C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047E9221E7
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITnu0NmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047E9221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGhcf-0001kp-RK
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGhc7-0001HL-8n
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:53:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGhc4-0003sE-7S
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599825186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bm9kxq90U8Au3LKx3RZe6tHGfXscSktIeG7368KtnR8=;
 b=ITnu0NmSWrsc7oWlX98CRolyekwmpHMTagMqiFWRHg84X9veDYbZqHr+Fb0m80cQ9C4rJJ
 OPhRZQpfRV/6hFxljAJ5La4HQ1/ricqUIKHh7iQDBBVkO7jYwUgNSL+skZsCgSMpenqrvw
 aP2mghwe5NvQqvPcjXmd5E8Dfpgq9fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-Xzq8s0P8NkWZgv-OTHzblg-1; Fri, 11 Sep 2020 07:52:11 -0400
X-MC-Unique: Xzq8s0P8NkWZgv-OTHzblg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1794981F007;
 Fri, 11 Sep 2020 11:52:10 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7556060C07;
 Fri, 11 Sep 2020 11:52:07 +0000 (UTC)
Date: Fri, 11 Sep 2020 12:52:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/7] migration: bring improved savevm/loadvm/delvm to
 QMP
Message-ID: <20200911115204.GF3310@work-vm>
References: <20200827111606.1408275-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827111606.1408275-1-berrange@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin:
  While we're still arguing about details of the last commit; can we get
the first few commits in - they seem to be generally nice cleanups/error
handling.

Dave

* Daniel P. Berrangé (berrange@redhat.com) wrote:
>  v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html
>  v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07523.html
> 
> When QMP was first introduced some 10+ years ago now, the snapshot
> related commands (savevm/loadvm/delvm) were not converted. This was
> primarily because their implementation causes blocking of the thread
> running the monitor commands. This was (and still is) considered
> undesirable behaviour both in HMP and QMP.
> 
> In theory someone was supposed to fix this flaw at some point in the
> past 10 years and bring them into the QMP world. Sadly, thus far it
> hasn't happened as people always had more important things to work
> on. Enterprise apps were much more interested in external snapshots
> than internal snapshots as they have many more features.
> 
> Meanwhile users still want to use internal snapshots as there is
> a certainly simplicity in having everything self-contained in one
> image, even though it has limitations. Thus the apps that end up
> executing the savevm/loadvm/delvm via the "human-monitor-command"
> QMP command.
> 
> IOW, the problematic blocking behaviour that was one of the reasons
> for not having savevm/loadvm/delvm in QMP is experienced by applications
> regardless. By not portting the commands to QMP due to one design flaw,
> we've forced apps and users to suffer from other design flaws of HMP (
> bad error reporting, strong type checking of args, no introspection) for
> an additional 10 years. This feels rather sub-optimal :-(
> 
> In practice users don't appear to care strongly about the fact that these
> commands block the VM while they run. I might have seen one bug report
> about it, but it certainly isn't something that comes up as a frequent
> topic except among us QEMU maintainers. Users do care about having
> access to the snapshot feature.
> 
> Where I am seeing frequent complaints is wrt the use of OVMF combined
> with snapshots which has some serious pain points. This is getting worse
> as the push to ditch legacy BIOS in favour of UEFI gain momentum both
> across OS vendors and mgmt apps. Solving it requires new parameters to
> the commands, but doing this in HMP is super unappealing.
> 
> After 10 years, I think it is time for us to be a little pragmatic about
> our handling of snapshots commands. My desire is that libvirt should never
> use "human-monitor-command" under any circumstances, because of the
> inherant flaws in HMP as a protocol for machine consumption.
> 
> Thus in this series I'm proposing a fairly direct mapping of the existing
> HMP commands for savevm/loadvm/delvm into QMP as a first step. This does
> not solve the blocking thread problem, but it does put in a place a
> design using the jobs framework which can facilitate solving it later.
> It does also solve the error reporting, type checking and introspection
> problems inherant to HMP. So we're winning on 3 out of the 4 problems,
> and pushed apps to a QMP design that will let us solve the last
> remaining problem.
> 
> With a QMP variant, we reasonably deal with the problems related to OVMF:
> 
>  - The logic to pick which disk to store the vmstate in is not
>    satsifactory.
> 
>    The first block driver state cannot be assumed to be the root disk
>    image, it might be OVMF varstore and we don't want to store vmstate
>    in there.
> 
>  - The logic to decide which disks must be snapshotted is hardwired
>    to all disks which are writable
> 
>    Again with OVMF there might be a writable varstore, but this can be
>    raw rather than qcow2 format, and thus unable to be snapshotted.
>    While users might wish to snapshot their varstore, in some/many/most
>    cases it is entirely uneccessary. Users are blocked from snapshotting
>    their VM though due to this varstore.
> 
> These are solved by adding two parameters to the commands. The first is
> a block device node name that identifies the image to store vmstate in,
> and the second is a list of node names to include for the snapshots.
> If the list of nodes isn't given, it falls back to the historical
> behaviour of using all disks matching some undocumented criteria.
> 
> In the block code I've only dealt with node names for block devices, as
> IIUC, this is all that libvirt should need in the -blockdev world it now
> lives in. IOW, I've made not attempt to cope with people wanting to use
> these QMP commands in combination with -drive args, as libvirt will
> never use -drive with a QEMU new enough to have these new commands.
> 
> The main limitations of this current impl
> 
>  - The snapshot process runs serialized in the main thread. ie QEMU
>    guest execution is blocked for the duration. The job framework
>    lets us fix this in future without changing the QMP semantics
>    exposed to the apps.
> 
>  - Most vmstate loading errors just go to stderr, as they are not
>    using Error **errp reporting. Thus the job framework just
>    reports a fairly generic message
> 
>      "Error -22 while loading VM state"
> 
>    Again this can be fixed later without changing the QMP semantics
>    exposed to apps.
> 
> I've done some minimal work in libvirt to start to make use of the new
> commands to validate their functionality, but this isn't finished yet.
> 
> My ultimate goal is to make the GNOME Boxes maintainer happy again by
> having internal snapshots work with OVMF:
> 
>   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
> f45c5f64048f16a6e
> 
> Changed in v3:
> 
>  - Schedule a bottom half to escape from coroutine context in
>    the jobs. This is needed because the locking in the snapshot
>    code goes horribly wrong when run from a background coroutine
>    instead of the main event thread.
> 
>  - Re-factor way we iterate over devices, so that we correctly
>    report non-existant devices passed by the user over QMP.
> 
>  - Add QAPI docs notes about limitations wrt vmstate error
>    reporting (it all goes to stderr not an Error **errp)
>    so QMP only gets a fairly generic error message currently.
> 
>  - Add I/O test to validate many usage scenarios / errors
> 
>  - Add I/O test helpers to handle QMP events with a deterministic
>    ordering
> 
>  - Ensure 'delete-snapshot' reports an error if requesting
>    delete from devices that don't support snapshot, instead of
>    silently succeeding with no erro.
> 
> Changed in v2:
> 
>  - Use new command names "snapshot-{load,save,delete}" to make it
>    clear that these are different from the "savevm|loadvm|delvm"
>    as they use the Job framework
> 
>  - Use an include list for block devs, not an exclude list
> 
> Daniel P. Berrang=C3=A9 (7):
>   migration: improve error reporting of block driver state name
>   block: push error reporting into bdrv_all_*_snapshot functions
>   migration: stop returning errno from load_snapshot()
>   block: add ability to specify list of blockdevs during snapshot
>   block: allow specifying name of block device for vmstate storage
>   iotests: add support for capturing and matching QMP events
>   migration: introduce snapshot-{save,load,delete} QMP commands
> 
>  block/monitor/block-hmp-cmds.c |   7 +-
>  block/snapshot.c               | 233 ++++++++++++++-------
>  include/block/snapshot.h       |  19 +-
>  include/migration/snapshot.h   |  10 +-
>  migration/savevm.c             | 258 +++++++++++++++++++----
>  monitor/hmp-cmds.c             |  11 +-
>  qapi/job.json                  |   9 +-
>  qapi/migration.json            | 135 ++++++++++++
>  replay/replay-snapshot.c       |   4 +-
>  softmmu/vl.c                   |   2 +-
>  tests/qemu-iotests/267.out     |  14 +-
>  tests/qemu-iotests/310         | 255 +++++++++++++++++++++++
>  tests/qemu-iotests/310.out     | 369 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/common.qemu | 107 +++++++++-
>  tests/qemu-iotests/group       |   1 +
>  15 files changed, 1289 insertions(+), 145 deletions(-)
>  create mode 100755 tests/qemu-iotests/310
>  create mode 100644 tests/qemu-iotests/310.out
> 
> --=20
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


