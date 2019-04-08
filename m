Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27360C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB9120857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB9120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDYwU-0004QE-Ir
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:24:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYud-0003Gn-WE
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYub-0003wO-BE
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:22:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:53846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDYuZ-0003tK-Hb; Mon, 08 Apr 2019 14:22:29 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDYuT-0002Da-RQ; Mon, 08 Apr 2019 21:22:22 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 21:22:18 +0300
Message-Id:
 <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 0/3] block/stream: get rid of the base
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	berto@igalia.com, mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408182218.3omaYbGYJKVESHZxPgwKJkIOXC2ZVhU5bpR_ESAOPJg@z>

This series introduces a bottom intermediate node that eliminates the
dependency on the base that may change while stream job is running.
It happens when stream/commit parallel jobs are running on the same
backing chain. The base node of the stream job may be a top node of
the parallel commit job and can change before the stream job is
completed. We avoid that dependency by introducing the bottom node.

v4:
trace_stream_start reverted to the base.
bdrv_is_allocated_above_inclusive() deleted and the new parameter
'bool include_base' was added to the bdrv_is_allocated_above().

v3:
bottom = bdrv_find_overlay() moved into the stream_start()

v2:
The function bdrv_find_overlay() with the same functionality has been
used in the qmp_block_stream() to find a bottom node.
The algorithm in the bdrv_do_is_allocated_above() was simplified.
The commit messages were modified.

Discussed in the e-mail threads with the message IDs
<1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
<1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
<1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
<1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (2):
  block: include base when checking image chain for block allocation
  block/stream: introduce a bottom node

Vladimir Sementsov-Ogievskiy (1):
  block/stream: refactor stream_run: drop goto

 block/commit.c         |  2 +-
 block/io.c             | 14 +++++++++---
 block/mirror.c         |  2 +-
 block/replication.c    |  2 +-
 block/stream.c         | 62 +++++++++++++++++++++++---------------------------
 include/block/block.h  |  3 ++-
 tests/qemu-iotests/245 |  4 ++--
 7 files changed, 47 insertions(+), 42 deletions(-)

-- 
1.8.3.1


