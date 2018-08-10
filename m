Received: from eggs.gnu.org ([2001:4830:134:3::10]:40586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fo88v-0007iJ-0x
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fo88r-00072P-Rh
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:11:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48540
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fo88r-00070G-Lf
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:11:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7AE9IIp113988
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:11:47 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ksbyvrs0f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:11:47 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Fri, 10 Aug 2018 08:11:46 -0600
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date: Fri, 10 Aug 2018 11:11:16 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20180810141116.24016-1-muriloo@linux.ibm.com>
Subject: [Qemu-devel] [PATH] Fix build on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

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
---
 configure             | 24 +++++++++++++++++++++++-
 scsi/qemu-pr-helper.c |  4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2a7796ea80..bc6000c24a 100755
--- a/configure
+++ b/configure
@@ -3558,6 +3558,7 @@ fi
 # libmpathpersist probe
 
 if test "$mpath" != "no" ; then
+  # probe for the new API
   cat > $TMPC <<EOF
 #include <libudev.h>
 #include <mpath_persist.h>
@@ -3579,8 +3580,26 @@ int main(void) {
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
@@ -6421,6 +6440,9 @@ if test "$virtfs" = "yes" ; then
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
index 1528a712a0..ed037aabee 100644
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
2.17.1
