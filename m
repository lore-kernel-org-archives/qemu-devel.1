Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A8C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F3A22251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVwXE9qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F3A22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQm1N-0003kH-Rq
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzG-0001ws-3s
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzD-0008Tw-78
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602225277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VuXdYM6etcvUwJ5R2PrYu0vd1gWeG/r5KPCH50xhNU8=;
 b=dVwXE9qASpakGvM2gwnA/bNehn5RvRcJ5NVN9dQyj2ukXA/bIz6gPX2UtMm1t6Ovx+wIIe
 5Cel9HOYTqZ7zuoHTo7lJco2tHOOtbmZgrgAxlh7uIx9BbHC1Zlc33uw8Q5iJgANcSpS4/
 bwQLIDEi+S+huOOj+gwZuxojzORyTkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-J1LpNc8CO-uk4eR9Djgr3w-1; Fri, 09 Oct 2020 02:34:35 -0400
X-MC-Unique: J1LpNc8CO-uk4eR9Djgr3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDB27101FFA2
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 06:34:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BF1D5C1BB;
 Fri,  9 Oct 2020 06:34:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 046C1112CE10; Fri,  9 Oct 2020 08:34:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] Monitor patches for 2020-10-09
Date: Fri,  9 Oct 2020 08:34:18 +0200
Message-Id: <20201009063432.303441-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df64e:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201008-1' into staging (2020-10-08 21:41:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2020-10-09

for you to fetch changes up to eb94b81a94bce112e6b206df846c1551aaf6cab6:

  block: Convert 'block_resize' to coroutine (2020-10-09 07:08:20 +0200)

----------------------------------------------------------------
Monitor patches for 2020-10-09

* QMP command block-resize and HMP command block_resize no longer
  block the main loop.

----------------------------------------------------------------
Kevin Wolf (14):
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
      block: Add bdrv_co_enter()/leave()
      block: Add bdrv_lock()/unlock()
      block: Convert 'block_resize' to coroutine

 docs/devel/qapi-code-gen.txt            |  29 +++++++
 docs/sphinx/qapidoc.py                  |   2 +-
 qapi/block-core.json                    |   3 +-
 include/block/aio.h                     |  10 +++
 include/block/block.h                   |  31 ++++++++
 include/monitor/monitor.h               |   7 +-
 include/qapi/qmp/dispatch.h             |   5 +-
 monitor/monitor-internal.h              |   7 +-
 audio/wavcapture.c                      |   8 +-
 block.c                                 |  50 ++++++++++++
 blockdev.c                              |  16 ++--
 dump/dump.c                             |   2 +-
 hw/core/machine-hmp-cmds.c              |   2 +-
 hw/scsi/vhost-scsi.c                    |   2 +-
 hw/virtio/vhost-vsock.c                 |   2 +-
 migration/fd.c                          |   4 +-
 monitor/hmp-cmds.c                      |   4 +-
 monitor/hmp.c                           |  44 ++++++++---
 monitor/misc.c                          |  38 +++++----
 monitor/monitor.c                       | 101 +++++++++++++++++++++---
 monitor/qmp-cmds-control.c              |   2 +
 monitor/qmp-cmds.c                      |   2 +-
 monitor/qmp.c                           | 131 +++++++++++++++++++++++---------
 net/socket.c                            |   2 +-
 net/tap.c                               |   6 +-
 qapi/qmp-dispatch.c                     |  65 +++++++++++++++-
 qapi/qmp-registry.c                     |   3 +
 qga/main.c                              |   2 +-
 softmmu/cpus.c                          |   2 +-
 stubs/monitor-core.c                    |  10 ++-
 tests/test-qmp-cmds.c                   |  10 ++-
 tests/test-util-sockets.c               |  12 +--
 trace/control.c                         |   2 +-
 util/aio-posix.c                        |   8 +-
 util/async.c                            |  30 ++++++++
 util/qemu-error.c                       |   6 +-
 util/qemu-print.c                       |   3 +-
 util/qemu-sockets.c                     |   1 +
 hmp-commands.hx                         |   1 +
 scripts/qapi/commands.py                |  10 ++-
 scripts/qapi/expr.py                    |  11 ++-
 scripts/qapi/introspect.py              |   2 +-
 scripts/qapi/schema.py                  |  13 +++-
 tests/qapi-schema/meson.build           |   1 +
 tests/qapi-schema/oob-coroutine.err     |   2 +
 tests/qapi-schema/oob-coroutine.json    |   2 +
 tests/qapi-schema/oob-coroutine.out     |   0
 tests/qapi-schema/qapi-schema-test.json |   1 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 tests/qapi-schema/test-qapi.py          |   7 +-
 50 files changed, 573 insertions(+), 143 deletions(-)
 create mode 100644 tests/qapi-schema/oob-coroutine.err
 create mode 100644 tests/qapi-schema/oob-coroutine.json
 create mode 100644 tests/qapi-schema/oob-coroutine.out

-- 
2.26.2


