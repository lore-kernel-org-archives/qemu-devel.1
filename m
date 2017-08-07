Received: from eggs.gnu.org ([2001:4830:134:3::10]:57409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defkT-0008F6-Id
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defkQ-0005Ry-3B
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:59:01 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1defkP-0005Rk-Pa
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:58:58 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Mon,  7 Aug 2017 12:58:38 +0200
Message-Id: <cover.9aca98788e1a99635ffb85ab9c01cb0497d2b3d8.1502103332.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v7 0/4] Unit test+fix for problem with QEMU
 handling of multiple bind()s to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Knut Omang <knut.omang@oracle.com>

This series contains:
* a unit test that exposes a race condition which causes QEMU to fail
  to find a port even when there is plenty of available ports.
* a refactor of the qemu-sockets inet_listen_saddr() function
  to better handle this situation.

Changes from v6:
* Changed license of the (new) test-listen.c source file from
  GNU v2 to GNU v2 and later, according to QEMU standards.

Changes from v5:
* Also move setting of error from socket creation out
  into the main double for loop.
* Simplify and enhance reporting if socket creation fails:
  Only report failure to create sockets if none of the
  provided addrinfo list elements allows creation of a
  socket, otherwise report failure to find an available port.
* Further simplify if's within the for loops and make sure
  failure to recreate a socket gets distinctively reported.
* Rebased to current master.

Changes from v4:
* Move the complexity of recreating a socket and setting the error pointer
  into the main for loop, eliminating the try_bind_listen() function
  again. Cleaning up and improving error handling in the process.

Changes from v3:
* Test changes: Add missing license
  Add subtests for ipv4, ipv6 and both
  Various g_* usage improvements
* Split patch into 3 patches with two refactoring patches ahead
  of the actual fix.

Changes from v2:
* Non-trivial rebase + further abstraction
  on top of 7ad9af343c7f1c70c8015c7c519c312d8c5f9fa1
  'tests: add functional test validating ipv4/ipv6 address flag handling'

Changes from v1:
* Fix potential uninitialized variable only detected by optimize.
* Improve unexpected error detection in test-listen to give more
  details about why the test fails unexpectedly.
* Fix some line length style issues.

Thanks,
Knut

Knut Omang (4):
  tests: Add test-listen - a stress test for QEMU socket listen
  sockets: factor out a new try_bind() function
  sockets: factor out create_fast_reuse_socket
  sockets: Handle race condition between binds to the same port

 tests/Makefile.include |   2 +-
 tests/test-listen.c    | 253 ++++++++++++++++++++++++++++++++++++++++++-
 util/qemu-sockets.c    | 138 +++++++++++++++--------
 3 files changed, 345 insertions(+), 48 deletions(-)
 create mode 100644 tests/test-listen.c

base-commit: a588c4985eff363154d65aee8607d0a4601655f7
-- 
git-series 0.9.1
