Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E4FC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 00:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557CA20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 00:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557CA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnAuo-00081w-DT
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 20:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hnAuM-0006gP-Iv
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 20:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hnAuL-0007RS-D6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 20:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hnAuI-0007Nr-OW; Mon, 15 Jul 2019 20:01:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A98A3082B07;
 Tue, 16 Jul 2019 00:01:21 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-130.bos.redhat.com [10.18.17.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55BC66085B;
 Tue, 16 Jul 2019 00:01:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 20:01:06 -0400
Message-Id: <20190716000117.25219-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 16 Jul 2019 00:01:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/11] bitmaps: allow bitmaps to be used
 with full and top
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: https://github.com/jnsnow/qemu/tree/bitmaps

This follows the previous series which adds the 'bitmap' sync mode
and uses it to add interactions with bitmaps to the 'full' and 'top'
modes to blockdev-backup and drive-backup.

Why?
 on-success: Can conveniently synchronize a bitmap to a full backup.
             Allows for transactionless anchor backups.
             Allows us to attempt an anchor backup without damaging
               our bitmap until the backup is successful.
             Allows for transactional, ungrouped anchor backups.
 always: Allows us to resume full/top style backups with a later
         invocation to sync=3Dbitmap. Neat!

Summary:
1-3: Refactor iotest 257 to accommodate this;
4-5: Augment 257 to test trivial failure cases
6-9: Refactor sync=3Dtop for block/backup
10: Implement feature
11: Test feature

=3D=3D=3D
V2:
=3D=3D=3D

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/11:[0010] [FC] 'iotests/257: add Pattern class'
002/11:[0003] [FC] 'iotests/257: add EmulatedBitmap class'
003/11:[0042] [FC] 'iotests/257: Refactor backup helpers'
004/11:[----] [--] 'block/backup: hoist bitmap check into QMP interface'
005/11:[0016] [FC] 'iotests/257: test API failures'
006/11:[down] 'block/backup: improve sync=3Dbitmap work estimates'
007/11:[down] 'block/backup: centralize copy_bitmap initialization'
008/11:[down] 'block/backup: add backup_is_cluster_allocated'
009/11:[down] 'block/backup: teach TOP to never copy unallocated regions'
010/11:[0002] [FC] 'block/backup: support bitmap sync modes for non-bitma=
p backups'
011/11:[0058] [FC] 'iotests/257: test traditional sync modes'

001: Fallout from changing floor(x / y) to x // y.
     Fallout from changing x =3D x | y to x |=3D y.
     (Decided not to keep RB.)
002: Removed dead variable
     Change x =3D x - y to x -=3D y in clear_bits()
003: Substantially reorganize patch. Hopefully 10% more clever and 10% le=
ss cute.
004: (Added RB.)
005: Added docstring to test_backup_api
     Fixed test matrix enumeration to have consistent order in python2/3
     (Declined RB.)
---: What was patch 006 was dropped, and became patches 6-9.
6-9: New!
010: Was 007;
     Formatting fix.
     (Added RB.)
011: Was 008;
     Adjust bitmap clearing/expected code as a consequence of #9.
     Fallout from changes to 005.

John Snow (11):
  iotests/257: add Pattern class
  iotests/257: add EmulatedBitmap class
  iotests/257: Refactor backup helpers
  block/backup: hoist bitmap check into QMP interface
  iotests/257: test API failures
  block/backup: improve sync=3Dbitmap work estimates
  block/backup: centralize copy_bitmap initialization
  block/backup: add backup_is_cluster_allocated
  block/backup: teach TOP to never copy unallocated regions
  block/backup: support bitmap sync modes for non-bitmap backups
  iotests/257: test traditional sync modes

 block/backup.c             |  188 +-
 block/trace-events         |    1 +
 blockdev.c                 |   32 +
 qapi/block-core.json       |    6 +-
 tests/qemu-iotests/256.out |    4 +-
 tests/qemu-iotests/257     |  342 ++--
 tests/qemu-iotests/257.out | 3366 +++++++++++++++++++++++++++++++++++-
 7 files changed, 3683 insertions(+), 256 deletions(-)

--=20
2.21.0


