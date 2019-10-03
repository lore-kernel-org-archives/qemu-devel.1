Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A61FC4CED1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4439D20830
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4439D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG4kM-0000kx-6x
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG4hj-00074E-Nf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG4hi-00005s-MJ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:15:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:50258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG4hb-0008Tn-LD; Thu, 03 Oct 2019 13:15:43 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG4hX-0002ks-Us; Thu, 03 Oct 2019 20:15:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/6] block-copy: memory limit
Date: Thu,  3 Oct 2019 20:15:33 +0300
Message-Id: <20191003171539.12327-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

I'm going to bring block-status driven, async copying process to
block-copy, to make it fast. The first step is to limit memory usage of
backup, here is it.

Based on my "[PATCH v15 0/5] backup-top filter driver for backup":
Based-on: <20191001131409.14202-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (6):
  block/block-copy: allocate buffer in block_copy_with_bounce_buffer
  block/block-copy: limit copy_range_size to 16 MiB
  block/block-copy: refactor copying
  util: introduce co-shared-amount
  block/block-copy: add memory limit
  block/block-copy: increase buffered copy request

 include/block/block-copy.h      |   5 +-
 include/qemu/co-shared-amount.h |  66 ++++++++++++
 block/block-copy.c              | 179 +++++++++++++++++---------------
 util/qemu-co-shared-amount.c    |  77 ++++++++++++++
 block/trace-events              |   6 +-
 util/Makefile.objs              |   1 +
 6 files changed, 246 insertions(+), 88 deletions(-)
 create mode 100644 include/qemu/co-shared-amount.h
 create mode 100644 util/qemu-co-shared-amount.c

-- 
2.21.0


