Received: from eggs.gnu.org ([2001:4830:134:3::10]:49518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fflBD-0007bu-W1
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fflBC-00036V-J0
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fflBC-00036O-DN
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0498C4023132
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 12:03:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 18 Jul 2018 13:03:33 +0100
Message-Id: <20180718120334.27138-3-berrange@redhat.com>
In-Reply-To: <20180718120334.27138-1-berrange@redhat.com>
References: <20180718120334.27138-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] crypto: require libgcrypt >= 1.5.0 for
 building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

libgcrypt 1.5.0 was released in 2011 and all the distros that are build
target platforms for QEMU [1] include it:

  RHEL-7: 1.5.3
  Debian (Stretch): 1.7.6
  Debian (Jessie): 1.6.3
  OpenBSD (ports): 1.8.2
  FreeBSD (ports): 1.8.3
  OpenSUSE Leap 15: 1.8.2
  Ubuntu (Xenial): 1.6.5
  macOS (Homebrew): 1.8.3

Based on this, it is reasonable to require libgcrypt >=3D 1.5.0 in QEMU
which allows for some conditional version checks in the code to be
removed.

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure                 | 32 +++++++++++---------------------
 crypto/Makefile.objs      |  2 +-
 crypto/init.c             |  3 +--
 tests/Makefile.include    |  2 +-
 tests/test-crypto-block.c |  2 +-
 5 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/configure b/configure
index 856cb07be5..84c2f91a1f 100755
--- a/configure
+++ b/configure
@@ -460,7 +460,6 @@ nettle=3D""
 nettle_kdf=3D"no"
 gcrypt=3D""
 gcrypt_hmac=3D"no"
-gcrypt_kdf=3D"no"
 vte=3D""
 virglrenderer=3D""
 tpm=3D"yes"
@@ -2712,7 +2711,7 @@ then
     fi
 fi
=20
-has_libgcrypt_config() {
+has_libgcrypt() {
     if ! has "libgcrypt-config"
     then
 	return 1
@@ -2727,6 +2726,14 @@ has_libgcrypt_config() {
 	fi
     fi
=20
+    maj=3D`libgcrypt-config --version | awk -F . '{print $1}'`
+    min=3D`libgcrypt-config --version | awk -F . '{print $2}'`
+
+    if test $maj !=3D 1 || test $min -lt 5
+    then
+       return 1
+    fi
+
     return 0
 }
=20
@@ -2765,7 +2772,7 @@ EOF
 fi
=20
 if test "$gcrypt" !=3D "no"; then
-    if has_libgcrypt_config; then
+    if has_libgcrypt; then
         gcrypt_cflags=3D$(libgcrypt-config --cflags)
         gcrypt_libs=3D$(libgcrypt-config --libs)
         # Debian has remove -lgpg-error from libgcrypt-config
@@ -2782,19 +2789,6 @@ if test "$gcrypt" !=3D "no"; then
=20
         cat > $TMPC << EOF
 #include <gcrypt.h>
-int main(void) {
-  gcry_kdf_derive(NULL, 0, GCRY_KDF_PBKDF2,
-                  GCRY_MD_SHA256,
-                  NULL, 0, 0, 0, NULL);
- return 0;
-}
-EOF
-        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
-            gcrypt_kdf=3Dyes
-        fi
-
-        cat > $TMPC << EOF
-#include <gcrypt.h>
 int main(void) {
   gcry_mac_hd_t handle;
   gcry_mac_open(&handle, GCRY_MAC_HMAC_MD5,
@@ -2807,7 +2801,7 @@ EOF
         fi
     else
         if test "$gcrypt" =3D "yes"; then
-            feature_not_found "gcrypt" "Install gcrypt devel"
+            feature_not_found "gcrypt" "Install gcrypt devel >=3D 1.5.0"
         else
             gcrypt=3D"no"
         fi
@@ -5853,7 +5847,6 @@ echo "VTE support       $vte $(echo_version $vte $v=
teversion)"
 echo "TLS priority      $tls_priority"
 echo "GNUTLS support    $gnutls"
 echo "libgcrypt         $gcrypt"
-echo "libgcrypt kdf     $gcrypt_kdf"
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
 echo "nettle kdf        $nettle_kdf"
 echo "libtasn1          $tasn1"
@@ -6304,9 +6297,6 @@ if test "$gcrypt" =3D "yes" ; then
   if test "$gcrypt_hmac" =3D "yes" ; then
     echo "CONFIG_GCRYPT_HMAC=3Dy" >> $config_host_mak
   fi
-  if test "$gcrypt_kdf" =3D "yes" ; then
-    echo "CONFIG_GCRYPT_KDF=3Dy" >> $config_host_mak
-  fi
 fi
 if test "$nettle" =3D "yes" ; then
   echo "CONFIG_NETTLE=3Dy" >> $config_host_mak
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index a62cedaf36..6a908f51f5 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -24,7 +24,7 @@ crypto-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) +=3D=
 random-gnutls.o
 crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) +=3D rand=
om-platform.o
 crypto-obj-y +=3D pbkdf.o
 crypto-obj-$(CONFIG_NETTLE_KDF) +=3D pbkdf-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE_KDF),n,$(CONFIG_GCRYPT_KDF)) +=3D pbkdf-=
gcrypt.o
+crypto-obj-$(if $(CONFIG_NETTLE_KDF),n,$(CONFIG_GCRYPT)) +=3D pbkdf-gcry=
pt.o
 crypto-obj-y +=3D ivgen.o
 crypto-obj-y +=3D ivgen-essiv.o
 crypto-obj-y +=3D ivgen-plain.o
diff --git a/crypto/init.c b/crypto/init.c
index 10bf72463c..c30156405a 100644
--- a/crypto/init.c
+++ b/crypto/init.c
@@ -44,8 +44,7 @@
  */
=20
 #if (defined(CONFIG_GCRYPT) &&                  \
-     (!defined(GCRYPT_VERSION_NUMBER) ||        \
-      (GCRYPT_VERSION_NUMBER < 0x010600)))
+     (GCRYPT_VERSION_NUMBER < 0x010600))
 #define QCRYPTO_INIT_GCRYPT_THREADS
 #else
 #undef QCRYPTO_INIT_GCRYPT_THREADS
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a49282704e..3712de22cf 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -156,7 +156,7 @@ check-unit-$(CONFIG_GNUTLS) +=3D tests/test-io-channe=
l-tls$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-command$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-buffer$(EXESUF)
 check-unit-y +=3D tests/test-base64$(EXESUF)
-check-unit-$(if $(CONFIG_NETTLE_KDF),y,$(CONFIG_GCRYPT_KDF)) +=3D tests/=
test-crypto-pbkdf$(EXESUF)
+check-unit-$(if $(CONFIG_NETTLE_KDF),y,$(CONFIG_GCRYPT)) +=3D tests/test=
-crypto-pbkdf$(EXESUF)
 check-unit-y +=3D tests/test-crypto-ivgen$(EXESUF)
 check-unit-y +=3D tests/test-crypto-afsplit$(EXESUF)
 check-unit-y +=3D tests/test-crypto-xts$(EXESUF)
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index fd29a045d2..bd512cc79a 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -29,7 +29,7 @@
 #endif
=20
 #if (defined(_WIN32) || defined RUSAGE_THREAD) && \
-    (defined(CONFIG_NETTLE_KDF) || defined(CONFIG_GCRYPT_KDF))
+    (defined(CONFIG_NETTLE_KDF) || defined(CONFIG_GCRYPT))
 #define TEST_LUKS
 #else
 #undef TEST_LUKS
--=20
2.17.1
