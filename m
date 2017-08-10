Received: from eggs.gnu.org ([2001:4830:134:3::10]:45692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpy7-00059e-7R
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpy6-0003Fo-1l
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:05:55 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 17:04:43 +0100
Message-Id: <20170810160451.32723-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 0/8] Enable full IPv4/IPv6 dual stack support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

Currently all the network listeners in QEMU, except the VNC server,
are restricted to listening on a single socket. This makes it
impossible to fully support IPv4/IPv6 dual stack. We're restricted
to using IPV6_V6ONLY=0 to listen on both protocols from a single
socket, but this doesn't work at all on OpenBSD, and even where
supported it is quite crude (only really works for localhost and
wildcard addresses).

This patch series introduces a new object QIONetListener, which
encapsulates multiple QIOChannelSocket listeners. This makes it
trivial to support multiple listening sockets in any part of
QEMU.

Daniel P. Berrange (8):
  tests: add functional test validating ipv4/ipv6 address flag handling
  io: introduce a network socket listener API
  blockdev: convert internal NBD server to QIONetListener
  blockdev: convert qemu-nbd server to QIONetListener
  migration: convert socket server to QIONetListener
  chardev: convert the socket server to QIONetListener
  ui: convert VNC server to QIONetListener
  sockets: fix parsing of ipv4/ipv6 opts in parse_socket_addr

 blockdev-nbd.c             |  50 +--
 chardev/char-socket.c      |  70 ++--
 include/io/net-listener.h  | 174 +++++++++
 io/Makefile.objs           |   1 +
 io/net-listener.c          | 315 ++++++++++++++++
 migration/socket.c         |  44 +--
 qemu-nbd.c                 |  50 +--
 tests/.gitignore           |   1 +
 tests/Makefile.include     |   3 +
 tests/test-sockets-proto.c | 906 +++++++++++++++++++++++++++++++++++++++++++++
 ui/vnc.c                   | 194 +++-------
 ui/vnc.h                   |   9 +-
 util/qemu-sockets.c        |  36 +-
 13 files changed, 1563 insertions(+), 290 deletions(-)
 create mode 100644 include/io/net-listener.h
 create mode 100644 io/net-listener.c
 create mode 100644 tests/test-sockets-proto.c

-- 
2.13.3
