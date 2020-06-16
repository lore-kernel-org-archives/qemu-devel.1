Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847F0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6220620786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6220620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEMb-00017G-Kh
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jlEKM-0004wF-V0; Tue, 16 Jun 2020 12:20:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:43700 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jlEKJ-0006a2-5v; Tue, 16 Jun 2020 12:20:46 -0400
Received: from [192.168.15.172] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jlEK0-0003Pf-Ub; Tue, 16 Jun 2020 19:20:24 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] block: seriously improve savevm performance
Date: Tue, 16 Jun 2020 19:20:30 +0300
Message-Id: <20200616162035.29857-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 12:20:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series do standard basic things:
- it creates intermediate buffer for all writes from QEMU migration code
  to QCOW2 image,
- this buffer is sent to disk asynchronously, allowing several writes to
  run in parallel.

In general, migration code is fantastically inefficent (by observation),
buffers are not aligned and sent with arbitrary pieces, a lot of time
less than 100 bytes at a chunk, which results in read-modify-write
operations with non-cached operations. It should also be noted that all
operations are performed into unallocated image blocks, which also suffer
due to partial writes to such new clusters.

This patch series is an implementation of idea discussed in the RFC
posted by Denis Plotnikov
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg01925.html
Results with this series over NVME are better than original code
                original     rfc    this
cached:          1.79s      2.38s   1.27s
non-cached:      3.29s      1.31s   0.81s

Changes from v3:
- rebased to master
- added patch 3 which removes aio_task_pool_wait_one()
- added R-By to patch 1
- patch 4 is rewritten via bdrv_run_co
- error path in blk_save_vmstate() is rewritten to call bdrv_flush_vmstate
  unconditionally
- added some comments
- fixes initialization in bdrv_co_vmstate_save_task_entry as suggested

Changes from v2:
- code moved from QCOW2 level to generic block level
- created bdrv_flush_vmstate helper to fix 022, 029 tests
- added recursive for bs->file in bdrv_co_flush_vmstate (fix 267)
- fixed blk_save_vmstate helper
- fixed coroutine wait as Vladimir suggested with waiting fixes from me

Changes from v1:
- patchew warning fixed
- fixed validation that only 1 waiter is allowed in patch 1

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <fam@euphon.net>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>


