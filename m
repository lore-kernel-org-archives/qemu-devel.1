Received: from eggs.gnu.org ([2001:4830:134:3::10]:36606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0ug-0004iS-0Q
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0uf-0006AZ-3i
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cK0ue-0006A6-UI
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:53 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 22 Dec 2016 10:47:35 +0000
Message-Id: <20161222104740.19606-4-berrange@redhat.com>
In-Reply-To: <20161222104740.19606-1-berrange@redhat.com>
References: <20161222104740.19606-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 3/8] configure: add CONFIG_GCRYPT_HMAC item
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Longpeng(Mike)" <longpeng2@huawei.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

This item will be used for support libcrypt-backed HMAC algorithms.

Support for hmac has been added in Libgcrypt 1.6.0, but we cannot
use pkg-config to get libcrypt's version. However we can make a
in configure to know whether current libcrypt support hmac.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 configure | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configure b/configure
index 3770d7c..f30aa1b 100755
--- a/configure
+++ b/configure
@@ -313,6 +313,7 @@ gnutls_rnd=""
 nettle=""
 nettle_kdf="no"
 gcrypt=""
+gcrypt_hmac="no"
 gcrypt_kdf="no"
 vte=""
 virglrenderer=""
@@ -2417,6 +2418,19 @@ EOF
         if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
             gcrypt_kdf=yes
         fi
+
+        cat > $TMPC << EOF
+#include <gcrypt.h>
+int main(void) {
+  gcry_mac_hd_t handle;
+  gcry_mac_open(&handle, GCRY_MAC_HMAC_MD5,
+                GCRY_MAC_FLAG_SECURE, NULL);
+  return 0;
+}
+EOF
+        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
+            gcrypt_hmac=yes
+        fi
     else
         if test "$gcrypt" = "yes"; then
             feature_not_found "gcrypt" "Install gcrypt devel"
@@ -5387,6 +5401,9 @@ if test "$gnutls_rnd" = "yes" ; then
 fi
 if test "$gcrypt" = "yes" ; then
   echo "CONFIG_GCRYPT=y" >> $config_host_mak
+  if test "$gcrypt_hmac" = "yes" ; then
+    echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
+  fi
   if test "$gcrypt_kdf" = "yes" ; then
     echo "CONFIG_GCRYPT_KDF=y" >> $config_host_mak
   fi
-- 
2.9.3
