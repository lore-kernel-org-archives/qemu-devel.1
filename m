Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F3DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1148206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1148206CB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1t6-0007m9-Nk
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kS1s1-0006iK-BT; Mon, 12 Oct 2020 13:44:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:60458 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kS1ry-0007A1-Fl; Mon, 12 Oct 2020 13:44:24 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kS1qv-0047iC-So; Mon, 12 Oct 2020 20:43:17 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH v11 00/13] Apply COR-filter to the block-stream permanently
Date: Mon, 12 Oct 2020 20:43:12 +0300
Message-Id: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 13:44:17
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

The iotest case test_stream_parallel still does not pass after the
COR-filter is inserted into the backing chain. As the test case may not
be initialized, it does not make a sense and was removed again.

v11:
  04: Base node overlay is used instead of base.
  05: Base node overlay is used instead of base.
  06: New.
  07: New.
  08: New.
  09: The new BDS-member 'supported_read_flags' is applied.
  10: The 'base_metadata' variable renamed to 'base_unfiltered'.
  11: New.
  12: The backing-file argument is left in the QMP interface. Warning added.
  13: The BDRV_REQ_COPY_ON_READ removed from the stream_populate();
      The 'implicit' initialization moved back to COR-filter driver.
      Base node overlay is used instead of base.

The v8 Message-Id:
<1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (13):
  copy-on-read: Support preadv/pwritev_part functions
  copy-on-read: add filter append/drop functions
  qapi: add filter-node-name to block-stream
  copy-on-read: pass overlay base node name to COR driver
  copy-on-read: limit COR operations to base in COR driver
  block: modify the comment for BDRV_REQ_PREFETCH flag
  block: include supported_read_flags into BDS structure
  copy-on-read: add support for BDRV_REQ_PREFETCH to COR-filter
  copy-on-read: skip non-guest reads if no copy needed
  stream: skip filters when writing backing file name to QCOW2 header
  stream: mark backing-file argument as deprecated
  stream: remove unused backing-file name parameter
  block: apply COR-filter to block-stream jobs

 block/copy-on-read.c           | 171 ++++++++++++++++++++++++++++++++++++++---
 block/copy-on-read.h           |  35 +++++++++
 block/io.c                     |   3 +-
 block/monitor/block-hmp-cmds.c |   4 +-
 block/stream.c                 | 112 ++++++++++++++++-----------
 blockdev.c                     |  25 +++---
 docs/system/deprecated.rst     |   6 ++
 include/block/block.h          |   7 +-
 include/block/block_int.h      |  13 +++-
 qapi/block-core.json           |   6 ++
 tests/qemu-iotests/030         |  51 ++----------
 tests/qemu-iotests/030.out     |   4 +-
 tests/qemu-iotests/141.out     |   2 +-
 tests/qemu-iotests/245         |  19 +++--
 14 files changed, 324 insertions(+), 134 deletions(-)
 create mode 100644 block/copy-on-read.h

-- 
1.8.3.1


