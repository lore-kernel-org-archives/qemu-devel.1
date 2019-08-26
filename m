Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E684C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1376B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1376B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2HgV-0003Ud-TR
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2Hcp-0000lg-Ai
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2Hcn-00016b-ND
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:13:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:44772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2Hch-0000lr-Ab; Mon, 26 Aug 2019 12:13:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2HcH-0006QJ-FW; Mon, 26 Aug 2019 19:13:13 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 26 Aug 2019 19:12:59 +0300
Message-Id: <20190826161312.489398-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 00/13] backup-top filter driver for backup
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

I decided to postpone all these "preparation" and "improvement"
series, as it seems we will never do the core thing in such way.

v9:

01: rebased, it's from "backup improvements" series

02-05: new patches, introduction of block-copy

06: unchanged

07-08: new iotests preparation

10-11: unchanged

12:
backup-top filter is simplified: it don't do copy operation
by hands but through block-copy, and it don't have second "target"
child anymore. So the state is reduced to only two fields: 
block-copy state and "active".

What else?
1. filter-node-name parameter added
2. "active" parameter. I failed on my way to make bdrv_append
firstly do bdrv_replace_node and then bdrv_set_backing_hd, as it
leads to much problems, block-layer is unprepared for child-less
filters. So, it's a lot simpler to cheat a bit with permissions,
and don't require unshared WRITE during appending.
3. filter is not finished in this patch, as block_copy is not
finished too, you can see a TODO and abort() in backup_top_cbw.

13:
- filter-node-name added
- backup_clean simplified: don't bother with keeping block job
  blk on backup-top filter, it's not necessary.
- locking is all done in block-copy code
- itests changed in different manner
- I'm afraid that's not a full list, patch really changed
  significantly.

The series also needs one small fix:
  "[PATCH] block: fix permission update in bdrv_replace_node"
Based-on: <20190824100740.61635-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (13):
  block/backup: fix backup_cow_with_offload for last cluster
  block/backup: split shareable copying part from backup_do_cow
  block/backup: introduce BlockCopyState
  block/backup: adjust block-copy functions style
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
 include/block/block-copy.h    |  59 +++
 include/block/block_int.h     |   5 +
 block.c                       |  34 +-
 block/backup-top.c            | 241 ++++++++++++
 block/backup.c                | 411 +++----------------
 block/block-copy.c            | 320 +++++++++++++++
 block/io.c                    |  68 +++-
 block/replication.c           |   2 +-
 blockdev.c                    |   1 +
 block/Makefile.objs           |   3 +
 block/trace-events            |  14 +-
 tests/qemu-iotests/056        |   2 +-
 tests/qemu-iotests/124        |   3 +-
 tests/qemu-iotests/257        |  81 ++--
 tests/qemu-iotests/257.out    | 714 ++++++++++++++--------------------
 tests/qemu-iotests/iotests.py |  22 ++
 18 files changed, 1163 insertions(+), 862 deletions(-)
 create mode 100644 block/backup-top.h
 create mode 100644 include/block/block-copy.h
 create mode 100644 block/backup-top.c
 create mode 100644 block/block-copy.c

-- 
2.18.0


