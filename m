Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03CAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B565C20738
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B565C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhdp-00027W-QJ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhd8-0001Nw-6j; Fri, 28 Aug 2020 12:53:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:37526 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhd3-0001Hb-T3; Fri, 28 Aug 2020 12:53:33 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhcW-001XPR-JX; Fri, 28 Aug 2020 19:52:56 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH v8 0/7] Apply COR-filter to the block-stream permanently
Date: Fri, 28 Aug 2020 19:52:52 +0300
Message-Id: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:53:26
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

Note: this series is based on the another one "block: Deal with filters"
      by Max Reitz that could be found in the branches:
      https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
      https://github.com/XanClic/qemu child-access-functions-v6

v8:
  03: qapi - version changed to 'Since: 5.2'.
  04: New.
  05: New.
  06: New.
  07: The extra bs variable and the enable_cor were dropped.

The v7 Message-Id:
<1598257914-887267-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (7):
  copy-on-read: Support preadv/pwritev_part functions
  copy-on-read: add filter append/drop functions
  qapi: add filter-node-name to block-stream
  copy-on-read: pass base file name to COR driver
  copy-on-read: limit guest writes to base in COR driver
  block-stream: freeze link to base node during stream job
  block: apply COR-filter to block-stream jobs

 block/copy-on-read.c           | 218 ++++++++++++++++++++++++++++++++++++++---
 block/copy-on-read.h           |  36 +++++++
 block/monitor/block-hmp-cmds.c |   4 +-
 block/stream.c                 | 105 ++++++++++----------
 blockdev.c                     |   4 +-
 include/block/block_int.h      |   7 +-
 qapi/block-core.json           |   6 ++
 tests/qemu-iotests/030         |  60 +++---------
 tests/qemu-iotests/030.out     |   4 +-
 tests/qemu-iotests/245         |  21 ++--
 tests/qemu-iotests/258         | 161 ------------------------------
 tests/qemu-iotests/258.out     |  33 -------
 12 files changed, 341 insertions(+), 318 deletions(-)
 create mode 100644 block/copy-on-read.h
 delete mode 100755 tests/qemu-iotests/258
 delete mode 100644 tests/qemu-iotests/258.out

-- 
1.8.3.1


