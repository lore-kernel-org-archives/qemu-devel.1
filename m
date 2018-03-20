Received: from eggs.gnu.org ([2001:4830:134:3::10]:51348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mo-00076Z-MM
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mk-0008Qe-1O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mj-0008QV-SZ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:01 -0400
Date: Tue, 20 Mar 2018 05:18:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-50-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 49/50] libvhost-user: Claim support for
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Tell QEMU we understand the protocol features needed for postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 33 +++++++++++++++++++++++++++++=
++++
 1 file changed, 33 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 504ff5e..beeed0c 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -185,6 +185,35 @@ vmsg_close_fds(VhostUserMsg *vmsg)
     }
 }
=20
+/* A test to see if we have userfault available */
+static bool
+have_userfault(void)
+{
+#if defined(__linux__) && defined(__NR_userfaultfd) &&\
+        defined(UFFD_FEATURE_MISSING_SHMEM) &&\
+        defined(UFFD_FEATURE_MISSING_HUGETLBFS)
+    /* Now test the kernel we're running on really has the features */
+    int ufd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+    struct uffdio_api api_struct;
+    if (ufd < 0) {
+        return false;
+    }
+
+    api_struct.api =3D UFFD_API;
+    api_struct.features =3D UFFD_FEATURE_MISSING_SHMEM |
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
@@ -939,6 +968,10 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserM=
sg *vmsg)
     uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ;
=20
+    if (have_userfault()) {
+        features |=3D 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
+    }
+
     if (dev->iface->get_protocol_features) {
         features |=3D dev->iface->get_protocol_features(dev);
     }
--=20
MST
