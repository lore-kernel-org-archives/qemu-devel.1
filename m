Received: from eggs.gnu.org ([2001:4830:134:3::10]:42232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3c-0002wX-4H
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3Y-0001Ku-VQ
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:28 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:6867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3Y-0001JU-8a
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:24 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 3 Jan 2017 08:33:06 +0800
Message-ID: <1483403591-2564-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1483403591-2564-1-git-send-email-longpeng2@huawei.com>
References: <1483403591-2564-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/6] configure: add CONFIG_GCRYPT/NETTLE_AEAD
 item
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

This item will be used for gcrypt/nettle backed AEAD algorithms.

It's hardly to decide which version of gcrypt/nettle started
supporting AEAD algorithms, but it's easily for us to making
a test in configure to know whether current gcrypt/nettle
support AEAD.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 configure | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/configure b/configure
index 218df87..14f558c 100755
--- a/configure
+++ b/configure
@@ -309,8 +309,10 @@ tls_priority="NORMAL"
 gnutls=""
 gnutls_rnd=""
 nettle=""
+nettle_aead="no"
 nettle_kdf="no"
 gcrypt=""
+gcrypt_aead="no"
 gcrypt_hmac="no"
 gcrypt_kdf="no"
 vte=""
@@ -2429,6 +2431,19 @@ EOF
         if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
             gcrypt_hmac=yes
         fi
+
+        cat > $TMPC << EOF
+#include <gcrypt.h>
+int main(void) {
+  gcry_cipher_hd_t handle;
+  gcry_cipher_open(&handle, 0, 0, 0);
+  gcry_cipher_authenticate(handle, NULL, 0);
+  return 0;
+}
+EOF
+        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
+            gcrypt_aead=yes
+        fi
     else
         if test "$gcrypt" = "yes"; then
             feature_not_found "gcrypt" "Install gcrypt devel"
@@ -2460,6 +2475,21 @@ EOF
         if compile_prog "$nettle_cflags" "$nettle_libs" ; then
             nettle_kdf=yes
         fi
+
+        cat > $TMPC << EOF
+#include <stddef.h>
+#include <nettle/aes.h>
+#include <nettle/ccm.h>
+#include <nettle/gcm.h>
+int main(void) {
+     ccm_aes128_encrypt(NULL, 0, NULL, NULL);
+     gcm_aes128_encrypt(NULL, 0, NULL, NULL);
+     return 0;
+}
+EOF
+        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
+            nettle_aead=yes
+        fi
     else
         if test "$nettle" = "yes"; then
             feature_not_found "nettle" "Install nettle devel"
@@ -5399,6 +5429,9 @@ if test "$gnutls_rnd" = "yes" ; then
 fi
 if test "$gcrypt" = "yes" ; then
   echo "CONFIG_GCRYPT=y" >> $config_host_mak
+  if test "$gcrypt_aead" = "yes" ; then
+    echo "CONFIG_GCRYPT_AEAD=y" >> $config_host_mak
+  fi
   if test "$gcrypt_hmac" = "yes" ; then
     echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
   fi
@@ -5409,6 +5442,9 @@ fi
 if test "$nettle" = "yes" ; then
   echo "CONFIG_NETTLE=y" >> $config_host_mak
   echo "CONFIG_NETTLE_VERSION_MAJOR=${nettle_version%%.*}" >> $config_host_mak
+  if test "$nettle_aead" = "yes" ; then
+    echo "CONFIG_NETTLE_AEAD=y" >> $config_host_mak
+  fi
   if test "$nettle_kdf" = "yes" ; then
     echo "CONFIG_NETTLE_KDF=y" >> $config_host_mak
   fi
-- 
2.9.3
