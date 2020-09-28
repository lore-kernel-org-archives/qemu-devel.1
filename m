Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351CAC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA21920789
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA21920789
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtRy-0001FY-LD
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMslk-0004YH-Lv; Mon, 28 Sep 2020 09:00:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:58252 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsld-0000BQ-OO; Mon, 28 Sep 2020 09:00:39 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsl0-001tba-EP; Mon, 28 Sep 2020 15:59:54 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v9 0/9] Apply COR-filter to the block-stream permanently
Date: Mon, 28 Sep 2020 15:59:52 +0300
Message-Id: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:00:28
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

Despite the patch "freeze link to base node..." has been removed from the
series in the current version 9, the iotest case test_stream_parallel does
not pass after the COR-filter is inserted into the backing chain. As the
test case may not be initialized, it does not make a sense and was removed
again.
The check with bdrv_is_allocated_above() takes place in the COR-filter and
in the block-stream job both. An optimization of the block-stream job based
on the filter functionality may be made in a separate series.

v9:
  02: Refactored.
  04: Base node name is used instead of the file name.
  05: New implementation based on Max' review.
  06: New.
  07: New. The patch "freeze link to base node..." was deleted.
  08: New.
  09: The filter node options are initialized.

The v8 Message-Id:
<1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (9):
  copy-on-read: Support preadv/pwritev_part functions
  copy-on-read: add filter append/drop functions
  qapi: add filter-node-name to block-stream
  copy-on-read: pass base node name to COR driver
  copy-on-read: limit guest COR activity to base in COR driver
  copy-on-read: skip non-guest reads if no copy needed
  stream: skip filters when writing backing file name to QCOW2 header
  block: remove unused parameter backing-file name
  block: apply COR-filter to block-stream jobs

 block/copy-on-read.c           | 165 ++++++++++++++++++++++++++++++++++++++---
 block/io.c                     |   2 +-
 block/monitor/block-hmp-cmds.c |   6 +-
 block/stream.c                 | 112 +++++++++++++++++-----------
 blockdev.c                     |  21 +-----
 include/block/block_int.h      |   9 ++-
 qapi/block-core.json           |  23 ++----
 tests/qemu-iotests/030         |  51 ++-----------
 tests/qemu-iotests/030.out     |   4 +-
 tests/qemu-iotests/141.out     |   2 +-
 tests/qemu-iotests/245         |  19 +++--
 11 files changed, 267 insertions(+), 147 deletions(-)

-- 
1.8.3.1


