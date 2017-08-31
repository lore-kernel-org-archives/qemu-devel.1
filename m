Received: from eggs.gnu.org ([2001:4830:134:3::10]:50081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNI2-0006fB-4L
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNHy-0007di-3K
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:05:38 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 12:05:14 +0100
Message-Id: <20170831110518.10741-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] block: improve luks driver perf &
 switch to byte APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

This series includes a previously posted patch that improves performance
of the luks crypto driver:

  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00781.html

And then adds three patches that switch over to use byte based APIs for
I/O, rather than the legacy sector based APIs.

Daniel P. Berrange (4):
  block: use 1 MB bounce buffers for crypto instead of 16KB
  block: use BDRV_SECTOR_SIZE in crypto driver
  block: convert crypto driver to bdrv_co_preadv|pwritev
  block: convert qcrypto_block_encrypt|decrypt to take bytes offset

 block/crypto.c         | 119 +++++++++++++++++++++++++------------------------
 block/qcow.c           |   7 ++-
 block/qcow2-cluster.c  |   8 ++--
 block/qcow2.c          |   4 +-
 crypto/block-luks.c    |  12 +++--
 crypto/block-qcow.c    |  12 +++--
 crypto/block.c         |  14 +++---
 crypto/blockpriv.h     |   4 +-
 include/crypto/block.h |  14 +++---
 9 files changed, 104 insertions(+), 90 deletions(-)

-- 
2.13.5
