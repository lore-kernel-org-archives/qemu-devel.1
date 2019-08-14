Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AF2C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDB02084F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDB02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxuaA-00087I-9i
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 10:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUo-00043o-SR
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUn-0002DV-LA
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:49618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUi-0002AI-Qm; Wed, 14 Aug 2019 10:43:22 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUd-0007hk-RL; Wed, 14 Aug 2019 17:43:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 14 Aug 2019 17:43:11 +0300
Message-Id: <20190814144315.89729-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 0/4] backup: fix skipping unallocated clusters
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
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

There is a bug in not yet merged patch
"block/backup: teach TOP to never copy unallocated regions"
in https://github.com/jnsnow/qemu bitmaps. 04 fixes it. So, I propose
to put 01-03 somewhere before
"block/backup: teach TOP to never copy unallocated regions"
and squash 04 into "block/backup: teach TOP to never copy unallocated regions"

Based-on: https://github.com/jnsnow/qemu bitmaps

Vladimir Sementsov-Ogievskiy (4):
  block/dirty-bitmap: switch _next_dirty_area and _next_zero to int64_t
  block/dirty-bitmap: add _next_dirty API
  block/backup: use bdrv_dirty_bitmap_next_dirty
  block/backup: fix and improve skipping unallocated in backup_do_cow

 include/block/dirty-bitmap.h |  8 ++--
 include/qemu/hbitmap.h       | 18 +++++++--
 block/backup.c               | 33 ++++++++++-------
 block/dirty-bitmap.c         | 12 ++++--
 block/mirror.c               |  4 +-
 tests/test-hbitmap.c         | 32 ++++++++--------
 util/hbitmap.c               | 72 ++++++++++++++++++++----------------
 block/trace-events           |  1 -
 8 files changed, 107 insertions(+), 73 deletions(-)

-- 
2.18.0


