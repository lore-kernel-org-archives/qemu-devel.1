Received: from eggs.gnu.org ([2001:4830:134:3::10]:59753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gSLDm-0007ZU-Hd
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gSLDh-0003lR-EG
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:15:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gSLDh-0003l3-7l
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:15:01 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Nov 2018 20:14:45 +0800
Message-Id: <20181129121449.4322-1-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V2 for 3.1 0/4] Fix possible OOB during queuing
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, Jason Wang <jasowang@redhat.com>

Hi:

This series tries to fix a possible OOB during queueing packets
through qemu_net_queue_append_iov(). This could happen when it tries
to queue a packet whose size is larger than INT_MAX which may lead
integer overflow. We've fixed similar issue in the past during
qemu_net_queue_deliver_iov() by ignoring large packets there. Let's
just move the check earlier to qemu_sendv_packet_async() and reduce
the limitation to NET_BUFSIZE. A simple qtest were also added this.

Please review.

Thanks

Jason Wang (4):
  net: drop too large packet early
  virtio-net-test: remove unused macro
  virtio-net-test: accept variable length argument in pci_test_start()
  virtio-net-test: add large tx buffer test

 net/net.c               | 13 +++++----
 tests/virtio-net-test.c | 63 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 13 deletions(-)

-- 
2.17.1
