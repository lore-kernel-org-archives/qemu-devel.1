Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A194EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1F722272
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+me3KVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1F722272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1qD-0000I6-Vw
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lX-0000u4-Gg
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lU-0003kb-06
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hKHL0H3fHFZht2VeEP4Quc9dgTC9Pa35JtJtxdEQi8I=;
 b=H+me3KVAYSi1EBucGd0llWcX2puGo/MuRg5Fxoj6de4a93oZ1es0HC23cdu0/KwY4TzRQl
 6/XRT46zog1+H8x0ENTJw5pFy7EgcdPW1yLAjmOEJRduqpYyIpl1LYxVyR2UDY64mSF2Jq
 bn2jsDaZiZyyCtdNihROLjP8vUs6hxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-XPeE5KFKNdGg3-QlFtX5WA-1; Wed, 09 Sep 2020 11:11:59 -0400
X-MC-Unique: XPeE5KFKNdGg3-QlFtX5WA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AAED8015AA;
 Wed,  9 Sep 2020 15:11:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-221.ams2.redhat.com
 [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42F7B60C07;
 Wed,  9 Sep 2020 15:11:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 00/13] monitor: Optionally run handlers in coroutines
Date: Wed,  9 Sep 2020 17:11:36 +0200
Message-Id: <20200909151149.490589-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some QMP command handlers can block the main loop for a relatively long
time, for example because they perform some I/O. This is quite nasty.
Allowing such handlers to run in a coroutine where they can yield (and
therefore release the BQL) while waiting for an event such as I/O
completion solves the problem.

This series adds the infrastructure to allow this and switches
block_resize to run in a coroutine as a first example.

This is an alternative solution to Marc-André's "monitor: add
asynchronous command type" series.

v7:
- Added patch 2 to add a Monitor parameter to monitor_get_cpu_index(),
  too [Markus]
- Let monitor_set_cur() return the old monitor [Markus]
- Fixed comment about linking stub objects in test-util-sockets [Markus]
- More detailed commit message for per-coroutine current monitor and
  document that monitor_set_cur(NULL) must be called eventually [Markus]
- Resolve some merge conflicts on rebase

v6:
- Fixed cur_mon behaviour: It should always point to the Monitor while
  we're in the handler coroutine, but be NULL while the handler
  coroutines has yielded. [Markus]
- Give HMP handlers the coroutine option, too, because they will call
  QMP handlers, and life is easier when we know whether we are in
  coroutine context or not.
- Fixed block_resize for block devices in iothreads and for HMP
- Resolved some merge conflict with QAPI generator and monitor
  refactorings that were merged in the meantime

v5:
- Improved comments and documentation [Markus]

v4:
- Forbid 'oob': true, 'coroutine': true [Markus]
- Removed Python type hints [Markus]
- Introduced separate bool qmp_dispatcher_co_shutdown to make it clearer
  how a shutdown request is signalled to the dispatcher [Markus]
- Allow using aio_poll() with iohandler_ctx and use that instead of
  aio_bh_poll() [Markus]
- Removed coroutine_fn from qmp_block_resize() again because at least
  one caller (HMP) calls it outside of coroutine context [Markus]
- Tried to make the synchronisation between dispatcher and the monitor
  thread clearer, and fixed a race condition
- Improved documentation and comments

v3:
- Fix race between monitor thread and dispatcher that could schedule the
  dispatcher coroutine twice if a second requests comes in before the
  dispatcher can wake up [Patchew]

v2:
- Fix typo in a commit message [Eric]
- Use hyphen instead of underscore for the test command [Eric]
- Mark qmp_block_resize() as coroutine_fn [Stefan]


Kevin Wolf (13):
  monitor: Add Monitor parameter to monitor_set_cpu()
  monitor: Add Monitor parameter to monitor_get_cpu_index()
  monitor: Use getter/setter functions for cur_mon
  hmp: Update current monitor only in handle_hmp_command()
  qmp: Assert that no other monitor is active
  qmp: Call monitor_set_cur() only in qmp_dispatch()
  monitor: Make current monitor a per-coroutine property
  qapi: Add a 'coroutine' flag for commands
  qmp: Move dispatcher to a coroutine
  hmp: Add support for coroutine command handlers
  util/async: Add aio_co_reschedule_self()
  block: Add bdrv_co_move_to_aio_context()
  block: Convert 'block_resize' to coroutine

 qapi/block-core.json                    |   3 +-
 docs/devel/qapi-code-gen.txt            |  12 +++
 include/block/aio.h                     |  10 ++
 include/block/block.h                   |   6 ++
 include/monitor/monitor.h               |   7 +-
 include/qapi/qmp/dispatch.h             |   5 +-
 monitor/monitor-internal.h              |   7 +-
 audio/wavcapture.c                      |   8 +-
 block.c                                 |  10 ++
 blockdev.c                              |  13 ++-
 dump/dump.c                             |   2 +-
 hw/core/machine-hmp-cmds.c              |   2 +-
 hw/scsi/vhost-scsi.c                    |   2 +-
 hw/virtio/vhost-vsock.c                 |   2 +-
 migration/fd.c                          |   4 +-
 monitor/hmp-cmds.c                      |   4 +-
 monitor/hmp.c                           |  44 ++++++--
 monitor/misc.c                          |  38 ++++---
 monitor/monitor.c                       | 101 ++++++++++++++++--
 monitor/qmp-cmds-control.c              |   2 +
 monitor/qmp-cmds.c                      |   2 +-
 monitor/qmp.c                           | 130 +++++++++++++++++-------
 net/socket.c                            |   2 +-
 net/tap.c                               |   6 +-
 qapi/qmp-dispatch.c                     |  61 ++++++++++-
 qapi/qmp-registry.c                     |   3 +
 qga/main.c                              |   2 +-
 softmmu/cpus.c                          |   2 +-
 stubs/monitor-core.c                    |  10 +-
 tests/test-qmp-cmds.c                   |  10 +-
 tests/test-util-sockets.c               |  12 +--
 trace/control.c                         |   2 +-
 util/aio-posix.c                        |   8 +-
 util/async.c                            |  30 ++++++
 util/qemu-error.c                       |   6 +-
 util/qemu-print.c                       |   3 +-
 util/qemu-sockets.c                     |   1 +
 scripts/qapi/commands.py                |  10 +-
 scripts/qapi/doc.py                     |   2 +-
 scripts/qapi/expr.py                    |  10 +-
 scripts/qapi/introspect.py              |   2 +-
 scripts/qapi/schema.py                  |  12 ++-
 tests/qapi-schema/test-qapi.py          |   7 +-
 hmp-commands.hx                         |   1 +
 tests/qapi-schema/meson.build           |   1 +
 tests/qapi-schema/oob-coroutine.err     |   2 +
 tests/qapi-schema/oob-coroutine.json    |   2 +
 tests/qapi-schema/oob-coroutine.out     |   0
 tests/qapi-schema/qapi-schema-test.json |   1 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 50 files changed, 481 insertions(+), 143 deletions(-)
 create mode 100644 tests/qapi-schema/oob-coroutine.err
 create mode 100644 tests/qapi-schema/oob-coroutine.json
 create mode 100644 tests/qapi-schema/oob-coroutine.out

-- 
2.25.4


