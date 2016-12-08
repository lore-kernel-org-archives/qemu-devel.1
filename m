Received: from eggs.gnu.org ([2001:4830:134:3::10]:45101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEqTr-0004Qx-7m
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 23:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEqTn-0001EO-Fg
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 23:38:51 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:9122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEqTm-0001Ba-Jw
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 23:38:47 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 8 Dec 2016 12:37:07 +0800
Message-ID: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 0/2] virtio-crypto: add Linux driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
Cc: luonengjun@huawei.com, mst@redhat.com, stefanha@redhat.com, weidong.huang@huawei.com, wu.wubin@huawei.com, xin.zeng@intel.com, claudio.fontana@huawei.com, herbert@gondor.apana.org.au, pasic@linux.vnet.ibm.com, davem@davemloft.net, jianjay.zhou@huawei.com, hanweidong@huawei.com, arei.gonglei@hotmail.com, cornelia.huck@de.ibm.com, xuquan8@huawei.com, longpeng2@huawei.com, wanzongshun@huawei.com, Gonglei <arei.gonglei@huawei.com>

v6:
 - add patch 1/2 to make sparc architecture happy. [Sam]
 - close created sessions previousely when rekeying.
 - convert the priority of virtio crypto algs from 4001 to 501
   which is enough.

v5:
 - add comments for algs_lock and table_lock. [Stefan]
 - use kzfree instead of kfree for key material security. [Stefan]
 - drop unnecessary spin_lock for struct virtio_crypto_ablkcipher_ctx.
 - dynamically allocated memory for iv in order to avoid to do DMA from
   the stack memory in __virtio_crypto_ablkcipher_do_req().
 - add logs for error path in virtio_crypto_alg_validate_key().
 - add lock before calling virtio_break_device() in virtcrypto_update_status()

v4:
 - rework unknow status bit handler by calling virtio_break_device(). [Cornelia]
 - convert space to tab in Kconfig. [Stefan]
 - rename virtio_crypto.c to virtio_crypto_core.c and then make the
   moudle named virtio_crypto.ko for consistency. [Stefan]
 - don't call virtcrypto_dev_stop() on failure path. [Stefan]
 - don't add two empty lines. [Michael]
 - fix possible race by add spin_lock in virtio_crypto_alg_ablkcipher_init_session() [Michael and Halil]
 - drop virtcrypto_devmgr_get_first() calling in virtio_crypto_ablkcipher_setkey. [Michael]
 - drop superfluous assigned value for virtio_crypto_algs[i].cra_flags
   in virtio_crypto_algs_register(). [Stefan]
 - decrease virtio_crypto_active_devs if calling crypto_register_algs() failed. [Stefan]
 - fix some typos here and there. [Stefan]
 - fix missing table_lock usage in virtio_crypto_mgr.c. [Stefan]
 - drop confused comments in virtio_crypto_alg_ablkcipher_init_session()
   for virtqueue_kick(). [Halil]

v3:
 - set cpu affinity when data queues are not equal to the number of online cpus. [Michael]
 - add TODO comments for cpu hotplug (changing the relationship of binding virtqueue and cpu)
 - use __u32/64 in the config space since the virtio->get() doesn't support byte-swap yet. [Michael]
 - drop the whole patch 1 of v2 because the above reason.
 - add VERSION_1 check at the beginning of virtcrypto_probe()
 - s/-1/EPERM/g in virtcrypto_update_status(), don't change err to EFAULT then. [Michael]
 - add reset operation before delete the virtqueus. [Micheal]
 - drop an unnecessiry spin_lock calling in virtcrypto_freeze(), avoid possible dead lock. [Micheal]
 - redefine parameter alg's type in order to use a cast for it. [Michael]
 - pad all structures to have the same size in one union, and add a member to
   show the union's size in virtio_crypto.h. [Michael]
 - update MAINTAINER file to add virtio-crypto stuff to Michael's entry so that
   the corresponding patches can be CC'ed to Michael as well because the virtio-crypto
   doesn't lay in driver/virtio directory. 

The virtio crypto device is a virtual cryptography device
as well as a kind of virtual hardware accelerator for
virtual machines. The encryption anddecryption requests
are placed in the data queue and are ultimately handled by
thebackend crypto accelerators. The second queue is the
control queue used to create or destroy sessions for
symmetric algorithms and will control some advanced features
in the future. The virtio crypto device provides the following
cryptoservices: CIPHER, MAC, HASH, and AEAD.

For more information about virtio-crypto device, please see:
  http://qemu-project.org/Features/VirtioCrypto

For better reviewing, pls see below explaination.

The patch mainly includes five files:

 1) virtio_crypto.h is the header file for virtio-crypto device,
which is based on the virtio-crypto specification. 
 2) virtio_crypto_core.c is the entry of the driver module,
which is similar with other virtio devices, such as virtio-net,
virtio-input etc. 
 3) virtio_crypto_mgr.c is used to manage the virtio
crypto devices in the system. We support up to 32 virtio-crypto
devices currently. I use a global list to store the virtio crypto
devices which refer to Intel QAT driver. Meanwhile, the file
includs the functions of add/del/search/start/stop for virtio
crypto devices.
 4) virtio_crypto_common.h is a private header file for virtio
crypto driver, includes structure definations, and function declarations.
 5) virtio_crypto_algs.c is the realization of algs based on Linux Crypto Framwork,
which can register different crypto algorithms. Currently it's only support AES-CBC.
The Crypto guys can mainly focus on this file. 


v2:
 - stop doing DMA from the stack, CONFIG_VMAP_STACK=y [Salvatore]
 - convert __virtio32/64 to __le32/64 in virtio_crypto.h
 - remove VIRTIO_CRYPTO_S_STARTED based on the lastest virtio crypto spec.
 - introduces the little edian functions for VIRTIO_1 devices in patch 1.


Gonglei (2):
  sparc: fix a building error reported by kbuild
  crypto: add virtio-crypto driver

 MAINTAINERS                                  |   9 +
 arch/sparc/include/asm/topology_64.h         |   1 +
 drivers/crypto/Kconfig                       |   2 +
 drivers/crypto/Makefile                      |   1 +
 drivers/crypto/virtio/Kconfig                |  10 +
 drivers/crypto/virtio/Makefile               |   5 +
 drivers/crypto/virtio/virtio_crypto_algs.c   | 541 +++++++++++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h | 122 ++++++
 drivers/crypto/virtio/virtio_crypto_core.c   | 464 +++++++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_mgr.c    | 264 +++++++++++++
 include/uapi/linux/Kbuild                    |   1 +
 include/uapi/linux/virtio_crypto.h           | 450 ++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h              |   1 +
 13 files changed, 1871 insertions(+)
 create mode 100644 drivers/crypto/virtio/Kconfig
 create mode 100644 drivers/crypto/virtio/Makefile
 create mode 100644 drivers/crypto/virtio/virtio_crypto_algs.c
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.h
 create mode 100644 drivers/crypto/virtio/virtio_crypto_core.c
 create mode 100644 drivers/crypto/virtio/virtio_crypto_mgr.c
 create mode 100644 include/uapi/linux/virtio_crypto.h

-- 
1.8.3.1
