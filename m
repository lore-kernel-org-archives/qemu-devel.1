Received: from eggs.gnu.org ([2001:4830:134:3::10]:47950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfF-0006Gp-UC
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfB-00074Z-S7
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:49 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:53421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfB-00072D-HP
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:45 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 12 Dec 2016 16:08:08 +0800
Message-ID: <1481530092-20240-4-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v2 3/7] configure: add
 CONFIG_GCRYPT_SUPPORT_HMAC item
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com, stefanha@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

This item will be used for support libcrypt-backed HMAC algorithms.

Support for hmac has been added in Libgcrypt 1.6.0, but we cannot
use pkg-config to get libcrypt's version. However we can make a
in configure to know whether current libcrypt support hmac.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 configure | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/configure b/configure
index 3770d7c..6eb5f5c 100755
--- a/configure
+++ b/configure
@@ -2417,6 +2417,21 @@ EOF
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
+            gcrypy_support_hmac="yes"
+        else
+            gcrypy_support_hmac="no"
+        fi
     else
         if test "$gcrypt" = "yes"; then
             feature_not_found "gcrypt" "Install gcrypt devel"
@@ -5387,6 +5402,9 @@ if test "$gnutls_rnd" = "yes" ; then
 fi
 if test "$gcrypt" = "yes" ; then
   echo "CONFIG_GCRYPT=y" >> $config_host_mak
+  if test "gcrypy_support_hmac" = "yes" ; then
+    echo "CONFIG_GCRYPT_SUPPORT_HMAC=y" >> $config_host_mak
+  fi
   if test "$gcrypt_kdf" = "yes" ; then
     echo "CONFIG_GCRYPT_KDF=y" >> $config_host_mak
   fi
-- 
1.8.3.1
