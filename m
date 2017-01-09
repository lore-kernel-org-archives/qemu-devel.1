Received: from eggs.gnu.org ([2001:4830:134:3::10]:34414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQc2h-0005j8-MO
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQc2d-0000gm-Gr
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:39:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cQc2d-0000gR-7m
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:39:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 495E131B304
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 15:39:23 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon,  9 Jan 2017 15:39:06 +0000
Message-Id: <20170109153914.27424-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/8] io: enable DNS resolving separately of
 socket create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is a followup of:

 v1: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00574.html

Currently DNS resolution of SocketAddress structs is done as
part of the socket connect/listen process. This is very
inflexible as it assumes that a single SocketAddress struct
will only ever require a single socket to be opened. While
true for connect(), it is not the case for listen() in two
scenarios

 - A name may resolve to both an IPv4 and IPv6 address. Currently
   we workaround that by clearing the IPV6_V6ONLY flag.

 - A name may resolve to multiple IP addresses of the same
   protocol. eg "myhostname" may return "192.168.122.1" and "10.0.0.2"
   when the host has multiple NICs, or multiple addresses per NIC.

The only way to deal with the latter problem is to open multiple
sockets and that requires the ability to separate DNS resolution
from socket creation.

This series thus enhances the I/O framework in QEMU to introduce
the "QIODNSResolver" concept. This (singleton) object allows the
caller to feed in a single SocketAddress struct, perform DNS
resolution, and get back out one or more new SocketAddress structs
for the results. The API allows both synchronous and asynchrounous
DNS lookups, the latter done by spawning a thread to do the
getaddrinfo call via the QIOTask framework.

In this series the InetSocketAddress struct gains a new field to
let the caller indicate that the address is providing a numeric
host value, thus skipping DNS altogether.

The QIOTask object had some refactoring to allow results to be
associated with it explicitly, so that the asynchronous DNS
results can be passed around. This triggered the code churn
across other files in QEMU using QIOTask.

This series will be utilized by a second series that will be
sent that updates the VNC server code to use this new feature.

Changed in v2:

 - Fix qapi schema version annotation (Eric)
 - Fix qapi schema optional status for "numeric" (Eric)
 - Use bool instead of gboolean (Eric)
 - Document that qio_task_set_error() accepts NULL (Eric)
 - Make qio_task_set_error() calls unconditional (Eric)
 - Fix leak of SocketAddress results (Eric)
 - Other misc typos (Eric)

Daniel P. Berrange (8):
  sockets: add ability to disable DNS resolution for InetSocketAddress
  io: stop incrementing reference in qio_task_get_source
  io: fix typo in docs for QIOTask
  io: add ability to associate an opaque "result" with with a task
  io: add ability to associate an error with a task
  io: change the QIOTask callback signature
  io: remove Error parameter from QIOTask thread worker
  io: introduce a DNS resolver API

 include/io/dns-resolver.h      | 228 +++++++++++++++++++++++++++++++++++
 include/io/task.h              | 154 +++++++++++++++++-------
 include/qemu/sockets.h         |   2 +
 io/Makefile.objs               |   1 +
 io/channel-socket.c            |  44 +++----
 io/channel-tls.c               |  16 +--
 io/channel-websock.c           |   8 +-
 io/dns-resolver.c              | 267 +++++++++++++++++++++++++++++++++++++++++
 io/task.c                      |  62 +++++++---
 io/trace-events                |   1 -
 migration/socket.c             |  11 +-
 migration/tls.c                |  19 +--
 nbd/common.c                   |   8 +-
 nbd/nbd-internal.h             |   3 +-
 qapi-schema.json               |   5 +
 qemu-char.c                    |  18 +--
 tests/test-io-channel-socket.c |   5 +-
 tests/test-io-channel-tls.c    |   5 +-
 tests/test-io-task.c           |  31 ++---
 ui/vnc-auth-vencrypt.c         |   7 +-
 ui/vnc-ws.c                    |  14 ++-
 util/qemu-sockets.c            |   7 +-
 22 files changed, 747 insertions(+), 169 deletions(-)
 create mode 100644 include/io/dns-resolver.h
 create mode 100644 io/dns-resolver.c

-- 
2.9.3
