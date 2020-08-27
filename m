Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D9DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AB122B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcAhpnWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AB122B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFu0-0005Im-TC
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtG-00049O-1W
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtC-0000mZ-Qa
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598526977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jQAWyHKD6x1jC9LbOgFnarxu5345NQX/mkh71dpnMNs=;
 b=KcAhpnWi25lIoVph8gFVjM0K2u2vWIRrnzyIyVG7pyZgokNx/cW3glCQnVsxzgaazbz059
 Qko7YmS6vjyuDpn15uKgB+XULHcX6zoUpVLsYLmu0WpSTOhK2Mrf/wZFyI5dx2pLJKk1hT
 xWVZmzuiOcE859Thy8HglgdRjsFBU1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-0tYRaKu3P3OfiYOuSKDP6g-1; Thu, 27 Aug 2020 07:16:13 -0400
X-MC-Unique: 0tYRaKu3P3OfiYOuSKDP6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0901D420E7;
 Thu, 27 Aug 2020 11:16:12 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 909B5757EC;
 Thu, 27 Aug 2020 11:16:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] migration: bring improved savevm/loadvm/delvm to QMP
Date: Thu, 27 Aug 2020 12:15:59 +0100
Message-Id: <20200827111606.1408275-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html=0D
 v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07523.html=0D
