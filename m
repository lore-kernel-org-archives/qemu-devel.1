Received: from eggs.gnu.org ([2001:4830:134:3::10]:36827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVP-0003CB-3G
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVO-0005fA-7J
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 26 Apr 2017 09:36:35 +0200
Message-Id: <1493192202-3184-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] sockets: Flatten SocketAddress except in
 external interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com, qemu-block@nongnu.org

SocketAddress is a simple union, and simple unions are awkward: they
have their variant members wrapped in a "data" object on the wire, and
require additional indirections in C.  Flatten it as follows: rename
SocketAddress to SocketAddressLegacy, rename its flat sibling
SocketAddressFlat to SocketAddress, convert all users of
SocketAddressLegacy to SocketAddress, except for existing external
interfaces.  This completes the work outlined in commit 9445673.

Markus Armbruster (7):
  sockets: Prepare vsock_parse() for flattened SocketAddress
  sockets: Prepare inet_parse() for flattened SocketAddress
  qapi: New QAPI_CLONE_MEMBERS()
  sockets: Rename SocketAddress to SocketAddressLegacy
  sockets: Rename SocketAddressFlat to SocketAddress
  sockets: Limit SocketAddressLegacy except to external interfaces
  socket: Delete unused helper socket_address_crumple()

 block/gluster.c                |  48 +++++------
 block/nbd.c                    |  36 ++++-----
 block/sheepdog.c               |  20 ++---
 blockdev-nbd.c                 |  21 +++--
 chardev/char-socket.c          |  42 +++++-----
 chardev/char-udp.c             |  20 +++--
 hmp.c                          |   3 +-
 include/block/nbd.h            |   3 +
 include/io/channel-socket.h    |   4 +-
 include/qapi/clone-visitor.h   |  14 ++++
 include/qemu/sockets.h         |  18 ++---
 io/dns-resolver.c              |  17 ++--
 migration/rdma.c               |   4 +-
 migration/socket.c             |  20 +++--
 qapi-schema.json               |  36 +++++----
 qapi/block-core.json           |   6 +-
 qapi/block.json                |   2 +-
 qapi/qapi-clone-visitor.c      |  13 +++
 qemu-nbd.c                     |   9 +--
 qga/main.c                     |   4 +-
 tests/test-io-channel-socket.c |  52 +++++-------
 ui/vnc-auth-sasl.c             |   5 +-
 ui/vnc.c                       |  68 ++++++++--------
 util/qemu-sockets.c            | 177 +++++++++++++++++++----------------------
 24 files changed, 328 insertions(+), 314 deletions(-)

-- 
2.7.4
