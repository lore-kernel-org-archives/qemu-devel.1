Received: from eggs.gnu.org ([2001:4830:134:3::10]:45032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSI-0000o5-Pd
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSF-0003j2-DM
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  5 Dec 2018 17:46:55 +0300
Message-Id: <20181205144700.26563-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/5] crypto threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all.

v2:
05: fix compilation of test-crypto-block (I am ashamed:(
    and change QCryptoBlock interface to be a bit more safe.

These series are preliminary step before moving encryption code in
qcow2 to the threads. The first attempt of doing it is on list
([PATCH 00/11] qcow2: encryption threads : 
 https://lists.gnu.org/archive/html/qemu-block/2018-11/msg00729.html)
But it's approach with multiplying the whole QCryptoBlock per thread
was rejected. So, here is a solution to maintain multitasking inside
QCryptoBlock.

Vladimir Sementsov-Ogievskiy (5):
  crypto/block-luks: fix memory leak in qcrypto_block_luks_create
  crypto/block: refactor qcrypto_block_*crypt_helper functions
  crypto/block: rename qcrypto_block_*crypt_helper
  crypto/block: introduce qcrypto_block_*crypt_helper functions
  crypto: support multiple threads accessing one QCryptoBlock

 crypto/blockpriv.h        |  42 ++++++--
 include/crypto/block.h    |   3 +
 block/crypto.c            |   1 +
 block/qcow.c              |   2 +-
 block/qcow2.c             |   4 +-
 crypto/block-luks.c       |  60 ++++++-----
 crypto/block-qcow.c       |  26 ++---
 crypto/block.c            | 221 +++++++++++++++++++++++++++++---------
 tests/test-crypto-block.c |   3 +
 9 files changed, 257 insertions(+), 105 deletions(-)

-- 
2.18.0
