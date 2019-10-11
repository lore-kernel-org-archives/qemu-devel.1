Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D94EC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0DE2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0DE2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIr36-0001oB-6R
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtM-0005wc-3U
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtL-0004BH-5k
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:60308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtH-000475-MW; Fri, 11 Oct 2019 05:07:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtD-0000XM-No; Fri, 11 Oct 2019 12:07:11 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/5] active-mirror: support unaligned guest operations
Date: Fri, 11 Oct 2019 12:07:06 +0300
Message-Id: <20191011090711.19940-1-vsementsov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 9adc1cb49af8d fixed a bug about unaligned (to dirty bitmap
granularity) guest writes (and discards) by simply requesting
corresponding alignment on mirror-top filter. However forcing large
alignment obviously decreases performance of unaligned requests.

So it's time for a new solution which is in 04. And 05 reverts
9adc1cb49af8d.

v2:
01: new fix (do we need it for stable?)
02,03,05: add Max's r-b
04: fix bitmap handling
    improve comments

Vladimir Sementsov-Ogievskiy (5):
  hbitmap: handle set/reset with zero length
  block/mirror: simplify do_sync_target_write
  block/block-backend: add blk_co_pwritev_part
  block/mirror: support unaligned write in active mirror
  Revert "mirror: Only mirror granularity-aligned chunks"

 include/sysemu/block-backend.h |   4 +
 block/block-backend.c          |  17 +++-
 block/mirror.c                 | 181 ++++++++++++++++-----------------
 util/hbitmap.c                 |   8 ++
 4 files changed, 114 insertions(+), 96 deletions(-)

-- 
2.21.0


