Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F26C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1D420854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1D420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKRWx-0004UL-IC
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 14:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKRR6-0005o9-5r
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKRR4-0001T7-U9
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:20:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:35014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKRR4-0001RG-MZ; Tue, 15 Oct 2019 14:20:42 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKRQy-0003ry-5s; Tue, 15 Oct 2019 21:20:36 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v3 0/5] qcow2: advanced compression options
Date: Tue, 15 Oct 2019 21:20:20 +0300
Message-Id: <1571163625-642312-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New enhancements for writing compressed data to QCOW2 image.

The preceding patches have been queued in the Max's block branch:

Based-on: <20190916175324.18478-1-vsementsov@virtuozzo.com>

v2:
    Instead of introducing multiple key options for many drivers, the
    'compression' option has been introduced on generic block layer
    as suggested by Roman Kagan. Discussed on the thread ID
    <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (5):
  qcow2: Allow writing compressed data of multiple clusters
  tests/qemu-iotests: add case to write compressed data of multiple
    clusters
  block: support compressed write for copy-on-read
  block-stream: add compress option
  tests/qemu-iotests: add case for block-stream compress

 block.c                    |  12 ++++-
 block/io.c                 |  23 +++++++---
 block/qcow2.c              | 106 +++++++++++++++++++++++++++++++++------------
 block/qcow2.h              |   1 +
 block/stream.c             |  10 ++++-
 block/trace-events         |   2 +-
 blockdev.c                 |  16 ++++++-
 include/block/block.h      |   1 +
 include/block/block_int.h  |   2 +
 qapi/block-core.json       |   6 ++-
 qemu-options.hx            |   6 ++-
 tests/qemu-iotests/030     |  51 +++++++++++++++++++++-
 tests/qemu-iotests/030.out |   4 +-
 tests/qemu-iotests/214     |  35 +++++++++++++++
 tests/qemu-iotests/214.out |  15 +++++++
 15 files changed, 246 insertions(+), 44 deletions(-)

-- 
1.8.3.1


