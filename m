Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD85C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 18:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A229420650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 18:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A229420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9vKK-0005OF-Nf
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 14:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9vC7-0006X6-Tt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9vC1-0004u3-MF
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:53:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:36802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9vBp-0004nf-Qt; Mon, 16 Sep 2019 13:53:30 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9vBm-0004Nc-0l; Mon, 16 Sep 2019 20:53:26 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 20:53:19 +0300
Message-Id: <20190916175324.18478-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v5 0/5] qcow2: async handling of fragmented io
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is an asynchronous scheme for handling fragmented qcow2
reads and writes. Both qcow2 read and write functions loops through
sequential portions of data. The series aim it to parallelize these
loops iterations.
It improves performance for fragmented qcow2 images, I've tested it
as described below.

v5: fix 026 and rebase on Max's block branch [perf results not updated]:

01: new, prepare 026 to not fail
03: - drop read_encrypted blkdbg event [Kevin]
    - assert((x & (BDRV_SECTOR_SIZE - 1)) == 0) -> assert(QEMU_IS_ALIGNED(x, BDRV_SECTOR_SIZE)) [rebase]
    - full host offset in argument of qcow2_co_decrypt [rebase]
04: - substitute remaining qcow2_co_do_pwritev by qcow2_co_pwritev_task in comment [Max]
    - full host offset in argument of qcow2_co_encrypt [rebase]
05: - Now patch don't affect 026 iotest, so its output is not changed

Rebase changes seems trivial, so, I've kept r-b marks.

Based-on: https://github.com/XanClic/qemu.git block

About testing:

I have four 4G qcow2 images (with default 64k block size) on my ssd disk:
t-seq.qcow2 - sequentially written qcow2 image
t-reverse.qcow2 - filled by writing 64k portions from end to the start
t-rand.qcow2 - filled by writing 64k portions (aligned) in random order
t-part-rand.qcow2 - filled by shuffling order of 64k writes in 1m clusters
(see source code of image generation in the end for details)

and I've done several runs like the following (sequential io by 1mb chunks):

    out=/tmp/block; echo > $out; cat /tmp/files | while read file; do for wr in {"","-w"}; do echo "$file" $wr; ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none $wr "$file" | grep 'Run completed in' | awk '{print $4}' >> $out; done; done


short info about parameters:
  -w - do writes (otherwise do reads)
  -c - count of blocks
  -s - block size
  -t none - disable cache
  -n - native aio
  -d 1 - don't use parallel requests provided by qemu-img bench itself

results:

    +---------------------------+---------+---------+
    | file                      | master  | async   |
    +---------------------------+---------+---------+
    | /ssd/t-part-rand.qcow2    | 14.671  | 9.193   |
    +---------------------------+---------+---------+
    | /ssd/t-part-rand.qcow2 -w | 11.434  | 8.621   |
    +---------------------------+---------+---------+
    | /ssd/t-rand.qcow2         | 20.421  | 10.05   |
    +---------------------------+---------+---------+
    | /ssd/t-rand.qcow2 -w      | 11.097  | 8.915   |
    +---------------------------+---------+---------+
    | /ssd/t-reverse.qcow2      | 17.515  | 9.407   |
    +---------------------------+---------+---------+
    | /ssd/t-reverse.qcow2 -w   | 11.255  | 8.649   |
    +---------------------------+---------+---------+
    | /ssd/t-seq.qcow2          | 9.081   | 9.072   |
    +---------------------------+---------+---------+
    | /ssd/t-seq.qcow2 -w       | 8.761   | 8.747   |
    +---------------------------+---------+---------+
    | /tmp/t-part-rand.qcow2    | 41.179  | 41.37   |
    +---------------------------+---------+---------+
    | /tmp/t-part-rand.qcow2 -w | 54.097  | 55.323  |
    +---------------------------+---------+---------+
    | /tmp/t-rand.qcow2         | 711.899 | 514.339 |
    +---------------------------+---------+---------+
    | /tmp/t-rand.qcow2 -w      | 546.259 | 642.114 |
    +---------------------------+---------+---------+
    | /tmp/t-reverse.qcow2      | 86.065  | 96.522  |
    +---------------------------+---------+---------+
    | /tmp/t-reverse.qcow2 -w   | 46.557  | 48.499  |
    +---------------------------+---------+---------+
    | /tmp/t-seq.qcow2          | 33.804  | 33.862  |
    +---------------------------+---------+---------+
    | /tmp/t-seq.qcow2 -w       | 34.299  | 34.233  |
    +---------------------------+---------+---------+


Performance gain is obvious, especially for read and especially for ssd.
For hdd there is a degradation for reverse case, but this is the most
impossible case and seems not critical.

How images are generated:

    ==== gen-writes ======
    #!/usr/bin/env python
    import random
    import sys

    size = 4 * 1024 * 1024 * 1024
    block = 64 * 1024
    block2 = 1024 * 1024

    arg = sys.argv[1]

    if arg in ('rand', 'reverse', 'seq'):
        writes = list(range(0, size, block))

    if arg == 'rand':
        random.shuffle(writes)
    elif arg == 'reverse':
        writes.reverse()
    elif arg == 'part-rand':
        writes = []
        for off in range(0, size, block2):
            wr = list(range(off, off + block2, block))
            random.shuffle(wr)
            writes.extend(wr)
    elif arg != 'seq':
        sys.exit(1)

    for w in writes:
        print 'write -P 0xff {} {}'.format(w, block)

    print 'q'
    ==========================

    ===== gen-test-images.sh =====
    #!/bin/bash

    IMG_PATH=/ssd

    for name in seq reverse rand part-rand; do
        IMG=$IMG_PATH/t-$name.qcow2
        echo createing $IMG ...
        rm -f $IMG
        qemu-img create -f qcow2 $IMG 4G
        gen-writes $name | qemu-io $IMG
    done
    ==============================

Vladimir Sementsov-Ogievskiy (5):
  qemu-iotests: ignore leaks on failure paths in 026
  block: introduce aio task pool
  block/qcow2: refactor qcow2_co_preadv_part
  block/qcow2: refactor qcow2_co_pwritev_part
  block/qcow2: introduce parallel subrequest handling in read and write

 block/qcow2.h                      |   3 +
 include/block/aio_task.h           |  54 ++++
 block/aio_task.c                   | 124 ++++++++
 block/qcow2.c                      | 466 +++++++++++++++++++----------
 block/Makefile.objs                |   2 +
 block/trace-events                 |   1 +
 tests/qemu-iotests/026             |   6 +-
 tests/qemu-iotests/026.out         |  80 ++---
 tests/qemu-iotests/026.out.nocache |  80 ++---
 tests/qemu-iotests/common.rc       |  17 ++
 10 files changed, 549 insertions(+), 284 deletions(-)
 create mode 100644 include/block/aio_task.h
 create mode 100644 block/aio_task.c

-- 
2.21.0


