Received: from eggs.gnu.org ([2001:4830:134:3::10]:53554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFE-00064j-Ed
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFB-0007pI-AA
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:12 -0400
Received: from mifritscher.de ([188.40.170.105]:33038
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtFB-0007of-1U
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:09 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:23 +0200
Message-Id: <20170929111323.6308-19-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 18/18] Enable 9pfs for Windows in configure /
 makefiles
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 Makefile.objs         |  1 +
 configure             | 23 +++++++++++++++++------
 hw/9pfs/Makefile.objs | 11 +++++++----
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index bdfa3b6177..1ab197f48c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -47,6 +47,7 @@ common-obj-$(CONFIG_WIN32) += os-win32.o
 common-obj-$(CONFIG_POSIX) += os-posix.o
 
 common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_WIN32) += fsdev/
 
 common-obj-y += migration/
 
diff --git a/configure b/configure
index 6587e8014b..74ca56c060 100755
--- a/configure
+++ b/configure
@@ -5067,13 +5067,22 @@ if test "$want_tools" = "yes" ; then
   fi
 fi
 if test "$softmmu" = yes ; then
-  if test "$linux" = yes; then
-    if test "$virtfs" != no && test "$cap" = yes && test "$attr" = yes ; then
+  if test "$virtfs" != no ; then
+    if test "$linux" = yes; then
+      if test "$cap" = yes && test "$attr" = yes ; then
+        virtfs=yes
+        tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
+      else
+        if test "$virtfs" = yes; then
+          error_exit "VirtFS requires libcap devel and libattr devel on Linux"
+        fi
+        virtfs=no
+      fi
+    elif test "$mingw32" = yes; then
       virtfs=yes
-      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" = yes; then
-        error_exit "VirtFS requires libcap devel and libattr devel"
+        error_exit "VirtFS is only supported on Linux or Windows"
       fi
       virtfs=no
     fi
@@ -5085,10 +5094,12 @@ if test "$softmmu" = yes ; then
       fi
       mpath=no
     fi
-    tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
+    if test "$linux" = yes; then
+      tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
+    fi
   else
     if test "$virtfs" = yes; then
-      error_exit "VirtFS is supported only on Linux"
+      error_exit "VirtFS is supported only on Linux or Windows"
     fi
     virtfs=no
     if test "$mpath" = yes; then
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index fd90b62900..d11100857d 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -1,10 +1,13 @@
-common-obj-y  = 9p.o 9p-util.o
-common-obj-y += 9p-local.o 9p-xattr.o
-common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
+common-obj-y  = 9p.o
+common-obj-$(CONFIG_LINUX) += 9p-util.o
+common-obj-$(CONFIG_LINUX) += 9p-local.o 9p-xattr.o
+common-obj-$(CONFIG_LINUX) += 9p-xattr-user.o 9p-posix-acl.o
+common-obj-$(CONFIG_WIN32) += 9p-util.o
+common-obj-$(CONFIG_WIN32) += 9p-local.o
 common-obj-y += coth.o cofs.o codir.o cofile.o
 common-obj-y += coxattr.o 9p-synth.o
 common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
-common-obj-y += 9p-proxy.o
+common-obj-$(CONFIG_POSIX) += 9p-proxy.o
 common-obj-$(CONFIG_XEN) += xen-9p-backend.o
 
 obj-$(CONFIG_VIRTIO) += virtio-9p-device.o
-- 
2.13.2.windows.1
