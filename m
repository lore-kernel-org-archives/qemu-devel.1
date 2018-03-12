Received: from eggs.gnu.org ([2001:4830:134:3::10]:53163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR99-0008OS-F1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR98-0007no-FB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR98-0007nD-Af
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E85384040856
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:22:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:15 +0000
Message-Id: <20180312172124.56461-21-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 20/29] postcopy: postcopy_notify_shared_wake
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

Add a hook to allow a client userfaultfd to be 'woken'
when a page arrives, and a walker that calls that
hook for relevant clients given a RAMBlock and offset.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/postcopy-ram.c | 16 ++++++++++++++++
 migration/postcopy-ram.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index d3e7f10c5a..585db9467a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -827,6 +827,22 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, voi=
d *host_addr,
     return ret;
 }
=20
+int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset)
+{
+    int i;
+    MigrationIncomingState *mis =3D migration_incoming_get_current();
+    GArray *pcrfds =3D mis->postcopy_remote_fds;
+
+    for (i =3D 0; i < pcrfds->len; i++) {
+        struct PostCopyFD *cur =3D &g_array_index(pcrfds, struct PostCop=
yFD, i);
+        int ret =3D cur->waker(cur, rb, offset);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 /*
  * Place a host page (from) at (host) atomically
  * returns 0 on success
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index fcd53b8295..2c73d77a5c 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -148,6 +148,10 @@ struct PostCopyFD;
=20
 /* ufd is a pointer to the struct uffd_msg *TODO: more Portable! */
 typedef int (*pcfdhandler)(struct PostCopyFD *pcfd, void *ufd);
+/* Notification to wake, either on place or on reception of
+ * a fault on something that's already arrived (race)
+ */
+typedef int (*pcfdwake)(struct PostCopyFD *pcfd, RAMBlock *rb, uint64_t =
offset);
=20
 struct PostCopyFD {
     int fd;
@@ -155,6 +159,8 @@ struct PostCopyFD {
     void *data;
     /* Handler to be called whenever we get a poll event */
     pcfdhandler handler;
+    /* Notification to wake shared client */
+    pcfdwake waker;
     /* A string to use in error messages */
     const char *idstr;
 };
@@ -164,6 +170,10 @@ struct PostCopyFD {
  */
 void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
 void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
+/* Call each of the shared 'waker's registerd telling them of
+ * availability of a block.
+ */
+int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset);
 /* postcopy_wake_shared: Notify a client ufd that a page is available
  *
  * Returns 0 on success
--=20
2.14.3
