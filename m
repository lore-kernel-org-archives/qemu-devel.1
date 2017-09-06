Received: from eggs.gnu.org ([2001:4830:134:3::10]:36230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpP7k-0003lF-Lf
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpP7j-00084u-MI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpP7j-00084b-Dz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EF1F5AFD9
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 01:27:22 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Wed,  6 Sep 2017 09:27:14 +0800
Message-Id: <20170906012715.31761-3-famz@redhat.com>
In-Reply-To: <20170906012715.31761-1-famz@redhat.com>
References: <20170906012715.31761-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] buildsys: Move gnutls cflags/libs to
 per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure              |  4 ++--
 crypto/Makefile.objs   |  7 +++++++
 tests/Makefile.include | 10 +++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 6a4cb3832b..d24a7eab37 100755
--- a/configure
+++ b/configure
@@ -2472,8 +2472,6 @@ if test "$gnutls" != "no"; then
     if gnutls_works; then
         gnutls_cflags=$($pkg_config --cflags gnutls)
         gnutls_libs=$($pkg_config --libs gnutls)
-        libs_softmmu="$gnutls_libs $libs_softmmu"
-        libs_tools="$gnutls_libs $libs_tools"
 	QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
         gnutls="yes"
 
@@ -5710,6 +5708,8 @@ fi
 echo "CONFIG_TLS_PRIORITY=\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" = "yes" ; then
   echo "CONFIG_GNUTLS=y" >> $config_host_mak
+  echo "GNUTLS_CFLAGS=$gnutls_cflags" >> $config_host_mak
+  echo "GNUTLS_LIBS=$gnutls_libs" >> $config_host_mak
 fi
 if test "$gnutls_rnd" = "yes" ; then
   echo "CONFIG_GNUTLS_RND=y" >> $config_host_mak
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index a936957d03..0cb5fa24b6 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -40,6 +40,13 @@ $(if $(CONFIG_NETTLE), \
 		$(eval $x.o-libs := $(NETTLE_LIBS))) \
 )
 
+$(if $(CONFIG_GNUTLS), \
+	$(foreach x, init random-gnutls tlscreds tlscredsanon \
+			tlscredsx509 tlssession, \
+		$(eval $x.o-cflags := $(GNUTLS_CFLAGS)) \
+		$(eval $x.o-libs := $(GNUTLS_LIBS))) \
+)
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
