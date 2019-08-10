Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BB7C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6192085B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6192085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwX6z-0002Df-PJ
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 15:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44026)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5y-0000Ip-VQ
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5x-0007C7-QC
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:48788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5s-000775-Gh; Sat, 10 Aug 2019 15:32:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5o-0000nK-JC; Sat, 10 Aug 2019 22:31:56 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Sat, 10 Aug 2019 22:31:48 +0300
Message-Id: <20190810193155.58637-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 0/7] backup improvements
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

There are some fixes and refactorings I need on my way to resend
my backup-top series. It's obvious now that I need to share copying
code between backup and backup-top, as backup copying code becomes
smarter and more complicated. So the goal of the series is to make copying
code more share-able.

Based-on: https://github.com/jnsnow/qemu bitmaps 

v3:
03: Ha, fix real bug, we shouldn't touch src before handling write-zero,
    as src may be NULL. So, replace align and max_transfer calculation
    together with max_transfer == 0 check. Drop comment, as there is no
    special place for it now..
04: add Max's r-b:
06-07: rewrite to keep bounce_buffer sharing between iterations and to
       limit allocation [Eric]

v2 (by Max's comments):

02: Add Max's r-b
03: - split out backup changes to 03
   - handle common max_transfer = 0 case
04: splat out from 02
06: fix allocation size
07: - rebase on 06 changes
   - add Max's r-b

two patches are dropped or postponed for the next step

Vladimir Sementsov-Ogievskiy (7):
  block/backup: deal with zero detection
  block/backup: refactor write_flags
  block/io: handle alignment and max_transfer for copy_range
  block/backup: drop handling of max_transfer for copy_range
  block/backup: fix backup_cow_with_offload for last cluster
  block/backup: teach backup_cow_with_bounce_buffer to copy more at once
  block/backup: merge duplicated logic into backup_do_cow

 block/backup.c | 154 ++++++++++++++++++++++---------------------------
 block/io.c     |  44 +++++++++++---
 blockdev.c     |   8 +--
 3 files changed, 110 insertions(+), 96 deletions(-)

-- 
2.18.0


