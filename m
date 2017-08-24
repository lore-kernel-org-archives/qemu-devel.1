Received: from eggs.gnu.org ([2001:4830:134:3::10]:52351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxo2-0002Wc-8x
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnz-0004ps-54
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxny-0004p3-VB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:39 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:11 +0100
Message-Id: <20170824192730.8440-14-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 13/32] vhost+postcopy: Register shared ufd
 with postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Register the UFD that comes in as the response to the 'advise' method
with the postcopy code.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user.c   | 21 ++++++++++++++++++++-
 migration/postcopy-ram.h |  2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7063e4df61..b7898f8939 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -24,6 +24,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <linux/vhost.h>
+#include <linux/userfaultfd.h>
 
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
@@ -130,6 +131,7 @@ struct vhost_user {
     CharBackend *chr;
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
+    struct PostCopyFD  postcopy_fd;
 };
 
 static bool ioeventfd_enabled(void)
@@ -726,6 +728,17 @@ out:
 }
 
 /*
+ * Called back from the postcopy fault thread when a fault is received on our
+ * ufd.
+ * TODO: This is Linux specific
+ */
+static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
+                                             void *ufd)
+{
+    return 0;
+}
+
+/*
  * Called at the start of an inbound postcopy on reception of the
  * 'advise' command.
  */
@@ -764,8 +777,14 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
         error_setg(errp, "%s: Failed to get ufd", __func__);
         return -1;
     }
+    fcntl(ufd, F_SETFL, O_NONBLOCK);
 
-    /* TODO: register ufd with userfault thread */
+    /* register ufd with userfault thread */
+    u->postcopy_fd.fd = ufd;
+    u->postcopy_fd.data = dev;
+    u->postcopy_fd.handler = vhost_user_postcopy_fault_handler;
+    u->postcopy_fd.idstr = "vhost-user"; /* Need to find unique name */
+    postcopy_register_shared_ufd(&u->postcopy_fd);
     return 0;
 }
 
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ba8a8ffec5..28c216cc7a 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -153,7 +153,7 @@ struct PostCopyFD {
     /* Handler to be called whenever we get a poll event */
     pcfdhandler handler;
     /* A string to use in error messages */
-    char *idstr;
+    const char *idstr;
 };
 
 /* Register a userfaultfd owned by an external process for
-- 
2.13.5
