Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJh-0006jt-Jr
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJg-0000sL-6Y
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXJf-0000qw-WE
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:24 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Mar 2017 18:16:11 +0200
Message-Id: <20170327161615.19637-6-pbonzini@redhat.com>
In-Reply-To: <20170327161615.19637-1-pbonzini@redhat.com>
References: <20170327161615.19637-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] mem-prealloc: fix
 sysconf(_SC_NPROCESSORS_ONLN) failure case.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jitendra Kolhe <jitendra.kolhe@hpe.com>

From: Jitendra Kolhe <jitendra.kolhe@hpe.com>

This was spotted by Coverity, in case where sysconf(_SC_NPROCESSORS_ONLN)
fails and returns -1. This results in memset_num_threads getting set to -1.
Which we then pass to g_new0().
The patch replaces MAX_MEM_PREALLOC_THREAD_COUNT macro with a function call
get_memset_num_threads() to handle sysconf() failure gracefully. In case
sysconf() fails, we fall back to single threaded.

(Spotted by Coverity, CID 1372465.)

Signed-off-by: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-Id: <1490079006-32495-1-git-send-email-jitendra.kolhe@hpe.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3fe6089..4d9189e 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -55,7 +55,7 @@
 #include "qemu/error-report.h"
 #endif
 
-#define MAX_MEM_PREALLOC_THREAD_COUNT (MIN(sysconf(_SC_NPROCESSORS_ONLN), 16))
+#define MAX_MEM_PREALLOC_THREAD_COUNT 16
 
 struct MemsetThread {
     char *addr;
@@ -381,6 +381,18 @@ static void *do_touch_pages(void *arg)
     return NULL;
 }
 
+static inline int get_memset_num_threads(int smp_cpus)
+{
+    long host_procs = sysconf(_SC_NPROCESSORS_ONLN);
+    int ret = 1;
+
+    if (host_procs > 0) {
+        ret = MIN(MIN(host_procs, MAX_MEM_PREALLOC_THREAD_COUNT), smp_cpus);
+    }
+    /* In case sysconf() fails, we fall back to single threaded */
+    return ret;
+}
+
 static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
                             int smp_cpus)
 {
@@ -389,7 +401,7 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
     int i = 0;
 
     memset_thread_failed = false;
-    memset_num_threads = MIN(smp_cpus, MAX_MEM_PREALLOC_THREAD_COUNT);
+    memset_num_threads = get_memset_num_threads(smp_cpus);
     memset_thread = g_new0(MemsetThread, memset_num_threads);
     numpages_per_thread = (numpages / memset_num_threads);
     size_per_thread = (hpagesize * numpages_per_thread);
-- 
2.9.3
