Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C653214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C653214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzmqn-0003Ip-Pb
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzmp9-0001Nv-Mw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzmp7-0001rw-MC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzmp4-0001q0-2J; Mon, 19 Aug 2019 14:56:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 689228980FC;
 Mon, 19 Aug 2019 18:56:05 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1453487A1;
 Mon, 19 Aug 2019 18:56:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 20:55:46 +0200
Message-Id: <20190819185602.4267-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 19 Aug 2019 18:56:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/16] qcow2: Let check -r all repair some
 snapshot bits
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

See the v1 cover letter here if you haven=E2=80=99t already:
https://lists.nongnu.org/archive/html/qemu-block/2019-07/msg01290.html

I kept all patches from the previous version because Eric deemed the
patches I might have dropped useful.

I kept the way I implemented fixing overly long snapshot tables, namely
by discarding all snapshots past the maximum end.  Eric criticized this,
because this is indiscriminate (and the last ones have been created the
most recently, but I=E2=80=99m not sure whether we=E2=80=99d generally ra=
ther keep the
oldest or the most recent ones.  Maybe best would be to drop every
second snapshot? :-)).
I kept it as it is, because everything else would require user
interaction.  We currently have no interactive check mode, and I feel
like this is not a place where we need it badly: We introduced our
current snapshot limits in such a way that no sane image would ever hit
them.  If you do hit them, changes are that your image is already
corrupted, so you probably no longer care about your snapshots anyway
and just want to copy the active layer off.

Furthermore, I felt like an interactive mode would be pretty hard to
test thoroughly.  I don=E2=80=99t want to introduce code that probably no=
body
will ever use and that is hardly tested.

I also tried Eric=E2=80=99s suggestion of using bdrv_preadv() in
qcow2_read_snapshots() to read all variable data at once, and while it
was very promising, it doesn=E2=80=99t allow us to skip data (which we mu=
st do
when we want to truncate extra data down to a sane size).  So all in all
I couldn=E2=80=99t make it work.


So, the changes in v2:
- Patch 1: Eric asked from some magic numbers to be removed (very
           reasonable), and endof() will help with that.
- Patch 2: See, it helps!
- Patch 4: Rebased conflicts (because of patch 2), and I should use
           BDRV_REQUEST_MAX_BYTES instead of INT_MAX when I mean the
           former
- Patch 7: Drop magic number [Eric]
- Patch 8: Drop magic number [Eric]
- Patch 10: Instead of dropping all unknown extra data when there is too
            much, just truncate it down to the maximum [Eric]
- Patch 11: When some snapshot table entry has too much extra data and
            we truncate it, that shortens the snapshot table length, so
            we should keep that in mind when calculating whether the
            table is too long
- Patch 12: Rebase conflicts, and dropped a magic number [Eric]
- Patch 14: Drop magic number [Eric]
- Patch 16: Simplified padding calculation [Eric], fixed one test case
            (I used =E2=80=9Csn-size=E2=80=9D instead of =E2=80=9Csn_size=
=E2=80=9D, oops), and added a
            test case for what happens when a snapshot table entry is
            too big and contains an entry with too much extra data (the
            latter should be fixed first and then we should look into
            whether the table is still too long)


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/16:[down] 'include: Move endof() up from hw/virtio/virtio.h'
002/16:[down] 'qcow2: Use endof()'
003/16:[----] [--] 'qcow2: Add Error ** to qcow2_read_snapshots()'
004/16:[0012] [FC] 'qcow2: Keep unknown extra snapshot data'
005/16:[----] [--] 'qcow2: Make qcow2_write_snapshots() public'
006/16:[----] [--] 'qcow2: Put qcow2_upgrade() into an own function'
007/16:[0005] [FC] 'qcow2: Write v3-compliant snapshot list on upgrade'
008/16:[0004] [FC] 'qcow2: Separate qcow2_check_read_snapshot_table()'
009/16:[----] [--] 'qcow2: Add qcow2_check_fix_snapshot_table()'
010/16:[0038] [FC] 'qcow2: Fix broken snapshot table entries'
011/16:[down] 'qcow2: Keep track of the snapshot table length'
012/16:[0003] [FC] 'qcow2: Fix overly long snapshot tables'
013/16:[----] [--] 'qcow2: Repair snapshot table with too many entries'
014/16:[0005] [FC] 'qcow2: Fix v3 snapshot table entry compliancy'
015/16:[----] [--] 'iotests: Add peek_file* functions'
016/16:[0125] [FC] 'iotests: Test qcow2's snapshot table handling'


Max Reitz (16):
  include: Move endof() up from hw/virtio/virtio.h
  qcow2: Use endof()
  qcow2: Add Error ** to qcow2_read_snapshots()
  qcow2: Keep unknown extra snapshot data
  qcow2: Make qcow2_write_snapshots() public
  qcow2: Put qcow2_upgrade() into its own function
  qcow2: Write v3-compliant snapshot list on upgrade
  qcow2: Separate qcow2_check_read_snapshot_table()
  qcow2: Add qcow2_check_fix_snapshot_table()
  qcow2: Fix broken snapshot table entries
  qcow2: Keep track of the snapshot table length
  qcow2: Fix overly long snapshot tables
  qcow2: Repair snapshot table with too many entries
  qcow2: Fix v3 snapshot table entry compliancy
  iotests: Add peek_file* functions
  iotests: Test qcow2's snapshot table handling

 block/qcow2.h                |  15 +-
 include/hw/virtio/virtio.h   |   7 -
 include/qemu/compiler.h      |   7 +
 block/qcow2-snapshot.c       | 323 +++++++++++++++++++--
 block/qcow2.c                | 155 +++++++++--
 hw/block/virtio-blk.c        |   4 +-
 hw/net/virtio-net.c          |  10 +-
 tests/qemu-iotests/261       | 523 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/261.out   | 346 +++++++++++++++++++++++
 tests/qemu-iotests/common.rc |  20 ++
 tests/qemu-iotests/group     |   1 +
 11 files changed, 1354 insertions(+), 57 deletions(-)
 create mode 100755 tests/qemu-iotests/261
 create mode 100644 tests/qemu-iotests/261.out

--=20
2.21.0


