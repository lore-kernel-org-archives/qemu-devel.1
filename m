Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FD6C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7B626C31
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7B626C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkU2-00080H-1q
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:34:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRt-0006lx-UX
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRs-0008Cv-H1
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:57242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRs-0008Ad-6z; Fri, 31 May 2019 12:32:08 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRn-0006Lb-31; Fri, 31 May 2019 19:32:03 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 31 May 2019 19:31:53 +0300
Message-Id: <20190531163202.162543-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 0/9] qcow2-bitmaps: rewrite reopening logic
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Bitmaps reopening is buggy, we may easily produce broken incremental
backup if we do temporary snapshot. Let's fix it!

v2:
01: new
02-03: test: splat into two patches, some wording
       improvements and event_wait improved
04: add John's r-b
05: new
06-09: fixes: changed, splat, use patch 01

Vladimir Sementsov-Ogievskiy (9):
  block: add .bdrv_need_rw_file_child_during_reopen_rw handler
  python/qemu: improve event_wait method of vm
  iotests: add test 255 to check bitmap life after snapshot + commit
  block/qcow2-bitmap: get rid of bdrv_has_changed_persistent_bitmaps
  block/qcow2-bitmap: drop qcow2_reopen_bitmaps_rw_hint()
  block/qcow2-bitmap: do not remove bitmaps on reopen-ro
  block/qcow2-bitmap: fix and improve qcow2_reopen_bitmaps_rw
  block/qcow2-bitmap: fix reopening bitmaps to RW
  qcow2-bitmap: move bitmap reopen-rw code to qcow2_reopen_prepare

 block/qcow2.h                 |   6 +-
 include/block/block_int.h     |   8 +-
 include/block/dirty-bitmap.h  |   1 -
 block.c                       | 163 +++++++++++++++++++++++++++-------
 block/dirty-bitmap.c          |  12 ---
 block/qcow2-bitmap.c          | 146 ++++++++++++++++++------------
 block/qcow2.c                 |   9 +-
 python/qemu/__init__.py       |   9 +-
 tests/qemu-iotests/255        |  86 ++++++++++++++++++
 tests/qemu-iotests/255.out    |  52 +++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   5 ++
 12 files changed, 381 insertions(+), 117 deletions(-)
 create mode 100755 tests/qemu-iotests/255
 create mode 100644 tests/qemu-iotests/255.out

-- 
2.18.0


