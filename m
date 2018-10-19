Received: from eggs.gnu.org ([2001:4830:134:3::10]:39560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDV4N-0000TQ-0F
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDV4H-00083f-Rw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:44:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDV3p-0006us-CW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:43:57 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 19 Oct 2018 14:43:18 +0100
Message-Id: <20181019134318.17155-4-berrange@redhat.com>
In-Reply-To: <20181019134318.17155-1-berrange@redhat.com>
References: <20181019134318.17155-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] crypto: require nettle >= 2.7.1 for
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

nettle 2.7.1 was released in 2013 and all the distros that are build
target platforms for QEMU [1] include it:

  RHEL-7: 2.7.1
  Debian (Stretch): 3.3
  Debian (Jessie): 2.7.1
  OpenBSD (ports): 3.4
  FreeBSD (ports): 3.4
  OpenSUSE Leap 15: 3.4
  Ubuntu (Xenial): 3.2
  macOS (Homebrew): 3.4

Based on this, it is reasonable to require nettle >=3D 2.7.1 in QEMU
which allows for some conditional version checks in the code to be
removed.

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure                 | 20 ++------------------
 tests/test-crypto-block.c |  2 +-
 crypto/Makefile.objs      |  4 ++--
 tests/Makefile.include    |  2 +-
 4 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index f943d6618a..5a508206e1 100755
--- a/configure
+++ b/configure
@@ -458,7 +458,6 @@ gtk_gl=3D"no"
 tls_priority=3D"NORMAL"
 gnutls=3D""
 nettle=3D""
-nettle_kdf=3D"no"
 gcrypt=3D""
 gcrypt_hmac=3D"no"
 vte=3D""
@@ -2730,7 +2729,7 @@ has_libgcrypt() {
=20
=20
 if test "$nettle" !=3D "no"; then
-    if $pkg_config --exists "nettle"; then
+    if $pkg_config --exists "nettle >=3D 2.7.1"; then
         nettle_cflags=3D$($pkg_config --cflags nettle)
         nettle_libs=3D$($pkg_config --libs nettle)
         nettle_version=3D$($pkg_config --modversion nettle)
@@ -2739,23 +2738,12 @@ if test "$nettle" !=3D "no"; then
         QEMU_CFLAGS=3D"$QEMU_CFLAGS $nettle_cflags"
         nettle=3D"yes"
=20
-        cat > $TMPC << EOF
-#include <stddef.h>
-#include <nettle/pbkdf2.h>
-int main(void) {
-     pbkdf2_hmac_sha256(8, NULL, 1000, 8, NULL, 8, NULL);
-     return 0;
-}
-EOF
         if test -z "$gcrypt"; then
            gcrypt=3D"no"
         fi
-        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
-            nettle_kdf=3Dyes
-        fi
     else
         if test "$nettle" =3D "yes"; then
-            feature_not_found "nettle" "Install nettle devel"
+            feature_not_found "nettle" "Install nettle devel >=3D 2.7.1"
         else
             nettle=3D"no"
         fi
@@ -5906,7 +5894,6 @@ echo "TLS priority      $tls_priority"
 echo "GNUTLS support    $gnutls"
 echo "libgcrypt         $gcrypt"
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
-echo "nettle kdf        $nettle_kdf"
 echo "libtasn1          $tasn1"
 echo "curses support    $curses"
 echo "virgl support     $virglrenderer $(echo_version $virglrenderer $vi=
rgl_version)"
@@ -6351,9 +6338,6 @@ fi
 if test "$nettle" =3D "yes" ; then
   echo "CONFIG_NETTLE=3Dy" >> $config_host_mak
   echo "CONFIG_NETTLE_VERSION_MAJOR=3D${nettle_version%%.*}" >> $config_=
host_mak
-  if test "$nettle_kdf" =3D "yes" ; then
-    echo "CONFIG_NETTLE_KDF=3Dy" >> $config_host_mak
-  fi
 fi
 if test "$tasn1" =3D "yes" ; then
   echo "CONFIG_TASN1=3Dy" >> $config_host_mak
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index bd512cc79a..fae4ffc453 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -29,7 +29,7 @@
 #endif
=20
 #if (defined(_WIN32) || defined RUSAGE_THREAD) && \
-    (defined(CONFIG_NETTLE_KDF) || defined(CONFIG_GCRYPT))
+    (defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT))
 #define TEST_LUKS
 #else
 #undef TEST_LUKS
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 6a908f51f5..256c9aca1f 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -23,8 +23,8 @@ crypto-obj-$(CONFIG_GCRYPT) +=3D random-gcrypt.o
 crypto-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) +=3D random-gnutls.=
o
 crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) +=3D rand=
om-platform.o
 crypto-obj-y +=3D pbkdf.o
-crypto-obj-$(CONFIG_NETTLE_KDF) +=3D pbkdf-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE_KDF),n,$(CONFIG_GCRYPT)) +=3D pbkdf-gcry=
pt.o
+crypto-obj-$(CONFIG_NETTLE) +=3D pbkdf-nettle.o
+crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) +=3D pbkdf-gcrypt.o
 crypto-obj-y +=3D ivgen.o
 crypto-obj-y +=3D ivgen-essiv.o
 crypto-obj-y +=3D ivgen-plain.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0c8113ffa6..f77a495109 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -115,7 +115,7 @@ check-unit-$(CONFIG_GNUTLS) +=3D tests/test-io-channe=
l-tls$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-command$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-buffer$(EXESUF)
 check-unit-y +=3D tests/test-base64$(EXESUF)
-check-unit-$(if $(CONFIG_NETTLE_KDF),y,$(CONFIG_GCRYPT)) +=3D tests/test=
-crypto-pbkdf$(EXESUF)
+check-unit-$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT)) +=3D tests/test-cry=
pto-pbkdf$(EXESUF)
 check-unit-y +=3D tests/test-crypto-ivgen$(EXESUF)
 check-unit-y +=3D tests/test-crypto-afsplit$(EXESUF)
 check-unit-y +=3D tests/test-crypto-xts$(EXESUF)
--=20
2.17.2
