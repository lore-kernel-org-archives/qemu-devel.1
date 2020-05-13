Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB4C47076
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15018206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15018206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYoDs-0007CL-8f
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo31-0006lL-3d; Wed, 13 May 2020 05:51:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:53986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo2z-0003Z5-6N; Wed, 13 May 2020 05:51:30 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo2U-0001e4-4y; Wed, 13 May 2020 12:50:58 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 00/15] Apply COR-filter to the block-stream permanently
Date: Wed, 13 May 2020 12:50:41 +0300
Message-Id: <1589363456-1035571-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 05:51:06
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this series, all the block-stream COR operations pass through
the COR-filter. The patches 01-08/15 are taken from the series
"block: Deal with filters" by Max Reitz, the full version of that
can be found in the branches:

      https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
      https://github.com/XanClic/qemu child-access-functions-v6

      When running iotests, apply "char-socket: Fix race condition"
      to avoid sporadic segmentation faults.

v5:
  01: Included forgotten file block/copy-on-read.h

v4:
  01: Initialization of the COR-filter BDRVStateCOR member.

v3:
  01: The COR filter insert/remove functions moved to block/copy-on-read.c
      to be a part of API.
  02: block/stream.c code refactoring.
  03: The separate call to block_job_add_bdrv() is used to block operations
      on the active node after the filter inserted and the job created.
  04: The iotests case 030::test_overlapping_4 was modified to unbound
      the block-stream job from the base node.
  05: The COR driver functions preadv/pwritev replaced with their analogous
      preadv/pwritev_part.

v2:
  01: No more skipping filters while checking for operation blockers.
      However, we exclude filters between the bottom node and base
      because we do not set the operation blockers for filters anymore.
  02: As stated above, we do not set the operation blockers for filters
      anymore. So, skip filters when we block operations for the target
      node.
  03: The comment added for the patch 4/7.
  04: The QAPI target version changed to 5.1.
  05: The 'filter-node-name' now excluded from using in the test #030.
      If we need it no more in a final version of the series, the patch
      5/7 may be removed.
  06: The COR-filter included into the frozen chain of a block-stream job.
      The 'above_base' node pointer is left because it is essential for
      finding the base node in case of filters above.


Andrey Shinkevich (7):
  block: prepare block-stream for using COR-filter
  copy-on-read: Support change filename functions
  copy-on-read: Support preadv/pwritev_part functions
  copy-on-read: add filter append/drop functions
  qapi: add filter-node-name to block-stream
  iotests: prepare 245 for using filter in block-stream
  block: apply COR-filter to block-stream jobs

Max Reitz (8):
  block: Mark commit and mirror as filter drivers
  copy-on-read: Support compressed writes
  block: Add child access functions
  block: Add chain helper functions
  block: Include filters when freezing backing chain
  block: Use CAFs in block status functions
  commit: Deal with filters when blocking intermediate nodes
  block: Use CAFs when working with backing chains

 block.c                        | 275 ++++++++++++++++++++++++++++++++++-------
 block/commit.c                 |  85 ++++++++++---
 block/copy-on-read.c           | 159 ++++++++++++++++++++++--
 block/copy-on-read.h           |  36 ++++++
 block/io.c                     |  19 +--
 block/mirror.c                 |   6 +-
 block/monitor/block-hmp-cmds.c |   4 +-
 block/stream.c                 |  89 +++++++++----
 blockdev.c                     |  19 ++-
 include/block/block.h          |   6 +-
 include/block/block_int.h      |  67 +++++++++-
 qapi/block-core.json           |   6 +
 tests/qemu-iotests/030         |  17 +--
 tests/qemu-iotests/141.out     |   2 +-
 tests/qemu-iotests/245         |  10 +-
 15 files changed, 661 insertions(+), 139 deletions(-)
 create mode 100644 block/copy-on-read.h

-- 
1.8.3.1


