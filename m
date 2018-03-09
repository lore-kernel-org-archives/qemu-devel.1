Received: from eggs.gnu.org ([2001:4830:134:3::10]:60141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnq-0000uW-W2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnm-0006dN-FF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:34 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 18:27:12 +0100
Message-Id: <20180309172713.26318-6-kwolf@redhat.com>
In-Reply-To: <20180309172713.26318-1-kwolf@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] luks: Catch integer overflow for huge sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

When you request an image size close to UINT64_MAX, the addition of the
crypto header may cause an integer overflow. Catch it instead of
silently truncating the image size.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 4908d8627f..1b46519c53 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -102,6 +102,11 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
 {
     struct BlockCryptoCreateData *data = opaque;
 
+    if (headerlen > UINT64_MAX - data->size) {
+        error_setg(errp, "The requested file size is too large");
+        return -EFBIG;
+    }
+
     /* User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
-- 
2.13.6
