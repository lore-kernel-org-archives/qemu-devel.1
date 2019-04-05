Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1665C282DA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EE12184B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EE12184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCSYU-0003DF-8Z
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 13:23:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSXg-0002oH-06
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSXe-0003s2-Sz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:22:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hCSWU-00031q-23; Fri, 05 Apr 2019 13:22:14 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hCS8Z-0008Mk-QH; Fri, 05 Apr 2019 19:56:20 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Apr 2019 19:56:16 +0300
Message-Id:
 <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 0/3] block/stream: get rid of the base
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
Message-ID: <20190405165616.7DsjDxBUJ0lPUzceOLzexboSVEQ54XWkG7flD1w9R-0@z>

This series introduces a bottom intermediate node that eliminates the
dependency on the base that may change while stream job is running.
It happens when stream/commit parallel jobs are running on the same
backing chain. The base node of the stream job may be a top node of
the parallel commit job and can change before the stream job is
completed. We avoid that dependency by introducing the bottom node.

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

Andrey Shinkevich (3):
  block: include base when checking image chain for block allocation
  block/stream: refactor stream_run: drop goto
  block/stream: introduce a bottom node

 block/io.c             | 33 ++++++++++++++++++++----
 block/stream.c         | 69 +++++++++++++++++++++++++-------------------------
 block/trace-events     |  2 +-
 include/block/block.h  |  4 +++
 tests/qemu-iotests/245 |  4 +--
 5 files changed, 69 insertions(+), 43 deletions(-)

-- 
1.8.3.1


