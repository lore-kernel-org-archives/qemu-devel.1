Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503C2C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AF620879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AF620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDX7W-0001mV-AE
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:27:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6I-00015f-P4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6G-0006Lv-56
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:50306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDX6D-0006EV-4G; Mon, 08 Apr 2019 12:26:23 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hDX69-0001tt-Ar; Mon, 08 Apr 2019 19:26:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 19:26:15 +0300
Message-Id: <20190408162617.258535-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 for 4.1 0/2] avoid lseek on block_status
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
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408162615.SC5K6grkjFPXdj8_ogyd08dr1qan4b2dgED7-fCwc0Y@z>

Hi!

It's a continuation for
"[PATCH] qcow2: avoid lseek on block_status if possible"
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06598.html

performance results for block-status on tmpfs [tests originally by Kevin,
now they are in 01]:

./tests/perf/block/qcow2/convert-blockstatus /ramdisk/x

after 01:

plain: 81.77
forward: 82.61
prealloc: 0.01

after 02:

plain: 0.12
forward: 0.12
prealloc: 0.01

v2:
 01: new
 02: [mostly by Kevin's comments]
     - rewritten to go through new flag BDRV_BLOCK_RECURSE
     - never retry detection if failed for first time
     - rewrite detection to do less iterations and to be more simple

     iotests 102 behavior changed [and not sure about other two ones
     in comparison with v1, but it seems it doesn't matter]

     also, patch subject changed, as now it's a generic change for
     block layer


Vladimir Sementsov-Ogievskiy (2):
  tests/perf: Test lseek influence on qcow2 block-status
  block: avoid recursive block_status call if possible

 block/qcow2.h                              |  4 ++
 include/block/block.h                      |  8 ++-
 block/io.c                                 |  9 ++-
 block/qcow2-refcount.c                     | 32 ++++++++++
 block/qcow2.c                              | 11 ++++
 tests/perf/block/qcow2/convert-blockstatus | 71 ++++++++++++++++++++++
 tests/qemu-iotests/102                     |  2 +-
 tests/qemu-iotests/102.out                 |  3 +-
 tests/qemu-iotests/141.out                 |  2 +-
 tests/qemu-iotests/144.out                 |  2 +-
 10 files changed, 138 insertions(+), 6 deletions(-)
 create mode 100755 tests/perf/block/qcow2/convert-blockstatus

-- 
2.18.0


