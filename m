Received: from eggs.gnu.org ([2001:4830:134:3::10]:52965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpG-0003ix-Od
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpF-0005f5-QE
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxpF-0005es-Ju
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:57 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:27 +0100
Message-Id: <20170824192730.8440-30-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 29/32] vhost-user: Claim support for postcopy
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

Tell QEMU we understand the protocol features needed for postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 23bff47649..290748733b 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -144,6 +144,35 @@ vmsg_close_fds(VhostUserMsg *vmsg)
     }
 }
 
+/* A test to see if we have userfault available */
+static bool
+have_userfault(void)
+{
+#if defined(__linux__) && defined(__NR_userfaultfd) &&\
+        defined(UFFD_FEATURE_MISSING_SHMEM) &&\
+        defined(UFFD_FEATURE_MISSING_HUGETLBFS)
+    /* Now test the kernel we're running on really has the features */
+    int ufd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+    struct uffdio_api api_struct;
+    if (ufd < 0) {
+        return false;
+    }
+
+    api_struct.api = UFFD_API;
+    api_struct.features = UFFD_FEATURE_MISSING_SHMEM |
+                          UFFD_FEATURE_MISSING_HUGETLBFS;
+    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
+        close(ufd);
+        return false;
+    }
+    close(ufd);
+    return true;
+
+#else
+    return false;
+#endif
+}
+
 static bool
 vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
@@ -796,6 +825,10 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
 
+    if (have_userfault()) {
+        features |= 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
+    }
+
     if (dev->iface->get_protocol_features) {
         features |= dev->iface->get_protocol_features(dev);
     }
-- 
2.13.5
