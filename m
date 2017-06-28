Received: from eggs.gnu.org ([2001:4830:134:3::10]:40547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDu-0004n9-KZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDt-0008Fi-IX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIDt-0008FZ-9f
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:57 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:30 +0100
Message-Id: <20170628190047.26159-13-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 12/29] vhost+postcopy: Register shared ufd with
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Register the UFD that comes in as the response to the 'advise' method
with the postcopy code.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user.c   | 23 ++++++++++++++++++++++-
 migration/postcopy-ram.h |  2 +-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ee9a1ac8a3..b98fbe4834 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -24,6 +24,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <linux/vhost.h>
+#include <linux/userfaultfd.h>
 
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
@@ -128,6 +129,7 @@ struct vhost_user {
     CharBackend *chr;
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
+    struct PostCopyFD  postcopy_fd;
 };
 
 static bool ioeventfd_enabled(void)
@@ -707,6 +709,19 @@ out:
 }
 
 /*
+ * Called back from the postcopy fault thread when a fault is received on our
+ * ufd.
+ * TODO: This is Linux specific
+ */
+static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
+                                             void *ufd)
+{
+    struct uffd_msg *msg = ufd;
+
+    return 0;
+}
+
+/*
  * Called at the start of an inbound postcopy on reception of the
  * 'advise' command.
  */
@@ -745,8 +760,14 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
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
2.13.0
