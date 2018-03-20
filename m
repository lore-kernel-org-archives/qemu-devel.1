Received: from eggs.gnu.org ([2001:4830:134:3::10]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyIss-0008Rm-5H
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyIsn-0003cu-TA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:09:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyIsn-0003cB-Mp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFB05406DE12
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 15:09:00 +0000 (UTC)
Date: Tue, 20 Mar 2018 17:09:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521558531-69828-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] postcopy: drop unnecessary conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We have our own copy of unistd so there is no
need to check for symbols present there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/postcopy-ram.c | 4 +---
 tests/migration-test.c   | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index efd7793..027c02c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -86,7 +86,7 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
 #include <asm/types.h> /* for __u64 */
 #endif
 
-#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+#if defined(__linux__) && defined(CONFIG_EVENTFD)
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
@@ -97,7 +97,6 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
  *
  * Returns: true on success
  *
- * __NR_userfaultfd - should be checked before
  *  @features: out parameter will contain uffdio_api.features provided by kernel
  *              in case of success
  */
@@ -107,7 +106,6 @@ static bool receive_ufd_features(uint64_t *features)
     int ufd;
     bool ret = true;
 
-    /* if we are here __NR_userfaultfd should exists */
     ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
     if (ufd == -1) {
         error_report("%s: syscall __NR_userfaultfd failed: %s", __func__,
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 422bf1a..e5dcedb 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -32,7 +32,7 @@ bool got_stop;
 #include <sys/vfs.h>
 #endif
 
-#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+#if defined(__linux__) && defined(CONFIG_EVENTFD)
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 #include <linux/userfaultfd.h>
-- 
MST
