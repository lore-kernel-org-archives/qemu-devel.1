Received: from eggs.gnu.org ([2001:4830:134:3::10]:33527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtx8-0007v7-Rq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtx7-0000cp-PA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:06:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtx7-0000cV-Je
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:06:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3852180125D6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:06:43 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:19 +0800
Message-Id: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 00/14] qio: general non-default GMainContext
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

This is another preparation work for monitor OOB seires.

This series tries to allow QIO code to run with non-default
GMainContext.  Note that for most places I kept the old code
untouched, and only modified/introduced new interfaces where there can
be a non-default GMainContext.  The "where" is mostly migration and
chardev submodules, since these two parts of code can be run with
monitor IOThread in the future (which holds a non-default
GMainContext).

These are existing known issue to be solved with GSources that bound
to main thread:

- migration
  - incoming side: still always running on main context, while we need
    to be able to run some command in OOB thread [1]
- tcp chardev (non-tcp chardevs should all support non-NULL context now)
  - server listening mode: QIO net listener used [2]
  - TELNET session: an isolated GSource used (tcp_chr_telnet_init) [3]
  - when "reconnect=N" is used, QIO threaded task is used [4]
  - TLS session: QIO tls handshake is used (tcp_chr_tls_init) [5]

Patch 1-2 are cleanups and fixes.

Patch 3 introduced qio_channel_add_watch_full(), which is the core API
for QIO to support non-default context.

Patch 4 fixes the migration usage of QIO, which is problem [1] above.

Patch 5-7 fixes the net listeners to use non-default gcontext, which
solves problem [2] above.

Patch 8 fixes the TELNET GSource, which solves problem [3].

Patch 9-13 fixes the threaded QIOTask usage, which is for problem [4].

Patch 14 fixes the last TLS usage, which is problem [5].

The whole series survives with "make check".  There are quite a few
QIO tests there.  Let's see whether this can be acceptable before more
tests.

Please review.  Thanks.

Peter Xu (14):
  chardev: fix leak in tcp_chr_telnet_init_io()
  qio: rename qio_task_thread_result
  qio: introduce qio_channel_add_watch_full()
  migration: let incoming side use thread context
  qio: refactor net listener source operations
  qio: store gsources for net listeners
  qio/chardev: update net listener gcontext
  chardev: allow telnet gsource to switch gcontext
  qio: basic non-default context support for thread
  qio: refcount QIOTask
  qio/chardev: return QIOTask when connect async
  qio: move QIOTaskThreadData into QIOTask
  qio: allow threaded qiotask to switch contexts
  qio/chardev: specify gcontext for TLS handshake

 chardev/char-socket.c       | 114 ++++++++++++++++++++++++++-------
 include/io/channel-socket.h |  14 +++--
 include/io/channel-tls.h    |  22 ++++++-
 include/io/channel.h        |  31 ++++++++-
 include/io/net-listener.h   |  33 +++++++++-
 include/io/task.h           |  10 ++-
 io/channel-socket.c         |  21 ++++---
 io/channel-tls.c            |  91 ++++++++++++++++++++++-----
 io/channel.c                |  24 +++++--
 io/dns-resolver.c           |   3 +-
 io/net-listener.c           | 119 +++++++++++++++++++++--------------
 io/task.c                   | 149 ++++++++++++++++++++++++++++++++++++--------
 migration/exec.c            |  11 ++--
 migration/fd.c              |  11 ++--
 migration/socket.c          |  12 ++--
 tests/test-io-task.c        |   2 +
 16 files changed, 514 insertions(+), 153 deletions(-)

-- 
2.14.3
