Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D5C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F982176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYaNQEgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F982176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j450H-0008Fl-7A
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j44zR-0006b0-I4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j44zQ-0001cZ-9l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j44zQ-0001c3-5W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582040447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V24lLa7UJYUcEBSqO5TToODE9BJIW3+b/OXUyWi1XNo=;
 b=dYaNQEgyk0r1E2J3ryF799CSPj7fvR7PeIn354vPTq42/ry205qUux3tBkpUAKyMQEu9ML
 6RGTm7SYfDihfXHTsILw+/xpcTXwY7dpcgB/OL3lBBxr7KJfxKrG91CuU0llg0AXiMkjcb
 lLpUFZoJlwVa+4CMjR8a3jVgyUU0CXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-pJ__IpvWPN6q74qzxkX31Q-1; Tue, 18 Feb 2020 10:40:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9ECC18B6401;
 Tue, 18 Feb 2020 15:40:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E16D5C13B;
 Tue, 18 Feb 2020 15:40:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/4] qmp: Optionally run handlers in coroutines
Date: Tue, 18 Feb 2020 16:40:32 +0100
Message-Id: <20200218154036.28562-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: pJ__IpvWPN6q74qzxkX31Q-1
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org
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


Kevin Wolf (4):
  qapi: Add a 'coroutine' flag for commands
  vl: Initialise main loop earlier
  qmp: Move dispatcher to a coroutine
  block: Mark 'block_resize' as coroutine

 qapi/block-core.json                    |   3 +-
 docs/devel/qapi-code-gen.txt            |  11 +++
 include/qapi/qmp/dispatch.h             |   2 +
 monitor/monitor-internal.h              |   6 +-
 monitor/monitor.c                       |  55 +++++++++--
 monitor/qmp.c                           | 122 ++++++++++++++++++------
 qapi/qmp-dispatch.c                     |  44 ++++++++-
 qapi/qmp-registry.c                     |   3 +
 tests/test-qmp-cmds.c                   |   4 +
 util/aio-posix.c                        |   7 +-
 vl.c                                    |  10 +-
 scripts/qapi/commands.py                |  10 +-
 scripts/qapi/doc.py                     |   2 +-
 scripts/qapi/expr.py                    |  10 +-
 scripts/qapi/introspect.py              |   2 +-
 scripts/qapi/schema.py                  |   9 +-
 tests/qapi-schema/test-qapi.py          |   7 +-
 tests/Makefile.include                  |   1 +
 tests/qapi-schema/oob-coroutine.err     |   2 +
 tests/qapi-schema/oob-coroutine.json    |   2 +
 tests/qapi-schema/oob-coroutine.out     |   0
 tests/qapi-schema/qapi-schema-test.json |   1 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 23 files changed, 254 insertions(+), 61 deletions(-)
 create mode 100644 tests/qapi-schema/oob-coroutine.err
 create mode 100644 tests/qapi-schema/oob-coroutine.json
 create mode 100644 tests/qapi-schema/oob-coroutine.out

--=20
2.20.1


