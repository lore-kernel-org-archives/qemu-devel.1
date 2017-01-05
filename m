Received: from eggs.gnu.org ([2001:4830:134:3::10]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAVr-00065P-Ax
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAVn-0000IP-6J
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPAVm-0000Hz-Tw
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:31 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4388F3F21F
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:03:30 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  5 Jan 2017 16:03:13 +0000
Message-Id: <20170105160321.21786-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 0/8] io: enable DNS resolving separately of
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

Daniel P. Berrange (8):
  sockets: add ability to disable DNS resolution for InetSocketAddress
  io: stop incrementing reference in qio_task_get_source
  io: fix typo in docs for QIOTask
  io: add ability to associate an opaque "result" with with a task
  io: add ability to associate an error with a task
  io: change the QIOTask callback signature
  io: remove Error parameter from QIOTask thread worker
  io: introduce a DNS resolver API

 include/io/dns-resolver.h      | 224 ++++++++++++++++++++++++++++++++++
 include/io/task.h              | 151 ++++++++++++++++-------
 include/qemu/sockets.h         |   2 +
 io/Makefile.objs               |   1 +
 io/channel-socket.c            |  50 ++++----
 io/channel-tls.c               |  16 +--
 io/channel-websock.c           |   8 +-
 io/dns-resolver.c              | 265 +++++++++++++++++++++++++++++++++++++++++
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
 22 files changed, 745 insertions(+), 168 deletions(-)
 create mode 100644 include/io/dns-resolver.h
 create mode 100644 io/dns-resolver.c

-- 
2.9.3
