Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC2C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C709620872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMeTiZ3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C709620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9Gw-0002Uh-KT
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9FN-0000kL-8H
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:35:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9FL-0002mk-12
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600169737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ii58a9TAUTFMI8Hda6XMiFyrLQyFQaqZqapyHfjayl0=;
 b=PMeTiZ3n0ZdC/Q1lB4x+wveTWeEshNM+cwtdcKOVSgjrTqO5tGWJH3xpZtxG0mDgXkUDM+
 0t+kEb319t/w9rDKQnWOi/78GGtuWj0VqbvOFgAn2lSJVYv9TPhVZTBFPxElSGjvzfqe6O
 9VZ7Bt/klveScSuLww6XbD0P5E93nzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-7uNaZBe7P-axkP7oDVBHMA-1; Tue, 15 Sep 2020 07:35:33 -0400
X-MC-Unique: 7uNaZBe7P-axkP7oDVBHMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3390910BBED1;
 Tue, 15 Sep 2020 11:35:32 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 003A9747B0;
 Tue, 15 Sep 2020 11:35:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/9] migration: bring improved savevm/loadvm/delvm to QMP
Date: Tue, 15 Sep 2020 12:35:14 +0100
Message-Id: <20200915113523.2520317-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html=0D
 v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07523.html=0D
 v3: https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07076.html=0D
=0D
This series aims to provide a better designed replacement for the=0D
savevm/loadvm/delvm HMP commands, which despite their flaws continue=0D
to be actively used in the QMP world via the HMP command passthrough=0D
facility.=0D
=0D
The main problems addressed are:=0D
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
 - The commands are synchronous blocking execution and returning=0D
   errors immediately.=0D
=0D
   This is partially addressed by integrating with the job framework.=0D
   This forces the client to use the async commands to determine=0D
   the completion status or error message from the operations.=0D
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
Changed in v4:=0D
=0D
 - Make the device lists mandatory, dropping all support for=0D
   QEMU's built-in heuristics to select devices.=0D
=0D
 - Improve some error reporting and I/O test coverage=0D
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
Daniel P. Berrang=3DC3=3DA9 (9):=0D
  block: push error reporting into bdrv_all_*_snapshot functions=0D
  migration: stop returning errno from load_snapshot()=0D
  block: add ability to specify list of blockdevs during snapshot=0D
  block: allow specifying name of block device for vmstate storage=0D
  migration: control whether snapshots are ovewritten=0D
  migration: wire up support for snapshot device selection=0D
  migration: introduce a delete_snapshot wrapper=0D
  iotests: add support for capturing and matching QMP events=0D
  migration: introduce snapshot-{save,load,delete} QMP commands=0D
=0D
 block/monitor/block-hmp-cmds.c |   7 +-=0D
 block/snapshot.c               | 248 ++++++++++++++------=0D
 include/block/snapshot.h       |  23 +-=0D
 include/migration/snapshot.h   |  14 +-=0D
 migration/savevm.c             | 260 +++++++++++++++++----=0D
 monitor/hmp-cmds.c             |  11 +-=0D
 qapi/job.json                  |   9 +-=0D
 qapi/migration.json            | 120 ++++++++++=0D
 replay/replay-snapshot.c       |   4 +-=0D
 softmmu/vl.c                   |   2 +-=0D
 tests/qemu-iotests/267.out     |  10 +-=0D
 tests/qemu-iotests/310         | 338 +++++++++++++++++++++++++++=0D
 tests/qemu-iotests/310.out     | 412 +++++++++++++++++++++++++++++++++=0D
 tests/qemu-iotests/common.qemu | 107 ++++++++-=0D
 tests/qemu-iotests/group       |   1 +=0D
 15 files changed, 1425 insertions(+), 141 deletions(-)=0D
 create mode 100755 tests/qemu-iotests/310=0D
 create mode 100644 tests/qemu-iotests/310.out=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