=0D
When QMP was first introduced some 10+ years ago now, the snapshot=0D
related commands (savevm/loadvm/delvm) were not converted. This was=0D
primarily because their implementation causes blocking of the thread=0D
running the monitor commands. This was (and still is) considered=0D
undesirable behaviour both in HMP and QMP.=0D
=0D
In theory someone was supposed to fix this flaw at some point in the=0D
past 10 years and bring them into the QMP world. Sadly, thus far it=0D
hasn't happened as people always had more important things to work=0D
on. Enterprise apps were much more interested in external snapshots=0D
than internal snapshots as they have many more features.=0D
=0D
Meanwhile users still want to use internal snapshots as there is=0D
a certainly simplicity in having everything self-contained in one=0D
image, even though it has limitations. Thus the apps that end up=0D
executing the savevm/loadvm/delvm via the "human-monitor-command"=0D
QMP command.=0D
=0D
IOW, the problematic blocking behaviour that was one of the reasons=0D
for not having savevm/loadvm/delvm in QMP is experienced by applications=0D
regardless. By not portting the commands to QMP due to one design flaw,=0D
we've forced apps and users to suffer from other design flaws of HMP (=0D
bad error reporting, strong type checking of args, no introspection) for=0D
an additional 10 years. This feels rather sub-optimal :-(=0D
=0D
In practice users don't appear to care strongly about the fact that these=
=0D
commands block the VM while they run. I might have seen one bug report=0D
about it, but it certainly isn't something that comes up as a frequent=0D
topic except among us QEMU maintainers. Users do care about having=0D
access to the snapshot feature.=0D
=0D
Where I am seeing frequent complaints is wrt the use of OVMF combined=0D
with snapshots which has some serious pain points. This is getting worse=0D
as the push to ditch legacy BIOS in favour of UEFI gain momentum both=0D
across OS vendors and mgmt apps. Solving it requires new parameters to=0D
the commands, but doing this in HMP is super unappealing.=0D
=0D
After 10 years, I think it is time for us to be a little pragmatic about=0D
our handling of snapshots commands. My desire is that libvirt should never=
=0D
use "human-monitor-command" under any circumstances, because of the=0D
inherant flaws in HMP as a protocol for machine consumption.=0D
=0D
Thus in this series I'm proposing a fairly direct mapping of the existing=
=0D
HMP commands for savevm/loadvm/delvm into QMP as a first step. This does=0D
not solve the blocking thread problem, but it does put in a place a=0D
design using the jobs framework which can facilitate solving it later.=0D
It does also solve the error reporting, type checking and introspection=0D
problems inherant to HMP. So we're winning on 3 out of the 4 problems,=0D
and pushed apps to a QMP design that will let us solve the last=0D
remaining problem.=0D
=0D
With a QMP variant, we reasonably deal with the problems related to OVMF:=
=0D
=0D
 - The logic to pick which disk to store the vmstate in is not=0D
   satsifactory.=0D
=0D
   The first block driver state cannot be assumed to be the root disk=0D
   image, it might be OVMF varstore and we don't want to store vmstate=0D
   in there.=0D
=0D
 - The logic to decide which disks must be snapshotted is hardwired=0D
   to all disks which are writable=0D
=0D
   Again with OVMF there might be a writable varstore, but this can be=0D
   raw rather than qcow2 format, and thus unable to be snapshotted.=0D
   While users might wish to snapshot their varstore, in some/many/most=0D
   cases it is entirely uneccessary. Users are blocked from snapshotting=0D
   their VM though due to this varstore.=0D
=0D
These are solved by adding two parameters to the commands. The first is=0D
a block device node name that identifies the image to store vmstate in,=0D
and the second is a list of node names to include for the snapshots.=0D
If the list of nodes isn't given, it falls back to the historical=0D
behaviour of using all disks matching some undocumented criteria.=0D
=0D
In the block code I've only dealt with node names for block devices, as=0D
IIUC, this is all that libvirt should need in the -blockdev world it now=0D
lives in. IOW, I've made not attempt to cope with people wanting to use=0D
these QMP commands in combination with -drive args, as libvirt will=0D
never use -drive with a QEMU new enough to have these new commands.=0D
=0D
The main limitations of this current impl=0D
=0D
 - The snapshot process runs serialized in the main thread. ie QEMU=0D
   guest execution is blocked for the duration. The job framework=0D
   lets us fix this in future without changing the QMP semantics=0D
   exposed to the apps.=0D
=0D
 - Most vmstate loading errors just go to stderr, as they are not=0D
   using Error **errp reporting. Thus the job framework just=0D
   reports a fairly generic message=0D
=0D
     "Error -22 while loading VM state"=0D
=0D
   Again this can be fixed later without changing the QMP semantics=0D
   exposed to apps.=0D
=0D
I've done some minimal work in libvirt to start to make use of the new=0D
commands to validate their functionality, but this isn't finished yet.=0D
=0D
My ultimate goal is to make the GNOME Boxes maintainer happy again by=0D
having internal snapshots work with OVMF:=0D
=0D
  https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb=
5e=3D=0D
f45c5f64048f16a6e=0D
=0D
Changed in v3:=0D
=0D
 - Schedule a bottom half to escape from coroutine context in=0D
   the jobs. This is needed because the locking in the snapshot=0D
   code goes horribly wrong when run from a background coroutine=0D
   instead of the main event thread.=0D
=0D
 - Re-factor way we iterate over devices, so that we correctly=0D
   report non-existant devices passed by the user over QMP.=0D
=0D
 - Add QAPI docs notes about limitations wrt vmstate error=0D
   reporting (it all goes to stderr not an Error **errp)=0D
   so QMP only gets a fairly generic error message currently.=0D
=0D
 - Add I/O test to validate many usage scenarios / errors=0D
=0D
 - Add I/O test helpers to handle QMP events with a deterministic=0D
   ordering=0D
=0D
 - Ensure 'delete-snapshot' reports an error if requesting=0D
   delete from devices that don't support snapshot, instead of=0D
   silently succeeding with no erro.=0D
=0D
Changed in v2:=0D
=0D
 - Use new command names "snapshot-{load,save,delete}" to make it=0D
   clear that these are different from the "savevm|loadvm|delvm"=0D
   as they use the Job framework=0D
=0D
 - Use an include list for block devs, not an exclude list=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (7):=0D
  migration: improve error reporting of block driver state name=0D
  block: push error reporting into bdrv_all_*_snapshot functions=0D
  migration: stop returning errno from load_snapshot()=0D
  block: add ability to specify list of blockdevs during snapshot=0D
  block: allow specifying name of block device for vmstate storage=0D
  iotests: add support for capturing and matching QMP events=0D
  migration: introduce snapshot-{save,load,delete} QMP commands=0D
=0D
 block/monitor/block-hmp-cmds.c |   7 +-=0D
 block/snapshot.c               | 233 ++++++++++++++-------=0D
 include/block/snapshot.h       |  19 +-=0D
 include/migration/snapshot.h   |  10 +-=0D
 migration/savevm.c             | 258 +++++++++++++++++++----=0D
 monitor/hmp-cmds.c             |  11 +-=0D
 qapi/job.json                  |   9 +-=0D
 qapi/migration.json            | 135 ++++++++++++=0D
 replay/replay-snapshot.c       |   4 +-=0D
 softmmu/vl.c                   |   2 +-=0D
 tests/qemu-iotests/267.out     |  14 +-=0D
 tests/qemu-iotests/310         | 255 +++++++++++++++++++++++=0D
 tests/qemu-iotests/310.out     | 369 +++++++++++++++++++++++++++++++++=0D
 tests/qemu-iotests/common.qemu | 107 +++++++++-=0D
 tests/qemu-iotests/group       |   1 +=0D
 15 files changed, 1289 insertions(+), 145 deletions(-)=0D
 create mode 100755 tests/qemu-iotests/310=0D
 create mode 100644 tests/qemu-iotests/310.out=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


