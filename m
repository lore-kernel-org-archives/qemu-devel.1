Received: from eggs.gnu.org ([2001:4830:134:3::10]:51910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfsp-0001aD-W8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emfso-00061h-Vd
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emfso-00061E-QM
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 761CB4027CDF
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:16:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 13:16:16 +0000
Message-Id: <20180216131625.9639-21-dgilbert@redhat.com>
In-Reply-To: <20180216131625.9639-1-dgilbert@redhat.com>
References: <20180216131625.9639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 20/29] postcopy: postcopy_notify_shared_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, imammedo@redhat.com, mst@redhat.com
Cc: quintela@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a hook to allow a client userfaultfd to be 'woken'
when a page arrives, and a walker that calls that
hook for relevant clients given a RAMBlock and offset.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 16 ++++++++++++++++
 migration/postcopy-ram.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 67deae7e1c..879711968c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -824,6 +824,22 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
     return ret;
 }
 
+int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset)
+{
+    int i;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    GArray *pcrfds = mis->postcopy_remote_fds;
+
+    for (i = 0; i < pcrfds->len; i++) {
+        struct PostCopyFD *cur = &g_array_index(pcrfds, struct PostCopyFD, i);
+        int ret = cur->waker(cur, rb, offset);
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
index 2e3dd844d5..2b71cf958e 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -146,6 +146,10 @@ struct PostCopyFD;
 
 /* ufd is a pointer to the struct uffd_msg *TODO: more Portable! */
 typedef int (*pcfdhandler)(struct PostCopyFD *pcfd, void *ufd);
+/* Notification to wake, either on place or on reception of
+ * a fault on something that's already arrived (race)
+ */
+typedef int (*pcfdwake)(struct PostCopyFD *pcfd, RAMBlock *rb, uint64_t offset);
 
 struct PostCopyFD {
     int fd;
@@ -153,6 +157,8 @@ struct PostCopyFD {
     void *data;
     /* Handler to be called whenever we get a poll event */
     pcfdhandler handler;
+    /* Notification to wake shared client */
+    pcfdwake waker;
     /* A string to use in error messages */
     const char *idstr;
 };
@@ -162,6 +168,10 @@ struct PostCopyFD {
  */
 void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
 void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
+/* Call each of the shared 'waker's registerd telling them of
+ * availability of a block.
+ */
+int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset);
 /* Notify a client ufd that a page is available
  * Note: The 'client_address' is in the address space of the client
  * program not QEMU
-- 
2.14.3
