Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC4CC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E787A20675
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E787A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46923 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i3t-0004SM-6E
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvu-0005Jv-An
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvt-0007l5-0t
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:38 -0500
Received: from relay.sw.ru ([185.231.240.75]:47528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvs-0007RS-PD; Mon, 17 Feb 2020 10:03:36 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvB-0007Zt-W9; Mon, 17 Feb 2020 18:02:54 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/22] Fix error handling during bitmap postcopy
Date: Mon, 17 Feb 2020 18:02:24 +0300
Message-Id: <20200217150246.29180-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, quintela@redhat.com, qemu-stable@nongnu.org,
 dgilbert@redhat.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 andrey.shinkevich@virtuozzo.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Original idea of bitmaps postcopy migration is that bitmaps are non
critical data, and their loss is not serious problem. So, using postcopy
method on any failure we should just drop unfinished bitmaps and
continue guest execution.

However, it doesn't work so. It crashes, fails, it goes to
postcopy-recovery feature. It does anything except for behavior we want.
These series fixes at least some problems with error handling during
bitmaps migration postcopy.

v1 was "[PATCH 0/7] Fix crashes on early shutdown during bitmaps postcopy"

v2:

Most of patches are new or changed a lot.
Only patches 06,07 mostly unchanged, just rebased on refactorings.

Vladimir Sementsov-Ogievskiy (22):
  migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
  migration/block-dirty-bitmap: rename state structure types
  migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
  migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
  migration/block-dirty-bitmap: refactor state global variables
  migration/block-dirty-bitmap: rename finish_lock to just lock
  migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
  migration/block-dirty-bitmap: keep bitmap state for all bitmaps
  migration/block-dirty-bitmap: relax error handling in incoming part
  migration/block-dirty-bitmap: cancel migration on shutdown
  migration/savevm: don't worry if bitmap migration postcopy failed
  qemu-iotests/199: fix style
  qemu-iotests/199: drop extra constraints
  qemu-iotests/199: better catch postcopy time
  qemu-iotests/199: improve performance: set bitmap by discard
  qemu-iotests/199: change discard patterns
  qemu-iotests/199: increase postcopy period
  python/qemu/machine: add kill() method
  qemu-iotests/199: prepare for new test-cases addition
  qemu-iotests/199: check persistent bitmaps
  qemu-iotests/199: add early shutdown case to bitmaps postcopy
  qemu-iotests/199: add source-killed case to bitmaps postcopy

Cc: John Snow <jsnow@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org # for patch 01

 migration/migration.h          |   3 +-
 migration/block-dirty-bitmap.c | 444 +++++++++++++++++++++------------
 migration/migration.c          |  15 +-
 migration/savevm.c             |  37 ++-
 python/qemu/machine.py         |  12 +-
 tests/qemu-iotests/199         | 244 ++++++++++++++----
 tests/qemu-iotests/199.out     |   4 +-
 7 files changed, 529 insertions(+), 230 deletions(-)

-- 
2.21.0


