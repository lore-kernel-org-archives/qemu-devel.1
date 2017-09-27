Received: from eggs.gnu.org ([2001:4830:134:3::10]:49909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqf-0004FM-Ah
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqe-0001Qh-9E
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:53:57 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 27 Sep 2017 13:53:34 +0100
Message-Id: <20170927125340.12360-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/6] Misc improvements to crypto block driver
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
  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02923.html

This collection of patches first improves the performance of the
crypto block driver and then does various cleanups to improve ongoing
maint work.

Changed in v4:

  - Drop intermediate patch that replaced '512' with a constant (Max)
  - Use MIN() macro where needed (Max)
  - Fix bounce buffer size at 1MB instead of varying per sector size (Max)
  - Convert missing qcrypto_block_encrypt call to sectors in qcow.c (Max)

Changed in v3:

  - Support passthrough of BDRV_REQ_FUA (Eric)
  - Fix potential truncation of payload offset values (Eric)
  - Use encryption scheme sector size instead of BDRV_SECTOR_SIZE (Kevin)
  - Use QEMU_IS_ALIGNED where appropriate (Eric)
  - Remove unused 'sector_num' variable (Eric)
  - Fix whitespace alignment (Eric)
  - Fix math error in qcow conversion (Eric)

Daniel P. Berrange (6):
  block: use 1 MB bounce buffers for crypto instead of 16KB
  crypto: expose encryption sector size in APIs
  block: fix data type casting for crypto payload offset
  block: convert crypto driver to bdrv_co_preadv|pwritev
  block: convert qcrypto_block_encrypt|decrypt to take bytes offset
  block: support passthrough of BDRV_REQ_FUA in crypto driver

 block/crypto.c         | 130 ++++++++++++++++++++++++++-----------------------
 block/qcow.c           |  11 +++--
 block/qcow2-cluster.c  |   8 ++-
 block/qcow2.c          |   4 +-
 crypto/block-luks.c    |  18 ++++---
 crypto/block-qcow.c    |  13 +++--
 crypto/block.c         |  26 +++++++---
 crypto/blockpriv.h     |   5 +-
 include/crypto/block.h |  29 ++++++++---
 9 files changed, 148 insertions(+), 96 deletions(-)

-- 
2.13.5
