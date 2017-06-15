Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXmq-00011m-Fa
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXml-0001xa-Fe
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLXml-0001xD-9P
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Jun 2017 17:38:08 +0100
Message-Id: <20170615163813.7255-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] qemu-iotests: test savevm/loadvm iothread
 (and make it work!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

This series extends qemu-iotests 068 to also run with iothread enabled.  Doing
so was harder than expected because:

1. ioeventfd is disabled without -M accel=kvm even though it should work
2. loadvm still has an iothread bug

Instead of adding a ./check -iothread option I decided to always run the test.
Kevin recently recommended this approach; the advantage is that iothread *will*
always be tested iothread mode whereas people won't run ./check -iothread.

Stefan Hajnoczi (5):
  virtio-pci: use ioeventfd even when KVM is disabled
  migration: hold AioContext lock for loadvm qemu_fclose()
  qemu-iotests: 068: extract _qemu() function
  qemu-iotests: 068: use -drive/-device instead of -hda
  qemu-iotests: 068: test iothread mode

 hw/virtio/virtio-pci.c     |  2 +-
 migration/savevm.c         |  2 +-
 tests/qemu-iotests/068     | 37 +++++++++++++++++++++++++------------
 tests/qemu-iotests/068.out | 11 ++++++++++-
 4 files changed, 37 insertions(+), 15 deletions(-)

-- 
2.9.4
