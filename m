Received: from eggs.gnu.org ([2001:4830:134:3::10]:37894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAW-00079f-Cx
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAU-0000HF-Sn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:28 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:55461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAU-0000Fy-KB
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:26 -0400
Received: by mail-wm0-x22c.google.com with SMTP id v16-v6so11054850wmv.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:21 +0200
Message-Id: <1530216310-52873-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/60] tests/atomic_add-bench: add -m option to
 use mutexes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Peter Xu <peterx@redhat.com>

From: "Emilio G. Cota" <cota@braap.org>

This allows us to use atomic-add-bench as a microbenchmark
for evaluating qemu_mutex_lock's performance.

Signed-off-by: Emilio G. Cota <cota@braap.org>
[cherry picked from https://github.com/cota/qemu/commit/f04f34df]
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180425025459.5258-2-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/atomic_add-bench.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index caa1e8e..f96d448 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -8,6 +8,7 @@ struct thread_info {
 } QEMU_ALIGNED(64);
 
 struct count {
+    QemuMutex lock;
     unsigned long val;
 } QEMU_ALIGNED(64);
 
@@ -18,11 +19,13 @@ static unsigned int n_ready_threads;
 static struct count *counts;
 static unsigned int duration = 1;
 static unsigned int range = 1024;
+static bool use_mutex;
 static bool test_start;
 static bool test_stop;
 
 static const char commands_string[] =
     " -n = number of threads\n"
+    " -m = use mutexes instead of atomic increments\n"
     " -d = duration in seconds\n"
     " -r = range (will be rounded up to pow2)";
 
@@ -59,7 +62,13 @@ static void *thread_func(void *arg)
 
         info->r = xorshift64star(info->r);
         index = info->r & (range - 1);
-        atomic_inc(&counts[index].val);
+        if (use_mutex) {
+            qemu_mutex_lock(&counts[index].lock);
+            counts[index].val += 1;
+            qemu_mutex_unlock(&counts[index].lock);
+        } else {
+            atomic_inc(&counts[index].val);
+        }
     }
     return NULL;
 }
@@ -91,6 +100,9 @@ static void create_threads(void)
     th_info = g_new(struct thread_info, n_threads);
     counts = qemu_memalign(64, sizeof(*counts) * range);
     memset(counts, 0, sizeof(*counts) * range);
+    for (i = 0; i < range; i++) {
+        qemu_mutex_init(&counts[i].lock);
+    }
 
     for (i = 0; i < n_threads; i++) {
         struct thread_info *info = &th_info[i];
@@ -131,7 +143,7 @@ static void parse_args(int argc, char *argv[])
     int c;
 
     for (;;) {
-        c = getopt(argc, argv, "hd:n:r:");
+        c = getopt(argc, argv, "hd:n:mr:");
         if (c < 0) {
             break;
         }
@@ -145,6 +157,9 @@ static void parse_args(int argc, char *argv[])
         case 'n':
             n_threads = atoi(optarg);
             break;
+        case 'm':
+            use_mutex = true;
+            break;
         case 'r':
             range = pow2ceil(atoi(optarg));
             break;
-- 
1.8.3.1
