Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB16C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D7B207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIC52uLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D7B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhk4-000887-4N
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irhi1-0006Lv-N6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irhhx-0001yD-W6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:23:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irhhx-0001xL-T4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579091016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMyJ70LkasI1lY/vJNrd2tyB4+Yby4rEnFim3Ne2an8=;
 b=AIC52uLio821/Nzo4GLBU4xzfnZbs0e1TdFD1xfnZ5Goyz7psFNDyuLaha0V8GI/cUktlN
 0uK0Opa08i6XYt9M1UP/MKUUoly0x6k47SiqRuzhRxfC3gTF+5Gxnm1Tx6R7TlSCk9XxbJ
 QS8LoxWobHNipyvCu/FCJtpUs5xzr5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-PRZGXzEBN--MWA6fBqsovQ-1; Wed, 15 Jan 2020 07:23:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DA1618B5F76;
 Wed, 15 Jan 2020 12:23:34 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-87.ams2.redhat.com [10.36.117.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66DD95C1D6;
 Wed, 15 Jan 2020 12:23:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] qmp: Optionally run handlers in coroutines
Date: Wed, 15 Jan 2020 13:23:22 +0100
Message-Id: <20200115122326.26393-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: PRZGXzEBN--MWA6fBqsovQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

 qapi/block-core.json                    |  3 +-
 tests/qapi-schema/qapi-schema-test.json |  1 +
 docs/devel/qapi-code-gen.txt            |  4 ++
 include/qapi/qmp/dispatch.h             |  3 +
 monitor/monitor-internal.h              |  5 +-
 blockdev.c                              |  6 +-
 monitor/monitor.c                       | 24 ++++---
 monitor/qmp.c                           | 83 ++++++++++++++++---------
 qapi/qmp-dispatch.c                     | 38 ++++++++++-
 tests/test-qmp-cmds.c                   |  4 ++
 vl.c                                    | 10 +--
 scripts/qapi/commands.py                | 17 +++--
 scripts/qapi/doc.py                     |  2 +-
 scripts/qapi/expr.py                    |  4 +-
 scripts/qapi/introspect.py              |  2 +-
 scripts/qapi/schema.py                  |  9 ++-
 tests/qapi-schema/qapi-schema-test.out  |  2 +
 tests/qapi-schema/test-qapi.py          |  7 ++-
 18 files changed, 158 insertions(+), 66 deletions(-)

--=20
2.20.1


