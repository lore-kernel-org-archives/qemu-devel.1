Received: from eggs.gnu.org ([2001:4830:134:3::10]:34844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgD-0002DZ-KZ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIg5-0003rK-IE
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gNIg5-0003pz-B3
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id y139so1666740wmc.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:31:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 15:31:14 +0100
Message-Id: <20181115143124.19234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.2 00/10] vhost: preparation for qgraph
 conversion of vhost-user-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The vhost-user-test is one of the most complex qtests in the tree,
and converting it to qgraph poses some unique challenges.  This series
addresses them in a way that does not depend on the qgraph conversion
itself, but prepares for it.

First of all, vhost-user-test is slow and that is a pain when debugging
it. :) So patches 1 and 2 fix this bug.

Second, qgraph will be able to test vhost-user-test on pSeries and ARM
virt (with virtio-mmio) machine types.  Patches 3 and 4 prepares for this
by compiling vhost-net even on TCG-only targets, and by supporting
wrong-endianness vnet headers.  Patches 5 and 6 instead make the test
more robust, so that it can run on those machines too.

Third, vhost-user-test is a bit strange in that it has more global state
than other tests (in particular a GMainLoop, but also a directory in /tmp
and some weird uses of global_qtest).  Patches 7 to 10 thus remove this
global state already, which simplifies the code and also will reduce
the diff for the qgraph conversion.

Please review and ack!  Thanks,

Paolo

Paolo Bonzini (10):
  vhost-user-test: use g_cond_broadcast
  vhost-user-test: signal data_cond when s->rings changes
  vhost-net: compile it for all targets
  vhost-user: support cross-endian vnet headers
  vhost-user-test: support VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
  vhost-user-test: skip if there is no memory at address 0
  vhost-user-test: reduce usage of global_qtest
  vhost-user-test: create a main loop per TestServer
  vhost-user-test: small changes to init_hugepagefs
  vhost-user-test: create a temporary directory per TestServer

 configure               |  13 +--
 include/exec/poison.h   |   1 -
 net/net.c               |   2 +-
 net/vhost-user.c        |  13 +++
 tests/Makefile.include  |   5 +-
 tests/vhost-user-test.c | 234 ++++++++++++++++++++++------------------
 6 files changed, 147 insertions(+), 121 deletions(-)

-- 
2.19.1
