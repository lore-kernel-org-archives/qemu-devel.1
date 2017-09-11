Received: from eggs.gnu.org ([2001:4830:134:3::10]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG5-0004HE-Kc
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG0-00045S-LZ
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDFz-0003yR-Vs
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:24 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:32 +0800
Message-ID: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 0/8] virtio-crypto: add multiplexing mode support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

*NOTE*
The code realization is based on the latest virtio crypto spec:
 [PATCH v19 0/2] virtio-crypto: virtio crypto device specification
   https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05217.html

In session mode, the process of create/close a session
makes we have a least one full round-trip cost from guest to host to guest
to be able to send any data for symmetric algorithms. It gets ourself into
synchronization troubles in some scenarios like a web server handling lots
of small requests whose algorithms and keys are different.

We can support one-blob request (no sessions) as well for symmetric
algorithms, including HASH, MAC services. The benefit is obvious for
HASH service because it's usually a one-blob operation.

Gonglei (3):
  virtio-crypto: add stateless crypto request handler
  cryptodev: extract one util function
  virtio-crypto: add host feature bits support

Longpeng(Mike) (5):
  virtio-crypto: add new definations for multiplexing mode
  virtio-crypto: add session creation logic for mux mode
  virtio-crypto: add dataq operation logic for mux mode
  cryptodev: add stateless mode cipher support
  cryptodev-builtin: add stateless cipher support

 backends/cryptodev-builtin.c                   | 189 ++++++++---
 backends/cryptodev.c                           |  21 ++
 hw/virtio/virtio-crypto.c                      | 433 +++++++++++++++++++++++--
 include/hw/virtio/virtio-crypto.h              |   2 +
 include/standard-headers/linux/virtio_crypto.h | 182 ++++++++++-
 include/sysemu/cryptodev.h                     |  21 ++
 6 files changed, 774 insertions(+), 74 deletions(-)

-- 
1.8.3.1
