Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755FAC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E762089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E762089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVx7-0007ml-Iy
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33377)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsVsE-0006Vh-9d
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsVsC-0002RT-Hk
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsVs7-0002O4-2R; Tue, 30 Jul 2019 13:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62F21308FB93;
 Tue, 30 Jul 2019 17:25:10 +0000 (UTC)
Received: from localhost (ovpn-116-164.ams2.redhat.com [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6A7C5D9C5;
 Tue, 30 Jul 2019 17:25:09 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 19:24:55 +0200
Message-Id: <20190730172508.19911-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 30 Jul 2019 17:25:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 00/13] qcow2: Let check -r all repair
 some snapshot bits
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

As Eric reports in https://bugzilla.redhat.com/show_bug.cgi?id=3D1727347,
qemu-img amend has a bug when it comes to converting qcow2 v2 images to
v3: In v3, every snapshot table entry requires at least 16 bytes of
extra metadata to be present, which isn=E2=80=99t the case for v2 images.
Currently, qemu-img amend doesn=E2=80=99t take care of updating the snaps=
hot
table, so the image is a bit corrupt afterwards (luckily, qemu doesn=E2=80=
=99t
take notice, though).

This yields the following patches:
- Patch 3: Helper patch
- Patch 4: Helper patch, so we can actually do more than just to bump up
  the version number when upgrading a qcow2 image from v2 to v3
- Patch 5: The fix

Eric also points out that qemu-img check does not see any problem with
such images and doesn=E2=80=99t fix them, so:
- Patch 11: Makes qemu-img check report if a snapshot table entry has
  too little extra data, and repair it with -r all
  (Patches 6 and 7 add the necessary infrastructure so we can check and
  repair the snapshot table at all.)

Then I got the glorious idea of =E2=80=9CHey, if I want to see how much e=
xtra
data a snapshot table entry has outside of qcow2_read_snapshots(), I
should add a field that reports that value to QCowSnapshot.  And if I do
that, I might as well make the qcow2 driver interpret the specification
a bit more literally, namely it should ignore all unknown extra data,
that is (as I interpret it), keep it in memory and write it back when
updating the snapshot table.=E2=80=9D

That led to patch 2.  Maybe you find that stupid, in which case we can
totally drop patch 2 (with some changes to other patches).

Anyway.  Because of this, qcow2_read_snapshots() suddenly got more error
case, so I thought now would be a good time to give it an Error **
parameter.  Cue patch 1.

At this point:
(1) I had infrastructure for repairing a snapshot table in
    qemu-img check -r all, and
(2) I had added a new error case if a snapshot table entry has a
    suspiciously large amount of extra data.

I decided that this should be repairable, too.  This is done by patch 8.
(If we drop patch 2, this will go, too.)

Now I was really into it, so I decided even more things needed fixing!
Namely the final two reasons why we would reject a snapshot table:
(1) It has too many snapshots (patch 10),
(2) It is too long overall (patch 9).


Finally, patch 13 adds an overly complicated test (using the new
peek_file* functions added in patch 12).


Max Reitz (13):
  qcow2: Add Error ** to qcow2_read_snapshots()
  qcow2: Keep unknown extra snapshot data
  qcow2: Make qcow2_write_snapshots() public
  qcow2: Put qcow2_upgrade() into an own function
  qcow2: Write v3-compliant snapshot list on upgrade
  qcow2: Separate qcow2_check_read_snapshot_table()
  qcow2: Add qcow2_check_fix_snapshot_table()
  qcow2: Fix broken snapshot table entries
  qcow2: Fix overly long snapshot tables
  qcow2: Repair snapshot table with too many entries
  qcow2: Fix v3 snapshot table entry compliancy
  iotests: Add peek_file* functions
  iotests: Test qcow2's snapshot table handling

 block/qcow2.h                |  15 +-
 block/qcow2-snapshot.c       | 302 +++++++++++++++++++++--
 block/qcow2.c                | 152 ++++++++++--
 tests/qemu-iotests/261       | 449 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/261.out   | 321 +++++++++++++++++++++++++
 tests/qemu-iotests/common.rc |  20 ++
 tests/qemu-iotests/group     |   1 +
 7 files changed, 1219 insertions(+), 41 deletions(-)
 create mode 100755 tests/qemu-iotests/261
 create mode 100644 tests/qemu-iotests/261.out

--=20
2.21.0


