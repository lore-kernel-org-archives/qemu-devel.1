Received: from eggs.gnu.org ([2001:4830:134:3::10]:35803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh6Y-0006VL-Iq
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh6V-00068p-Ew
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:02:26 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:23226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh6V-00063P-2y
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:02:23 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 13 Dec 2016 15:01:48 +0800
Message-ID: <1481612513-28556-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
References: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v3 1/6] configure: add
 CONFIG_GCRYPT_HMAC item
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

This item will be used for support libcrypt-backed HMAC algorithms.

Support for hmac has been added in Libgcrypt 1.6.0, but we cannot
use pkg-config to get libcrypt's version. However we can make a
in configure to know whether current libcrypt support hmac.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
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
1.8.3.1
