Received: from eggs.gnu.org ([2001:4830:134:3::10]:55675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpZlV-0002YL-38
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpZlQ-0004IZ-QT
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:49:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpZlQ-0004IH-HK
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:49:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A758356D4
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 12:49:03 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Wed,  6 Sep 2017 20:49:00 +0800
Message-Id: <20170906124900.17354-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4] buildsys: Move crypto cflags/libs to per
 object variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch groups the crypto objects into a few .mo objects based on
functional submodules, and moves inclusion conditions to *-objs
variables, then moves the global cflags/libs to the *-cflags and *-libs
variables.

For init.o and cipher.o, which may or may not need the library flags
depending on config, adding flags and libs unconditionally doesn't hurt,
because if the library is not available, the variables are empty.  This
makes less code.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v4: Merge into one patch which is supposedly easier to manage and
review, and use .mo appraoch to avoid $(foreach) and $(eval) magics.
Fixes the gcrypt patch typo in v3 while doing this.
---
 configure              | 15 +++++-------
 crypto/Makefile.objs   | 66 ++++++++++++++++++++++++++++++++++++--------------
 tests/Makefile.include | 10 ++++----
 3 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/configure b/configure
index fb7e34a901..b37cd54bda 100755
--- a/configure
+++ b/configure
@@ -2472,9 +2472,6 @@ if test "$gnutls" != "no"; then
     if gnutls_works; then
         gnutls_cflags=$($pkg_config --cflags gnutls)
         gnutls_libs=$($pkg_config --libs gnutls)
-        libs_softmmu="$gnutls_libs $libs_softmmu"
-        libs_tools="$gnutls_libs $libs_tools"
-	QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
         gnutls="yes"
 
 	# gnutls_rnd requires >= 2.11.0
@@ -2568,9 +2565,6 @@ if test "$gcrypt" != "no"; then
         then
             gcrypt_libs="$gcrypt_libs -lgpg-error"
         fi
-        libs_softmmu="$gcrypt_libs $libs_softmmu"
-        libs_tools="$gcrypt_libs $libs_tools"
-        QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
         gcrypt="yes"
         if test -z "$nettle"; then
            nettle="no"
@@ -2616,9 +2610,6 @@ if test "$nettle" != "no"; then
         nettle_cflags=$($pkg_config --cflags nettle)
         nettle_libs=$($pkg_config --libs nettle)
         nettle_version=$($pkg_config --modversion nettle)
-        libs_softmmu="$nettle_libs $libs_softmmu"
-        libs_tools="$nettle_libs $libs_tools"
-        QEMU_CFLAGS="$QEMU_CFLAGS $nettle_cflags"
         nettle="yes"
 
         cat > $TMPC << EOF
@@ -5713,12 +5704,16 @@ fi
 echo "CONFIG_TLS_PRIORITY=\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" = "yes" ; then
   echo "CONFIG_GNUTLS=y" >> $config_host_mak
+  echo "GNUTLS_CFLAGS=$gnutls_cflags" >> $config_host_mak
+  echo "GNUTLS_LIBS=$gnutls_libs" >> $config_host_mak
 fi
 if test "$gnutls_rnd" = "yes" ; then
   echo "CONFIG_GNUTLS_RND=y" >> $config_host_mak
 fi
 if test "$gcrypt" = "yes" ; then
   echo "CONFIG_GCRYPT=y" >> $config_host_mak
+  echo "GCRYPT_CFLAGS=$gcrypt_cflags" >> $config_host_mak
+  echo "GCRYPT_LIBS=$gcrypt_libs" >> $config_host_mak
   if test "$gcrypt_hmac" = "yes" ; then
     echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
   fi
@@ -5732,6 +5727,8 @@ if test "$nettle" = "yes" ; then
   if test "$nettle_kdf" = "yes" ; then
     echo "CONFIG_NETTLE_KDF=y" >> $config_host_mak
   fi
+  echo "NETTLE_CFLAGS=$nettle_cflags" >> $config_host_mak
+  echo "NETTLE_LIBS=$nettle_libs" >> $config_host_mak
 fi
 if test "$tasn1" = "yes" ; then
   echo "CONFIG_TASN1=y" >> $config_host_mak
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 2b99e08062..a3ff1417c7 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -1,29 +1,53 @@
 crypto-obj-y = init.o
