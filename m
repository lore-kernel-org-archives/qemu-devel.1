Received: from eggs.gnu.org ([2001:4830:134:3::10]:49203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJE-0007Y9-Qz
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIz-000435-Jn
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:46:00 +0200
Message-Id: <1502117160-24655-57-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 56/56] crypto: Make QCryptoBlockInfoLUKS
 offsets unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Byte offsets should use QAPI type 'size' (uint64_t).
QCryptoBlockInfoLUKS member @payload-offset and
QCryptoBlockInfoLUKSSlot member @key-offset are 'int' (int64_t).
qcrypto_block_luks_get_info() gets the former QCryptoBlock member
@payload_offset, implicitly converting from uint64_t, and computes the
latter from QCryptoBlockLUKSKeySlot member @key_offset, implicitly
converting from long long.

Change both offsets to 'size'.

query-block and query-named-block-nodes now report @payload-offset
values above 2^63-1 correctly instead of their (negative) two's
complement.  Should never occur in practice.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/crypto.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6b6fde3..57a10cb 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -266,7 +266,7 @@
   'data': {'active': 'bool',
            '*iters': 'int',
            '*stripes': 'int',
-           'key-offset': 'int' } }
+           'key-offset': 'size' } }
 
 
 ##
@@ -292,7 +292,7 @@
            'ivgen-alg': 'QCryptoIVGenAlgorithm',
            '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
            'hash-alg': 'QCryptoHashAlgorithm',
-           'payload-offset': 'int',
+           'payload-offset': 'size',
            'master-key-iters': 'int',
            'uuid': 'str',
            'slots': [ 'QCryptoBlockInfoLUKSSlot' ] }}
-- 
2.7.5
