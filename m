Received: from eggs.gnu.org ([2001:4830:134:3::10]:60894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001As-9u
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3m-0005cB-Rf
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:40652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3l-0005Sv-SO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:14 -0400
Received: by mail-wm0-x22f.google.com with SMTP id y9-v6so3496323wma.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:38 +0200
Message-Id: <1534870966-9287-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/74] qemu-pr-helper: Fix build on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

After commit b3f1c8c413bc83e4a2cc7a63e4eddf9fe6449052 "qemu-pr-helper: use new
libmultipath API", QEMU started using new libmultipath API, which is not
available on CentOS 7.x.

This fixes that by probing the new libmultipath API in configure.  If it fails,
then try probing the old API.  If it fails, then consider libmultipath not
available.

With this, configure script defines CONFIG_MPATH_NEW_API that is used in
scsi/qemu-pr-helper.c to use the new libmultipath API.

Fixes: b3f1c8c413bc83e4a2cc7a63e4eddf9fe6449052
BugLink: https://bugs.launchpad.net/qemu/+bug/1786343
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Message-Id: <20180810141116.24016-1-muriloo@linux.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             | 24 +++++++++++++++++++++++-
 scsi/qemu-pr-helper.c |  4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index e7bddc0..af0c149 100755
--- a/configure
+++ b/configure
@@ -3612,6 +3612,7 @@ fi
 # libmpathpersist probe
 
 if test "$mpath" != "no" ; then
+  # probe for the new API
   cat > $TMPC <<EOF
 #include <libudev.h>
 #include <mpath_persist.h>
@@ -3633,8 +3634,26 @@ int main(void) {
 EOF
   if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
     mpathpersist=yes
+    mpathpersist_new_api=yes
   else
-    mpathpersist=no
+    # probe for the old API
+    cat > $TMPC <<EOF
+#include <libudev.h>
+#include <mpath_persist.h>
+unsigned mpath_mx_alloc_len = 1024;
+int logsink;
+int main(void) {
+    struct udev *udev = udev_new();
+    mpath_lib_init(udev);
+    return 0;
+}
+EOF
+    if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
+      mpathpersist=yes
+      mpathpersist_new_api=no
+    else
+      mpathpersist=no
+    fi
   fi
 else
   mpathpersist=no
@@ -6495,6 +6514,9 @@ if test "$virtfs" = "yes" ; then
 fi
 if test "$mpath" = "yes" ; then
   echo "CONFIG_MPATH=y" >> $config_host_mak
+  if test "$mpathpersist_new_api" = "yes"; then
+    echo "CONFIG_MPATH_NEW_API=y" >> $config_host_mak
+  fi
 fi
 if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 1528a71..ed037aa 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -301,7 +301,11 @@ void put_multipath_config(struct config *conf)
 static void multipath_pr_init(void)
 {
     udev = udev_new();
+#ifdef CONFIG_MPATH_NEW_API
     multipath_conf = mpath_lib_init();
+#else
+    mpath_lib_init(udev);
+#endif
 }
 
 static int is_mpath(int fd)
-- 
1.8.3.1
