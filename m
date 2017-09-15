Received: from eggs.gnu.org ([2001:4830:134:3::10]:38937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCd-0000d0-DR
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCc-0003Hj-AD
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dsmCc-0003HF-4Q
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:22 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 15 Sep 2017 10:41:39 +0200
Message-Id: <20170915084139.4481-7-otubo@redhat.com>
In-Reply-To: <20170915084139.4481-1-otubo@redhat.com>
References: <20170915084139.4481-1-otubo@redhat.com>
Subject: [Qemu-devel] [PULL 06/06] buildsys: Move seccomp cflags/libs to per
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Fam Zheng <famz@redhat.com>

Like many other libraries, libseccomp cflags and libs should only apply
to the building of necessary objects. Do so in the usual way with the
help of per object variables.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 Makefile.objs | 2 ++
 configure     | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 24a4ea08b8..d9cf7ad791 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -70,6 +70,8 @@ common-obj-y += backends/
 common-obj-y += chardev/
 
 common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
+qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
+qemu-seccomp.o-libs := $(SECCOMP_LIBS)
 
 common-obj-$(CONFIG_FDT) += device_tree.o
 
diff --git a/configure b/configure
index 9ee4559b54..94db2d103e 100755
--- a/configure
+++ b/configure
@@ -2035,8 +2035,8 @@ if test "$seccomp" != "no" ; then
 
     if test "$libseccomp_minver" != "" &&
        $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
-        libs_softmmu="$libs_softmmu $($pkg_config --libs libseccomp)"
-        QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags libseccomp)"
+        seccomp_cflags="$($pkg_config --cflags libseccomp)"
+        seccomp_libs="$($pkg_config --libs libseccomp)"
         seccomp="yes"
     else
         if test "$seccomp" = "yes" ; then
@@ -5829,6 +5829,8 @@ fi
 
 if test "$seccomp" = "yes"; then
   echo "CONFIG_SECCOMP=y" >> $config_host_mak
+  echo "SECCOMP_CFLAGS=$seccomp_cflags" >> $config_host_mak
+  echo "SECCOMP_LIBS=$seccomp_libs" >> $config_host_mak
 fi
 
 # XXX: suppress that
-- 
2.13.5
