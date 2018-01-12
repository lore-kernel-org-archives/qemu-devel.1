Received: from eggs.gnu.org ([2001:4830:134:3::10]:43510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0mO-00088a-AR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0mK-0001Ap-De
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:58:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ea0mK-00019i-7T
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:57:56 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 12 Jan 2018 15:56:54 +0100
Message-Id: <20180112145658.17121-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] vhost-user: notify backend with number of
 queues setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

This series introduces a new vhost-user protocol request for QEMU
to notify the backend with the number of queues setup by the
guest driver.

When the user backend cannot add queues dynamically (i.e. once the
port is running), it waits for all queues to be initialized.

Problem is that QEMU sends messages for all queues declared in
command line, even the ones no setup by the guest driver.
Without fix from Zheng Xiang [0] that doesn't start queues that
haven't been setup by the guest, it ends up corrupting memory
around GPA 0 as SET_VRING_ADDR is sent with uninitialized ring
addresses.
With the fix, the DPDK backend would be stuck forever, waiting
for unused queues to be setup, which won't happen.

Note that these problems are met neither with virtio-net Linux
driver, nor DPDK's Virtio PMD, because these drivers always setup
all queues provided by QEMU, even if they doesn't use all of them.

However, the problem can be reproduced with Windows guest, when
QEMU declares more queue pairs than vcpus. In this case, the
Windows virtio-net driver only setup as much queue pairs as vcpus.

[0]: https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02484.html

Maxime Coquelin (4):
  vhost-user: fix multiple queue specification
  vhost-user: specify and implement VHOST_USER_SET_QUEUE_NUM request
  vhost-net: add vhost_net_set_queue_num helper
  virtio-net: notify backend with number of queue pairs setup

 docs/interop/vhost-user.txt       | 22 +++++++++++++++++++---
 hw/net/vhost_net.c                | 17 +++++++++++++++++
 hw/net/virtio-net.c               |  5 +++++
 hw/virtio/vhost-user.c            | 24 ++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  3 +++
 include/net/vhost_net.h           |  1 +
 6 files changed, 69 insertions(+), 3 deletions(-)

-- 
2.14.3
