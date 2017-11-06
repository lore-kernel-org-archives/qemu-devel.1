Received: from eggs.gnu.org ([2001:4830:134:3::10]:38513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc5q-0004FM-0g
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc5l-0004oU-5G
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:45:14 -0500
Received: from [45.249.212.32] (port=42641 helo=huawei.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc5k-0004o3-Qw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:45:09 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:52 +0800
Message-ID: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 00/10] virtio-crypto: add multiplexing mode
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

*NOTE*
The code realization is based on the latest virtio crypto spec:
 [PATCH v21 0/2] virtio-crypto: virtio crypto device specification

In session mode, the process of create/close a session
makes we have a least one full round-trip cost from guest to host to guest
to be able to send any data for symmetric algorithms. It gets ourself into
synchronization troubles in some scenarios like a web server handling lots
of small requests whose algorithms and keys are different.

We can support one-blob request (no sessions) as well for symmetric
algorithms, including HASH, MAC services. The benefit is obvious for
HASH service because it's usually a one-blob operation.

---
Gonglei (2):
  cryptodev: extract one util function
  virtio-crypto: add host feature bits support

Longpeng(Mike) (8):
  virtio-crypto: remove virtio_crypto_op_ctrl_req structure
  virtio-crypto: add session creation logic for mux mode
  virtio-crypto: remove queue_id field in ctrl header
  virtio-crypto: remove virtio_crypto_op_data_req structure
  virtio-crypto: add dataq operation logic for mux mode
  cryptodev: add stateless mode cipher support
  virtio-crypto: add stateless crypto request handler
  cryptodev-builtin: add stateless cipher support

 backends/cryptodev-builtin.c                   | 189 +++++++++---
 backends/cryptodev.c                           |  21 ++
 hw/virtio/virtio-crypto.c                      | 403 +++++++++++++++++++++++--
 include/hw/virtio/virtio-crypto.h              |   2 +
 include/standard-headers/linux/virtio_crypto.h | 199 ++++++++++--
 include/sysemu/cryptodev.h                     |  21 ++
 6 files changed, 735 insertions(+), 100 deletions(-)

-- 
1.8.3.1
