Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyJ-0003kS-BU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyH-0002Lk-EH
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:47837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyH-0002LH-7k
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:29 -0400
Received: by mail-wm0-x241.google.com with SMTP id t69so10986885wmt.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:29 -0700 (PDT)
Received: from 640k.lan (94-39-155-245.adsl-ull.clienti.tiscali.it.
	[94.39.155.245])
	by smtp.gmail.com with ESMTPSA id 69sm13436794wmm.2.2017.10.18.09.13.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Oct 2017 09:13:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:17 +0200
Message-Id: <1508343141-31835-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/29] qemu-pr-helper: use new libmultipath API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

libmultipath has recently changed its API.  The new API supports multi-threaded
clients better.  Unfortunately there is no backwards-compatibility, so we just
switch to the new one.  Running QEMU compiled with the new library on the old
library will likely crash, while doing the opposite will cause QEMU not to
start at all (because udev, get_multipath_config and put_multipath_config
are undefined).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             | 12 ++++++++++--
 scsi/qemu-pr-helper.c | 17 ++++++++++++++---
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 6587e80..7766e74 100755
--- a/configure
+++ b/configure
@@ -3312,9 +3312,17 @@ if test "$mpath" != "no" ; then
 #include <mpath_persist.h>
 unsigned mpath_mx_alloc_len = 1024;
 int logsink;
+static struct config *multipath_conf;
+extern struct udev *udev;
+extern struct config *get_multipath_config(void);
+extern void put_multipath_config(struct config *conf);
+struct udev *udev;
+struct config *get_multipath_config(void) { return multipath_conf; }
+void put_multipath_config(struct config *conf) { }
+
 int main(void) {
-    struct udev *udev = udev_new();
-    mpath_lib_init(udev);
+    udev = udev_new();
+    multipath_conf = mpath_lib_init();
     return 0;
 }
 EOF
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index d581848..dd97851 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -276,15 +276,26 @@ static void dm_init(void)
 
 /* Variables required by libmultipath and libmpathpersist.  */
 QEMU_BUILD_BUG_ON(PR_HELPER_DATA_SIZE > MPATH_MAX_PARAM_LEN);
+static struct config *multipath_conf;
 unsigned mpath_mx_alloc_len = PR_HELPER_DATA_SIZE;
 int logsink;
+struct udev *udev;
 
-static void multipath_pr_init(void)
+extern struct config *get_multipath_config(void);
+struct config *get_multipath_config(void)
 {
-    static struct udev *udev;
+    return multipath_conf;
+}
 
+extern void put_multipath_config(struct config *conf);
+void put_multipath_config(struct config *conf)
+{
+}
+
+static void multipath_pr_init(void)
+{
     udev = udev_new();
-    mpath_lib_init(udev);
+    multipath_conf = mpath_lib_init();
 }
 
 static int is_mpath(int fd)
-- 
1.8.3.1
