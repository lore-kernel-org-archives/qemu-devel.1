Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18A6C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790EB20730
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790EB20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcTJ-0001hn-5C
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNf-000571-1H
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNd-0002Ad-5M
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:47408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNZ-0001rm-VV; Fri, 15 Nov 2019 09:15:18 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcN3-0006WW-50; Fri, 15 Nov 2019 17:14:45 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 00/24] backup performance: block_status + async
Date: Fri, 15 Nov 2019 17:14:20 +0300
Message-Id: <20191115141444.24155-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

These series does the following things:

1. bring block_status to block-copy, for efficient chunk sizes and
handling ZERO clusters. (mirror does it)
2. bring aio-task-pool to block-copy, for parallel copying loop
iteration. (mirror does it its own way)
4. add speed limit and cancelling possibility to block-copy (for 5.)
5. use block-copy in backup directly, to bring block_status and async.
tasks into backup
6. add some python scripts to benchmark the results

The main theme is async handling of copying loop iterations, which
already works and bring performance in mirror (in its own way) and in
qcow2 (using aio-task-pool).

Here are the results:

----------  -------------  -----------------  -------------  -----------------  -------------
            backup-old     backup-old(no CR)  backup-new     backup-new(no CR)  mirror
ssd -> ssd  9.88 +- 0.85   8.85 +- 0.48       5.39 +- 0.04   4.06 +- 0.01       4.15 +- 0.03
ssd -> hdd  10.90 +- 0.30  10.39 +- 0.41      9.36 +- 0.06   9.24 +- 0.06       9.00 +- 0.06
hdd -> hdd  20.09 +- 0.23  20.15 +- 0.07      48.65 +- 1.86  20.62 +- 0.08      19.82 +- 0.37
----------  -------------  -----------------  -------------  -----------------  -------------

----------  -------------  -------------  -------------
            backup-old     backup-new     mirror
nbd -> ssd  30.69 +- 0.23  9.02 +- 0.00   9.06 +- 0.03
ssd -> nbd  36.94 +- 0.01  11.50 +- 0.08  10.12 +- 0.05
----------  -------------  -------------  -------------

Here:
"old" means "before series"
"new" means "after series"
"no CR" means "copy_range disabled"

nbd is nbd server on another node, running like
"qemu-nbd --persistent --nocache -p 10810 ones1000M-source"

RFC.1
What I noticed, is that copy_range makes things worse.. Is there any
case or benchmarking which shows that copy_range increases performance?
Possibly we should disable it by default..

RFC.2
Last patch isn't for commit, possibly I should make some generic
example, ideas are welcome

RFC.3
The series are big and splittable. The reason to send it alltogether is
that I wanted to get the whole picture to benchmark.

Also, I keep in mind benchmarking backup to qcow2 with different levels
of defragmentation and with/without compression.

Future plan is obvious: move block-commit and block-stream to use
block-copy, which will unify code path and bring performance to commit
and stream.

Vladimir Sementsov-Ogievskiy (24):
  block/block-copy: specialcase first copy_range request
  block/block-copy: use block_status
  block/block-copy: factor out block_copy_find_inflight_req
  block/block-copy: refactor interfaces to use bytes instead of end
  block/block-copy: rename start to offset in interfaces
  block/block-copy: reduce intersecting request lock
  block/block-copy: hide structure definitions
  block/block-copy: rename in-flight requests to tasks
  block/block-copy: alloc task on each iteration
  block/block-copy: add state pointer to BlockCopyTask
  block/block-copy: move task size initial calculation to _task_create
  block/block-copy: move block_copy_task_create down
  block/block-copy: use aio-task-pool API
  block/block-copy: More explicit call_state
  block/block-copy: implement block_copy_async
  block/block-copy: add max_chunk and max_workers paramters
  block/block-copy: add ratelimit to block-copy
  block/block-copy: add block_copy_cancel
  blockjob: add set_speed to BlockJobDriver
  job: call job_enter from job_user_pause
  backup: move to block-copy
  python: add simplebench.py
  python: add qemu/bench_block_job.py
  python: benchmark new backup architecture

 qapi/block-core.json           |   9 +-
 include/block/block-copy.h     |  90 ++---
 include/block/block_int.h      |   7 +
 include/block/blockjob_int.h   |   2 +
 block/backup-top.c             |   6 +-
 block/backup.c                 | 184 ++++++----
 block/block-copy.c             | 608 ++++++++++++++++++++++++++++-----
 block/replication.c            |   1 +
 blockdev.c                     |   5 +
 blockjob.c                     |   6 +
 job.c                          |   1 +
 block/trace-events             |   1 +
 python/bench-example.py        |  93 +++++
 python/qemu/bench_block_job.py | 114 +++++++
 python/simplebench.py          | 122 +++++++
 tests/qemu-iotests/129         |   3 +-
 tests/qemu-iotests/185         |   3 +-
 tests/qemu-iotests/219         |   1 +
 tests/qemu-iotests/257         |   1 +
 tests/qemu-iotests/257.out     | 306 ++++++++---------
 20 files changed, 1184 insertions(+), 379 deletions(-)
 create mode 100755 python/bench-example.py
 create mode 100755 python/qemu/bench_block_job.py
 create mode 100644 python/simplebench.py

-- 
2.21.0


