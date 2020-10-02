Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E1C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F10206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9j5uqgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F10206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONz4-0002EY-GV
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONud-0004hN-N9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONua-0003Cm-My
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601656079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QzpltHDiRwVVs5pr+7b6piarUlrcIy799VpHwZ5+buQ=;
 b=g9j5uqgZITRZcAYs/7NZmN3eNeF3InrMnPNyuqR/twkC+NQpjxs4tjh2/GrMt33L9Een8F
 hOSCSlQBNTWACmyfXerpLNbFZgu7GK0+CDpZuRzdYQSBGNwY1TN96e+yoXImTBCIRLvnEG
 dGJCeKjHfJyfJVUBvz9xMMYfyoR3SSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-DZ6HcJDsN-u6bCBVD4yrUQ-1; Fri, 02 Oct 2020 12:27:53 -0400
X-MC-Unique: DZ6HcJDsN-u6bCBVD4yrUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 772F7100C636;
 Fri,  2 Oct 2020 16:27:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E940A1000320;
 Fri,  2 Oct 2020 16:27:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/10] migration: bring improved savevm/loadvm/delvm to QMP
Date: Fri,  2 Oct 2020 17:27:37 +0100
Message-Id: <20201002162747.3123597-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html=0D
 v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07523.html=0D
 v3: https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07076.html=0D
 v4: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg05221.html=0D
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
Changed in v5:=0D
=0D
 - Fix prevention of tag overwriting=0D
 - Refactor and expand test suite coverage to validate=0D
   more negative scenarios=0D
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
Daniel P. Berrang=3DC3=3DA9 (10):=0D
  block: push error reporting into bdrv_all_*_snapshot functions=0D
  migration: stop returning errno from load_snapshot()=0D
  block: add ability to specify list of blockdevs during snapshot=0D
  block: allow specifying name of block device for vmstate storage=0D
  block: rename and alter bdrv_all_find_snapshot semantics=0D
  migration: control whether snapshots are ovewritten=0D
  migration: wire up support for snapshot device selection=0D
  migration: introduce a delete_snapshot wrapper=0D
  iotests: add support for capturing and matching QMP events=0D
  migration: introduce snapshot-{save,load,delete} QMP commands=0D
=0D
 block/monitor/block-hmp-cmds.c |   7 +-=0D
 block/snapshot.c               | 256 +++++++++++++++------=0D
 include/block/snapshot.h       |  23 +-=0D
 include/migration/snapshot.h   |  14 +-=0D
 migration/savevm.c             | 282 +++++++++++++++++++----=0D
 monitor/hmp-cmds.c             |  12 +-=0D
 qapi/job.json                  |   9 +-=0D
 qapi/migration.json            | 120 ++++++++++=0D
 replay/replay-snapshot.c       |   5 +-=0D
 softmmu/vl.c                   |   2 +-=0D
 tests/qemu-iotests/267.out     |  12 +-=0D
 tests/qemu-iotests/310         | 385 +++++++++++++++++++++++++++++++=0D
 tests/qemu-iotests/310.out     | 407 +++++++++++++++++++++++++++++++++=0D
 tests/qemu-iotests/common.qemu | 107 ++++++++-=0D
 tests/qemu-iotests/group       |   1 +=0D
 15 files changed, 1500 insertions(+), 142 deletions(-)=0D
 create mode 100755 tests/qemu-iotests/310=0D
 create mode 100644 tests/qemu-iotests/310.out=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


