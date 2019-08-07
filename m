Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4769A21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4769A21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41635 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMiD-0004hl-IM
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg8-0007lN-1e
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg6-0003Jo-Nc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:40654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg4-0003D2-1Z; Wed, 07 Aug 2019 10:12:32 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMfz-0005oH-6E; Wed, 07 Aug 2019 17:12:27 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 17:12:16 +0300
Message-Id: <20190807141226.193501-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 00/10] qcow2-bitmaps: rewrite reopening logic
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Bitmaps reopening is buggy, reopening-rw just not working at all and
reopening-ro may lead to producing broken incremental
backup if we do temporary snapshot in a meantime.

v4: Drop complicated solution around reopening logic [Kevin], fix
    the existing bug in a simplest way

Structure:

02: fix reopen to RW
03: test reopen to RW

07: fix reopen to RO
08: test reopen to RO

Others are less significant improvements and refactoring

Changelog:

01-03: new patches, to fix reopening bitmaps to RW and personal test for
       this bug
08: merged test from v3, it covers both bugs (reopen to RW and reopen to RO)
10: instead of moving bitmap-reopening to prepare(as in 09 in v3) we now keep it
    in commit, but in right place
others: unchanged

v3:
02: John's events_wait already merged in, so my 02 from v2 is not needed.
    Instead, add two simple logging wrappers here
03: rebase on 02 - use new wrappers, move to 260
05: add John's r-b
06: improve function docs [John], add John's r-b

v2:
01: new
02-03: test: splat into two patches, some wording
       improvements and event_wait improved
04: add John's r-b
05: new
06-09: fixes: changed, splat, use patch 01

Vladimir Sementsov-Ogievskiy (10):
  block: switch reopen queue from QSIMPLEQ to QTAILQ
  block: reverse order for reopen commits
  iotests: add test-case to 165 to test reopening qcow2 bitmaps to RW
  iotests.py: add event_wait_log and events_wait_log helpers
  block/qcow2-bitmap: get rid of bdrv_has_changed_persistent_bitmaps
  block/qcow2-bitmap: drop qcow2_reopen_bitmaps_rw_hint()
  block/qcow2-bitmap: do not remove bitmaps on reopen-ro
  iotests: add test 260 to check bitmap life after snapshot + commit
  block/qcow2-bitmap: fix and improve qcow2_reopen_bitmaps_rw
  qcow2-bitmap: move bitmap reopen-rw code to qcow2_reopen_commit

 block/qcow2.h                 |   5 +-
 include/block/block.h         |   2 +-
 include/block/block_int.h     |   6 --
 include/block/dirty-bitmap.h  |   1 -
 block.c                       |  51 +++++-------
 block/dirty-bitmap.c          |  12 ---
 block/qcow2-bitmap.c          | 143 ++++++++++++++++++++--------------
 block/qcow2.c                 |  17 +++-
 tests/qemu-iotests/165        |  46 ++++++++++-
 tests/qemu-iotests/165.out    |   4 +-
 tests/qemu-iotests/260        |  87 +++++++++++++++++++++
 tests/qemu-iotests/260.out    |  52 +++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  10 +++
 14 files changed, 318 insertions(+), 119 deletions(-)
 create mode 100755 tests/qemu-iotests/260
 create mode 100644 tests/qemu-iotests/260.out

-- 
2.18.0


