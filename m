Received: from eggs.gnu.org ([2001:4830:134:3::10]:54314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005QK-3n
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000PT-6i
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:30429 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000NE-Mk
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:33 +0300
Message-Id: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 00/19] nbd errors and traces refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is based on my "nbd: error path refactoring" series.

These series bring errp instead of LOG to the server too, making
some related refactorings.

nbd_negotiate_read and friends a dropped as was discussed in
"nbd: error path refactoring" thread.

finally - refactor traces to modern way too, to get rid of LOG()
macro at all.

Patches subgroup 01-x, where x <= 10 may be pushed as separate series,
as they are general enough.

11-14 needed to not create error-output on non-error disconnects in 15
16 is good addition for 15
17 is addition for 15 and in the same time prerequisite for 19

patches 18-19 may be pushed separately (but of course after 01-17 and
19 after 18)

Vladimir Sementsov-Ogievskiy (19):
  nbd/server: get rid of nbd_negotiate_read and friends
  nbd/server: get rid of ssize_t
  nbd/server: refactor nbd_co_send_reply
  nbd/server: get rid of EAGAIN dead code
  nbd/server: refactor nbd_co_receive_request
  nbd/server: remove NBDClientNewData
  nbd/server: nbd_negotiate: fix error path
  nbd/server: get rid of fail: return rc
  nbd/server: rename rc to ret
  nbd/server: refactor nbd_trip
  io/channel-socket: qio_channel_socket_writev handle EPIPE
  nbd/common: nbd_wr_syncv handle QIO_CHANNEL_ERR_EPIPE
  nbd/server: return original error codes
  nbd/server: nbd_negotiate: return 1 on NBD_OPT_ABORT
  nbd/server: use errp instead of LOG
  nbd/server: add errp to nbd_send_reply()
  nbd/common: nbd_tls_handshake: use error_reportf_err instead of TRACE
  nbd/client: refactor TRACE of NBD_MAGIC
  nbd: use generic trace subsystem instead of TRACE macro

 Makefile.objs        |   1 +
 include/io/channel.h |   1 +
 io/channel-socket.c  |   2 +-
 nbd/client.c         | 127 ++++------
 nbd/common.c         |  30 ++-
 nbd/nbd-internal.h   |  21 +-
 nbd/server.c         | 670 ++++++++++++++++++++++++---------------------------
 nbd/trace-events     |  67 ++++++
 8 files changed, 471 insertions(+), 448 deletions(-)
 create mode 100644 nbd/trace-events

-- 
2.11.1
