Received: from eggs.gnu.org ([2001:4830:134:3::10]:52317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpc-0007aI-Jp
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpa-0006kN-HX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJpa-0006kD-Bs
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0A6240FB658
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:44:49 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:23 +0800
Message-Id: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/15] qio: general non-default GMainContext
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is another preparation work for monitor OOB seires.

V1: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06972.html

V2 rewrote the bottom half of the code.  The first 8 patches are
mostly the same, but I rewrote the last patches to solve both TLS and
reconnect use cases by introducing a machine_done hook for chardevs in
general.  So if I copy the problems:

- migration
  - incoming side: still always running on main context, while we need
    to be able to run some command in OOB thread [1]
- tcp chardev (non-tcp chardevs should all support non-NULL context now)
  - server listening mode: QIO net listener used [2]
  - TELNET session: an isolated GSource used (tcp_chr_telnet_init) [3]
  - when "reconnect=N" is used, QIO threaded task is used [4]
  - TLS session: QIO tls handshake is used (tcp_chr_tls_init) [5]

Problem [1-3] are still fixed in the old way, but [4-5] now are fixed
by using the new machine_done notifier.

I'll still try to provide a changelog beside the big change mentioned:

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

Peter Xu (15):
  chardev: fix leak in tcp_chr_telnet_init_io()
  qio: rename qio_task_thread_result
  qio: introduce qio_channel_add_watch_{full|source}
  migration: let incoming side use thread context
  qio: refactor net listener source operations
  qio: store gsources for net listeners
  qio/chardev: update net listener gcontext
  chardev: allow telnet gsource to switch gcontext
  qio: non-default context for threaded qtask
  qio: non-default context for async conn
  qio: non-default context for TLS handshake
  chardev: introduce chr_machine_done hook
  char: use chardev's gcontext for async connect
  chardev: tcp: postpone async connection setup
  chardev: tcp: postpone TLS work until machine done

 chardev/char-mux.c             |  29 ++++++++++
 chardev/char-socket.c          | 124 ++++++++++++++++++++++++++++++++---------
 chardev/char.c                 |  43 ++++++--------
 include/chardev/char.h         |   2 +
 include/io/channel-socket.h    |   4 +-
 include/io/channel-tls.h       |  17 ++++++
 include/io/channel.h           |  44 +++++++++++++++
 include/io/net-listener.h      |  21 ++++++-
 include/io/task.h              |   6 +-
 io/channel-socket.c            |  12 ++--
 io/channel-tls.c               |  51 ++++++++++++-----
 io/channel.c                   |  40 +++++++++++--
 io/dns-resolver.c              |   3 +-
 io/net-listener.c              | 112 +++++++++++++++++++++----------------
 io/task.c                      |  22 +++++++-
 migration/exec.c               |   9 ++-
 migration/fd.c                 |   9 ++-
 migration/socket.c             |  13 +++--
 tests/test-io-channel-socket.c |   2 +-
 tests/test-io-task.c           |   2 +
 20 files changed, 415 insertions(+), 150 deletions(-)

-- 
2.14.3
