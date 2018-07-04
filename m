Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajIo-00049m-Ub
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajIl-0000cl-St
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:02:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Jul 2018 12:02:29 -0300
Message-Id: <20180704150229.9948-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] block/crypto: Simplify
 block_crypto_co_create_opts_luks to avoid a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

After 1ec4f4160a1 Coverity reported:

  Variable cryptoopts going out of scope leaks the storage it points to.

Fixes: Coverity CID 1393782 (Resource leak)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I think this check is superfluous but I respected the previous code:

     ret = block_crypto_co_create_generic(bs, size, create_opts, errp);
     if (ret > 0) {
         ret = 0;
     }

 block/crypto.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 994172a3de..d4d2c6c511 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -545,33 +545,36 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
     create_opts = block_crypto_create_opts_init(cryptoopts, errp);
     if (!create_opts) {
         ret = -EINVAL;
-        goto fail;
+        goto cleanup_cryptoopts;
     }
 
     /* Create protocol layer */
     ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        return ret;
+        goto cleanup_create_opts;
     }
 
     bs = bdrv_open(filename, NULL, NULL,
                    BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
     if (!bs) {
         ret = -EINVAL;
-        goto fail;
+        goto cleanup_create_opts;
     }
 
     /* Create format layer */
     ret = block_crypto_co_create_generic(bs, size, create_opts, errp);
-    if (ret < 0) {
-        goto fail;
+    if (ret > 0) {
+        ret = 0;
     }
 
-    ret = 0;
-fail:
     bdrv_unref(bs);
+
+cleanup_create_opts:
     qapi_free_QCryptoBlockCreateOptions(create_opts);
+
+cleanup_cryptoopts:
     qobject_unref(cryptoopts);
+
     return ret;
 }
 
-- 
2.18.0
