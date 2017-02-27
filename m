Received: from eggs.gnu.org ([2001:4830:134:3::10]:52283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLWa-00075P-TU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLWZ-0000S9-RW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLWZ-0000S4-LX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:35 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:39:26 +0000
Message-Id: <20170227133927.759-2-berrange@redhat.com>
In-Reply-To: <20170227133927.759-1-berrange@redhat.com>
References: <20170227133927.759-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/2] crypto: fix leak in ivgen essiv init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liqiang6-s@360.cn>, "Daniel P . Berrange" <berrange@redhat.com>

From: Li Qiang <liqiang6-s@360.cn>

On error path, the 'salt' doesn't been freed thus leading
a memory leak. This patch avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/ivgen-essiv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index 634de63..cba20bd 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -48,6 +48,7 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
                            &salt, &nhash,
                            errp) < 0) {
         g_free(essiv);
+        g_free(salt);
         return -1;
     }
 
-- 
2.9.3
