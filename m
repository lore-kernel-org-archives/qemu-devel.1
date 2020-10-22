Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC0FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA95223C7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA95223C7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfF3-0000QQ-Ev
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf6Q-0000oS-Dn; Thu, 22 Oct 2020 14:14:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:52078 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf6K-0001nh-GQ; Thu, 22 Oct 2020 14:14:18 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5r-005dVw-CC; Thu, 22 Oct 2020 21:13:43 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v12 00/14] Apply COR-filter to the block-stream permanently
Date: Thu, 22 Oct 2020 21:13:29 +0300
Message-Id: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:13:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

The node insert/remove functions were added at the block generic layer.
COR-filter options structure was added to the QAPI.
The test case #310 was added to check the 'bottom' node limit for COR.
The 'supported_read_flags' member was added to the BDS structure
(with the flags check at the block generic layer for drivers).

v12:
  02: New.
  03: Only the temporary drop filter function left.
  05: New (suggested by Max)
  06: 'base' -> 'bottom' option.
  07: Fixes based on the review of the v11.
  08: New.
  09: The comment ext was modified.
  10: The read flags check at the block generic layer.
  11: COR flag was added.
  12: The condition was fixed.
  13: The 'backing-file' parameter returned. No deprecation.
  14: The COR-filter 'add' function replaced with the 'insert node' generic
      function. Fixes based on the review of the v11.

Andrey Shinkevich (14):
  copy-on-read: support preadv/pwritev_part functions
  block: add insert/remove node functions
  copy-on-read: add filter drop function
  qapi: add filter-node-name to block-stream
  qapi: create BlockdevOptionsCor structure for COR driver
  copy-on-read: pass bottom node name to COR driver
  copy-on-read: limit COR operations to bottom node
  iotests: add #310 to test bottom node in COR driver
  block: modify the comment for BDRV_REQ_PREFETCH flag
  block: include supported_read_flags into BDS structure
  copy-on-read: add support for read flags to COR-filter
  copy-on-read: skip non-guest reads if no copy needed
  stream: skip filters when writing backing file name to QCOW2 header
  block: apply COR-filter to block-stream jobs

 block.c                        |  49 ++++++++++++++
 block/copy-on-read.c           | 144 +++++++++++++++++++++++++++++++++++++----
 block/copy-on-read.h           |  32 +++++++++
 block/io.c                     |  12 +++-
 block/monitor/block-hmp-cmds.c |   4 +-
 block/stream.c                 | 117 ++++++++++++++++++++++-----------
 blockdev.c                     |  13 ++--
 include/block/block.h          |  11 +++-
 include/block/block_int.h      |  11 +++-
 qapi/block-core.json           |  27 +++++++-
 tests/qemu-iotests/030         |  51 ++-------------
 tests/qemu-iotests/030.out     |   4 +-
 tests/qemu-iotests/141.out     |   2 +-
 tests/qemu-iotests/245         |  22 +++++--
 tests/qemu-iotests/310         | 109 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/310.out     |  15 +++++
 tests/qemu-iotests/group       |   3 +-
 17 files changed, 503 insertions(+), 123 deletions(-)
 create mode 100644 block/copy-on-read.h
 create mode 100755 tests/qemu-iotests/310
 create mode 100644 tests/qemu-iotests/310.out

-- 
1.8.3.1


