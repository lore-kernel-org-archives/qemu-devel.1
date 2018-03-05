Received: from eggs.gnu.org ([2001:4830:134:3::10]:45497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqZ-0002jd-2B
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqU-0005oP-BO
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjqU-0005nW-5u
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6CE0404084B
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:43:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:43:18 +0800
Message-Id: <20180305064324.9238-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] qio: general non-default GMainContext
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

V1: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06972.html
V2: http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00016.html

>From this version, I'll split the old series into two: one QIO series
and one CHARDEV series.  This is the QIO part.

Hopefully I have addressed every comments in v2.  Please shoot if I
missed any of them.  Thanks,

v3:
- add r-bs
- move the migration patch out of the series [Dan]
- in comments, mention "%NULL" case for contexts [Paolo]
- do similar thing to listen_async and dgram_async to allow context
  parameter [Dan]
- cache TCPChardevTelnetInit properly in telnet patch, and fixes
  around that new change in the patch [Paolo]
- drop patch 5 [Dan]
- drop the helper tcp_chr_net_listener_setup() [Dan]

v2:
- collect r-bs
- qio_channel_add_watch_full() should still return the same thing as
  the old one, and introduced qio_channel_add_watch_full() to return a
  GSource pointer. [Dan]
- Fix commit message on RDMA. It's using QIO, but still, I am not
  touching it.  [Dan]
- use qio_net_listener_set_client_func_full() directly, and avoid
  introducing new API. [Dan]

Please review.  Thanks.

Peter Xu (6):
  qio: rename qio_task_thread_result
  qio: introduce qio_channel_add_watch_{full|source}
  qio: store gsources for net listeners
  qio: non-default context for threaded qtask
  qio: non-default context for async conn
  qio: non-default context for TLS handshake

 chardev/char-socket.c          |  5 ++--
 include/io/channel-socket.h    | 15 ++++++++---
 include/io/channel-tls.h       |  5 +++-
 include/io/channel.h           | 44 ++++++++++++++++++++++++++++++++
 include/io/net-listener.h      | 22 ++++++++++++++--
 include/io/task.h              |  7 +++--
 io/channel-socket.c            | 18 ++++++++-----
 io/channel-tls.c               | 45 ++++++++++++++++++++++++--------
 io/channel.c                   | 40 ++++++++++++++++++++++++-----
 io/dns-resolver.c              |  3 ++-
 io/net-listener.c              | 58 ++++++++++++++++++++++++++----------------
 io/task.c                      | 22 +++++++++++++---
 migration/socket.c             |  3 ++-
 migration/tls.c                |  2 ++
 nbd/client.c                   |  1 +
 nbd/server.c                   |  1 +
 tests/test-io-channel-socket.c |  4 +--
 tests/test-io-channel-tls.c    |  2 ++
 tests/test-io-task.c           |  2 ++
 ui/vnc-auth-vencrypt.c         |  1 +
 ui/vnc-ws.c                    |  1 +
 21 files changed, 239 insertions(+), 62 deletions(-)

-- 
2.14.3
