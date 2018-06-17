Received: from eggs.gnu.org ([2001:4830:134:3::10]:56901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0b-0005nn-SA
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0Y-0003II-Vm
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:33 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:42874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0Y-0003ID-RL
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:30 -0400
Received: by mail-qk0-x235.google.com with SMTP id j80-v6so7659797qke.9
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:30 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:57 -0400
Message-Id: <6619399bfc7df3fdd4d2f5b78ed28b1e95fce1c9.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 13/13] 9p: darwin: configure: Allow VirtFS
 on Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 Makefile.objs |  1 +
 configure     | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 7a9828d..c968a9a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -104,6 +104,7 @@ common-obj-$(CONFIG_WIN32) += os-win32.o
 common-obj-$(CONFIG_POSIX) += os-posix.o
 
 common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_DARWIN) += fsdev/
 
 common-obj-y += migration/
 
diff --git a/configure b/configure
index 195c9bd..74f593a 100755
--- a/configure
+++ b/configure
@@ -5568,16 +5568,28 @@ if test "$want_tools" = "yes" ; then
   fi
 fi
 if test "$softmmu" = yes ; then
-  if test "$linux" = yes; then
-    if test "$virtfs" != no && test "$cap" = yes && test "$attr" = yes ; then
+  if test "$virtfs" != no; then
+    if test "$linux" = yes; then
+      if test "$cap" = yes && test "$attr" = yes ; then
+        virtfs=yes
+        tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
+      else
+        if test "$virtfs" = yes; then
+          error_exit "VirtFS requires libcap devel and libattr devel under Linux"
+        fi
+        virtfs=no
+      fi
+    elif test "$darwin" = yes; then
       virtfs=yes
       tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" = yes; then
-        error_exit "VirtFS requires libcap devel and libattr devel"
+        error_exit "VirtFS is supported only on Linux and Darwin"
       fi
       virtfs=no
     fi
+  fi
+  if test "$linux" = yes; then
     if test "$mpath" != no && test "$mpathpersist" = yes ; then
       mpath=yes
     else
@@ -5588,10 +5600,6 @@ if test "$softmmu" = yes ; then
     fi
     tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
   else
-    if test "$virtfs" = yes; then
-      error_exit "VirtFS is supported only on Linux"
-    fi
-    virtfs=no
     if test "$mpath" = yes; then
       error_exit "Multipath is supported only on Linux"
     fi
-- 
2.8.1
