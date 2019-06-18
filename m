Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB6CC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180A32070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180A32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCgq-0004ol-DC
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48446)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWb-00042a-Au
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWV-0000Mo-5w
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:58016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWU-0000Jh-Rk; Tue, 18 Jun 2019 07:43:35 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWO-00016b-LF; Tue, 18 Jun 2019 14:43:28 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 14:43:19 +0300
Message-Id: <20190618114328.55249-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 0/9] NBD reconnect
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!
Here is NBD reconnect. Previously, if connection failed all current
and future requests will fail. After the series, nbd-client driver
will try to reconnect unlimited times. During first @reconnect-delay
seconds of reconnecting all requests will wait for the connection,
and if it is established requests will be resent. After
@reconnect-delay period all requests will be failed (until successful
reconnect).

v7:
almost all: rebased on merged nbd.c and nbd-client.c (including patch subject)
01-04: add Eric's r-b
04: wording
05: new
06: rewrite to remove timer earlier
07: new
08:
 - rebase on 05 and 07
 - drop "All rights reserved"
 - handle drain
 - improve handling aio context attach
09: move 249 -> 257

Vladimir Sementsov-Ogievskiy (9):
  block/nbd: split connection_co start out of nbd_client_connect
  block/nbd: use non-blocking io channel for nbd negotiation
  block/nbd: move from quit to state
  block/nbd: add cmdline and qapi parameter reconnect-delay
  block/nbd: refactor nbd connection parameters
  qemu-coroutine-sleep: introduce qemu_co_sleep_wake
  qemu/units: add SI decimal units
  block/nbd: nbd reconnect
  iotests: test nbd reconnect

 qapi/block-core.json          |  11 +-
 include/block/nbd.h           |   3 +-
 include/qemu/coroutine.h      |  17 +-
 include/qemu/units.h          |   7 +
 block/nbd.c                   | 531 +++++++++++++++++++++++++---------
 block/null.c                  |   2 +-
 block/sheepdog.c              |   2 +-
 nbd/client.c                  |  16 +-
 qemu-nbd.c                    |   2 +-
 tests/test-bdrv-drain.c       |   6 +-
 tests/test-block-iothread.c   |   2 +-
 util/qemu-coroutine-sleep.c   |  47 ++-
 tests/qemu-iotests/257        |  63 ++++
 tests/qemu-iotests/257.out    |  10 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   4 +
 16 files changed, 551 insertions(+), 173 deletions(-)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out

-- 
2.18.0


