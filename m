Received: from eggs.gnu.org ([2001:4830:134:3::10]:50688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0002xB-Mr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0Q-0004VI-9k
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0P-0004UM-MD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:10 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:15 +0800
Message-ID: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 0/9] virtio-crypto: add stateless mode support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, pasic@linux.vnet.ibm.com, stefanha@redhat.com, luonengjun@huawei.com, cornelia.huck@de.ibm.com, linqiangmin@huawei.com, xin.zeng@intel.com, wu.wubin@huawei.com, Gonglei <arei.gonglei@huawei.com>

In session mode, the process of create/close a session
makes we have a least one full round-trip cost from guest to host to guest
to be able to send any data for symmetric algorithms. It gets ourself into
synchronization troubles in some scenarios like a web server handling lots
of small requests whose algorithms and keys are different.

We can support one-blob request (no sessions) as well for symmetric
algorithms, including HASH, MAC services. The benefit is obvious for
HASH service because it's usually a one-blob operation.

The code realization is based on the latest virtio crypto spec:

[PATCH v18 0/2] virtio-crypto: virtio crypto device specification
  https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03860.html

Patch 1~4 introduce stateless symmetric crypto operations stuff for
stateless mode in cryptodev backend framework.

Patch 5~8 introduce stateless operation for virtio crypto device and
add 5 feature bits to support it.

Patch 9 is a experimental patch for testing the new stateless functions, so
that people don't need to compile a new linux driver to test it (I havn't
realize the driver yet, It's not a big deal). Of cource the patch
can't be upsteamed until the qtest framework supports virtio 1.0 or latter.

Gonglei (9):
  cryptodev: introduce stateless sym operation stuff
  cryptodev: extract one util function
  cryptodev: add missing op_code for symmertric crypto
  cryptodev-builtin: realize stateless operation function
  virtio-crypto: update header file
  virtio-crypto: rework virtio_crypto_handle_request
  virtio-crypto: add stateless crypto request handler
  virtio-crypto: add host feature bits support
  qtest: emulate virtio crypto as a legacy device for experiment

 backends/cryptodev-builtin.c                   | 189 ++++++--
 backends/cryptodev.c                           |  21 +
 docs/specs/pci-ids.txt                         |   2 +
 hw/virtio/virtio-crypto-pci.c                  |   4 +-
 hw/virtio/virtio-crypto.c                      | 340 +++++++++++++-
 include/hw/pci/pci.h                           |   2 +
 include/hw/virtio/virtio-crypto.h              |   2 +
 include/standard-headers/linux/virtio_crypto.h | 210 ++++++++-
 include/sysemu/cryptodev.h                     |  22 +
 tests/Makefile.include                         |   3 +
 tests/virtio-crypto-test.c                     | 596 +++++++++++++++++++++++++
 11 files changed, 1332 insertions(+), 59 deletions(-)
 create mode 100644 tests/virtio-crypto-test.c

-- 
1.8.3.1
