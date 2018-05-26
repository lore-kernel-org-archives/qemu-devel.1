Received: from eggs.gnu.org ([2001:4830:134:3::10]:35842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgi-0006Tz-T2
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgf-0004ez-Rr
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:20 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:45077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgf-0004ed-Nk
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:17 -0400
Received: by mail-qk0-x235.google.com with SMTP id c198-v6so5676628qkg.12
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:17 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:15 -0400
Message-Id: <f7e1cd54774642aec19dd2c547a5e560050ab9cd.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 13/13] 9p: darwin: configure: Allow VirtFS on
 Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 Makefile.objs |  1 +
 configure     | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index c6c3554..a2245c9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -104,6 +104,7 @@ common-obj-$(CONFIG_WIN32) += os-win32.o
 common-obj-$(CONFIG_POSIX) += os-posix.o
 
 common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_DARWIN) += fsdev/
 
 common-obj-y += migration/
 
diff --git a/configure b/configure
index a8498ab..eb7328c 100755
--- a/configure
+++ b/configure
@@ -5535,16 +5535,27 @@ if test "$want_tools" = "yes" ; then
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
-      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
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
@@ -5555,10 +5566,6 @@ if test "$softmmu" = yes ; then
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
