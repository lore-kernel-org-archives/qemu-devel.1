Received: from eggs.gnu.org ([2001:4830:134:3::10]:42072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dPPV2-0001F1-4g
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dPPUz-0003Eg-0T
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:36:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dPPUy-0003ED-Nr
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:35:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OS5004JFBVT7H70@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:35:53 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Mon, 26 Jun 2017 11:35:19 +0300
Message-id: <1498466120-5836-3-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1498466120-5836-1-git-send-email-a.perevalov@samsung.com>
References: <1498466120-5836-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170626083552eucas1p24efde91b6a4544fb77927f3b93d83cdf@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v4 2/3] migration: introduce
 qemu_ufd_copy_ioctl helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

Just for placing auxilary operations inside helper,
auxilary operations like: track received pages,
notify about copying operation in futher patches.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index dae41b5..293db97 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -561,6 +561,25 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     return 0;
 }
 
+static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
+        void *from_addr, uint64_t pagesize)
+{
+    if (from_addr) {
+        struct uffdio_copy copy_struct;
+        copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
+        copy_struct.src = (uint64_t)(uintptr_t)from_addr;
+        copy_struct.len = pagesize;
+        copy_struct.mode = 0;
+        return ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
+    } else {
+        struct uffdio_zeropage zero_struct;
+        zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
+        zero_struct.range.len = pagesize;
+        zero_struct.mode = 0;
+        return ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
+    }
+}
+
 /*
  * Place a host page (from) at (host) atomically
  * returns 0 on success
@@ -568,20 +587,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
                         RAMBlock *rb)
 {
-    struct uffdio_copy copy_struct;
     size_t pagesize = qemu_ram_pagesize(rb);
 
-    copy_struct.dst = (uint64_t)(uintptr_t)host;
-    copy_struct.src = (uint64_t)(uintptr_t)from;
-    copy_struct.len = pagesize;
-    copy_struct.mode = 0;
-
     /* copy also acks to the kernel waking the stalled thread up
      * TODO: We can inhibit that ack and only do it if it was requested
      * which would be slightly cheaper, but we'd have to be careful
      * of the order of updating our page state.
      */
-    if (ioctl(mis->userfault_fd, UFFDIO_COPY, &copy_struct)) {
+    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize)) {
         int e = errno;
         error_report("%s: %s copy host: %p from: %p (size: %zd)",
                      __func__, strerror(e), host, from, pagesize);
@@ -603,12 +616,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
     trace_postcopy_place_page_zero(host);
 
     if (qemu_ram_pagesize(rb) == getpagesize()) {
-        struct uffdio_zeropage zero_struct;
-        zero_struct.range.start = (uint64_t)(uintptr_t)host;
-        zero_struct.range.len = getpagesize();
-        zero_struct.mode = 0;
-
-        if (ioctl(mis->userfault_fd, UFFDIO_ZEROPAGE, &zero_struct)) {
+        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpagesize())) {
             int e = errno;
             error_report("%s: %s zero host: %p",
                          __func__, strerror(e), host);
-- 
1.9.1
