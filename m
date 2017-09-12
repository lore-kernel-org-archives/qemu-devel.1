Received: from eggs.gnu.org ([2001:4830:134:3::10]:53762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNN-0002wQ-GD
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNM-0004Pa-IN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:09 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 12:28:48 +0100
Message-Id: <20170912112855.24269-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/7] Misc improvements to crypto block driver
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

This is a followup to

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00781.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06464.html

This collection of patches first improves the performance of the
crypto block driver and then does various cleanups to improve ongoing
maint work.

Changed in v3:

  - Support passthrough of BDRV_REQ_FUA (Eric)
  - Fix potential truncation of payload offset values (Eric)
  - Use encryption scheme sector size instead of BDRV_SECTOR_SIZE (Kevin)
  - Use QEMU_IS_ALIGNED where appropriate (Eric)
  - Remove unused 'sector_num' variable (Eric)
  - Fix whitespace alignment (Eric)
  - Fix math error in qcow conversion (Eric)

Daniel P. Berrange (7):
  block: use 1 MB bounce buffers for crypto instead of 16KB
  crypto: expose encryption sector size in APIs
  block: fix data type casting for crypto payload offset
  block: don't use constant 512 as sector size in crypto driver
  block: convert crypto driver to bdrv_co_preadv|pwritev
  block: convert qcrypto_block_encrypt|decrypt to take bytes offset
  block: support passthrough of BDRV_REQ_FUA in crypto driver

 block/crypto.c         | 134 +++++++++++++++++++++++++++----------------------
 block/qcow.c           |   7 ++-
 block/qcow2-cluster.c  |   8 ++-
 block/qcow2.c          |   4 +-
 crypto/block-luks.c    |  18 ++++---
 crypto/block-qcow.c    |  13 +++--
 crypto/block.c         |  26 +++++++---
 crypto/blockpriv.h     |   5 +-
 include/crypto/block.h |  29 ++++++++---
 9 files changed, 150 insertions(+), 94 deletions(-)

-- 
2.13.5
