Received: from eggs.gnu.org ([2001:4830:134:3::10]:34061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cOdEp-0005EH-Oe
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cOdEl-0005Fv-Qi
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:31:47 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cOdEl-0005FK-NI
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:31:43 -0500
Received: by mail-qt0-x243.google.com with SMTP id j29so1640047qtc.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 20:31:42 -0800 (PST)
Message-ID: <586c7aad.0834c80a.d7aff.122e@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue,  3 Jan 2017 20:31:34 -0800
Subject: [Qemu-devel] [PATCH] Crypto: fix leak in ivgen essiv init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, qemu-devel@nongnu.org
Cc: liqiang6-s@360.cn

From: Li Qiang <liqiang6-s@360.cn>

On error path, the 'salt' doesn't been freed thus leading
a memory leak. This patch avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
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
1.8.3.1
