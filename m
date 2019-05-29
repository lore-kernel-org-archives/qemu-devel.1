Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8457CC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6812400B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6812400B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58669 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW2ps-0005bo-6D
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 13:58:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hW2oL-0004W0-5f
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hW2oK-00073b-76
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:56:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:48126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hW2oK-00072N-05; Wed, 29 May 2019 13:56:24 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hW2oD-0006Rz-EY; Wed, 29 May 2019 20:56:17 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 29 May 2019 20:56:13 +0300
Message-Id: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 0/3] block/stream: get rid of the base
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	berto@igalia.com, wencongyang2@huawei.com,
	xiechanglong.d@gmail.com, mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series introduces a bottom intermediate node that eliminates the
dependency on the base that may change while stream job is running.
It happens when stream/commit parallel jobs are running on the same
backing chain. The base node of the stream job may be a top node of
the parallel commit job and can change before the stream job is
completed. We avoid that dependency by introducing the bottom node.

v7: [resend by Andrey]
  01: assert(intermediate) was inserted before the call to
      bdrv_is_allocated() in the intermediate node loop of the
      bdrv_is_allocated_above() as suggested by Max.
  02: The change of the intermediate node loop in the stream_start() was
      rolled back to its original design and the reassignment of the base
      node pointer was added as Vladimir and Max suggested. The relevant
      comment was amended.

v6: [resend by Vladimir]
  01: improve comment in block/io.c, suggested by Alberto

v5: [resend by Vladimir]
  01: use comment wording in block/io.c suggested by Alberto

v4:
trace_stream_start reverted to the base.
bdrv_is_allocated_above_inclusive() deleted and the new parameter
'bool include_base' was added to the bdrv_is_allocated_above().

Andrey Shinkevich (3):
  block: include base when checking image chain for block allocation
  block/stream: refactor stream_run: drop goto
  block/stream: introduce a bottom node

 block/commit.c         |  2 +-
 block/io.c             | 21 +++++++++++++------
 block/mirror.c         |  2 +-
 block/replication.c    |  2 +-
 block/stream.c         | 56 ++++++++++++++++++++++++--------------------------
 include/block/block.h  |  3 ++-
 tests/qemu-iotests/245 |  4 ++--
 7 files changed, 49 insertions(+), 41 deletions(-)

-- 
1.8.3.1


