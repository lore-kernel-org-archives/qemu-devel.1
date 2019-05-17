Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A0BC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625BF2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625BF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRehz-0003mK-MR
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 11:23:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hReff-0001hq-TE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRefe-0003eJ-Vh
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:21:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRefe-0003PP-NI; Fri, 17 May 2019 11:21:18 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hRefZ-0005qt-LD; Fri, 17 May 2019 18:21:13 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 17 May 2019 18:21:09 +0300
Message-Id: <20190517152111.206494-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 0/2] bitmaps: merge bitmaps from different
 nodes
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

We need to copy bitmaps to new top node on external snapshot, to
not break incremental backup chain.

The only thing to do is to allow block-dirty-bitmap-merge to work
with different nodes, here it is.

v2: use 'alternate' type in qapi for specifying source bitmap
    instead of adding new field external-bitmaps [Eric]

Vladimir Sementsov-Ogievskiy (2):
  qapi: support external bitmaps in block-dirty-bitmap-merge
  iotests: test external snapshot with bitmap copying

 qapi/block-core.json       | 22 +++++++++++++---
 block/dirty-bitmap.c       |  9 ++++---
 blockdev.c                 | 50 +++++++++++++++++++++++-------------
 tests/qemu-iotests/254     | 52 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/254.out | 52 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 163 insertions(+), 23 deletions(-)
 create mode 100755 tests/qemu-iotests/254
 create mode 100644 tests/qemu-iotests/254.out

-- 
2.18.0


