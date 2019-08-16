Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD633C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82D1206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82D1206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyeFI-0003VC-P4
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 11:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyeBM-0007lD-Ix
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyeBK-0001Yc-PS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:30:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:60426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyeBH-0001Qa-4F; Fri, 16 Aug 2019 11:30:19 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyeBD-0007x1-7q; Fri, 16 Aug 2019 18:30:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 18:30:10 +0300
Message-Id: <20190816153015.447957-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 0/5] qcow2: async handling of fragmented io
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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

v4 [perf results not updated]:
01: new patch. Unrelated, but need to fix 026 before the series to
    correctly fix it after :)
02: - use coroutine_fn where appropriate (i.e. in aio_task_pool_new too)
    - add Max's r-b
03,04: add Max's r-b
05: fix 026 output

v3 (by Max's comments) [perf results not updated]:

01: - use coroutine_fn where appropriate !!!!!!!!!!!!!!!!!!!!!!!
    - add aio_task_pool_free
    - add some comments
    - move header to include/block
    - s/wait_done/waiting
02: - Rewrite note about decryption in guest buffers [thx to Eric]
    - separate g_assert_not_reached for QCOW2_CLUSTER_ZERO_*
    - drop return after g_assert_not_reached
03: - drop bytes_done and correctly use qiov_offset
    - fix comment
04: - move QCOW2_MAX_WORKERS to block/qcow2.h
    - initialize ret in qcow2_co_preadv_part
Based-on: https://github.com/stefanha/qemu/commits/block


v2: changed a lot, as
 1. a lot of preparations around locks, hd_qiovs, threads for encryption
    are done
 2. I decided to create separate file with async request handling API, to
    reuse it for backup, stream and copy-on-read to improve their performance
    too. Mirror and qemu-img convert has their own async request handling,
    may be we'll be able finally merge all these similar code into one
    feature.
    Note that not all API calls used in qcow2, some will be needed on
    following steps for parallelizing other io loops.

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
  tests/qemu-iotests: Fix qemu-io related output in 026.out.nocache
  block: introduce aio task pool
  block/qcow2: refactor qcow2_co_preadv_part
  block/qcow2: refactor qcow2_co_pwritev_part
  block/qcow2: introduce parallel subrequest handling in read and write

 qapi/block-core.json               |   2 +-
 block/qcow2.h                      |   3 +
 include/block/aio_task.h           |  54 ++++
 block/aio_task.c                   | 124 ++++++++
 block/qcow2.c                      | 461 +++++++++++++++++++----------
 block/Makefile.objs                |   2 +
 block/trace-events                 |   1 +
 tests/qemu-iotests/026.out         |  18 +-
 tests/qemu-iotests/026.out.nocache | 188 ++++++------
 9 files changed, 591 insertions(+), 262 deletions(-)
 create mode 100644 include/block/aio_task.h
 create mode 100644 block/aio_task.c

-- 
2.18.0


