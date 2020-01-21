Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F9AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C4F22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWuf8Rw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C4F22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ity1L-00082L-A0
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 13:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ity0A-0006nq-3G
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ity05-0008OZ-O9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ity05-0008OF-LG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579630301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sH0lnleTC7/AhfBTegIZXIlr7Ejsnf6UdbzYfLwyHlQ=;
 b=WWuf8Rw4MPPn/EEhjXF6L4BG/4bspU2sBEzBoDavbWwWadsLP8afGftCK4F2m1h07nnw1I
 9Yk5MYh4dxyupw6FEj68iStsXCSY75kSOVo1hpwzokZuyu1tFbLDpDV+JkYv9cnvGJNOX5
 4lgURgxTfFT0lBLnFyT1cXgBX/DQDnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-IOkU1rIOO7-mAGGM5bqK5A-1; Tue, 21 Jan 2020 13:11:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D7E3800D41;
 Tue, 21 Jan 2020 18:11:36 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC8460E1C;
 Tue, 21 Jan 2020 18:11:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] qmp: Optionally run handlers in coroutines
Date: Tue, 21 Jan 2020 19:11:18 +0100
Message-Id: <20200121181122.15941-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IOkU1rIOO7-mAGGM5bqK5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com
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

This is an alternative solution to Marc-Andr=C3=A9's "monitor: add
asynchronous command type" series.

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

Kevin Wolf (4):
  qapi: Add a 'coroutine' flag for commands
  vl: Initialise main loop earlier
  qmp: Move dispatcher to a coroutine
  block: Mark 'block_resize' as coroutine

 qapi/block-core.json                    |   3 +-
 docs/devel/qapi-code-gen.txt            |  10 +++
 include/qapi/qmp/dispatch.h             |   2 +
 monitor/monitor-internal.h              |   6 +-
 monitor/monitor.c                       |  33 +++++--
 monitor/qmp.c                           | 110 +++++++++++++++++-------
 qapi/qmp-dispatch.c                     |  44 +++++++++-
 qapi/qmp-registry.c                     |   3 +
 tests/test-qmp-cmds.c                   |   4 +
 util/aio-posix.c                        |   7 +-
 vl.c                                    |  10 +--
 scripts/qapi/commands.py                |  10 ++-
 scripts/qapi/doc.py                     |   2 +-
 scripts/qapi/expr.py                    |   7 +-
 scripts/qapi/introspect.py              |   2 +-
 scripts/qapi/schema.py                  |   9 +-
 tests/qapi-schema/test-qapi.py          |   7 +-
 tests/Makefile.include                  |   1 +
 tests/qapi-schema/oob-coroutine.err     |   2 +
 tests/qapi-schema/oob-coroutine.json    |   2 +
 tests/qapi-schema/oob-coroutine.out     |   0
 tests/qapi-schema/qapi-schema-test.json |   1 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 23 files changed, 216 insertions(+), 61 deletions(-)
 create mode 100644 tests/qapi-schema/oob-coroutine.err
 create mode 100644 tests/qapi-schema/oob-coroutine.json
 create mode 100644 tests/qapi-schema/oob-coroutine.out

--=20
2.20.1


