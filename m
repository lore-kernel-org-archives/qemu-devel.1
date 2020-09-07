Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42480C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABA72177B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBHwxv0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABA72177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFF3K-0003kD-C3
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF1y-0001i0-Cc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:09:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF1v-0007qi-K6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599476986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivOMTX/5BEYzRjRij14ka9b8UzkCtyUXx45fVTX8myw=;
 b=WBHwxv0qqxMMW40D7qEwrHTlbIJuEB5XDnFjmfR2YNXAYaVXyYl6DnMLD8BV3u8L59YZQb
 sfTxVXeYQyHF9Mx25OI50kYXQoK0Kk6IPGMer7jjOpR+MAoFKlpXofCHfLa0fLhOeo8rCC
 lcSt0RgMNoG0SkMSTjcsfZQ5+csYX2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-auujLZ3tMRKB_LO2GqlDnQ-1; Mon, 07 Sep 2020 07:09:42 -0400
X-MC-Unique: auujLZ3tMRKB_LO2GqlDnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC0E6802B49;
 Mon,  7 Sep 2020 11:09:41 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F10667ED60;
 Mon,  7 Sep 2020 11:09:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/64] Block layer patches
Date: Mon,  7 Sep 2020 13:08:32 +0200
Message-Id: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7c37270b3fbe3d034ba80e488761461676e21eb4:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06 16:23:55 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4cc0ec9b1b8830f7d1fcf5dfded19ef070f98eaa:

  block/nvme: Pair doorbell registers (2020-09-07 12:47:57 +0200)

----------------------------------------------------------------
Block layer patches:

- qemu-img create: Fail gracefully when backing file is an empty string
- Fixes related to filter block nodes ("Deal with filters" series)
- block/nvme: Various cleanups required to use multiple queues
- block/nvme: Use NvmeBar structure from "block/nvme.h"
- file-win32: Fix "locking" option
- iotests: Allow running from different directory

----------------------------------------------------------------
Connor Kuehl (1):
      block: Raise an error when backing file parameter is an empty string

Kevin Wolf (2):
      iotests: Allow running from different directory
      file-win32: Fix "locking" option

Max Reitz (43):
      block: Add child access functions
      block: Add chain helper functions
      block: bdrv_cow_child() for bdrv_has_zero_init()
      block: bdrv_set_backing_hd() is about bs->backing
      block: Include filters when freezing backing chain
      block: Drop bdrv_is_encrypted()
      block: Add bdrv_supports_compressed_writes()
      throttle: Support compressed writes
      copy-on-read: Support compressed writes
      block: Use bdrv_filter_(bs|child) where obvious
      block: Use CAFs in block status functions
      stream: Deal with filters
      block: Use CAFs when working with backing chains
      block: Use bdrv_cow_child() in bdrv_co_truncate()
      block: Re-evaluate backing file handling in reopen
      block: Flush all children in generic code
      vmdk: Drop vmdk_co_flush()
      block: Iterate over children in refresh_limits
      block: Use CAFs in bdrv_refresh_filename()
      block: Use CAF in bdrv_co_rw_vmstate()
      block/snapshot: Fix fallback
      block: Use CAFs for debug breakpoints
      block: Improve get_allocated_file_size's default
      block/null: Implement bdrv_get_allocated_file_size
      blockdev: Use CAF in external_snapshot_prepare()
      block: Report data child for query-blockstats
      block: Use child access functions for QAPI queries
      block-copy: Use CAF to find sync=top base
      mirror: Deal with filters
      backup: Deal with filters
      commit: Deal with filters
      nbd: Use CAF when looking for dirty bitmap
      qemu-img: Use child access functions
      block: Drop backing_bs()
      blockdev: Fix active commit choice
      block: Inline bdrv_co_block_status_from_*()
      block: Leave BDS.backing_{file,format} constant
      iotests: Test that qcow2's data-file is flushed
      iotests: Let complete_and_wait() work with commit
      iotests: Add filter commit test cases
      iotests: Add filter mirror test cases
      iotests: Add test for commit in sub directory
      iotests: Test committing to overridden backing

Philippe Mathieu-Daudé (18):
      block/nvme: Replace magic value by SCALE_MS definition
      block/nvme: Avoid further processing if trace event not enabled
      block/nvme: Let nvme_create_queue_pair() fail gracefully
      block/nvme: Define INDEX macros to ease code review
      block/nvme: Improve error message when IO queue creation failed
      block/nvme: Use common error path in nvme_add_io_queue()
      block/nvme: Rename local variable
      block/nvme: Use union of NvmeIdCtrl / NvmeIdNs structures
      block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset
      block/nvme: Replace qemu_try_blockalign(bs) by qemu_try_memalign(pg_sz)
      block/nvme: Simplify nvme_init_queue() arguments
      block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
      block/nvme: Simplify nvme_create_queue_pair() arguments
      block/nvme: Extract nvme_poll_queue()
      block/nvme: Use an array of EventNotifier
      block/nvme: Group controller registers in NVMeRegs structure
      block/nvme: Use generic NvmeBar structure
      block/nvme: Pair doorbell registers

 qapi/block-core.json           |  58 +++--
 include/block/block.h          |   2 +-
 include/block/block_int.h      |  95 +++++---
 block.c                        | 492 +++++++++++++++++++++++++++++++++--------
 block/backup-top.c             |   4 +-
 block/backup.c                 |   9 +-
 block/blkdebug.c               |   7 +-
 block/blklogwrites.c           |   1 -
 block/block-backend.c          |   7 +-
 block/block-copy.c             |   4 +-
 block/commit.c                 |  95 +++++---
 block/copy-on-read.c           |  13 +-
 block/file-win32.c             |  22 +-
 block/filter-compress.c        |   2 -
 block/io.c                     | 142 ++++++------
 block/mirror.c                 | 119 +++++++---
 block/monitor/block-hmp-cmds.c |   2 +-
 block/null.c                   |   7 +
 block/nvme.c                   | 248 +++++++++++----------
 block/qapi.c                   |  74 +++++--
 block/snapshot.c               | 104 +++++++--
 block/stream.c                 |  63 ++++--
 block/throttle.c               |  11 +-
 block/vmdk.c                   |  16 --
 blockdev.c                     | 101 +++++++--
 migration/block-dirty-bitmap.c |   8 +-
 nbd/server.c                   |   6 +-
 qemu-img.c                     |  43 ++--
 tests/qemu-iotests/iotests.py  |  10 +-
 tests/qemu-iotests/020         |  44 ++++
 tests/qemu-iotests/020.out     |  10 +
 tests/qemu-iotests/040         | 238 ++++++++++++++++++++
 tests/qemu-iotests/040.out     |   4 +-
 tests/qemu-iotests/041         | 146 +++++++++++-
 tests/qemu-iotests/041.out     |   4 +-
 tests/qemu-iotests/049         |   4 +
 tests/qemu-iotests/049.out     |   5 +
 tests/qemu-iotests/153.out     |   2 +-
 tests/qemu-iotests/184         |   3 +-
 tests/qemu-iotests/184.out     |  14 +-
 tests/qemu-iotests/204.out     |   1 +
 tests/qemu-iotests/228         |   6 +-
 tests/qemu-iotests/228.out     |   6 +-
 tests/qemu-iotests/244         |  49 ++++
 tests/qemu-iotests/244.out     |   7 +
 tests/qemu-iotests/245         |   4 +-
 tests/qemu-iotests/273.out     |   4 +-
 tests/qemu-iotests/check       |   2 +-
 48 files changed, 1763 insertions(+), 555 deletions(-)


