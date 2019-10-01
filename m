Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691AAC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC2B20700
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC2B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFO0Y-0006FN-5S
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFNo8-0004i7-Fz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFNo7-0001SI-2F
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:45294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFNo6-0001Qf-Qd; Tue, 01 Oct 2019 15:27:34 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFNo2-00060a-Oc; Tue, 01 Oct 2019 22:27:30 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH 0/6] qcow2: advanced compression options
Date: Tue,  1 Oct 2019 22:27:14 +0300
Message-Id: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
 jsnow@redhat.com, armbru@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New enhancements of writing compressed data to QCOW2 image.

Based on: message ID <20190916175324.18478-1-vsementsov@virtuozzo.com>
          https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg00751.html

Andrey Shinkevich (6):
  qcow2: multiple clusters write compressed
  tests/qemu-iotests: add case of writing compressed data to multiple
    clusters.
  block: support compressed write for copy-on-read
  qemu-nbd: add compression flag support
  block-stream: add compress option
  tests/qemu-iotests: add case for block-stream compress

 block/io.c                 |  21 +++++++--
 block/qcow2.c              | 113 ++++++++++++++++++++++++++++++++++-----------
 block/stream.c             |  19 +++++---
 block/trace-events         |   2 +-
 blockdev-nbd.c             |   2 +-
 blockdev.c                 |  14 +++++-
 hmp-commands.hx            |   4 +-
 include/block/block_int.h  |   3 +-
 include/block/nbd.h        |   7 ++-
 monitor/hmp-cmds.c         |   5 +-
 nbd/server.c               |   8 +++-
 qapi/block-core.json       |   5 +-
 qemu-nbd.c                 |  18 +++++++-
 qemu-nbd.texi              |   2 +
 tests/qemu-iotests/030     |  49 +++++++++++++++++++-
 tests/qemu-iotests/030.out |   4 +-
 tests/qemu-iotests/214     |   9 ++++
 tests/qemu-iotests/214.out |   6 +++
 18 files changed, 236 insertions(+), 55 deletions(-)

-- 
1.8.3.1


