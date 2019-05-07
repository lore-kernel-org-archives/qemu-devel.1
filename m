Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC163C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBCD20449
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBCD20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54433 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO6qC-00074a-PP
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 16:37:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6oK-0005B8-If
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6oI-0003q6-Eu
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO6oC-0003VW-F5; Tue, 07 May 2019 16:35:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64005883B8;
	Tue,  7 May 2019 20:35:11 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E8DB95D9D2;
	Tue,  7 May 2019 20:35:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 22:35:01 +0200
Message-Id: <20190507203508.18026-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 07 May 2019 20:35:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/7] qemu-img: Add salvaging mode to convert
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series adds a --salvage option to qemu-img convert.  With this,
qemu-img will not abort when it encounters an I/O error.  Instead, it
tries to narrow it down and will treat the affected sectors as being
completely 0 (and print a warning).

Testing this is not so easy, because while real I/O errors during read
operations should be treated as described above, errors encountered
during bdrv_block_status() should just be ignored and the affected
sectors should be considered allocated.  But blkdebug does not yet have
a way to intercept this, and:

(1) Just adding a new block-status event would be silly, because I don't
    want an event, I want it to fail on a certain kind of operation, on
    a certain sector range, independently of any events, so why can't we
    just do that?  See patch 4.

(2) If we just make blkdebug intercept .bdrv_co_block_status() like all
    other kinds of operations, at least iotest 041 fails, which does
    exactly that silly thing: It uses the read_aio event to wait for any
    read.  But it turns out that there may be a bdrv_*block_status()
    call in between, so suddenly the wrong operation yields an error.
    As I said, the real fault here is that it does not really make sense
    to pray that the operation you want to fail is the one that is
    immediately executed after some event that you hope will trigger
    that operation.
    See patch 3.

So patch 3 allows blkdebug users to select which kind of I/O operation
they actually want to make fail, and patch 4 allows them to not use any
event, but to have a rule active all the time.

Together, we can then enable error injection for block-status in patch 5
and make use of event=3Dnone iotype=3Dblock-status in patch 6.


v4:
- Patch 2: Rebase conflict (265a7e54efad246f4bde63f77aee6311f436f5f1)
- Patch 3: Fix enum prefix to be BLKDEBUG_IO_TYPE [Vladimir]
- Patch 5: The same
- Patch 6:
  - 249 -> 251
  - s%#!/bin/bash%#!/usr/bin/env bash% [Thomas]
  - s/2018/2019/ [Vladimir]
  - Drop here=3D$PWD [Vladimir]
  - Clarified a comment (I hope) [Vladimir]


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[----] [--] 'qemu-img: Move quiet into ImgConvertState'
002/7:[0006] [FC] 'qemu-img: Add salvaging mode to convert'
003/7:[0028] [FC] 'blkdebug: Add @iotype error option'
004/7:[----] [--] 'blkdebug: Add "none" event'
005/7:[0002] [FC] 'blkdebug: Inject errors on .bdrv_co_block_status()'
006/7:[0015] [FC] 'iotests: Test qemu-img convert --salvage'
007/7:[----] [--] 'iotests: Test qemu-img convert -C --salvage'


Max Reitz (7):
  qemu-img: Move quiet into ImgConvertState
  qemu-img: Add salvaging mode to convert
  blkdebug: Add @iotype error option
  blkdebug: Add "none" event
  blkdebug: Inject errors on .bdrv_co_block_status()
  iotests: Test qemu-img convert --salvage
  iotests: Test qemu-img convert -C --salvage

 qapi/block-core.json       |  33 +++++++-
 block/blkdebug.c           |  60 +++++++++++---
 qemu-img.c                 | 103 ++++++++++++++++-------
 qemu-img-cmds.hx           |   4 +-
 qemu-img.texi              |   4 +
 tests/qemu-iotests/082     |   1 +
 tests/qemu-iotests/082.out |   3 +
 tests/qemu-iotests/251     | 162 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/251.out |  43 ++++++++++
 tests/qemu-iotests/group   |   1 +
 10 files changed, 375 insertions(+), 39 deletions(-)
 create mode 100755 tests/qemu-iotests/251
 create mode 100644 tests/qemu-iotests/251.out

--=20
2.20.1


