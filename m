Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9033DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6DE207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZY2Hu0kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6DE207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKd3-0006VT-Ge
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbY-0003RD-3M
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbX-0003pS-83
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ECAObEdVKnIosON+lim4EH8Dz4bcWcMcUF2wvBUmpSQ=;
 b=ZY2Hu0knmCjJr1pF9Mhr11xA/hiywWaGC3NaiA+OJcKyh9mVvMnYT/kmg/WL8hlqY2C3tO
 AW+sT5zelbQFWde2qvxrraoalBgoPp/+BmXarONZRzKKiGWEIL3GeiE5Tfep4Ie7/Vzzuh
 UnK0Cee3Lc6UMfdO0/8OW1pD9UAP7yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-qsRQihMLP0eC6N8Gjx328A-1; Thu, 28 May 2020 11:37:54 -0400
X-MC-Unique: qsRQihMLP0eC6N8Gjx328A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECF7E19200FC;
 Thu, 28 May 2020 15:37:46 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA8E010013C0;
 Thu, 28 May 2020 15:37:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 00/12] monitor: Optionally run handlers in coroutines
Date: Thu, 28 May 2020 17:37:30 +0200
Message-Id: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org
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


Kevin Wolf (12):
  monitor: Add Monitor parameter to monitor_set_cpu()
  monitor: Use getter/setter functions for cur_mon
  hmp: Set cur_mon only in handle_hmp_command()
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
 include/monitor/monitor.h               |   5 +-
 include/qapi/qmp/dispatch.h             |   5 +-
 monitor/monitor-internal.h              |   7 +-
 audio/wavcapture.c                      |   8 +-
 block.c                                 |  10 ++
 blockdev.c                              |  13 ++-
 dump/dump.c                             |   2 +-
 hw/scsi/vhost-scsi.c                    |   2 +-
 hw/virtio/vhost-vsock.c                 |   2 +-
 migration/fd.c                          |   4 +-
 monitor/hmp-cmds.c                      |   2 +-
 monitor/hmp.c                           |  51 +++++++---
 monitor/misc.c                          |  21 ++--
 monitor/monitor.c                       |  87 ++++++++++++++--
 monitor/qmp-cmds-control.c              |   2 +
 monitor/qmp-cmds.c                      |   2 +-
 monitor/qmp.c                           | 130 +++++++++++++++++-------
 net/socket.c                            |   2 +-
 net/tap.c                               |   6 +-
 qapi/qmp-dispatch.c                     |  52 +++++++++-
 qapi/qmp-registry.c                     |   3 +
 qga/main.c                              |   2 +-
 stubs/monitor-core.c                    |   9 +-
 tests/test-qmp-cmds.c                   |  10 +-
 tests/test-util-sockets.c               |  22 ++--
 trace/control.c                         |   2 +-
 util/aio-posix.c                        |   8 +-
 util/async.c                            |  30 ++++++
 util/qemu-error.c                       |   4 +-
 util/qemu-print.c                       |   3 +-
 util/qemu-sockets.c                     |   1 +
 scripts/qapi/commands.py                |  10 +-
 scripts/qapi/doc.py                     |   2 +-
 scripts/qapi/expr.py                    |  10 +-
 scripts/qapi/introspect.py              |   2 +-
 scripts/qapi/schema.py                  |  12 ++-
 tests/qapi-schema/test-qapi.py          |   7 +-
 hmp-commands.hx                         |   1 +
 tests/Makefile.include                  |   1 +
 tests/qapi-schema/oob-coroutine.err     |   2 +
 tests/qapi-schema/oob-coroutine.json    |   2 +
 tests/qapi-schema/oob-coroutine.out     |   0
 tests/qapi-schema/qapi-schema-test.json |   1 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 48 files changed, 454 insertions(+), 136 deletions(-)
 create mode 100644 tests/qapi-schema/oob-coroutine.err
 create mode 100644 tests/qapi-schema/oob-coroutine.json
 create mode 100644 tests/qapi-schema/oob-coroutine.out

-- 
2.25.4


