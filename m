Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55804C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2892C2168B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2892C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExTX-0006zx-2m
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iExOJ-0004YS-Qp
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iExOI-0005tl-Dw
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:15:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:46662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iExOF-0005oo-9S; Mon, 30 Sep 2019 11:15:07 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iExOA-0005tD-Pv; Mon, 30 Sep 2019 18:15:03 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/10] Further bitmaps improvements
Date: Mon, 30 Sep 2019 18:14:52 +0300
Message-Id: <20190930151502.7829-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

The main feature here is improvement of _next_dirty_area API, which I'm
going to use then for backup / block-copy.

Vladimir Sementsov-Ogievskiy (10):
  hbitmap: introduce HBITMAP_MAX_ORIG_SIZE
  hbitmap: move hbitmap_iter_next_word to hbitmap.c
  hbitmap: unpublish hbitmap_iter_skip_words
  hbitmap: drop meta bitmaps as they are unused
  block/dirty-bitmap: switch _next_dirty_area and _next_zero to int64_t
  block/dirty-bitmap: add _next_dirty API
  block/dirty-bitmap: improve _next_dirty_area API
  nbd/server: introduce NBDExtentArray
  nbd/server: use bdrv_dirty_bitmap_next_dirty_area
  block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty

 include/block/dirty-bitmap.h |   9 +-
 include/qemu/hbitmap.h       | 104 ++++--------
 block/dirty-bitmap.c         |  16 +-
 block/mirror.c               |  15 +-
 block/qcow2-bitmap.c         |  11 +-
 nbd/server.c                 | 224 +++++++++++--------------
 tests/test-hbitmap.c         | 314 +++++++++++++----------------------
 util/hbitmap.c               | 133 +++++++++------
 8 files changed, 360 insertions(+), 466 deletions(-)

-- 
2.21.0


