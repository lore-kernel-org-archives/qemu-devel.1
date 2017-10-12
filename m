Received: from eggs.gnu.org ([2001:4830:134:3::10]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBI-0001FW-5d
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBE-0000Gy-Vv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32768 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2aBE-0000DQ-Ka
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 12:53:06 +0300
Message-Id: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 00/13] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Minimally implement nbd structured read extension.

v3:

clone: tag up-nbd-minimal-structured-read-v3 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=up-nbd-minimal-structured-read-v3

03: rename  nbd_co_send_reply here too, remove r-b
04-07: splitted nbd server refactoring, with some changes
08: add Eric's r-b
13: rewrite receiving loops by Paolo's suggestion


v2:

01: improve assertion (Eric)
02: add Eric's r-b
06: define NBD_SREP_TYPE_OFFSET_HOLE and NBD_SREP_TYPE_ERROR_OFFSET
    here (Eric)
07: fix return value of nbd_request_simple_option
08-09: new patches
10: mostly rewritten

Vladimir Sementsov-Ogievskiy (13):
  block/nbd-client: assert qiov len once in nbd_co_request
  block/nbd-client: refactor nbd_co_receive_reply
  nbd: rename some simple-request related objects to be _simple_
  nbd/server: structurize simple reply header sending
  nbd/server: do not use NBDReply structure
  nbd/server: refactor nbd_co_send_simple_reply parameters
  nbd-server: simplify reply transmission
  nbd: header constants indenting
  nbd: Minimal structured read for server
  nbd/client: refactor nbd_receive_starttls
  nbd: share some nbd entities to be reused in block/nbd-client.c
  nbd/client: prepare nbd_receive_reply for structured reply
  nbd: Minimal structured read for client

 include/block/nbd.h                      | 132 +++++++++-
 nbd/nbd-internal.h                       |  56 ++---
 block/nbd-client.c                       | 401 ++++++++++++++++++++++++++++---
 nbd/client.c                             | 205 ++++++++++------
 nbd/server.c                             | 189 ++++++++++-----
 nbd/trace-events                         |  12 +-
 tests/qemu-iotests/nbd-fault-injector.py |   4 +-
 7 files changed, 784 insertions(+), 215 deletions(-)

-- 
2.11.1
