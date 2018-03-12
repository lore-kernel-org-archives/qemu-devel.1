Received: from eggs.gnu.org ([2001:4830:134:3::10]:53291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR9L-000095-US
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR9K-0007vR-95
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR9K-0007v5-4C
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9C98406E97D
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:22:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:23 +0000
Message-Id: <20180312172124.56461-29-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 28/29] libvhost-user: Claim support for
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Tell QEMU we understand the protocol features needed for postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 33 +++++++++++++++++++++++++++++=
++++
 1 file changed, 33 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 504ff5ea59..beeed0c43f 100644
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
2.14.3
