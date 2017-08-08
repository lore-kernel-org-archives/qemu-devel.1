Received: from eggs.gnu.org ([2001:4830:134:3::10]:35583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBPt-0006QE-9J
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBPs-0006b8-8H
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:47:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dfBPs-0006aB-1p
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:47:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B0764A700
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:13 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Tue,  8 Aug 2017 22:38:55 +0200
Message-Id: <20170808203900.7661-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] tests/pxe-test: add testcase using
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

This implements a testcase for pxe-test using the vhost-user interface. Spawn a
vhost-user-bridge process and connect it to the qemu process.

To make the testcase work we need to apply a few patches before the actual testcase:
- Patch 1 disables debug output of vhost-user-bridge
- Patch 2 fixes passing a file descriptor to -netdev.  This was broken since the
  mcast option was introduced. 
- Patch 3 makes sure we stop processing vhost-user messages when recvmsg returns 0.
- Patch 4 makes qtest abort handlers always work

changes v1->v2:

- new patch 4/5. Necessary to make qtest_add_abrt_handler work. 
- get rid of hugepagefs specific code (mst)
- use htonl and INADDR_LOOPBACK to set remote address (Stefan Hajnoczi)
- add qtest abort handler (Stefan Hajnoczi)
- spawn vhost-user-bridge process with flag DO_NOT_REAP_CHILD and add a child
  watch function (Stefan Hajnoczi)
  Killing the vubr process manually at the end of the test and watching
  its termination with the child watch function. 
- clean up pxe-test-disk images 
- add Jason Wang to Cc

regards,
Jens

Jens Freimann (5):
  tests/vhost-user-bridge: disable debug output by default
  net: fix -netdev socket,fd= for UDP sockets
  libvhost-user: quit when no more data received
  libqtest: always set up signal handler for SIGABRT 
  tests/pxe-test: add testcase using vhost-user-bridge

 contrib/libvhost-user/libvhost-user.c |   4 +-
 net/socket.c                          |  37 ++++++-----
 tests/Makefile.include                |   4 +-
 tests/libqtest.c                      |   2 +-
 tests/pxe-test.c                      | 115 +++++++++++++++++++++++++++++++++-
 tests/vhost-user-bridge.c             |   2 +-
 6 files changed, 140 insertions(+), 24 deletions(-)

-- 
2.13.3
