Received: from eggs.gnu.org ([2001:4830:134:3::10]:45481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAN-00045N-Aq
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAL-0006Sm-Ve
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canAL-0006SW-ND
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D586C8EB54
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:33:04 +0000
Message-Id: <20170206173306.20603-15-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/16] postcopy: Update userfaultfd.h header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We use a new userfaultfd define, so update the header.
(Not needed if someone just runs the update script once it's
gone into the main kernel).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 linux-headers/linux/userfaultfd.h | 81 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 19e8453..a7c1a62 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -11,13 +11,19 @@
 
 #include <linux/types.h>
 
-#define UFFD_API ((__u64)0xAA)
 /*
- * After implementing the respective features it will become:
- * #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP | \
- *			      UFFD_FEATURE_EVENT_FORK)
+ * If the UFFDIO_API is upgraded someday, the UFFDIO_UNREGISTER and
+ * UFFDIO_WAKE ioctls should be defined as _IOW and not as _IOR.  In
+ * userfaultfd.h we assumed the kernel was reading (instead _IOC_READ
+ * means the userland is reading).
  */
-#define UFFD_API_FEATURES (0)
+#define UFFD_API ((__u64)0xAA)
+#define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
+			   UFFD_FEATURE_EVENT_FORK |		\
+			   UFFD_FEATURE_EVENT_REMAP |		\
+			   UFFD_FEATURE_EVENT_MADVDONTNEED |	\
+			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
+			   UFFD_FEATURE_MISSING_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -25,7 +31,11 @@
 #define UFFD_API_RANGE_IOCTLS			\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
-	 (__u64)1 << _UFFDIO_ZEROPAGE)
+	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT)
+#define UFFD_API_RANGE_IOCTLS_BASIC		\
+	((__u64)1 << _UFFDIO_WAKE |		\
+	 (__u64)1 << _UFFDIO_COPY)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -40,6 +50,7 @@
 #define _UFFDIO_WAKE			(0x02)
 #define _UFFDIO_COPY			(0x03)
 #define _UFFDIO_ZEROPAGE		(0x04)
+#define _UFFDIO_WRITEPROTECT		(0x05)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -56,6 +67,8 @@
 				      struct uffdio_copy)
 #define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
 				      struct uffdio_zeropage)
+#define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
+				      struct uffdio_writeprotect)
 
 /* read() structure */
 struct uffd_msg {
@@ -72,6 +85,21 @@ struct uffd_msg {
 		} pagefault;
 
 		struct {
+			__u32	ufd;
+		} fork;
+
+		struct {
+			__u64	from;
+			__u64	to;
+			__u64	len;
+		} remap;
+
+		struct {
+			__u64	start;
+			__u64	end;
+		} madv_dn;
+
+		struct {
 			/* unused reserved fields */
 			__u64	reserved1;
 			__u64	reserved2;
@@ -84,9 +112,9 @@ struct uffd_msg {
  * Start at 0x12 and not at 0 to be more strict against bugs.
  */
 #define UFFD_EVENT_PAGEFAULT	0x12
-#if 0 /* not available yet */
 #define UFFD_EVENT_FORK		0x13
-#endif
+#define UFFD_EVENT_REMAP	0x14
+#define UFFD_EVENT_MADVDONTNEED	0x15
 
 /* flags for UFFD_EVENT_PAGEFAULT */
 #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
@@ -104,11 +132,37 @@ struct uffdio_api {
 	 * Note: UFFD_EVENT_PAGEFAULT and UFFD_PAGEFAULT_FLAG_WRITE
 	 * are to be considered implicitly always enabled in all kernels as
 	 * long as the uffdio_api.api requested matches UFFD_API.
+	 *
+	 * UFFD_FEATURE_MISSING_HUGETLBFS means an UFFDIO_REGISTER
+	 * with UFFDIO_REGISTER_MODE_MISSING mode will succeed on
+	 * hugetlbfs virtual memory ranges. Adding or not adding
+	 * UFFD_FEATURE_MISSING_HUGETLBFS to uffdio_api.features has
+	 * no real functional effect after UFFDIO_API returns, but
+	 * it's only useful for an initial feature set probe at
+	 * UFFDIO_API time. There are two ways to use it:
+	 *
+	 * 1) by adding UFFD_FEATURE_MISSING_HUGETLBFS to the
+	 *    uffdio_api.features before calling UFFDIO_API, an error
+	 *    will be returned by UFFDIO_API on a kernel without
+	 *    hugetlbfs missing support
+	 *
+	 * 2) the UFFD_FEATURE_MISSING_HUGETLBFS can not be added in
+	 *    uffdio_api.features and instead it will be set by the
+	 *    kernel in the uffdio_api.features if the kernel supports
+	 *    it, so userland can later check if the feature flag is
+	 *    present in uffdio_api.features after UFFDIO_API
+	 *    succeeded.
+	 *
+	 * UFFD_FEATURE_MISSING_SHMEM works the same as
+	 * UFFD_FEATURE_MISSING_HUGETLBFS, but it applies to shmem
+	 * (i.e. tmpfs and other shmem based APIs).
 	 */
-#if 0 /* not available yet */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
-#endif
+#define UFFD_FEATURE_EVENT_REMAP		(1<<2)
+#define UFFD_FEATURE_EVENT_MADVDONTNEED		(1<<3)
+#define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
+#define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
 	__u64 features;
 
 	__u64 ioctls;
@@ -164,4 +218,11 @@ struct uffdio_zeropage {
 	__s64 zeropage;
 };
 
+struct uffdio_writeprotect {
+	struct uffdio_range range;
+	/* !WP means undo writeprotect. DONTWAKE is valid only with !WP */
+#define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
+#define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
+	__u64 mode;
+};
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.9.3
