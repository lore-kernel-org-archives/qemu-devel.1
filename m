Received: from eggs.gnu.org ([2001:4830:134:3::10]:60752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dOLtG-00074Q-VS
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dOLtD-0001hb-S0
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:32:38 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:49419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dOLtD-0001Qm-J1
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:32:35 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Fri, 23 Jun 2017 12:31:04 +0200
Message-Id: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v4 0/4] Unit test+fix for problem with QEMU
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
  sockets: factor out create_fast_reuse_socket
  sockets: factor out a new try_bind() function
  sockets: Handle race condition between binds to the same port

 tests/Makefile.include |   2 +-
 tests/test-listen.c    | 253 ++++++++++++++++++++++++++++++++++++++++++-
 util/qemu-sockets.c    | 159 +++++++++++++++++---------
 3 files changed, 362 insertions(+), 52 deletions(-)
 create mode 100644 tests/test-listen.c

base-commit: 7ad9af343c7f1c70c8015c7c519c312d8c5f9fa1
-- 
git-series 0.9.1
