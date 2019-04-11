Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB1C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4772084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4772084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdVc-0005mk-9m
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:29:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTn-0004ZI-4x
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bs-QB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:59348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTl-0003Zw-D4; Thu, 11 Apr 2019 13:27:13 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTi-00044D-2w; Thu, 11 Apr 2019 20:27:10 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 11 Apr 2019 20:27:02 +0300
Message-Id: <20190411172709.205032-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 0/7] NBD reconnect
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411172702.Vrx7E581PA01woklIdvRVXclj9CzkVacBCVLUMh83mI@z>

Here is NBD reconnect. Previously, if connection failed all current
and future requests will fail. After the series, nbd-client driver
will try to reconnect unlimited times. During first @reconnect-delay
seconds of reconnecting all requests will wait for the connection,
and if it is established requests will be resent. After
@reconnect-delay period all requests will be failed (until successful
reconnect).

v4->v6:
 (some preparing patches from v4 was merged as v5)
01: new
02: new
03: - drop unused things
       - future states
       - future s/break/continue/
04: - fix typos
    - s/3.1/4.1/
    - set 0 as default
05: new
06: - new states and s/break/continue/ moved here from 03
    - drop NBDClientSession.receiving, as now in_flight
      requests used instread
    - add copyright
    - go to NBD_CLIENT_CONNECTING_NOWAIT immediately if
      reconnect_delay is 0 (so, reconnect_delay moved to
      NBDClientSession)
    - on close, do qemu_co_sleep_wake(client->connection_co),
      to not wait for reconnect loop iteration
    - handle state transition to QUIT during reconnect loop
      (assert(nbd_client_connecting(s)) was bad idea)
    - don't try to fail on protocol errors after
      nbd_client_connect, as we can't distinguish them
    - decrement in_flight around reconnect sleep to make
      it possible to drain and exit during it
      (v4 was based on something before in_flight logic
       introduced into nbd-client)
    - changed logic in nbd_client_attach_aio_context 
07: - refactor, using log and qmp_log
    - drop export name
    - drop strange try/except
    - add reconnect-delay option (as 0 is a default now)


Vladimir Sementsov-Ogievskiy (7):
  block/nbd-client: split connection_co start out of nbd_client_connect
  block/nbd-client: use non-blocking io channel for nbd negotiation
  block/nbd-client: move from quit to state
  block/nbd: add cmdline and qapi parameter reconnect-delay
  qemu-coroutine-sleep: introduce qemu_co_sleep_wake
  block/nbd-client: nbd reconnect
  iotests: test nbd reconnect

 qapi/block-core.json          |  12 +-
 block/nbd-client.h            |  15 +-
 include/block/nbd.h           |   3 +-
 include/qemu/coroutine.h      |   6 +
 block/nbd-client.c            | 416 +++++++++++++++++++++++++---------
 block/nbd.c                   |  16 +-
 nbd/client.c                  |  16 +-
 qemu-nbd.c                    |   2 +-
 util/qemu-coroutine-sleep.c   |  20 +-
 tests/qemu-iotests/249        |  63 +++++
 tests/qemu-iotests/249.out    |  10 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   4 +
 13 files changed, 468 insertions(+), 116 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

-- 
2.18.0


