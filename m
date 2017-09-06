Received: from eggs.gnu.org ([2001:4830:134:3::10]:36214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpP7j-0003lB-PA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpP7h-00084J-PW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpP7h-000840-J6
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 21:27:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A52CA751
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 01:27:20 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Wed,  6 Sep 2017 09:27:13 +0800
Message-Id: <20170906012715.31761-2-famz@redhat.com>
In-Reply-To: <20170906012715.31761-1-famz@redhat.com>
References: <20170906012715.31761-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] buildsys: Move nettle cflags/libs to
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
 configure            | 5 ++---
 crypto/Makefile.objs | 6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index fb7e34a901..6a4cb3832b 100755
--- a/configure
+++ b/configure
@@ -2616,9 +2616,6 @@ if test "$nettle" != "no"; then
         nettle_cflags=$($pkg_config --cflags nettle)
         nettle_libs=$($pkg_config --libs nettle)
         nettle_version=$($pkg_config --modversion nettle)
-        libs_softmmu="$nettle_libs $libs_softmmu"
-        libs_tools="$nettle_libs $libs_tools"
-        QEMU_CFLAGS="$QEMU_CFLAGS $nettle_cflags"
         nettle="yes"
 
         cat > $TMPC << EOF
@@ -5732,6 +5729,8 @@ if test "$nettle" = "yes" ; then
   if test "$nettle_kdf" = "yes" ; then
     echo "CONFIG_NETTLE_KDF=y" >> $config_host_mak
   fi
+  echo "NETTLE_CFLAGS=$nettle_cflags" >> $config_host_mak
+  echo "NETTLE_LIBS=$nettle_libs" >> $config_host_mak
 fi
 if test "$tasn1" = "yes" ; then
   echo "CONFIG_TASN1=y" >> $config_host_mak
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 2b99e08062..a936957d03 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -34,6 +34,12 @@ crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
 
+$(if $(CONFIG_NETTLE), \
+	$(foreach x, cipher hash-nettle hmac-nettle pbkdf-nettle, \
+		$(eval $x.o-cflags := $(NETTLE_CFLAGS)) \
+		$(eval $x.o-libs := $(NETTLE_LIBS))) \
+)
+
 # Let the userspace emulators avoid linking gnutls/etc
 crypto-aes-obj-y = aes.o
 
-- 
2.13.5
