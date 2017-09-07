Received: from eggs.gnu.org ([2001:4830:134:3::10]:46440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsYy-0005e3-Fh
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsYt-0005ye-W5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsYt-0005y6-Q7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1FCCC04B32C
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:53:22 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:53:16 +0800
Message-Id: <20170907085316.8861-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] buildsys: Move seccomp cflags/libs to per
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
Cc: Eduardo Otubo <otubo@redhat.com>

Like many other libraries, libseccomp cflags and libs should only apply
to the building of necessary objects. Do so in the usual way with the
help of per object variables.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
index fb7e34a901..fb81a0189b 100755
--- a/configure
+++ b/configure
@@ -2052,8 +2052,8 @@ if test "$seccomp" != "no" ; then
 
     if test "$libseccomp_minver" != "" &&
        $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
-        libs_softmmu="$libs_softmmu $($pkg_config --libs libseccomp)"
-        QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags libseccomp)"
+        seccomp_cflags="$($pkg_config --cflags libseccomp)"
+        seccomp_libs="$($pkg_config --libs libseccomp)"
         seccomp="yes"
     else
         if test "$seccomp" = "yes" ; then
@@ -5875,6 +5875,8 @@ fi
 
 if test "$seccomp" = "yes"; then
   echo "CONFIG_SECCOMP=y" >> $config_host_mak
+  echo "SECCOMP_CFLAGS=$seccomp_cflags" >> $config_host_mak
+  echo "SECCOMP_LIBS=$seccomp_libs" >> $config_host_mak
 fi
 
 # XXX: suppress that
-- 
2.13.5
