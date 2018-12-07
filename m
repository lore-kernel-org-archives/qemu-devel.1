Received: from eggs.gnu.org ([2001:4830:134:3::10]:41789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlO-0006rc-U1
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlK-0002bx-OP
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Dec 2018 19:13:46 +0300
Message-Id: <20181207161351.4380-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/5] crypto threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

v3:
01: add r-b by Daniel and Alberto
02: Alberto r-b
    encrypt->encdec for generic
03: qcrypto_cipher_*crypt_helper->
    qcrypto_block_cipher_*crypt_helper
04: rebased on previous renamings
    Daniel r-b
05: use size_t
    improve comment about n_threads
    don't use ret in qcrypto_block_luks_create
    do qemu_mutex_init at the end of open/create
    do qemu_mutex_destroy in free
    fix comment for qcrypto_block_get_cipher

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

 crypto/blockpriv.h        |  42 +++++--
 include/crypto/block.h    |   2 +
 block/crypto.c            |   1 +
 block/qcow.c              |   2 +-
 block/qcow2.c             |   4 +-
 crypto/block-luks.c       |  57 +++++-----
 crypto/block-qcow.c       |  26 ++---
 crypto/block.c            | 225 +++++++++++++++++++++++++++++---------
 tests/test-crypto-block.c |   3 +
 9 files changed, 257 insertions(+), 105 deletions(-)

-- 
2.18.0
