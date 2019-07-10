Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB62C73C65
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A9A20645
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A9A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl16R-0002FJ-J9
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl13j-0000HK-6U
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl13h-0004KQ-2j
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13Z-0004Dw-Dx; Tue, 09 Jul 2019 21:06:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D65E308212A;
 Wed, 10 Jul 2019 01:05:59 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A43A21001281;
 Wed, 10 Jul 2019 01:05:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:48 -0400
Message-Id: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 10 Jul 2019 01:05:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/8] bitmaps: allow bitmaps to be used with
 full and top
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Requires: <20190709232550.10724-1-jsnow@redhat.com>
[PATCH v4 00/18] bitmaps: introduce 'bitmap' sync mode

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
6-7: Implement feature
8: Test new feature

John Snow (8):
  iotests/257: add Pattern class
  iotests/257: add EmulatedBitmap class
  iotests/257: Refactor backup helpers
  block/backup: hoist bitmap check into QMP interface
  iotests/257: test API failures
  block/backup: issue progress updates for skipped regions
  block/backup: support bitmap sync modes for non-bitmap backups
  iotests/257: test traditional sync modes

 block/backup.c             |   22 +-
 blockdev.c                 |   32 +
 qapi/block-core.json       |    6 +-
 tests/qemu-iotests/257     |  329 +++-
 tests/qemu-iotests/257.out | 3366 +++++++++++++++++++++++++++++++++++-
 5 files changed, 3548 insertions(+), 207 deletions(-)

--=20
2.21.0


