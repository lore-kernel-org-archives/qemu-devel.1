Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54563ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295CD20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295CD20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFI1i-00078H-Td
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFHyx-0004bG-Mn
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFHyw-0006NC-Cs
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:14:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:60982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFHyr-0006D9-9f; Tue, 01 Oct 2019 09:14:19 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFHyk-00040D-4n; Tue, 01 Oct 2019 16:14:10 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v15 0/5] backup-top filter driver for backup
Date: Tue,  1 Oct 2019 16:14:04 +0300
Message-Id: <20191001131409.14202-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

These series introduce backup-top driver. It's a filter-node, which
do copy-before-write operation. Mirror uses filter-node for handling
guest writes, let's move to filter-node (from write-notifiers) for
backup too.

Preparation patches are queued in Max's block branch:

Based-on: https://github.com/XanClic/qemu.git block

v15: use BdrvChildren in block-copy
01-03: new
04-05: a lot of changes, such as
04:
    - add new parameters for creation
    - prepare bcs creation
    - add target child
    - refactor bdrv_backup_top_append
    - drop r-b
05:
    - move block-copy to use BdrvChildren
    - drop extra style fixing hunks
    - iotest 141 output changed

v14: Drop range locks, keep old good in-flight requests waiting

12: new patch
14: use old request-waiting scheme instead of range locks

Vladimir Sementsov-Ogievskiy (5):
  block/backup: move in-flight requests handling from backup to
    block-copy
  block/backup: move write_flags calculation inside backup_job_create
  block/block-copy: split block_copy_set_callbacks function
  block: introduce backup-top filter driver
  block/backup: use backup-top instead of write notifiers

 qapi/block-core.json       |   8 +-
 block/backup-top.h         |  41 +++++
 include/block/block-copy.h |  31 +++-
 include/block/block_int.h  |   1 +
 block/backup-top.c         | 276 +++++++++++++++++++++++++++++++++
 block/backup.c             | 147 +++++-------------
 block/block-copy.c         | 140 +++++++++--------
 block/replication.c        |   2 +-
 blockdev.c                 |   1 +
 block/Makefile.objs        |   1 +
 tests/qemu-iotests/056     |   8 +-
 tests/qemu-iotests/141.out |   2 +-
 tests/qemu-iotests/257     |   7 +-
 tests/qemu-iotests/257.out | 306 ++++++++++++++++++-------------------
 14 files changed, 628 insertions(+), 343 deletions(-)
 create mode 100644 block/backup-top.h
 create mode 100644 block/backup-top.c

-- 
2.21.0