-crypto-obj-y += hash.o
-crypto-obj-$(CONFIG_NETTLE) += hash-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
-crypto-obj-y += hmac.o
-crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
-crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
+crypto-obj-y += hash.mo
+
+hash.mo-objs := hash.o \
+	$(if $(CONFIG_NETTLE), \
+		hash-nettle.o, \
+		$(if $(CONFIG_GCRYPT), hash-gcrypt.o, hash-glib.o))
+hash.mo-cflags := $(NETTLE_CFLAGS) $(GCRYPT_CFLAGS)
+hash.mo-libs := $(NETTLE_LIBS) $(GCRYPT_LIBS)
+
+crypto-obj-y += hmac.mo
+hmac.mo-objs := hmac.o \
+	$(if $(CONFIG_NETTLE), \
+		hmac-nettle.o, \
+		$(if $(CONFIG_GCRYPT_HMAC), hmac-gcrypt.o, hmac-glib.o))
+hmac.mo-cflags := $(NETTLE_CFLAGS) $(GCRYPT_CFLAGS)
+hmac.mo-libs := $(NETTLE_LIBS) $(GCRYPT_LIBS)
+
 crypto-obj-y += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
-crypto-obj-y += tlscreds.o
-crypto-obj-y += tlscredsanon.o
-crypto-obj-y += tlscredsx509.o
-crypto-obj-y += tlssession.o
+
+crypto-obj-y += tls.mo
+tls.mo-objs := \
+	tlscreds.o \
+	tlscredsanon.o \
+	tlscredsx509.o \
+	tlssession.o
+tls.mo-cflags := $(GNUTLS_CFLAGS)
+tls.mo-libs := $(GNUTLS_LIBS)
+
 crypto-obj-y += secret.o
-crypto-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS_RND)) += random-gnutls.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS_RND),n,y)) += random-platform.o
-crypto-obj-y += pbkdf.o
-crypto-obj-$(CONFIG_NETTLE_KDF) += pbkdf-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE_KDF),n,$(CONFIG_GCRYPT_KDF)) += pbkdf-gcrypt.o
+
+crypto-obj-y += random.mo
+random.mo-objs := \
+	$(if $(CONFIG_GCRYPT), random-gcrypt.o, \
+		$(if $(CONFIG_GNUTLS_RND), random-gnutls.o, random-platform.o))
+random.mo-cflags := $(GNUTLS_CFLAGS) $(GCRYPT_CFLAGS)
+random.mo-libs := $(GNUTLS_LIBS) $(GCRYPT_LIBS)
+
+crypto-obj-y += pbkdf.mo
+pbkdf.mo-objs := pbkdf.o \
+	$(if $(CONFIG_NETTLE_KDF), pbkdf-nettle.o, \
+		$(if $(CONFIG_GCRYPT_KDF), pbkdf-gcrypt.o))
+pbkdf.mo-cflags := $(NETTLE_CFLAGS) $(GCRYPT_CFLAGS)
+pbkdf.mo-libs := $(NETTLE_LIBS) $(GCRYPT_LIBS)
+
 crypto-obj-y += ivgen.o
 crypto-obj-y += ivgen-essiv.o
 crypto-obj-y += ivgen-plain.o
@@ -34,6 +58,12 @@ crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
 
+init.o-cflags := $(GNUTLS_CFLAGS) $(GCRYPT_CFLAGS)
+init.o-libs := $(GNUTLS_LIBS) $(GCRYPT_LIBS)
+
+cipher.o-cflags := $(NETTLE_CFLAGS) $(GCRYPT_CFLAGS)
+cipher.o-libs := $(NETTLE_LIBS) $(GCRYPT_LIBS)
+
 # Let the userspace emulators avoid linking gnutls/etc
 crypto-aes-obj-y = aes.o
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..d46c22d1ec 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -677,15 +677,15 @@ tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-c
 tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
 tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
 
-tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
-tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS)
-tests/pkix_asn1_tab.o-cflags := $(TASN1_CFLAGS)
+tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS) $(GNUTLS_CFLAGS)
+tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS) $(GNUTLS_LIBS)
+tests/pkix_asn1_tab.o-cflags := $(TASN1_CFLAGS) $(GNUTLS_LIBS)
 
-tests/test-crypto-tlscredsx509.o-cflags := $(TASN1_CFLAGS)
+tests/test-crypto-tlscredsx509.o-cflags := $(TASN1_CFLAGS) $(GNUTLS_CFLAGS)
 tests/test-crypto-tlscredsx509$(EXESUF): tests/test-crypto-tlscredsx509.o \
 	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y)
 
-tests/test-crypto-tlssession.o-cflags := $(TASN1_CFLAGS)
+tests/test-crypto-tlssession.o-cflags := $(TASN1_CFLAGS) $(GNUTLS_CFLAGS)
 tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
 	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
-- 
2.13.5
