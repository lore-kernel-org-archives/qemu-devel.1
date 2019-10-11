Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9681C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F12B214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F12B214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwrx-000334-RZ
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwq6-00016B-7o
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwq5-0006Kk-40
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwq2-0006JY-H0; Fri, 11 Oct 2019 11:28:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94FC530ADBA1;
 Fri, 11 Oct 2019 15:28:17 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1088C5D6C8;
 Fri, 11 Oct 2019 15:28:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/16] qcow2: Let check -r all repair some snapshot bits
Date: Fri, 11 Oct 2019 17:27:58 +0200
Message-Id: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 11 Oct 2019 15:28:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

The v1 cover letter explained this series=E2=80=99s purpose:
https://lists.nongnu.org/archive/html/qemu-block/2019-07/msg01290.html

The v2 cover letter explained the v2 changes:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00921.html


The only changes in v3 are:
- Patches 12 and 13: Added notes to the commit messages why it=E2=80=99s =
OK to
                     not let the user choose which snapshots to drop

(I wanted to also address Eric=E2=80=99s idea of letting
QCowSnapshot.extra_data_size be always >=3D sizeof(QCowSnapshotExtraData)
and thus save the MAX(sizeof(extra), sn->extra_data_size) in
qcow2_write_snapshots(), but that doesn=E2=80=99t really work, because th=
en we
have no way of knowing later whether the image is compliant and thus
needs fixing or not.  He gave me an R-b anyway, so I guess it=E2=80=99s f=
ine.
O:-))

This series now has R-bs from Eric on all patches.  I=E2=80=99m only post=
ing it
because I felt a bit bad about just taking the series as-is and add the
commit notes to 12 and 13 while applying it.
(Also, maybe there is someone who saw me have a bit of discussion with
Eric and thus assumed I would definitely send a v3 that they could then
review.)


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


