Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96797C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7652342C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7652342C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3jaw-00032H-5X
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 12:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3jWB-00006k-9C
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3jW5-0004Uq-7a
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:12:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:60588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3jVs-0004Ff-Q2; Fri, 30 Aug 2019 12:12:38 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3jVl-0001X0-3q; Fri, 30 Aug 2019 19:12:29 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri, 30 Aug 2019 19:12:14 +0300
Message-Id: <20190830161228.54238-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v10 00/14] backup-top filter driver for backup
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
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

These series introduce backup-top driver. It's a filter-node, which
do copy-before-write operation. Mirror uses filter-node for handling
guest writes, let's move to filter-node (from write-notifiers) for
backup too.

v10 (mostly by Max's comments):

01: - s/MIN(end - start, job->len - start)/MIN(end, job->len) - start
    - Max's r-b
02: s/offset/start/ and drop extra variable from backup_do_copy
03: new
04: - add job->source_bs
    - use two progress callbacks instead of one combined
    - add comment to skip_unallocated
    - drop zeroing blk's in block_copy_state_free
    - s/g_new0/g_new/ before compound literal
    - add comment and assertion about aio context for block-copy source and target
    - in backup_clean handle possibly executing in parallel backup_drain and check
      only s->bcs pointer in backup_drain
    - fix s/job/bcs in trace-events file
05: partly new, now only fix comments style
06: a lot of changes as rebased on above changes, but it's still a clean
    code move, keep Max's r-b
07: add Max's r-b
08: deeper refactoring of tests
09-11: add Max's r-b
   [also, fix my email in 11]
12: - drop bdrv_refresh_filename(bs->backing->bs) call
    - drop assertion of taken permission
    - active = false + refresh_perms in _drop() instead of _set_perm()
13: - add comment about WRITE perm sharing
    - add backup_top bs to job state
    - fix cleanup on failure path in backup_job_create
    - keep "fail:" path in block_copy_with_bounce_buffer
    - in 56, collide on job-id instead of posix locks


Vladimir Sementsov-Ogievskiy (14):
  block/backup: fix backup_cow_with_offload for last cluster
  block/backup: split shareable copying part from backup_do_cow
  block/backup: improve comment about image fleecing
  block/backup: introduce BlockCopyState
  block/backup: fix block-comment style
  block: move block_copy from block/backup.c to separate file
  block: teach bdrv_debug_breakpoint skip filters with backing
  iotests: prepare 124 and 257 bitmap querying for backup-top filter
  iotests: 257: drop unused Drive.device field
  iotests: 257: drop device_add
  block/io: refactor wait_serialising_requests
  block: add lock/unlock range functions
  block: introduce backup-top filter driver
  block/backup: use backup-top instead of write notifiers

 qapi/block-core.json          |   8 +-
 block/backup-top.h            |  37 ++
 include/block/block-copy.h    |  75 ++++
 include/block/block_int.h     |   5 +
 block.c                       |  34 +-
 block/backup-top.c            | 240 ++++++++++++
 block/backup.c                | 454 +++++----------------
 block/block-copy.c            | 337 ++++++++++++++++
 block/io.c                    |  68 +++-
 block/replication.c           |   2 +-
 blockdev.c                    |   1 +
 block/Makefile.objs           |   3 +
 block/trace-events            |  14 +-
 tests/qemu-iotests/056        |   8 +-
 tests/qemu-iotests/124        |  83 ++--
 tests/qemu-iotests/257        |  91 ++---
 tests/qemu-iotests/257.out    | 714 ++++++++++++++--------------------
 tests/qemu-iotests/iotests.py |  27 ++
 18 files changed, 1281 insertions(+), 920 deletions(-)
 create mode 100644 block/backup-top.h
 create mode 100644 include/block/block-copy.h
 create mode 100644 block/backup-top.c
 create mode 100644 block/block-copy.c

-- 
2.18.0


